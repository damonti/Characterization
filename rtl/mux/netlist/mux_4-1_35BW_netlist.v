
// Generated by Cadence Genus(TM) Synthesis Solution 19.11-s087_1
// Generated on: Jul 20 2022 17:31:58 CEST (Jul 20 2022 15:31:58 UTC)

// Verification Directory fv/mux 

module mux(idata_0, ivalid_0, ivch_0, idata_1, ivalid_1, ivch_1,
     idata_2, ivalid_2, ivch_2, idata_3, ivalid_3, ivch_3, sel, odata,
     ovalid, ovch);
  input [37:0] idata_0, idata_1, idata_2, idata_3;
  input ivalid_0, ivalid_1, ivalid_2, ivalid_3;
  input [1:0] ivch_0, ivch_1, ivch_2, ivch_3;
  input [3:0] sel;
  output [37:0] odata;
  output ovalid;
  output [1:0] ovch;
  wire [37:0] idata_0, idata_1, idata_2, idata_3;
  wire ivalid_0, ivalid_1, ivalid_2, ivalid_3;
  wire [1:0] ivch_0, ivch_1, ivch_2, ivch_3;
  wire [3:0] sel;
  wire [37:0] odata;
  wire ovalid;
  wire [1:0] ovch;
  wire n_0, n_1, n_2, n_3, n_4, n_5, n_6, n_7;
  wire n_8, n_9, n_10, n_11, n_12, n_13, n_14, n_15;
  wire n_16, n_17, n_18, n_19, n_20, n_21, n_22, n_23;
  wire n_24, n_25, n_26, n_27, n_28, n_29, n_30, n_31;
  wire n_32, n_33, n_34, n_35, n_36, n_37, n_38, n_39;
  wire n_40, n_41, n_42, n_43, n_44, n_45, n_64, n_77;
  wire n_87, n_88;
  AO221D0BWP g2181__2398(.A1 (n_88), .A2 (idata_0[29]), .B1 (n_87), .B2
       (idata_1[29]), .C (n_26), .Z (odata[29]));
  AO221D0BWP g2174__5107(.A1 (n_88), .A2 (idata_0[36]), .B1 (n_87), .B2
       (idata_1[36]), .C (n_37), .Z (odata[36]));
  AO221D0BWP g2175__6260(.A1 (n_88), .A2 (idata_0[34]), .B1 (n_87), .B2
       (idata_1[34]), .C (n_33), .Z (odata[34]));
  AO221D0BWP g2186__4319(.A1 (n_88), .A2 (idata_0[33]), .B1 (n_87), .B2
       (idata_1[33]), .C (n_39), .Z (odata[33]));
  AO221D0BWP g2154__8428(.A1 (n_88), .A2 (idata_0[32]), .B1 (n_64), .B2
       (idata_3[32]), .C (n_30), .Z (odata[32]));
  AO221D0BWP g2152__5526(.A1 (n_88), .A2 (idata_0[37]), .B1 (n_77), .B2
       (idata_2[37]), .C (n_40), .Z (odata[37]));
  AO221D0BWP g2187__6783(.A1 (n_88), .A2 (idata_0[28]), .B1 (n_87), .B2
       (idata_1[28]), .C (n_41), .Z (odata[28]));
  AO221D0BWP g2191__3680(.A1 (n_88), .A2 (idata_0[27]), .B1 (n_87), .B2
       (idata_1[27]), .C (n_35), .Z (odata[27]));
  AO221D0BWP g2176__1617(.A1 (n_88), .A2 (idata_0[21]), .B1 (n_87), .B2
       (idata_1[21]), .C (n_32), .Z (odata[21]));
  AO221D0BWP g2178__2802(.A1 (n_88), .A2 (idata_0[20]), .B1 (n_87), .B2
       (idata_1[20]), .C (n_34), .Z (odata[20]));
  AO221D0BWP g2182__1705(.A1 (n_88), .A2 (idata_0[19]), .B1 (n_77), .B2
       (idata_2[19]), .C (n_24), .Z (odata[19]));
  AO221D0BWP g2179__5122(.A1 (n_88), .A2 (idata_0[2]), .B1 (n_87), .B2
       (idata_1[2]), .C (n_29), .Z (odata[2]));
  AO221D0BWP g2190__8246(.A1 (n_88), .A2 (idata_0[17]), .B1 (n_87), .B2
       (idata_1[17]), .C (n_45), .Z (odata[17]));
  AO221D0BWP g2172__7098(.A1 (n_88), .A2 (idata_0[16]), .B1 (n_87), .B2
       (idata_1[16]), .C (n_36), .Z (odata[16]));
  AO221D0BWP g2192__6131(.A1 (n_88), .A2 (idata_0[5]), .B1 (n_87), .B2
       (idata_1[5]), .C (n_38), .Z (odata[5]));
  AO221D0BWP g2173__1881(.A1 (n_88), .A2 (idata_0[4]), .B1 (n_87), .B2
       (idata_1[4]), .C (n_28), .Z (odata[4]));
  AO221D0BWP g2177__5115(.A1 (n_88), .A2 (idata_0[3]), .B1 (n_87), .B2
       (idata_1[3]), .C (n_31), .Z (odata[3]));
  AO221D0BWP g2188__7482(.A1 (n_88), .A2 (idata_0[18]), .B1 (n_87), .B2
       (idata_1[18]), .C (n_43), .Z (odata[18]));
  AO221D0BWP g2180__4733(.A1 (n_88), .A2 (idata_0[1]), .B1 (n_87), .B2
       (idata_1[1]), .C (n_27), .Z (odata[1]));
  AO221D0BWP g2183__6161(.A1 (n_88), .A2 (idata_0[0]), .B1 (n_87), .B2
       (idata_1[0]), .C (n_25), .Z (odata[0]));
  AO221D0BWP g2184__9315(.A1 (n_88), .A2 (ivalid_0), .B1 (n_87), .B2
       (ivalid_1), .C (n_23), .Z (ovalid));
  AO221D0BWP g2185__9945(.A1 (n_88), .A2 (ivch_0[1]), .B1 (n_87), .B2
       (ivch_1[1]), .C (n_44), .Z (ovch[1]));
  AO221D0BWP g2189__2883(.A1 (n_88), .A2 (ivch_0[0]), .B1 (n_64), .B2
       (ivch_3[0]), .C (n_42), .Z (ovch[0]));
  AO221D0BWP g2156__2346(.A1 (n_64), .A2 (idata_3[15]), .B1 (n_77), .B2
       (idata_2[15]), .C (n_14), .Z (odata[15]));
  AO221D0BWP g2164__1666(.A1 (n_64), .A2 (idata_3[31]), .B1 (n_77), .B2
       (idata_2[31]), .C (n_17), .Z (odata[31]));
  AO221D0BWP g2169__7410(.A1 (n_64), .A2 (idata_3[30]), .B1 (n_77), .B2
       (idata_2[30]), .C (n_11), .Z (odata[30]));
  AO221D0BWP g2155__6417(.A1 (n_64), .A2 (idata_3[26]), .B1 (n_77), .B2
       (idata_2[26]), .C (n_10), .Z (odata[26]));
  AO221D0BWP g2159__5477(.A1 (n_64), .A2 (idata_3[25]), .B1 (n_77), .B2
       (idata_2[25]), .C (n_7), .Z (odata[25]));
  AO221D0BWP g2162__2398(.A1 (n_64), .A2 (idata_3[24]), .B1 (n_77), .B2
       (idata_2[24]), .C (n_12), .Z (odata[24]));
  AO221D0BWP g2165__5107(.A1 (n_64), .A2 (idata_3[23]), .B1 (n_77), .B2
       (idata_2[23]), .C (n_13), .Z (odata[23]));
  AO221D0BWP g2170__6260(.A1 (n_64), .A2 (idata_3[22]), .B1 (n_77), .B2
       (idata_2[22]), .C (n_15), .Z (odata[22]));
  AO221D0BWP g2153__4319(.A1 (n_64), .A2 (idata_3[35]), .B1 (n_77), .B2
       (idata_2[35]), .C (n_8), .Z (odata[35]));
  AO221D0BWP g2163__8428(.A1 (n_64), .A2 (idata_3[10]), .B1 (n_77), .B2
       (idata_2[10]), .C (n_16), .Z (odata[10]));
  AO221D0BWP g2158__5526(.A1 (n_64), .A2 (idata_3[13]), .B1 (n_77), .B2
       (idata_2[13]), .C (n_19), .Z (odata[13]));
  AO221D0BWP g2160__6783(.A1 (n_64), .A2 (idata_3[12]), .B1 (n_77), .B2
       (idata_2[12]), .C (n_22), .Z (odata[12]));
  AO221D0BWP g2161__3680(.A1 (n_64), .A2 (idata_3[11]), .B1 (n_77), .B2
       (idata_2[11]), .C (n_20), .Z (odata[11]));
  AO221D0BWP g2166__1617(.A1 (n_64), .A2 (idata_3[9]), .B1 (n_77), .B2
       (idata_2[9]), .C (n_5), .Z (odata[9]));
  AO221D0BWP g2167__2802(.A1 (n_64), .A2 (idata_3[8]), .B1 (n_77), .B2
       (idata_2[8]), .C (n_9), .Z (odata[8]));
  AO221D0BWP g2168__1705(.A1 (n_64), .A2 (idata_3[7]), .B1 (n_77), .B2
       (idata_2[7]), .C (n_6), .Z (odata[7]));
  AO221D0BWP g2171__5122(.A1 (n_64), .A2 (idata_3[6]), .B1 (n_77), .B2
       (idata_2[6]), .C (n_21), .Z (odata[6]));
  AO221D0BWP g2157__8246(.A1 (n_64), .A2 (idata_3[14]), .B1 (n_77), .B2
       (idata_2[14]), .C (n_18), .Z (odata[14]));
  AO22D0BWP g2229__7098(.A1 (n_64), .A2 (idata_3[17]), .B1
       (idata_2[17]), .B2 (n_77), .Z (n_45));
  AO22D0BWP g2225__6131(.A1 (n_64), .A2 (ivch_3[1]), .B1 (ivch_2[1]),
       .B2 (n_77), .Z (n_44));
  AO22D0BWP g2226__1881(.A1 (n_64), .A2 (idata_3[18]), .B1
       (idata_2[18]), .B2 (n_77), .Z (n_43));
  AO22D0BWP g2227__5115(.A1 (n_87), .A2 (ivch_1[0]), .B1 (ivch_2[0]),
       .B2 (n_77), .Z (n_42));
  AO22D0BWP g2228__7482(.A1 (n_64), .A2 (idata_3[28]), .B1
       (idata_2[28]), .B2 (n_77), .Z (n_41));
  AO22D0BWP g2195__4733(.A1 (n_87), .A2 (idata_1[37]), .B1
       (idata_3[37]), .B2 (n_64), .Z (n_40));
  AO22D0BWP g2230__6161(.A1 (n_64), .A2 (idata_3[33]), .B1
       (idata_2[33]), .B2 (n_77), .Z (n_39));
  AO22D0BWP g2212__9315(.A1 (n_64), .A2 (idata_3[5]), .B1 (idata_2[5]),
       .B2 (n_77), .Z (n_38));
  AO22D0BWP g2231__9945(.A1 (n_64), .A2 (idata_3[36]), .B1
       (idata_2[36]), .B2 (n_77), .Z (n_37));
  AO22D0BWP g2232__2883(.A1 (n_64), .A2 (idata_3[16]), .B1
       (idata_2[16]), .B2 (n_77), .Z (n_36));
  AO22D0BWP g2213__2346(.A1 (n_64), .A2 (idata_3[27]), .B1
       (idata_2[27]), .B2 (n_77), .Z (n_35));
  AO22D0BWP g2219__1666(.A1 (n_64), .A2 (idata_3[20]), .B1
       (idata_2[20]), .B2 (n_77), .Z (n_34));
  AO22D0BWP g2214__7410(.A1 (n_64), .A2 (idata_3[34]), .B1
       (idata_2[34]), .B2 (n_77), .Z (n_33));
  AO22D0BWP g2215__6417(.A1 (n_64), .A2 (idata_3[21]), .B1
       (idata_2[21]), .B2 (n_77), .Z (n_32));
  AO22D0BWP g2217__5477(.A1 (n_64), .A2 (idata_3[3]), .B1 (idata_2[3]),
       .B2 (n_77), .Z (n_31));
  AO22D0BWP g2199__2398(.A1 (n_87), .A2 (idata_1[32]), .B1
       (idata_2[32]), .B2 (n_77), .Z (n_30));
  AO22D0BWP g2218__5107(.A1 (n_64), .A2 (idata_3[2]), .B1 (idata_2[2]),
       .B2 (n_77), .Z (n_29));
  AO22D0BWP g2233__6260(.A1 (n_64), .A2 (idata_3[4]), .B1 (idata_2[4]),
       .B2 (n_77), .Z (n_28));
  AO22D0BWP g2220__4319(.A1 (n_64), .A2 (idata_3[1]), .B1 (idata_2[1]),
       .B2 (n_77), .Z (n_27));
  AO22D0BWP g2221__8428(.A1 (n_64), .A2 (idata_3[29]), .B1
       (idata_2[29]), .B2 (n_77), .Z (n_26));
  AO22D0BWP g2222__5526(.A1 (n_64), .A2 (idata_3[0]), .B1 (idata_2[0]),
       .B2 (n_77), .Z (n_25));
  AO22D0BWP g2223__6783(.A1 (n_87), .A2 (idata_1[19]), .B1
       (idata_3[19]), .B2 (n_64), .Z (n_24));
  AO22D0BWP g2224__3680(.A1 (n_64), .A2 (ivalid_3), .B1 (ivalid_2), .B2
       (n_77), .Z (n_23));
  AO22D0BWP g2198__1617(.A1 (n_88), .A2 (idata_0[12]), .B1
       (idata_1[12]), .B2 (n_87), .Z (n_22));
  AO22D0BWP g2209__2802(.A1 (n_88), .A2 (idata_0[6]), .B1 (idata_1[6]),
       .B2 (n_87), .Z (n_21));
  AO22D0BWP g2201__1705(.A1 (n_88), .A2 (idata_0[11]), .B1
       (idata_1[11]), .B2 (n_87), .Z (n_20));
  AO22D0BWP g2197__5122(.A1 (n_88), .A2 (idata_0[13]), .B1
       (idata_1[13]), .B2 (n_87), .Z (n_19));
  AO22D0BWP g2194__8246(.A1 (n_88), .A2 (idata_0[14]), .B1
       (idata_1[14]), .B2 (n_87), .Z (n_18));
  AO22D0BWP g2210__7098(.A1 (n_88), .A2 (idata_0[31]), .B1
       (idata_1[31]), .B2 (n_87), .Z (n_17));
  AO22D0BWP g2202__6131(.A1 (n_88), .A2 (idata_0[10]), .B1
       (idata_1[10]), .B2 (n_87), .Z (n_16));
  AO22D0BWP g2211__1881(.A1 (n_88), .A2 (idata_0[22]), .B1
       (idata_1[22]), .B2 (n_87), .Z (n_15));
  AO22D0BWP g2193__5115(.A1 (n_88), .A2 (idata_0[15]), .B1
       (idata_1[15]), .B2 (n_87), .Z (n_14));
  AO22D0BWP g2208__7482(.A1 (n_88), .A2 (idata_0[23]), .B1
       (idata_1[23]), .B2 (n_87), .Z (n_13));
  AO22D0BWP g2204__4733(.A1 (n_88), .A2 (idata_0[24]), .B1
       (idata_1[24]), .B2 (n_87), .Z (n_12));
  AO22D0BWP g2216__6161(.A1 (n_88), .A2 (idata_0[30]), .B1
       (idata_1[30]), .B2 (n_87), .Z (n_11));
  AO22D0BWP g2196__9315(.A1 (n_88), .A2 (idata_0[26]), .B1
       (idata_1[26]), .B2 (n_87), .Z (n_10));
  AO22D0BWP g2205__9945(.A1 (n_88), .A2 (idata_0[8]), .B1 (idata_1[8]),
       .B2 (n_87), .Z (n_9));
  AO22D0BWP g2206__2883(.A1 (n_88), .A2 (idata_0[35]), .B1
       (idata_1[35]), .B2 (n_87), .Z (n_8));
  AO22D0BWP g2200__2346(.A1 (n_88), .A2 (idata_0[25]), .B1
       (idata_1[25]), .B2 (n_87), .Z (n_7));
  AO22D0BWP g2207__1666(.A1 (n_88), .A2 (idata_0[7]), .B1 (idata_1[7]),
       .B2 (n_87), .Z (n_6));
  AO22D0BWP g2203__7410(.A1 (n_88), .A2 (idata_0[9]), .B1 (idata_1[9]),
       .B2 (n_87), .Z (n_5));
  CKAN2D2BWP g2235__6417(.A1 (n_1), .A2 (n_4), .Z (n_64));
  CKAN2D2BWP g2234__5477(.A1 (n_2), .A2 (n_4), .Z (n_77));
  AN3D2BWP g2236__2398(.A1 (n_3), .A2 (n_4), .A3 (sel[1]), .Z (n_87));
  AN3D2BWP g2237__5107(.A1 (n_3), .A2 (n_0), .A3 (sel[0]), .Z (n_88));
  INR3D0BWP g2238__6260(.A1 (sel[2]), .B1 (sel[3]), .B2 (sel[1]), .ZN
       (n_2));
  INR3D0BWP g2239__4319(.A1 (sel[3]), .B1 (sel[2]), .B2 (sel[1]), .ZN
       (n_1));
  NR2D0BWP g2240__8428(.A1 (sel[3]), .A2 (sel[2]), .ZN (n_3));
  CKND0BWP g2242(.I (sel[0]), .ZN (n_4));
  CKND0BWP g2241(.I (sel[1]), .ZN (n_0));
endmodule
