`default_nettype none
`timescale 1ns / 1ps

// Direct testbench for the digital_counter leaf (no Tiny Tapeout wrapper).
module counter_tb ();

  initial begin
    $dumpfile("tb.fst");
    $dumpvars(0, counter_tb);
    #1;
  end

  reg        clk;
  reg        rst_n;
  reg        ena;
  reg  [2:0] byte_sel;
  wire [7:0] uo_out;

  digital_counter #(
      .CTR_W(64)
  ) dut (
      .clk     (clk),
      .rst_n   (rst_n),
      .ena     (ena),
      .byte_sel(byte_sel),
      .uo_out  (uo_out)
  );

endmodule
