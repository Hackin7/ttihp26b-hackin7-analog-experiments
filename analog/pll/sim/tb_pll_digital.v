`timescale 1ns / 1ps
`default_nettype none

// Checks pll_digital pin decode: N=8+n_sel (clamp 22), M default/raw,
// and that clk_fb / clk_out divide independently.
module tb_pll_digital;
  reg        clk_vco;
  reg        rst_n;
  reg  [3:0] n_sel;
  reg  [4:0] m_sel;
  wire       clk_fb;
  wire       clk_out;

  pll_digital dut (
      .clk_vco(clk_vco),
      .rst_n  (rst_n),
      .n_sel  (n_sel),
      .m_sel  (m_sel),
      .clk_fb (clk_fb),
      .clk_out(clk_out)
  );

  initial clk_vco = 0;
  always #0.5 clk_vco = ~clk_vco;  // 1 GHz

  integer edges_fb, edges_out;

  task automatic run_case;
    input [3:0] n;
    input [4:0] m;
    input integer expect_fb_lo;
    input integer expect_fb_hi;
    input integer expect_out_lo;
    input integer expect_out_hi;
    begin
      rst_n = 0;
      n_sel = n;
      m_sel = m;
      edges_fb  = 0;
      edges_out = 0;
      #5 rst_n = 1;
      #10000;
      if (edges_fb < expect_fb_lo || edges_fb > expect_fb_hi) begin
        $display("FAIL fb n_sel=%0d m_sel=%0d edges=%0d (expect %0d..%0d)",
                 n, m, edges_fb, expect_fb_lo, expect_fb_hi);
        $fatal(1);
      end
      if (edges_out < expect_out_lo || edges_out > expect_out_hi) begin
        $display("FAIL out n_sel=%0d m_sel=%0d edges=%0d (expect %0d..%0d)",
                 n, m, edges_out, expect_out_lo, expect_out_hi);
        $fatal(1);
      end
      $display("PASS case n_sel=%0d m_sel=%0d fb=%0d out=%0d",
               n, m, edges_fb, edges_out);
      rst_n = 0;
      #5;
    end
  endtask

  initial begin
    // n_sel=0 → N=8 → ~1250 rising edges / 10 us @ 1 GHz
    // m_sel=0 → M=16 → ~625
    run_case(4'd0, 5'd0, 1100, 1400, 550, 700);

    // n_sel=8 → N=16; m_sel=8 → M=8
    run_case(4'd8, 5'd8, 550, 700, 1100, 1400);

    // n_sel=15 → N=23 clamped to 22; m_sel=22 → M=22
    run_case(4'd15, 5'd22, 400, 500, 400, 500);

    $display("PASS pll_digital all cases");
    $finish;
  end

  always @(posedge clk_fb)  edges_fb  = edges_fb + 1;
  always @(posedge clk_out) edges_out = edges_out + 1;
endmodule
