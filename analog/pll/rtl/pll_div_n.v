/*
 * Copyright (c) 2026 Hackin7
 * SPDX-License-Identifier: Apache-2.0
 *
 * Canonical copy lives in src/pll_div_n.v (Tiny Tapeout build).
 * Kept here so analog/pll/sim can compile against ../rtl.
 */

`default_nettype none

// Programmable divide-by-div with ~50% duty (toggle every div/2 cycles).
// Prefer even div; odd values force LSB clear after clamp (period = 2*floor(div/2)).
module pll_div_n (
    input  wire       clk_in,
    input  wire       rst_n,
    input  wire [4:0] div,
    output reg        clk_div
);
  // Minimum 2; max 31. Force even so HALF is exact.
  wire [4:0] div_c = (div < 5'd2) ? 5'd2 : {div[4:1], 1'b0};
  wire [4:0] half  = {1'b0, div_c[4:1]};

  reg [4:0] cnt;

  always @(posedge clk_in or negedge rst_n) begin
    if (!rst_n) begin
      cnt     <= 5'd0;
      clk_div <= 1'b0;
    end else if (cnt == half - 5'd1) begin
      cnt     <= 5'd0;
      clk_div <= ~clk_div;
    end else begin
      cnt <= cnt + 5'd1;
    end
  end
endmodule
