# External-clock mode is the timing-qualified operating mode in this revision.
create_clock -name tt_clk -period 20.0 [get_ports clk]
set_clock_uncertainty 0.2 [get_clocks tt_clk]

# Reset and clock selection are asynchronous controls. The direct mux is an
# explicit integration experiment; software changes ui_in[1] only under reset.
set_false_path -from [get_ports rst_n]
set_false_path -from [get_ports {ui_in[1]}]

# The ring macro has no Liberty timing view, so its output is black-boxed and
# is not promoted to a timing clock in this integration pass.
