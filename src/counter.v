/*
 * Copyright (c) 2026 Hackin7
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// Digital leaf: synthesized into the Tiny Tapeout top (not a GDS macro).
module digital_counter #(
    parameter integer CTR_W = 64
) (
    input  wire             clk,
    input  wire             rst_n,
    input  wire             ena,
    input  wire [2:0]       byte_sel,
    output wire [7:0]       uo_out
);

  reg [CTR_W-1:0] counter;
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      counter <= 64'd0;
    else if (ena)
      counter <= counter + 1'b1;
  end

  assign uo_out = counter[byte_sel * 8 +: 8];

endmodule
