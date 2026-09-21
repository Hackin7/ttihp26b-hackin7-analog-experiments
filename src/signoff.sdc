# External Tiny Tapeout clock (board / GPIO clock).
create_clock -name tt_clk -period 20.0 [get_ports clk]
set_clock_uncertainty 0.2 [get_clocks tt_clk]

# STA experiment: treat analog ring outputs as 100 MHz / 500 MHz sources.
# Macros have no Liberty, so clocks start at the blackbox pin with zero
# source latency (optimistic for analog, real for the digital chain).
create_clock -name clk_ring_100 -period 10.0 [get_pins u_ring_oscillator/out]
set_clock_uncertainty 0.2 [get_clocks clk_ring_100]

create_clock -name clk_ring_500 -period 2.0 [get_pins u_ring_oscillator_500mhz/out]
set_clock_uncertainty 0.2 [get_clocks clk_ring_500]

set_clock_groups -logically_exclusive \
  -group [get_clocks tt_clk] \
  -group [get_clocks clk_ring_100] \
  -group [get_clocks clk_ring_500]

set_false_path -from [get_ports rst_n]
set_false_path -from [get_ports {ui_in[1]}]
set_false_path -from [get_ports {ui_in[5]}]
set_false_path -from [get_ports {ui_in[6]}]
set_false_path -from [get_ports {ui_in[7]}]
set_false_path -from [get_ports {uio_in[*]}]
