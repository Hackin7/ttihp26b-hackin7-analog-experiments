/* Analog leaf blackbox. Physical views:
 *   analog/transistor_ring_oscillator_500mhz/macro/ring_oscillator_500mhz.{gds,lef,spice}
 * LibreLane binds this module name to those views via src/config.json MACROS.
 * Power ports are only present when the powered netlist is generated.
 */
(* blackbox *)
module ring_oscillator_500mhz (
`ifdef USE_POWER_PINS
    inout  wire VPWR,
    inout  wire VGND,
`endif
    /* verilator lint_off UNDRIVEN */
    output wire out
    /* verilator lint_on UNDRIVEN */
);
endmodule
