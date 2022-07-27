
// Generated by Cadence Genus(TM) Synthesis Solution 19.11-s087_1
// Generated on: Jul 26 2022 12:23:49 CEST (Jul 26 2022 10:23:49 UTC)

// Verification Directory fv/adder 

module half_adder(x, y, s, c);
  input x, y;
  output s, c;
  wire x, y;
  wire s, c;
  HA1D0BWP g23__2398(.A (y), .B (x), .CO (c), .S (s));
endmodule

module full_adder(x, y, c_in, s, c_out);
  input x, y, c_in;
  output s, c_out;
  wire x, y, c_in;
  wire s, c_out;
  FA1D0BWP g61__5107(.A (y), .B (x), .CI (c_in), .CO (c_out), .S (s));
endmodule

module full_adder_1(x, y, c_in, s, c_out);
  input x, y, c_in;
  output s, c_out;
  wire x, y, c_in;
  wire s, c_out;
  FA1D0BWP g61__6260(.A (y), .B (x), .CI (c_in), .CO (c_out), .S (s));
endmodule

module full_adder_2(x, y, c_in, s, c_out);
  input x, y, c_in;
  output s, c_out;
  wire x, y, c_in;
  wire s, c_out;
  FA1D0BWP g61__4319(.A (y), .B (x), .CI (c_in), .CO (c_out), .S (s));
endmodule

module full_adder_3(x, y, c_in, s, c_out);
  input x, y, c_in;
  output s, c_out;
  wire x, y, c_in;
  wire s, c_out;
  FA1D0BWP g61__8428(.A (y), .B (x), .CI (c_in), .CO (c_out), .S (s));
endmodule

module full_adder_4(x, y, c_in, s, c_out);
  input x, y, c_in;
  output s, c_out;
  wire x, y, c_in;
  wire s, c_out;
  FA1D0BWP g61__5526(.A (y), .B (x), .CI (c_in), .CO (c_out), .S (s));
endmodule

module full_adder_5(x, y, c_in, s, c_out);
  input x, y, c_in;
  output s, c_out;
  wire x, y, c_in;
  wire s, c_out;
  FA1D0BWP g61__6783(.A (y), .B (x), .CI (c_in), .CO (c_out), .S (s));
endmodule

module full_adder_6(x, y, c_in, s, c_out);
  input x, y, c_in;
  output s, c_out;
  wire x, y, c_in;
  wire s, c_out;
  FA1D0BWP g61__3680(.A (y), .B (x), .CI (c_in), .CO (c_out), .S (s));
endmodule

module full_adder_7(x, y, c_in, s, c_out);
  input x, y, c_in;
  output s, c_out;
  wire x, y, c_in;
  wire s, c_out;
  FA1D0BWP g61__1617(.A (y), .B (x), .CI (c_in), .CO (c_out), .S (s));
endmodule

module full_adder_8(x, y, c_in, s, c_out);
  input x, y, c_in;
  output s, c_out;
  wire x, y, c_in;
  wire s, c_out;
  FA1D0BWP g61__2802(.A (y), .B (x), .CI (c_in), .CO (c_out), .S (s));
endmodule

module full_adder_9(x, y, c_in, s, c_out);
  input x, y, c_in;
  output s, c_out;
  wire x, y, c_in;
  wire s, c_out;
  FA1D0BWP g61__1705(.A (y), .B (x), .CI (c_in), .CO (c_out), .S (s));
endmodule

module full_adder_10(x, y, c_in, s, c_out);
  input x, y, c_in;
  output s, c_out;
  wire x, y, c_in;
  wire s, c_out;
  FA1D0BWP g61__5122(.A (y), .B (x), .CI (c_in), .CO (c_out), .S (s));
endmodule

module full_adder_11(x, y, c_in, s, c_out);
  input x, y, c_in;
  output s, c_out;
  wire x, y, c_in;
  wire s, c_out;
  FA1D0BWP g61__8246(.A (y), .B (x), .CI (c_in), .CO (c_out), .S (s));
endmodule

module full_adder_12(x, y, c_in, s, c_out);
  input x, y, c_in;
  output s, c_out;
  wire x, y, c_in;
  wire s, c_out;
  FA1D0BWP g61__7098(.A (y), .B (x), .CI (c_in), .CO (c_out), .S (s));
endmodule

module full_adder_13(x, y, c_in, s, c_out);
  input x, y, c_in;
  output s, c_out;
  wire x, y, c_in;
  wire s, c_out;
  XOR3D0BWP g32__6131(.A1 (x), .A2 (y), .A3 (c_in), .Z (s));
endmodule

module adder(input1, input2, sum);
  input [14:0] input1, input2;
  output [14:0] sum;
  wire [14:0] input1, input2;
  wire [14:0] sum;
  wire [14:0] carry;
  wire UNCONNECTED;
  half_adder \generate_N_bit_Adder[0].genblk1.f (input1[0], input2[0],
       sum[0], carry[0]);
  full_adder \generate_N_bit_Adder[1].genblk1.f (input1[1], input2[1],
       carry[0], sum[1], carry[1]);
  full_adder_1 \generate_N_bit_Adder[2].genblk1.f (input1[2],
       input2[2], carry[1], sum[2], carry[2]);
  full_adder_2 \generate_N_bit_Adder[3].genblk1.f (input1[3],
       input2[3], carry[2], sum[3], carry[3]);
  full_adder_3 \generate_N_bit_Adder[4].genblk1.f (input1[4],
       input2[4], carry[3], sum[4], carry[4]);
  full_adder_4 \generate_N_bit_Adder[5].genblk1.f (input1[5],
       input2[5], carry[4], sum[5], carry[5]);
  full_adder_5 \generate_N_bit_Adder[6].genblk1.f (input1[6],
       input2[6], carry[5], sum[6], carry[6]);
  full_adder_6 \generate_N_bit_Adder[7].genblk1.f (input1[7],
       input2[7], carry[6], sum[7], carry[7]);
  full_adder_7 \generate_N_bit_Adder[8].genblk1.f (input1[8],
       input2[8], carry[7], sum[8], carry[8]);
  full_adder_8 \generate_N_bit_Adder[9].genblk1.f (input1[9],
       input2[9], carry[8], sum[9], carry[9]);
  full_adder_9 \generate_N_bit_Adder[10].genblk1.f (input1[10],
       input2[10], carry[9], sum[10], carry[10]);
  full_adder_10 \generate_N_bit_Adder[11].genblk1.f (input1[11],
       input2[11], carry[10], sum[11], carry[11]);
  full_adder_11 \generate_N_bit_Adder[12].genblk1.f (input1[12],
       input2[12], carry[11], sum[12], carry[12]);
  full_adder_12 \generate_N_bit_Adder[13].genblk1.f (input1[13],
       input2[13], carry[12], sum[13], carry[13]);
  full_adder_13 \generate_N_bit_Adder[14].genblk1.f (input1[14],
       input2[14], carry[13], sum[14], UNCONNECTED);
endmodule

