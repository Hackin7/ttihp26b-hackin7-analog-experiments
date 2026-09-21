/*
 * Copyright (c) 2026 Hackin7
 * SPDX-License-Identifier: Apache-2.0
 *
 * Canonical copy lives in src/pll_digital.v (Tiny Tapeout build).
 */

`default_nettype none

// Digital side of the PLL loop: feedback ÷N and observe/use ÷M off clk_vco.
module pll_digital (
    input  wire       clk_vco,
    input  wire       rst_n,
    input  wire [3:0] n_sel,
    input  wire [4:0] m_sel,
    output wire       clk_fb,
    output wire       clk_out
);
  wire [4:0] n_sum = 5'd8 + {1'b0, n_sel};
  wire [4:0] N = (n_sum > 5'd22) ? 5'd22 : n_sum;
  wire [4:0] M = (m_sel == 5'd0) ? 5'd16 : m_sel;

  pll_div_n u_div_fb (
      .clk_in (clk_vco),
      .rst_n  (rst_n),
      .div    (N),
      .clk_div(clk_fb)
  );

  pll_div_n u_div_out (
      .clk_in (clk_vco),
      .rst_n  (rst_n),
      .div    (M),
      .clk_div(clk_out)
  );
endmodule
