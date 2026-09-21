`default_nettype none
`timescale 1ns / 1ps

// Behavioral stand-in for the analog ring_oscillator_1ghz GDS macro.
// Analog delay is not modeled. `osc` stays 0 unless a test drives it.
module ring_oscillator_1ghz (
`ifdef USE_POWER_PINS
    inout  wire VPWR,
    inout  wire VGND,
`endif
    output wire out
);

  reg osc = 1'b0;
  assign out = osc;

`ifdef USE_POWER_PINS
  wire _unused_power = &{VPWR, VGND, 1'b0};
`endif

endmodule
