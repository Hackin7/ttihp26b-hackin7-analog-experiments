/*
 * Copyright (c) 2026 Hackin7
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

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

  // The ring oscillator is a pre-hardened physical macro. Its power pins are
  // connected by LibreLane through PDN_MACRO_CONNECTIONS.
  wire clk_ring;
  ring_oscillator u_ring_oscillator (
      .out(clk_ring)
  );

  // Direct clock selection is intentional. Change ui_in[1] only while reset
  // is asserted, since an asynchronous live change can create a clock glitch.
  wire counter_clk = ui_in[1] ? clk_ring : clk;
  wire ctr_ena = ena && ui_in[0];

  // Part 2: 64-bit continuously counting counter.
  reg [CTR_W-1:0] counter;
  always @(posedge counter_clk or negedge rst_n) begin
    if (!rst_n)
      counter <= 64'd0;
    else if (ctr_ena)
      counter <= counter + 1'b1;
  end

  // ui_in[4:2] selects which of the eight counter bytes drives uo_out.
  assign uo_out = counter[ui_in[4:2] * 8 +: 8];

  // IO pins are not used; keep them driven low.
  assign uio_out = 8'b0;
  assign uio_oe  = 8'b0;

  // Absorb the intentionally unused inputs (verilator lint).
  wire _unused = &{uio_in, ui_in[7:5], 1'b0};

endmodule
