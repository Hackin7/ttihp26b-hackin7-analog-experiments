/*
 * Copyright (c) 2026 Hackin7
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// Digital leaf: synthesized into the Tiny Tapeout top (not a GDS macro).
// 64-bit async ripple T-FF counter. Same binary sequence as counter+1.
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
      counter[0] <= 1'b0;
    else if (ena)
      counter[0] <= ~counter[0];
  end

  genvar i;
  generate
    for (i = 1; i < CTR_W; i = i + 1) begin : g_ripple
      always @(negedge counter[i-1] or negedge rst_n) begin
        if (!rst_n)
          counter[i] <= 1'b0;
        else
          counter[i] <= ~counter[i];
      end
    end
  endgenerate

  assign uo_out = counter[byte_sel * 8 +: 8];

endmodule
