`timescale 1ps / 1ps

// Generated by Cadence Genus(TM) Synthesis Solution 19.11-s087_1
// Generated on: Sep  6 2022 17:00:06 CEST (Sep  6 2022 15:00:06 UTC)

module fir_Add_11Ux11U_11U_4_1(in2, in1, out1);
  input [10:0] in2, in1;
  output [10:0] out1;
  wire [10:0] in2, in1;
  wire [10:0] out1;
  wire add_23_2_n_0, add_23_2_n_1, add_23_2_n_2, add_23_2_n_3,
       add_23_2_n_4, add_23_2_n_5, add_23_2_n_6, add_23_2_n_7;
  wire add_23_2_n_8, add_23_2_n_9, add_23_2_n_10, add_23_2_n_11,
       add_23_2_n_12, add_23_2_n_13, add_23_2_n_14, add_23_2_n_15;
  wire add_23_2_n_16, add_23_2_n_17, add_23_2_n_18, add_23_2_n_19,
       add_23_2_n_21, add_23_2_n_22, add_23_2_n_23, add_23_2_n_24;
  wire add_23_2_n_25, add_23_2_n_26, add_23_2_n_27, add_23_2_n_28,
       add_23_2_n_29, add_23_2_n_30, add_23_2_n_31, add_23_2_n_32;
  wire add_23_2_n_33, add_23_2_n_35, add_23_2_n_36, add_23_2_n_37,
       add_23_2_n_39, add_23_2_n_40, add_23_2_n_41, add_23_2_n_44;
  wire add_23_2_n_45, add_23_2_n_46, add_23_2_n_47, add_23_2_n_51,
       add_23_2_n_52, add_23_2_n_53;
  MOAI22D0BWP add_23_2_g208(.A1 (add_23_2_n_22), .A2 (add_23_2_n_53),
       .B1 (add_23_2_n_22), .B2 (add_23_2_n_53), .ZN (out1[10]));
  MOAI22D0BWP add_23_2_g209(.A1 (add_23_2_n_30), .A2 (add_23_2_n_52),
       .B1 (add_23_2_n_30), .B2 (add_23_2_n_52), .ZN (out1[9]));
  MOAI22D0BWP add_23_2_g210(.A1 (add_23_2_n_29), .A2 (add_23_2_n_51),
       .B1 (add_23_2_n_29), .B2 (add_23_2_n_51), .ZN (out1[7]));
  OAI211D1BWP add_23_2_g211(.A1 (add_23_2_n_0), .A2 (add_23_2_n_13), .B
       (add_23_2_n_47), .C (add_23_2_n_18), .ZN (add_23_2_n_53));
  OAI21D1BWP add_23_2_g212(.A1 (add_23_2_n_15), .A2 (add_23_2_n_44), .B
       (add_23_2_n_0), .ZN (add_23_2_n_52));
  OAI21D1BWP add_23_2_g213(.A1 (add_23_2_n_14), .A2 (add_23_2_n_46), .B
       (add_23_2_n_12), .ZN (add_23_2_n_51));
  MOAI22D0BWP add_23_2_g214(.A1 (add_23_2_n_23), .A2 (add_23_2_n_44),
       .B1 (add_23_2_n_23), .B2 (add_23_2_n_44), .ZN (out1[8]));
  MOAI22D0BWP add_23_2_g215(.A1 (add_23_2_n_24), .A2 (add_23_2_n_46),
       .B1 (add_23_2_n_24), .B2 (add_23_2_n_46), .ZN (out1[6]));
  MOAI22D0BWP add_23_2_g216(.A1 (add_23_2_n_26), .A2 (add_23_2_n_45),
       .B1 (add_23_2_n_26), .B2 (add_23_2_n_45), .ZN (out1[5]));
  OR3D1BWP add_23_2_g217(.A1 (add_23_2_n_44), .A2 (add_23_2_n_13), .A3
       (add_23_2_n_15), .Z (add_23_2_n_47));
  AOI21D1BWP add_23_2_g218(.A1 (add_23_2_n_27), .A2 (add_23_2_n_41), .B
       (add_23_2_n_32), .ZN (add_23_2_n_46));
  OAI21D1BWP add_23_2_g219(.A1 (add_23_2_n_4), .A2 (add_23_2_n_40), .B
       (add_23_2_n_11), .ZN (add_23_2_n_45));
  AOI31D1BWP add_23_2_g220(.A1 (add_23_2_n_41), .A2 (add_23_2_n_31),
       .A3 (add_23_2_n_27), .B (add_23_2_n_35), .ZN (add_23_2_n_44));
  MUX2ND0BWP add_23_2_g221(.I0 (add_23_2_n_41), .I1 (add_23_2_n_40), .S
       (add_23_2_n_19), .ZN (out1[4]));
  MOAI22D0BWP add_23_2_g222(.A1 (add_23_2_n_25), .A2 (add_23_2_n_39),
       .B1 (add_23_2_n_25), .B2 (add_23_2_n_39), .ZN (out1[3]));
  INVD1BWP add_23_2_g223(.I (add_23_2_n_41), .ZN (add_23_2_n_40));
  OAI211D1BWP add_23_2_g224(.A1 (add_23_2_n_5), .A2 (add_23_2_n_3), .B
       (add_23_2_n_37), .C (add_23_2_n_9), .ZN (add_23_2_n_41));
  OA21D1BWP add_23_2_g225(.A1 (add_23_2_n_1), .A2 (add_23_2_n_36), .B
       (add_23_2_n_5), .Z (add_23_2_n_39));
  MOAI22D0BWP add_23_2_g226(.A1 (add_23_2_n_21), .A2 (add_23_2_n_36),
       .B1 (add_23_2_n_21), .B2 (add_23_2_n_36), .ZN (out1[2]));
  OR3XD1BWP add_23_2_g227(.A1 (add_23_2_n_36), .A2 (add_23_2_n_3), .A3
       (add_23_2_n_1), .Z (add_23_2_n_37));
  OA21D1BWP add_23_2_g228(.A1 (add_23_2_n_16), .A2 (add_23_2_n_17), .B
       (add_23_2_n_6), .Z (add_23_2_n_36));
  OAI211D1BWP add_23_2_g229(.A1 (add_23_2_n_12), .A2 (add_23_2_n_2), .B
       (add_23_2_n_33), .C (add_23_2_n_8), .ZN (add_23_2_n_35));
  MOAI22D0BWP add_23_2_g230(.A1 (add_23_2_n_16), .A2 (add_23_2_n_28),
       .B1 (add_23_2_n_16), .B2 (add_23_2_n_28), .ZN (out1[1]));
  ND2D1BWP add_23_2_g231(.A1 (add_23_2_n_31), .A2 (add_23_2_n_32), .ZN
       (add_23_2_n_33));
  OAI21D1BWP add_23_2_g232(.A1 (add_23_2_n_11), .A2 (add_23_2_n_10), .B
       (add_23_2_n_7), .ZN (add_23_2_n_32));
  NR2D1BWP add_23_2_g233(.A1 (add_23_2_n_2), .A2 (add_23_2_n_14), .ZN
       (add_23_2_n_31));
  IND2D1BWP add_23_2_g234(.A1 (add_23_2_n_13), .B1 (add_23_2_n_18), .ZN
       (add_23_2_n_30));
  IND2D1BWP add_23_2_g235(.A1 (add_23_2_n_2), .B1 (add_23_2_n_8), .ZN
       (add_23_2_n_29));
  INR2XD0BWP add_23_2_g236(.A1 (add_23_2_n_6), .B1 (add_23_2_n_17), .ZN
       (add_23_2_n_28));
  NR2XD0BWP add_23_2_g237(.A1 (add_23_2_n_10), .A2 (add_23_2_n_4), .ZN
       (add_23_2_n_27));
  IND2D1BWP add_23_2_g238(.A1 (add_23_2_n_10), .B1 (add_23_2_n_7), .ZN
       (add_23_2_n_26));
  XOR2D1BWP add_23_2_g239(.A1 (in2[0]), .A2 (in1[0]), .Z (out1[0]));
  INR2XD0BWP add_23_2_g240(.A1 (add_23_2_n_9), .B1 (add_23_2_n_3), .ZN
       (add_23_2_n_25));
  INR2XD0BWP add_23_2_g241(.A1 (add_23_2_n_12), .B1 (add_23_2_n_14),
       .ZN (add_23_2_n_24));
  INR2XD0BWP add_23_2_g242(.A1 (add_23_2_n_0), .B1 (add_23_2_n_15), .ZN
       (add_23_2_n_23));
  MOAI22D0BWP add_23_2_g243(.A1 (in2[10]), .A2 (in1[10]), .B1
       (in2[10]), .B2 (in1[10]), .ZN (add_23_2_n_22));
  INR2XD0BWP add_23_2_g244(.A1 (add_23_2_n_5), .B1 (add_23_2_n_1), .ZN
       (add_23_2_n_21));
  IND2D1BWP add_23_2_g245(.A1 (add_23_2_n_4), .B1 (add_23_2_n_11), .ZN
       (add_23_2_n_19));
  ND2D1BWP add_23_2_g246(.A1 (in2[9]), .A2 (in1[9]), .ZN
       (add_23_2_n_18));
  NR2D1BWP add_23_2_g247(.A1 (in2[1]), .A2 (in1[1]), .ZN
       (add_23_2_n_17));
  CKND2D1BWP add_23_2_g248(.A1 (in2[0]), .A2 (in1[0]), .ZN
       (add_23_2_n_16));
  NR2XD0BWP add_23_2_g249(.A1 (in2[8]), .A2 (in1[8]), .ZN
       (add_23_2_n_15));
  NR2XD0BWP add_23_2_g250(.A1 (in2[6]), .A2 (in1[6]), .ZN
       (add_23_2_n_14));
  NR2XD0BWP add_23_2_g251(.A1 (in2[9]), .A2 (in1[9]), .ZN
       (add_23_2_n_13));
  ND2D1BWP add_23_2_g252(.A1 (in2[6]), .A2 (in1[6]), .ZN
       (add_23_2_n_12));
  ND2D1BWP add_23_2_g253(.A1 (in2[4]), .A2 (in1[4]), .ZN
       (add_23_2_n_11));
  NR2XD0BWP add_23_2_g254(.A1 (in2[5]), .A2 (in1[5]), .ZN
       (add_23_2_n_10));
  ND2D1BWP add_23_2_g255(.A1 (in2[3]), .A2 (in1[3]), .ZN
       (add_23_2_n_9));
  ND2D1BWP add_23_2_g256(.A1 (in2[7]), .A2 (in1[7]), .ZN
       (add_23_2_n_8));
  ND2D1BWP add_23_2_g257(.A1 (in2[5]), .A2 (in1[5]), .ZN
       (add_23_2_n_7));
  CKND2D1BWP add_23_2_g258(.A1 (in2[1]), .A2 (in1[1]), .ZN
       (add_23_2_n_6));
  ND2D1BWP add_23_2_g259(.A1 (in2[2]), .A2 (in1[2]), .ZN
       (add_23_2_n_5));
  NR2XD0BWP add_23_2_g260(.A1 (in2[4]), .A2 (in1[4]), .ZN
       (add_23_2_n_4));
  NR2XD0BWP add_23_2_g261(.A1 (in2[3]), .A2 (in1[3]), .ZN
       (add_23_2_n_3));
  NR2XD0BWP add_23_2_g262(.A1 (in2[7]), .A2 (in1[7]), .ZN
       (add_23_2_n_2));
  NR2XD0BWP add_23_2_g263(.A1 (in2[2]), .A2 (in1[2]), .ZN
       (add_23_2_n_1));
  ND2D1BWP add_23_2_g264(.A1 (in2[8]), .A2 (in1[8]), .ZN
       (add_23_2_n_0));
endmodule

