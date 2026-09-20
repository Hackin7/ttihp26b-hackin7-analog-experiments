/*
 * Copyright (c) 2026 Hackin7
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// Tiny Tapeout top: instantiates analog and digital leaves and glues clocks.
// LibreLane auto-routes every Verilog signal net, including clk_ring.
module tt_um_hackin7_analog_experiments #(
    parameter integer CTR_W = 64
) (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // Analog leaf (pre-hardened GDS/LEF). Power pins are connected by PDN.
  wire clk_ring;
  ring_oscillator u_ring_oscillator (
      .out(clk_ring)
  );

  // Direct clock selection is intentional. Change ui_in[1] only while reset
  // is asserted, since an asynchronous live change can create a clock glitch.
  wire counter_clk = ui_in[1] ? clk_ring : clk;

  digital_counter #(
      .CTR_W(CTR_W)
  ) u_counter (
      .clk     (counter_clk),
      .rst_n   (rst_n),
      .ena     (ena && ui_in[0]),
      .byte_sel(ui_in[4:2]),
      .uo_out  (uo_out)
  );

  assign uio_out = 8'b0;
  assign uio_oe  = 8'b0;

  wire _unused = &{uio_in, ui_in[7:5], 1'b0};

endmodule
