`timescale 1ns / 1ps

module tb_div_n;
  reg clk_in, rst_n;
  wire clk_div8, clk_div16, clk_div22;

  pll_div_n #(.N(8))  u8  (.clk_in(clk_in), .rst_n(rst_n), .clk_div(clk_div8));
  pll_div_n #(.N(16)) u16 (.clk_in(clk_in), .rst_n(rst_n), .clk_div(clk_div16));
  pll_div_n #(.N(22)) u22 (.clk_in(clk_in), .rst_n(rst_n), .clk_div(clk_div22));

  initial clk_in = 0;
  always #0.5 clk_in = ~clk_in;  // 1 GHz

  integer c8, c16, c22;
  integer edges8, edges16, edges22;

  initial begin
    rst_n = 0;
    c8 = 0; c16 = 0; c22 = 0;
    edges8 = 0; edges16 = 0; edges22 = 0;
    #5 rst_n = 1;
    #10000;
    // At 1 GHz for 10 us -> 10000 cycles in
    // Expect clk_div edges ~ 10000/N rising+falling; count rising on clk_div
    if (edges8 < 1100 || edges8 > 1400) begin
      $display("FAIL N=8 edges=%0d (expect ~1250)", edges8);
      $fatal(1);
    end
    if (edges16 < 550 || edges16 > 700) begin
      $display("FAIL N=16 edges=%0d (expect ~625)", edges16);
      $fatal(1);
    end
    if (edges22 < 400 || edges22 > 500) begin
      $display("FAIL N=22 edges=%0d (expect ~455)", edges22);
      $fatal(1);
    end
    $display("PASS pll_div_n N=8/16/22 edges=%0d/%0d/%0d", edges8, edges16, edges22);
    $finish;
  end

  always @(posedge clk_div8)  edges8  = edges8 + 1;
  always @(posedge clk_div16) edges16 = edges16 + 1;
  always @(posedge clk_div22) edges22 = edges22 + 1;
endmodule
