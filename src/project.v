/*
 * Copyright (c) 2026 Hackin7
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

// Tiny Tapeout top: instantiates analog and digital leaves and glues clocks.
// LibreLane auto-routes every Verilog signal net, including clk_ring_*.
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

  // Analog leaves (pre-hardened GDS/LEF). Power pins are connected by PDN.
  wire clk_ring_100;
  wire clk_ring_500;
  ring_oscillator u_ring_oscillator (
      .out(clk_ring_100)
  );
  ring_oscillator_500mhz u_ring_oscillator_500mhz (
      .out(clk_ring_500)
  );

  // Direct clock selection is intentional. Change ui_in[1]/ui_in[5] only while
  // reset is asserted, since an asynchronous live change can create a clock glitch.
  // ui_in[1]=0 -> TT clk; ui_in[1]=1 && ui_in[5]=0 -> 100 MHz; ui_in[5]=1 -> 500 MHz.
  wire clk_ring = ui_in[5] ? clk_ring_500 : clk_ring_100;
  wire counter_clk = ui_in[1] ? clk_ring : clk;

  digital_counter #(
      .CTR_W(CTR_W)
  ) u_counter (
      .clk     (counter_clk),
      .rst_n   (rst_n),
      .ena     (ena && ui_in[0]),
      .byte_sel(ui_in[4:2]),
      .uo_out  (uo_out)
  );

  assign uio_out = 8'b0;
  assign uio_oe  = 8'b0;

  (* keep *)
  chips_art u_chips_art ();

  wire _unused = &{uio_in, ui_in[7:6], 1'b0};

endmodule
