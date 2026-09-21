# External Tiny Tapeout clock (board / GPIO clock).
create_clock -name tt_clk -period 20.0 [get_ports clk]
set_clock_uncertainty 0.2 [get_clocks tt_clk]

# STA experiment: treat the analog ring output as a 100 MHz source.
# The macro has no Liberty, so this clock starts at the blackbox pin with
# zero source latency (optimistic for analog, real for the digital chain).
set ring_clk_src [get_pins -quiet u_ring_oscillator/out]
if {[sizeof_collection $ring_clk_src] == 0} {
  set ring_clk_src [get_nets -quiet clk_ring]
}
if {[sizeof_collection $ring_clk_src] == 0} {
  puts "WARNING: clk_ring source not found; 100 MHz ring clock not created"
} else {
  create_clock -name clk_ring -period 10.0 $ring_clk_src
  set_clock_uncertainty 0.2 [get_clocks clk_ring]
  # Mux selects one source; do not time tt_clk vs clk_ring as a CDC.
  set_clock_groups -logically_exclusive \
    -group [get_clocks tt_clk] \
    -group [get_clocks clk_ring]
}

# Reset and clock selection are asynchronous controls. The direct mux is an
# explicit integration experiment; software changes ui_in[1] only under reset.
set_false_path -from [get_ports rst_n]
set_false_path -from [get_ports {ui_in[1]}]
