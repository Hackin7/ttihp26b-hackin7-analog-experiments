# External-clock mode is the timing-qualified operating mode in this revision.
create_clock -name tt_clk -period 20.0 [get_ports clk]
set_clock_uncertainty 0.2 [get_clocks tt_clk]

set_false_path -from [get_ports rst_n]
set_false_path -from [get_ports {ui_in[1]}]
# The ring macro has no Liberty timing view and remains outside signoff STA.
