`timescale 1ps / 1ps

// Generated by Cadence Genus(TM) Synthesis Solution 19.11-s087_1
// Generated on: Sep  7 2022 16:12:07 CEST (Sep  7 2022 14:12:07 UTC)

module fir_DECODE_16U_15_4(in1, out1);
  input [3:0] in1;
  output [15:0] out1;
  wire [3:0] in1;
  wire [15:0] out1;
  wire sll_19_38_n_0, sll_19_38_n_1, sll_19_38_n_2, sll_19_38_n_3,
       sll_19_38_n_4, sll_19_38_n_5, sll_19_38_n_6, sll_19_38_n_7;
  NOR2BX1 sll_19_38_g147(.AN (sll_19_38_n_6), .B (sll_19_38_n_5), .Y
       (out1[8]));
  NOR2X1 sll_19_38_g148(.A (sll_19_38_n_7), .B (sll_19_38_n_5), .Y
       (out1[14]));
  NOR2BX1 sll_19_38_g149(.AN (sll_19_38_n_6), .B (sll_19_38_n_2), .Y
       (out1[9]));
  NOR2BX1 sll_19_38_g150(.AN (sll_19_38_n_6), .B (sll_19_38_n_4), .Y
       (out1[1]));
  NOR2X1 sll_19_38_g151(.A (sll_19_38_n_7), .B (sll_19_38_n_2), .Y
       (out1[15]));
  NOR2X1 sll_19_38_g152(.A (sll_19_38_n_7), .B (sll_19_38_n_4), .Y
       (out1[7]));
  NOR2X1 sll_19_38_g153(.A (sll_19_38_n_2), .B (sll_19_38_n_3), .Y
       (out1[13]));
  NOR2BX1 sll_19_38_g154(.AN (sll_19_38_n_1), .B (sll_19_38_n_7), .Y
       (out1[6]));
  NOR2X1 sll_19_38_g155(.A (sll_19_38_n_4), .B (sll_19_38_n_0), .Y
       (out1[3]));
  NOR2BX1 sll_19_38_g156(.AN (sll_19_38_n_1), .B (sll_19_38_n_3), .Y
       (out1[4]));
  NOR2BX1 sll_19_38_g157(.AN (sll_19_38_n_1), .B (sll_19_38_n_0), .Y
       (out1[2]));
  AND2XL sll_19_38_g158(.A (sll_19_38_n_6), .B (sll_19_38_n_1), .Y
       (out1[0]));
  NOR2X1 sll_19_38_g159(.A (sll_19_38_n_2), .B (sll_19_38_n_0), .Y
       (out1[11]));
  NOR2X1 sll_19_38_g160(.A (sll_19_38_n_4), .B (sll_19_38_n_3), .Y
       (out1[5]));
  NOR2X1 sll_19_38_g161(.A (sll_19_38_n_3), .B (sll_19_38_n_5), .Y
       (out1[12]));
  NOR2X1 sll_19_38_g162(.A (sll_19_38_n_0), .B (sll_19_38_n_5), .Y
       (out1[10]));
  NAND2X1 sll_19_38_g163(.A (in1[2]), .B (in1[1]), .Y (sll_19_38_n_7));
  NOR2X1 sll_19_38_g164(.A (in1[2]), .B (in1[1]), .Y (sll_19_38_n_6));
  NAND2BX1 sll_19_38_g165(.AN (in1[0]), .B (in1[3]), .Y
       (sll_19_38_n_5));
  NAND2BX1 sll_19_38_g166(.AN (in1[3]), .B (in1[0]), .Y
       (sll_19_38_n_4));
  NAND2BX1 sll_19_38_g167(.AN (in1[1]), .B (in1[2]), .Y
       (sll_19_38_n_3));
  NAND2X1 sll_19_38_g168(.A (in1[3]), .B (in1[0]), .Y (sll_19_38_n_2));
  NOR2X1 sll_19_38_g169(.A (in1[3]), .B (in1[0]), .Y (sll_19_38_n_1));
  NAND2BX1 sll_19_38_g170(.AN (in1[2]), .B (in1[1]), .Y
       (sll_19_38_n_0));
endmodule

