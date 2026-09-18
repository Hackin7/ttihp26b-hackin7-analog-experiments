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

  // Part 2: the ring oscillator does not exist yet (clk_ring is a tied-off 0),
  // so selecting it is observably identical to freezing the counter. Folding
  // the clock-select into the increment enable keeps all combinational logic
  // off the clock path: a combinational mux would form a gated clock and fail
  // the OpenROAD half-period clock-gating hold check (the select must hold
  // across the fall edge of clk; an async input cannot). Part 3 reintroduces
  // the physical mux with a registered select and the ring oscillator.
  wire ctr_ena = ena && ui_in[0] && !ui_in[1];

  // Part 2: 64-bit continuously counting counter.
  reg [CTR_W-1:0] counter;
  always @(posedge clk or negedge rst_n) begin
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