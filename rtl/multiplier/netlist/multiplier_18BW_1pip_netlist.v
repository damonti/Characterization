
// Generated by Cadence Genus(TM) Synthesis Solution 19.11-s087_1
// Generated on: Jul 28 2022 15:45:07 CEST (Jul 28 2022 13:45:07 UTC)

// Verification Directory fv/multiplier 

module multiplier(a, b, clk, pdt);
  input [8:0] a, b;
  input clk;
  output [17:0] pdt;
  wire [8:0] a, b;
  wire clk;
  wire [17:0] pdt;
  wire [8:0] b_int;
  wire [8:0] a_int;
  wire mul_31_25_n_0, mul_31_25_n_1, mul_31_25_n_2, mul_31_25_n_3,
       mul_31_25_n_4, mul_31_25_n_5, mul_31_25_n_6, mul_31_25_n_7;
  wire mul_31_25_n_8, mul_31_25_n_9, mul_31_25_n_10, mul_31_25_n_11,
       mul_31_25_n_12, mul_31_25_n_13, mul_31_25_n_14, mul_31_25_n_15;
  wire mul_31_25_n_16, mul_31_25_n_17, mul_31_25_n_18, mul_31_25_n_19,
       mul_31_25_n_20, mul_31_25_n_21, mul_31_25_n_22, mul_31_25_n_23;
  wire mul_31_25_n_24, mul_31_25_n_25, mul_31_25_n_26, mul_31_25_n_27,
       mul_31_25_n_28, mul_31_25_n_29, mul_31_25_n_30, mul_31_25_n_31;
  wire mul_31_25_n_32, mul_31_25_n_33, mul_31_25_n_34, mul_31_25_n_35,
       mul_31_25_n_36, mul_31_25_n_37, mul_31_25_n_38, mul_31_25_n_39;
  wire mul_31_25_n_40, mul_31_25_n_41, mul_31_25_n_42, mul_31_25_n_43,
       mul_31_25_n_44, mul_31_25_n_45, mul_31_25_n_46, mul_31_25_n_47;
  wire mul_31_25_n_48, mul_31_25_n_49, mul_31_25_n_50, mul_31_25_n_51,
       mul_31_25_n_52, mul_31_25_n_53, mul_31_25_n_54, mul_31_25_n_55;
  wire mul_31_25_n_56, mul_31_25_n_57, mul_31_25_n_58, mul_31_25_n_59,
       mul_31_25_n_60, mul_31_25_n_61, mul_31_25_n_62, mul_31_25_n_63;
  wire mul_31_25_n_64, mul_31_25_n_65, mul_31_25_n_66, mul_31_25_n_67,
       mul_31_25_n_68, mul_31_25_n_70, mul_31_25_n_71, mul_31_25_n_72;
  wire mul_31_25_n_73, mul_31_25_n_74, mul_31_25_n_75, mul_31_25_n_76,
       mul_31_25_n_77, mul_31_25_n_78, mul_31_25_n_79, mul_31_25_n_80;
  wire mul_31_25_n_81, mul_31_25_n_82, mul_31_25_n_83, mul_31_25_n_84,
       mul_31_25_n_85, mul_31_25_n_86, mul_31_25_n_87, mul_31_25_n_88;
  wire mul_31_25_n_89, mul_31_25_n_90, mul_31_25_n_91, mul_31_25_n_92,
       mul_31_25_n_93, mul_31_25_n_94, mul_31_25_n_95, mul_31_25_n_96;
  wire mul_31_25_n_97, mul_31_25_n_101, mul_31_25_n_102,
       mul_31_25_n_103, mul_31_25_n_104, mul_31_25_n_105,
       mul_31_25_n_106, mul_31_25_n_107;
  wire mul_31_25_n_108, mul_31_25_n_109, mul_31_25_n_110,
       mul_31_25_n_115, mul_31_25_n_116, mul_31_25_n_117,
       mul_31_25_n_118, mul_31_25_n_119;
  wire mul_31_25_n_120, mul_31_25_n_121, mul_31_25_n_122,
       mul_31_25_n_125, mul_31_25_n_126, mul_31_25_n_127,
       mul_31_25_n_128, mul_31_25_n_129;
  wire mul_31_25_n_130, mul_31_25_n_131, mul_31_25_n_132,
       mul_31_25_n_135, mul_31_25_n_136, mul_31_25_n_137,
       mul_31_25_n_138, mul_31_25_n_139;
  wire mul_31_25_n_143, mul_31_25_n_146, mul_31_25_n_147,
       mul_31_25_n_148, mul_31_25_n_149, mul_31_25_n_150,
       mul_31_25_n_151, mul_31_25_n_154;
  wire mul_31_25_n_155, mul_31_25_n_157, mul_31_25_n_158,
       mul_31_25_n_159, mul_31_25_n_160, mul_31_25_n_161,
       mul_31_25_n_176, mul_31_25_n_177;
  wire mul_31_25_n_187, mul_31_25_n_188, mul_31_25_n_227,
       mul_31_25_n_228, mul_31_25_n_230, mul_31_25_n_231,
       mul_31_25_n_233, mul_31_25_n_234;
  wire mul_31_25_n_236, mul_31_25_n_237, n_0, n_1, n_2, n_3, n_4, n_14;
  wire n_15, n_16, n_17, n_258, n_259, n_260, n_261, n_262;
  wire n_263, n_264, n_265, n_266, n_267, n_268, n_269, n_270;
  wire n_271, n_272, n_273, n_274, n_275, n_276, n_277, n_278;
  wire n_279, n_280, n_281, n_282, n_283, n_284, n_285, n_286;
  wire n_287, n_288, n_289, n_290, n_291, n_292, n_293, n_294;
  wire n_295, n_296, n_297, n_298, n_299, n_300, n_301, n_302;
  wire n_303, n_304, n_305, n_306, n_307, n_308, n_309, n_310;
  wire n_311, n_312, n_313, n_314, n_315, n_316, n_317;
  DFQD1BWP \pdt_int_reg[0][17] (.CP (clk), .D (n_0), .Q (pdt[17]));
  DFQD1BWP \pdt_int_reg[0][16] (.CP (clk), .D (n_1), .Q (pdt[16]));
  DFQD1BWP \pdt_int_reg[0][14] (.CP (clk), .D (n_3), .Q (pdt[14]));
  DFQD1BWP \pdt_int_reg[0][10] (.CP (clk), .D (n_269), .Q (pdt[10]));
  DFQD1BWP \pdt_int_reg[0][2] (.CP (clk), .D (n_15), .Q (pdt[2]));
  DFQD1BWP \pdt_int_reg[0][1] (.CP (clk), .D (n_16), .Q (pdt[1]));
  DFQD1BWP \pdt_int_reg[0][9] (.CP (clk), .D (n_273), .Q (pdt[9]));
  DFQD1BWP \pdt_int_reg[0][0] (.CP (clk), .D (n_17), .Q (pdt[0]));
  DFQD1BWP \pdt_int_reg[0][13] (.CP (clk), .D (n_4), .Q (pdt[13]));
  DFQD1BWP \pdt_int_reg[0][8] (.CP (clk), .D (n_277), .Q (pdt[8]));
  DFQD1BWP \pdt_int_reg[0][7] (.CP (clk), .D (n_281), .Q (pdt[7]));
  DFQD1BWP \pdt_int_reg[0][15] (.CP (clk), .D (n_2), .Q (pdt[15]));
  DFQD1BWP \pdt_int_reg[0][12] (.CP (clk), .D (n_261), .Q (pdt[12]));
  DFQD1BWP \pdt_int_reg[0][6] (.CP (clk), .D (n_285), .Q (pdt[6]));
  DFQD1BWP \pdt_int_reg[0][5] (.CP (clk), .D (n_289), .Q (pdt[5]));
  DFQD1BWP \pdt_int_reg[0][11] (.CP (clk), .D (n_265), .Q (pdt[11]));
  DFQD1BWP \pdt_int_reg[0][4] (.CP (clk), .D (n_296), .Q (pdt[4]));
  DFQD1BWP \pdt_int_reg[0][3] (.CP (clk), .D (n_14), .Q (pdt[3]));
  DFQD1BWP \b_int_reg[1] (.CP (clk), .D (b[1]), .Q (b_int[1]));
  DFQD1BWP \a_int_reg[5] (.CP (clk), .D (a[5]), .Q (a_int[5]));
  DFQD1BWP \b_int_reg[7] (.CP (clk), .D (b[7]), .Q (b_int[7]));
  DFQD1BWP \a_int_reg[0] (.CP (clk), .D (a[0]), .Q (a_int[0]));
  DFQD1BWP \a_int_reg[2] (.CP (clk), .D (a[2]), .Q (a_int[2]));
  DFQD1BWP \a_int_reg[8] (.CP (clk), .D (a[8]), .Q (a_int[8]));
  DFQD1BWP \a_int_reg[7] (.CP (clk), .D (a[7]), .Q (a_int[7]));
  DFQD1BWP \b_int_reg[6] (.CP (clk), .D (b[6]), .Q (b_int[6]));
  DFQD1BWP \b_int_reg[8] (.CP (clk), .D (b[8]), .Q (b_int[8]));
  DFQD1BWP \a_int_reg[3] (.CP (clk), .D (a[3]), .Q (a_int[3]));
  DFQD1BWP \b_int_reg[3] (.CP (clk), .D (b[3]), .Q (b_int[3]));
  DFQD1BWP \a_int_reg[6] (.CP (clk), .D (a[6]), .Q (a_int[6]));
  DFQD1BWP \b_int_reg[5] (.CP (clk), .D (b[5]), .Q (b_int[5]));
  DFQD1BWP \b_int_reg[2] (.CP (clk), .D (b[2]), .Q (b_int[2]));
  DFQD1BWP \a_int_reg[4] (.CP (clk), .D (a[4]), .Q (a_int[4]));
  DFQD1BWP \b_int_reg[0] (.CP (clk), .D (b[0]), .Q (b_int[0]));
  DFQD1BWP \a_int_reg[1] (.CP (clk), .D (a[1]), .Q (a_int[1]));
  DFQD1BWP \b_int_reg[4] (.CP (clk), .D (b[4]), .Q (b_int[4]));
  CKND1BWP mul_31_25_g1854(.I (mul_31_25_n_237), .ZN (n_1));
  CKND1BWP mul_31_25_g1855(.I (mul_31_25_n_236), .ZN (n_0));
  FA1D0BWP mul_31_25_g1856__2398(.A (mul_31_25_n_146), .B
       (mul_31_25_n_59), .CI (mul_31_25_n_233), .CO (mul_31_25_n_236),
       .S (mul_31_25_n_237));
  CKND1BWP mul_31_25_g1857(.I (mul_31_25_n_234), .ZN (n_2));
  FA1D0BWP mul_31_25_g1858__5107(.A (n_303), .B (mul_31_25_n_147), .CI
       (mul_31_25_n_230), .CO (mul_31_25_n_233), .S (mul_31_25_n_234));
  CKND1BWP mul_31_25_g1859(.I (mul_31_25_n_231), .ZN (n_3));
  FA1D0BWP mul_31_25_g1860__6260(.A (n_290), .B (n_304), .CI
       (mul_31_25_n_227), .CO (mul_31_25_n_230), .S (mul_31_25_n_231));
  CKND1BWP mul_31_25_g1861(.I (mul_31_25_n_228), .ZN (n_4));
  FA1D0BWP mul_31_25_g1862__4319(.A (n_259), .B (n_291), .CI (n_258),
       .CO (mul_31_25_n_227), .S (mul_31_25_n_228));
  FA1D0BWP mul_31_25_g1886__6161(.A (n_299), .B (mul_31_25_n_110), .CI
       (n_312), .CO (mul_31_25_n_187), .S (mul_31_25_n_188));
  FA1D0BWP mul_31_25_g1892__1666(.A (mul_31_25_n_150), .B
       (mul_31_25_n_120), .CI (mul_31_25_n_137), .CO (mul_31_25_n_176),
       .S (mul_31_25_n_177));
  FA1D0BWP mul_31_25_g1900__8428(.A (mul_31_25_n_127), .B (n_314), .CI
       (mul_31_25_n_130), .CO (mul_31_25_n_160), .S (mul_31_25_n_161));
  FA1D0BWP mul_31_25_g1901__5526(.A (mul_31_25_n_101), .B (n_311), .CI
       (mul_31_25_n_122), .CO (mul_31_25_n_158), .S (mul_31_25_n_159));
  MAOI222D1BWP mul_31_25_g1902__6783(.A (mul_31_25_n_143), .B
       (mul_31_25_n_135), .C (mul_31_25_n_85), .ZN (mul_31_25_n_157));
  XOR3D1BWP mul_31_25_g1903__3680(.A1 (mul_31_25_n_85), .A2
       (mul_31_25_n_135), .A3 (mul_31_25_n_143), .Z (n_14));
  FA1D0BWP mul_31_25_g1904__1617(.A (mul_31_25_n_107), .B
       (mul_31_25_n_90), .CI (mul_31_25_n_106), .CO (mul_31_25_n_154),
       .S (mul_31_25_n_155));
  FA1D0BWP mul_31_25_g1906__1705(.A (mul_31_25_n_93), .B
       (mul_31_25_n_81), .CI (mul_31_25_n_105), .CO (mul_31_25_n_150),
       .S (mul_31_25_n_151));
  FA1D0BWP mul_31_25_g1907__5122(.A (mul_31_25_n_9), .B
       (mul_31_25_n_7), .CI (mul_31_25_n_109), .CO (mul_31_25_n_148),
       .S (mul_31_25_n_149));
  FA1D0BWP mul_31_25_g1908__8246(.A (mul_31_25_n_52), .B
       (mul_31_25_n_47), .CI (n_305), .CO (mul_31_25_n_146), .S
       (mul_31_25_n_147));
  FA1D0BWP mul_31_25_g1910__6131(.A (mul_31_25_n_83), .B
       (mul_31_25_n_46), .CI (mul_31_25_n_96), .CO (mul_31_25_n_143),
       .S (n_15));
  FA1D0BWP mul_31_25_g1912__5115(.A (mul_31_25_n_87), .B
       (mul_31_25_n_10), .CI (mul_31_25_n_97), .CO (mul_31_25_n_138),
       .S (mul_31_25_n_139));
  FA1D0BWP mul_31_25_g1913__7482(.A (mul_31_25_n_82), .B
       (mul_31_25_n_55), .CI (mul_31_25_n_95), .CO (mul_31_25_n_136),
       .S (mul_31_25_n_137));
  INVD1BWP mul_31_25_g1914(.I (mul_31_25_n_118), .ZN (mul_31_25_n_135));
  FA1D0BWP mul_31_25_g1916__6161(.A (mul_31_25_n_60), .B
       (mul_31_25_n_57), .CI (mul_31_25_n_23), .CO (mul_31_25_n_131),
       .S (mul_31_25_n_132));
  FA1D0BWP mul_31_25_g1917__9315(.A (mul_31_25_n_43), .B
       (mul_31_25_n_24), .CI (mul_31_25_n_58), .CO (mul_31_25_n_129),
       .S (mul_31_25_n_130));
  FA1D0BWP mul_31_25_g1918__9945(.A (mul_31_25_n_11), .B
       (mul_31_25_n_18), .CI (mul_31_25_n_28), .CO (mul_31_25_n_127),
       .S (mul_31_25_n_128));
  FA1D0BWP mul_31_25_g1919__2883(.A (mul_31_25_n_41), .B
       (mul_31_25_n_13), .CI (mul_31_25_n_89), .CO (mul_31_25_n_125),
       .S (mul_31_25_n_126));
  FA1D0BWP mul_31_25_g1921__1666(.A (mul_31_25_n_56), .B
       (mul_31_25_n_49), .CI (mul_31_25_n_31), .CO (mul_31_25_n_121),
       .S (mul_31_25_n_122));
  FA1D0BWP mul_31_25_g1922__7410(.A (mul_31_25_n_8), .B
       (mul_31_25_n_48), .CI (mul_31_25_n_32), .CO (mul_31_25_n_119),
       .S (mul_31_25_n_120));
  FA1D0BWP mul_31_25_g1923__6417(.A (mul_31_25_n_21), .B
       (mul_31_25_n_54), .CI (mul_31_25_n_92), .CO (mul_31_25_n_117),
       .S (mul_31_25_n_118));
  FA1D0BWP mul_31_25_g1924__5477(.A (mul_31_25_n_67), .B
       (mul_31_25_n_53), .CI (mul_31_25_n_44), .CO (mul_31_25_n_115),
       .S (mul_31_25_n_116));
  FA1D0BWP mul_31_25_g1927__6260(.A (mul_31_25_n_61), .B
       (mul_31_25_n_16), .CI (mul_31_25_n_27), .CO (mul_31_25_n_109),
       .S (mul_31_25_n_110));
  FA1D0BWP mul_31_25_g1928__4319(.A (mul_31_25_n_20), .B
       (mul_31_25_n_62), .CI (mul_31_25_n_25), .CO (mul_31_25_n_107),
       .S (mul_31_25_n_108));
  FA1D0BWP mul_31_25_g1929__8428(.A (mul_31_25_n_45), .B
       (mul_31_25_n_19), .CI (mul_31_25_n_29), .CO (mul_31_25_n_105),
       .S (mul_31_25_n_106));
  FA1D0BWP mul_31_25_g1930__5526(.A (mul_31_25_n_51), .B
       (mul_31_25_n_12), .CI (mul_31_25_n_66), .CO (mul_31_25_n_103),
       .S (mul_31_25_n_104));
  FA1D0BWP mul_31_25_g1931__6783(.A (mul_31_25_n_1), .B
       (mul_31_25_n_2), .CI (mul_31_25_n_65), .CO (mul_31_25_n_101), .S
       (mul_31_25_n_102));
  AOI21D1BWP mul_31_25_g1933__1617(.A1 (mul_31_25_n_79), .A2
       (mul_31_25_n_80), .B (mul_31_25_n_83), .ZN (n_16));
  XNR2D1BWP mul_31_25_g1934__2802(.A1 (mul_31_25_n_39), .A2
       (mul_31_25_n_74), .ZN (mul_31_25_n_97));
  XOR2D1BWP mul_31_25_g1935__1705(.A1 (mul_31_25_n_71), .A2
       (mul_31_25_n_72), .Z (mul_31_25_n_96));
  XNR2D1BWP mul_31_25_g1936__5122(.A1 (mul_31_25_n_73), .A2
       (mul_31_25_n_37), .ZN (mul_31_25_n_95));
  XNR2D1BWP mul_31_25_g1937__8246(.A1 (mul_31_25_n_77), .A2
       (mul_31_25_n_34), .ZN (mul_31_25_n_94));
  XNR2D1BWP mul_31_25_g1938__7098(.A1 (mul_31_25_n_38), .A2
       (mul_31_25_n_35), .ZN (mul_31_25_n_93));
  XNR2D1BWP mul_31_25_g1939__6131(.A1 (mul_31_25_n_75), .A2
       (mul_31_25_n_76), .ZN (mul_31_25_n_92));
  XNR2D1BWP mul_31_25_g1940__1881(.A1 (mul_31_25_n_40), .A2
       (mul_31_25_n_70), .ZN (mul_31_25_n_91));
  XNR2D1BWP mul_31_25_g1941__5115(.A1 (mul_31_25_n_78), .A2
       (mul_31_25_n_36), .ZN (mul_31_25_n_90));
  OR2D1BWP mul_31_25_g1942__7482(.A1 (mul_31_25_n_74), .A2
       (mul_31_25_n_39), .Z (mul_31_25_n_89));
  OR2D1BWP mul_31_25_g1943__4733(.A1 (mul_31_25_n_77), .A2
       (mul_31_25_n_34), .Z (mul_31_25_n_88));
  OR2D1BWP mul_31_25_g1944__6161(.A1 (mul_31_25_n_70), .A2
       (mul_31_25_n_40), .Z (mul_31_25_n_87));
  OR2XD1BWP mul_31_25_g1945__9315(.A1 (mul_31_25_n_37), .A2
       (mul_31_25_n_73), .Z (mul_31_25_n_86));
  NR2XD0BWP mul_31_25_g1946__9945(.A1 (mul_31_25_n_71), .A2
       (mul_31_25_n_72), .ZN (mul_31_25_n_85));
  OR2XD1BWP mul_31_25_g1947__2883(.A1 (mul_31_25_n_75), .A2
       (mul_31_25_n_76), .Z (mul_31_25_n_84));
  NR2XD0BWP mul_31_25_g1948__2346(.A1 (mul_31_25_n_79), .A2
       (mul_31_25_n_80), .ZN (mul_31_25_n_83));
  OR2D1BWP mul_31_25_g1949__1666(.A1 (mul_31_25_n_35), .A2
       (mul_31_25_n_38), .Z (mul_31_25_n_82));
  OR2D1BWP mul_31_25_g1950__7410(.A1 (mul_31_25_n_36), .A2
       (mul_31_25_n_78), .Z (mul_31_25_n_81));
  AN2XD1BWP mul_31_25_g1951__6417(.A1 (b_int[0]), .A2 (a_int[0]), .Z
       (n_17));
  CKND2D1BWP mul_31_25_g1952__5477(.A1 (b_int[1]), .A2 (a_int[0]), .ZN
       (mul_31_25_n_80));
  CKND2D1BWP mul_31_25_g1953__2398(.A1 (b_int[0]), .A2 (a_int[1]), .ZN
       (mul_31_25_n_79));
  CKND2D1BWP mul_31_25_g1954__5107(.A1 (b_int[1]), .A2 (a_int[5]), .ZN
       (mul_31_25_n_78));
  CKND2D1BWP mul_31_25_g1955__6260(.A1 (b_int[1]), .A2 (a_int[8]), .ZN
       (mul_31_25_n_77));
  CKND2D1BWP mul_31_25_g1956__4319(.A1 (b_int[0]), .A2 (a_int[3]), .ZN
       (mul_31_25_n_76));
  CKND2D1BWP mul_31_25_g1957__8428(.A1 (b_int[1]), .A2 (a_int[2]), .ZN
       (mul_31_25_n_75));
  CKND2D1BWP mul_31_25_g1958__5526(.A1 (a_int[1]), .A2 (b_int[8]), .ZN
       (mul_31_25_n_68));
  ND2D1BWP mul_31_25_g1959__6783(.A1 (b_int[8]), .A2 (a_int[5]), .ZN
       (mul_31_25_n_67));
  CKND2D1BWP mul_31_25_g1960__3680(.A1 (a_int[0]), .A2 (b_int[4]), .ZN
       (mul_31_25_n_66));
  ND2D1BWP mul_31_25_g1961__1617(.A1 (b_int[0]), .A2 (a_int[5]), .ZN
       (mul_31_25_n_74));
  CKND2D1BWP mul_31_25_g1962__2802(.A1 (b_int[1]), .A2 (a_int[7]), .ZN
       (mul_31_25_n_73));
  CKND2D1BWP mul_31_25_g1963__1705(.A1 (a_int[0]), .A2 (b_int[2]), .ZN
       (mul_31_25_n_72));
  CKND2D1BWP mul_31_25_g1964__5122(.A1 (a_int[0]), .A2 (b_int[7]), .ZN
       (mul_31_25_n_65));
  ND2D1BWP mul_31_25_g1965__8246(.A1 (b_int[5]), .A2 (a_int[5]), .ZN
       (mul_31_25_n_64));
  CKND2D1BWP mul_31_25_g1966__7098(.A1 (b_int[0]), .A2 (a_int[2]), .ZN
       (mul_31_25_n_71));
  CKND2D1BWP mul_31_25_g1967__6131(.A1 (b_int[0]), .A2 (a_int[4]), .ZN
       (mul_31_25_n_70));
  ND2D1BWP mul_31_25_g1968__1881(.A1 (b_int[6]), .A2 (a_int[8]), .ZN
       (mul_31_25_n_63));
  ND2D1BWP mul_31_25_g1969__5115(.A1 (b_int[2]), .A2 (a_int[3]), .ZN
       (mul_31_25_n_62));
  CKND2D1BWP mul_31_25_g1970__7482(.A1 (b_int[5]), .A2 (a_int[6]), .ZN
       (mul_31_25_n_61));
  CKND2D1BWP mul_31_25_g1971__4733(.A1 (b_int[3]), .A2 (a_int[6]), .ZN
       (mul_31_25_n_60));
  ND2D1BWP mul_31_25_g1972__6161(.A1 (b_int[8]), .A2 (a_int[8]), .ZN
       (mul_31_25_n_59));
  ND2D1BWP mul_31_25_g1973__9315(.A1 (b_int[3]), .A2 (a_int[8]), .ZN
       (mul_31_25_n_58));
  ND2D1BWP mul_31_25_g1974__9945(.A1 (a_int[3]), .A2 (b_int[6]), .ZN
       (mul_31_25_n_57));
  CKND2D1BWP mul_31_25_g1975__2883(.A1 (b_int[2]), .A2 (a_int[6]), .ZN
       (mul_31_25_n_56));
  ND2D1BWP mul_31_25_g1976__2346(.A1 (a_int[2]), .A2 (b_int[6]), .ZN
       (mul_31_25_n_55));
  ND2D1BWP mul_31_25_g1977__1666(.A1 (a_int[0]), .A2 (b_int[3]), .ZN
       (mul_31_25_n_54));
  ND2D1BWP mul_31_25_g1978__7410(.A1 (b_int[6]), .A2 (a_int[7]), .ZN
       (mul_31_25_n_53));
  CKND2D1BWP mul_31_25_g1979__6417(.A1 (b_int[7]), .A2 (a_int[8]), .ZN
       (mul_31_25_n_52));
  CKND2D1BWP mul_31_25_g1980__5477(.A1 (a_int[2]), .A2 (b_int[2]), .ZN
       (mul_31_25_n_51));
  ND2D1BWP mul_31_25_g1981__2398(.A1 (b_int[2]), .A2 (a_int[5]), .ZN
       (mul_31_25_n_50));
  ND2D1BWP mul_31_25_g1982__5107(.A1 (b_int[4]), .A2 (a_int[4]), .ZN
       (mul_31_25_n_49));
  ND2D1BWP mul_31_25_g1983__6260(.A1 (b_int[3]), .A2 (a_int[5]), .ZN
       (mul_31_25_n_48));
  ND2D1BWP mul_31_25_g1984__4319(.A1 (b_int[8]), .A2 (a_int[7]), .ZN
       (mul_31_25_n_47));
  AN2XD1BWP mul_31_25_g1985__8428(.A1 (b_int[1]), .A2 (a_int[1]), .Z
       (mul_31_25_n_46));
  CKND2D1BWP mul_31_25_g1986__5526(.A1 (b_int[2]), .A2 (a_int[4]), .ZN
       (mul_31_25_n_45));
  CKND2D1BWP mul_31_25_g1987__6783(.A1 (b_int[5]), .A2 (a_int[8]), .ZN
       (mul_31_25_n_44));
  CKND2D1BWP mul_31_25_g1988__3680(.A1 (b_int[4]), .A2 (a_int[7]), .ZN
       (mul_31_25_n_43));
  CKND2D1BWP mul_31_25_g1989__1617(.A1 (a_int[2]), .A2 (b_int[5]), .ZN
       (mul_31_25_n_42));
  ND2D1BWP mul_31_25_g1990__2802(.A1 (a_int[1]), .A2 (b_int[5]), .ZN
       (mul_31_25_n_41));
  CKND2D1BWP mul_31_25_g1991__1705(.A1 (a_int[6]), .A2 (b_int[8]), .ZN
       (mul_31_25_n_33));
  CKND2D1BWP mul_31_25_g1992__5122(.A1 (a_int[0]), .A2 (b_int[8]), .ZN
       (mul_31_25_n_32));
  ND2D1BWP mul_31_25_g1993__8246(.A1 (b_int[5]), .A2 (a_int[3]), .ZN
       (mul_31_25_n_31));
  CKND2D1BWP mul_31_25_g1994__7098(.A1 (b_int[1]), .A2 (a_int[3]), .ZN
       (mul_31_25_n_40));
  CKND2D1BWP mul_31_25_g1995__6131(.A1 (b_int[1]), .A2 (a_int[4]), .ZN
       (mul_31_25_n_39));
  ND2D1BWP mul_31_25_g1996__1881(.A1 (b_int[1]), .A2 (a_int[6]), .ZN
       (mul_31_25_n_38));
  ND2D1BWP mul_31_25_g1997__5115(.A1 (b_int[7]), .A2 (a_int[5]), .ZN
       (mul_31_25_n_30));
  ND2D1BWP mul_31_25_g1998__7482(.A1 (a_int[2]), .A2 (b_int[4]), .ZN
       (mul_31_25_n_29));
  CKND2D1BWP mul_31_25_g1999__4733(.A1 (b_int[0]), .A2 (a_int[8]), .ZN
       (mul_31_25_n_37));
  ND2D1BWP mul_31_25_g2000__6161(.A1 (a_int[3]), .A2 (b_int[7]), .ZN
       (mul_31_25_n_28));
  CKND2D1BWP mul_31_25_g2001__9315(.A1 (a_int[3]), .A2 (b_int[8]), .ZN
       (mul_31_25_n_27));
  CKND2D1BWP mul_31_25_g2002__9945(.A1 (b_int[0]), .A2 (a_int[6]), .ZN
       (mul_31_25_n_36));
  CKND2D1BWP mul_31_25_g2003__2883(.A1 (a_int[1]), .A2 (b_int[6]), .ZN
       (mul_31_25_n_26));
  ND2D1BWP mul_31_25_g2004__2346(.A1 (b_int[0]), .A2 (a_int[7]), .ZN
       (mul_31_25_n_35));
  CKND2D1BWP mul_31_25_g2005__1666(.A1 (a_int[1]), .A2 (b_int[4]), .ZN
       (mul_31_25_n_25));
  ND2D1BWP mul_31_25_g2006__7410(.A1 (b_int[2]), .A2 (a_int[7]), .ZN
       (mul_31_25_n_34));
  ND2D1BWP mul_31_25_g2007__6417(.A1 (b_int[6]), .A2 (a_int[5]), .ZN
       (mul_31_25_n_24));
  ND2D1BWP mul_31_25_g2008__5477(.A1 (a_int[2]), .A2 (b_int[7]), .ZN
       (mul_31_25_n_23));
  ND2D1BWP mul_31_25_g2009__2398(.A1 (a_int[6]), .A2 (b_int[7]), .ZN
       (mul_31_25_n_22));
  CKND2D1BWP mul_31_25_g2010__5107(.A1 (a_int[1]), .A2 (b_int[2]), .ZN
       (mul_31_25_n_21));
  CKND2D1BWP mul_31_25_g2011__6260(.A1 (a_int[2]), .A2 (b_int[3]), .ZN
       (mul_31_25_n_20));
  ND2D1BWP mul_31_25_g2012__4319(.A1 (b_int[3]), .A2 (a_int[3]), .ZN
       (mul_31_25_n_19));
  ND2D1BWP mul_31_25_g2013__8428(.A1 (a_int[4]), .A2 (b_int[6]), .ZN
       (mul_31_25_n_18));
  CKND2D1BWP mul_31_25_g2014__5526(.A1 (b_int[4]), .A2 (a_int[8]), .ZN
       (mul_31_25_n_17));
  ND2D1BWP mul_31_25_g2015__6783(.A1 (a_int[4]), .A2 (b_int[7]), .ZN
       (mul_31_25_n_16));
  CKND2D1BWP mul_31_25_g2016__3680(.A1 (b_int[2]), .A2 (a_int[8]), .ZN
       (mul_31_25_n_15));
  CKND2D1BWP mul_31_25_g2017__1617(.A1 (b_int[5]), .A2 (a_int[7]), .ZN
       (mul_31_25_n_14));
  ND2D1BWP mul_31_25_g2018__2802(.A1 (a_int[0]), .A2 (b_int[6]), .ZN
       (mul_31_25_n_13));
  ND2D1BWP mul_31_25_g2019__1705(.A1 (a_int[1]), .A2 (b_int[3]), .ZN
       (mul_31_25_n_12));
  CKND2D1BWP mul_31_25_g2020__5122(.A1 (b_int[4]), .A2 (a_int[6]), .ZN
       (mul_31_25_n_11));
  ND2D1BWP mul_31_25_g2021__8246(.A1 (a_int[0]), .A2 (b_int[5]), .ZN
       (mul_31_25_n_10));
  CKND2D1BWP mul_31_25_g2022__7098(.A1 (a_int[6]), .A2 (b_int[6]), .ZN
       (mul_31_25_n_9));
  CKND2D1BWP mul_31_25_g2023__6131(.A1 (a_int[1]), .A2 (b_int[7]), .ZN
       (mul_31_25_n_8));
  ND2D1BWP mul_31_25_g2024__1881(.A1 (a_int[4]), .A2 (b_int[8]), .ZN
       (mul_31_25_n_7));
  ND2D1BWP mul_31_25_g2025__5115(.A1 (b_int[3]), .A2 (a_int[7]), .ZN
       (mul_31_25_n_6));
  ND2D1BWP mul_31_25_g2026__7482(.A1 (b_int[4]), .A2 (a_int[5]), .ZN
       (mul_31_25_n_5));
  ND2D1BWP mul_31_25_g2027__4733(.A1 (a_int[2]), .A2 (b_int[8]), .ZN
       (mul_31_25_n_4));
  CKND2D1BWP mul_31_25_g2028__6161(.A1 (b_int[5]), .A2 (a_int[4]), .ZN
       (mul_31_25_n_3));
  ND2D1BWP mul_31_25_g2029__9315(.A1 (b_int[4]), .A2 (a_int[3]), .ZN
       (mul_31_25_n_2));
  CKND2D1BWP mul_31_25_g2030__9945(.A1 (b_int[3]), .A2 (a_int[4]), .ZN
       (mul_31_25_n_1));
  ND2D1BWP mul_31_25_g2031__2883(.A1 (b_int[7]), .A2 (a_int[7]), .ZN
       (mul_31_25_n_0));
  CMPE42D1BWP g2(.A (n_307), .B (mul_31_25_n_160), .C
       (mul_31_25_n_187), .CIX (n_263), .D (n_262), .CO (n_258), .COX
       (n_259), .S (n_260));
  INVD0BWP g3(.I (n_260), .ZN (n_261));
  CMPE42D1BWP g2032(.A (mul_31_25_n_188), .B (mul_31_25_n_161), .C
       (n_297), .CIX (n_267), .D (n_266), .CO (n_262), .COX (n_263), .S
       (n_264));
  INVD0BWP g2033(.I (n_264), .ZN (n_265));
  CMPE42D1BWP g2034(.A (n_300), .B (n_313), .C (n_298), .CIX (n_271),
       .D (n_270), .CO (n_266), .COX (n_267), .S (n_268));
  INVD0BWP g2035(.I (n_268), .ZN (n_269));
  CMPE42D1BWP g2036(.A (mul_31_25_n_176), .B (n_316), .C (n_301), .CIX
       (n_275), .D (n_274), .CO (n_270), .COX (n_271), .S (n_272));
  INVD0BWP g2037(.I (n_272), .ZN (n_273));
  CMPE42D1BWP g2038(.A (n_309), .B (mul_31_25_n_159), .C
       (mul_31_25_n_177), .CIX (n_279), .D (n_278), .CO (n_274), .COX
       (n_275), .S (n_276));
  INVD0BWP g2039(.I (n_276), .ZN (n_277));
  CMPE42D1BWP g2040(.A (mul_31_25_n_154), .B (mul_31_25_n_151), .C
       (n_310), .CIX (n_283), .D (n_282), .CO (n_278), .COX (n_279), .S
       (n_280));
  INVD0BWP g2041(.I (n_280), .ZN (n_281));
  CMPE42D1BWP g2042(.A (mul_31_25_n_138), .B (mul_31_25_n_126), .C
       (mul_31_25_n_155), .CIX (n_287), .D (n_286), .CO (n_282), .COX
       (n_283), .S (n_284));
  INVD0BWP g2043(.I (n_284), .ZN (n_285));
  CMPE42D1BWP g2044(.A (mul_31_25_n_108), .B (mul_31_25_n_103), .C
       (mul_31_25_n_139), .CIX (n_294), .D (n_293), .CO (n_286), .COX
       (n_287), .S (n_288));
  INVD0BWP g2045(.I (n_288), .ZN (n_289));
  CMPE42D1BWP g2046(.A (n_308), .B (mul_31_25_n_22), .C
       (mul_31_25_n_116), .CIX (mul_31_25_n_148), .D (n_306), .CO
       (n_290), .COX (n_292), .S (n_291));
  CMPE42D1BWP g2047(.A (mul_31_25_n_91), .B (mul_31_25_n_84), .C
       (mul_31_25_n_104), .CIX (mul_31_25_n_117), .D (mul_31_25_n_157),
       .CO (n_293), .COX (n_294), .S (n_295));
  INVD0BWP g2048(.I (n_295), .ZN (n_296));
  CMPE42D1BWP g2049(.A (mul_31_25_n_88), .B (mul_31_25_n_4), .C
       (n_317), .CIX (n_302), .D (n_315), .CO (n_297), .COX (n_299), .S
       (n_298));
  CMPE42D1BWP g2050(.A (mul_31_25_n_94), .B (mul_31_25_n_86), .C
       (mul_31_25_n_119), .CIX (mul_31_25_n_136), .D (mul_31_25_n_158),
       .CO (n_300), .COX (n_302), .S (n_301));
  CMPE42D1BWP g2051(.A (mul_31_25_n_63), .B (mul_31_25_n_0), .C
       (mul_31_25_n_33), .CIX (mul_31_25_n_115), .D (n_292), .CO
       (n_303), .COX (n_305), .S (n_304));
  CMPE42D1BWP g2052(.A (mul_31_25_n_14), .B (mul_31_25_n_30), .C
       (mul_31_25_n_17), .CIX (mul_31_25_n_129), .D (mul_31_25_n_149),
       .CO (n_306), .COX (n_308), .S (n_307));
  CMPE42D1BWP g2053(.A (mul_31_25_n_42), .B (mul_31_25_n_50), .C
       (mul_31_25_n_26), .CIX (mul_31_25_n_125), .D (mul_31_25_n_102),
       .CO (n_309), .COX (n_311), .S (n_310));
  CMPE42D1BWP g2054(.A (mul_31_25_n_15), .B (mul_31_25_n_6), .C
       (mul_31_25_n_64), .CIX (mul_31_25_n_131), .D (mul_31_25_n_128),
       .CO (n_312), .COX (n_314), .S (n_313));
  CMPE42D1BWP g2055(.A (mul_31_25_n_3), .B (mul_31_25_n_5), .C
       (mul_31_25_n_68), .CIX (mul_31_25_n_121), .D (mul_31_25_n_132),
       .CO (n_315), .COX (n_317), .S (n_316));
endmodule

