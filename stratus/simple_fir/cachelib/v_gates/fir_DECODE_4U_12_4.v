`timescale 1ps / 1ps

// Generated by Cadence Genus(TM) Synthesis Solution 19.11-s087_1
// Generated on: Sep  6 2022 16:19:06 CEST (Sep  6 2022 14:19:06 UTC)

module fir_DECODE_4U_12_4(in1, out1);
  input [1:0] in1;
  output [3:0] out1;
  wire [1:0] in1;
  wire [3:0] out1;
  AN2XD1BWP sll_19_25_g42(.A1 (in1[1]), .A2 (in1[0]), .Z (out1[3]));
  INR2XD0BWP sll_19_25_g43(.A1 (in1[1]), .B1 (in1[0]), .ZN (out1[2]));
  INR2XD0BWP sll_19_25_g44(.A1 (in1[0]), .B1 (in1[1]), .ZN (out1[1]));
  NR2XD0BWP sll_19_25_g45(.A1 (in1[1]), .A2 (in1[0]), .ZN (out1[0]));
endmodule

