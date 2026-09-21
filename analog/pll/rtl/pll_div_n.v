`timescale 1ns / 1ps

module pll_div_n #(
    parameter integer N = 16
) (
    input  wire clk_in,
    input  wire rst_n,
    output reg  clk_div
);
  localparam integer HALF = N / 2;
  localparam integer CW   = (N <= 2) ? 1 : $clog2(N);
  reg [CW-1:0] cnt;

  always @(posedge clk_in or negedge rst_n) begin
    if (!rst_n) begin
      cnt     <= {CW{1'b0}};
      clk_div <= 1'b0;
    end else if (cnt == HALF[CW-1:0] - 1'b1) begin
      cnt     <= {CW{1'b0}};
      clk_div <= ~clk_div;
    end else begin
      cnt <= cnt + 1'b1;
    end
  end
endmodule
