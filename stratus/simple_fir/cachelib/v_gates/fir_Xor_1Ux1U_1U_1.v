`timescale 1ps / 1ps

// Generated by Cadence Genus(TM) Synthesis Solution 19.11-s087_1
// Generated on: Aug 31 2022 16:49:24 CEST (Aug 31 2022 14:49:24 UTC)

module fir_Xor_1Ux1U_1U_1(in2, in1, out1);
  input in2, in1;
  output out1;
  wire in2, in1;
  wire out1;
  wire n_0;
  MXI2X1 g10(.A (n_0), .B (in2), .S0 (in1), .Y (out1));
  CLKINVX4 g11(.A (in2), .Y (n_0));
endmodule

