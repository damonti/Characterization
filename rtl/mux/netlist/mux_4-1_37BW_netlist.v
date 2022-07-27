
// Generated by Cadence Genus(TM) Synthesis Solution 19.11-s087_1
// Generated on: Jul 20 2022 17:37:57 CEST (Jul 20 2022 15:37:57 UTC)

// Verification Directory fv/mux 

module mux(idata_0, ivalid_0, ivch_0, idata_1, ivalid_1, ivch_1,
     idata_2, ivalid_2, ivch_2, idata_3, ivalid_3, ivch_3, sel, odata,
     ovalid, ovch);
  input [39:0] idata_0, idata_1, idata_2, idata_3;
  input ivalid_0, ivalid_1, ivalid_2, ivalid_3;
  input [1:0] ivch_0, ivch_1, ivch_2, ivch_3;
  input [3:0] sel;
  output [39:0] odata;
  output ovalid;
  output [1:0] ovch;
  wire [39:0] idata_0, idata_1, idata_2, idata_3;
  wire ivalid_0, ivalid_1, ivalid_2, ivalid_3;
  wire [1:0] ivch_0, ivch_1, ivch_2, ivch_3;
  wire [3:0] sel;
  wire [39:0] odata;
  wire ovalid;
  wire [1:0] ovch;
  wire n_0, n_1, n_2, n_3, n_4, n_5, n_6, n_7;
  wire n_8, n_9, n_10, n_11, n_12, n_13, n_14, n_15;
  wire n_16, n_17, n_18, n_19, n_20, n_21, n_22, n_23;
  wire n_24, n_25, n_26, n_27, n_28, n_29, n_30, n_31;
  wire n_32, n_33, n_34, n_35, n_36, n_37, n_38, n_39;
  wire n_40, n_41, n_42, n_43, n_44, n_45, n_46, n_47;
  wire n_67, n_79, n_91, n_92;
  AO221D0BWP g2287__2398(.A1 (n_92), .A2 (idata_0[30]), .B1 (n_91), .B2
       (idata_1[30]), .C (n_41), .Z (odata[30]));
  AO221D0BWP g2274__5107(.A1 (n_92), .A2 (idata_0[38]), .B1 (n_91), .B2
       (idata_1[38]), .C (n_38), .Z (odata[38]));
  AO221D0BWP g2275__6260(.A1 (n_92), .A2 (idata_0[36]), .B1 (n_91), .B2
       (idata_1[36]), .C (n_42), .Z (odata[36]));
  AO221D0BWP g2286__4319(.A1 (n_92), .A2 (idata_0[35]), .B1 (n_91), .B2
       (idata_1[35]), .C (n_39), .Z (odata[35]));
  AO221D0BWP g2281__8428(.A1 (n_92), .A2 (idata_0[31]), .B1 (n_91), .B2
       (idata_1[31]), .C (n_28), .Z (odata[31]));
  AO221D0BWP g2272__5526(.A1 (n_92), .A2 (idata_0[39]), .B1 (n_79), .B2
       (idata_2[39]), .C (n_46), .Z (odata[39]));
  AO221D0BWP g2293__6783(.A1 (n_92), .A2 (idata_0[29]), .B1 (n_91), .B2
       (idata_1[29]), .C (n_35), .Z (odata[29]));
  AO221D0BWP g2276__3680(.A1 (n_92), .A2 (idata_0[23]), .B1 (n_91), .B2
       (idata_1[23]), .C (n_34), .Z (odata[23]));
  AO221D0BWP g2278__1617(.A1 (n_92), .A2 (idata_0[22]), .B1 (n_91), .B2
       (idata_1[22]), .C (n_36), .Z (odata[22]));
  AO221D0BWP g2282__2802(.A1 (n_92), .A2 (idata_0[21]), .B1 (n_91), .B2
       (idata_1[21]), .C (n_26), .Z (odata[21]));
  AO221D0BWP g2288__1705(.A1 (n_92), .A2 (idata_0[20]), .B1 (n_91), .B2
       (idata_1[20]), .C (n_45), .Z (odata[20]));
  AO221D0BWP g2283__5122(.A1 (n_92), .A2 (idata_0[2]), .B1 (n_91), .B2
       (idata_1[2]), .C (n_27), .Z (odata[2]));
  AO221D0BWP g2294__8246(.A1 (n_92), .A2 (idata_0[18]), .B1 (n_79), .B2
       (idata_2[18]), .C (n_37), .Z (odata[18]));
  AO221D0BWP g2284__7098(.A1 (n_92), .A2 (idata_0[6]), .B1 (n_91), .B2
       (idata_1[6]), .C (n_33), .Z (odata[6]));
  AO221D0BWP g2277__6131(.A1 (n_92), .A2 (idata_0[5]), .B1 (n_91), .B2
       (idata_1[5]), .C (n_32), .Z (odata[5]));
  AO221D0BWP g2279__1881(.A1 (n_92), .A2 (idata_0[4]), .B1 (n_91), .B2
       (idata_1[4]), .C (n_31), .Z (odata[4]));
  AO221D0BWP g2280__5115(.A1 (n_92), .A2 (idata_0[3]), .B1 (n_67), .B2
       (idata_3[3]), .C (n_29), .Z (odata[3]));
  AO221D0BWP g2290__7482(.A1 (n_92), .A2 (idata_0[19]), .B1 (n_91), .B2
       (idata_1[19]), .C (n_47), .Z (odata[19]));
  AO221D0BWP g2273__4733(.A1 (n_92), .A2 (idata_0[1]), .B1 (n_91), .B2
       (idata_1[1]), .C (n_25), .Z (odata[1]));
  AO221D0BWP g2285__6161(.A1 (n_92), .A2 (idata_0[0]), .B1 (n_91), .B2
       (idata_1[0]), .C (n_30), .Z (odata[0]));
  AO221D0BWP g2289__9315(.A1 (n_92), .A2 (ivalid_0), .B1 (n_91), .B2
       (ivalid_1), .C (n_44), .Z (ovalid));
  AO221D0BWP g2291__9945(.A1 (n_92), .A2 (ivch_0[1]), .B1 (n_91), .B2
       (ivch_1[1]), .C (n_43), .Z (ovch[1]));
  AO221D0BWP g2292__2883(.A1 (n_92), .A2 (ivch_0[0]), .B1 (n_91), .B2
       (ivch_1[0]), .C (n_40), .Z (ovch[0]));
  AO221D0BWP g2253__2346(.A1 (n_67), .A2 (idata_3[37]), .B1 (n_79), .B2
       (idata_2[37]), .C (n_8), .Z (odata[37]));
  AO221D0BWP g2254__1666(.A1 (n_67), .A2 (idata_3[34]), .B1 (n_79), .B2
       (idata_2[34]), .C (n_10), .Z (odata[34]));
  AO221D0BWP g2264__7410(.A1 (n_67), .A2 (idata_3[33]), .B1 (n_79), .B2
       (idata_2[33]), .C (n_21), .Z (odata[33]));
  AO221D0BWP g2269__6417(.A1 (n_67), .A2 (idata_3[32]), .B1 (n_79), .B2
       (idata_2[32]), .C (n_12), .Z (odata[32]));
  AO221D0BWP g2262__5477(.A1 (n_67), .A2 (idata_3[26]), .B1 (n_79), .B2
       (idata_2[26]), .C (n_13), .Z (odata[26]));
  AO221D0BWP g2265__2398(.A1 (n_67), .A2 (idata_3[25]), .B1 (n_79), .B2
       (idata_2[25]), .C (n_5), .Z (odata[25]));
  AO221D0BWP g2270__5107(.A1 (n_67), .A2 (idata_3[24]), .B1 (n_79), .B2
       (idata_2[24]), .C (n_19), .Z (odata[24]));
  AO221D0BWP g2255__6260(.A1 (n_67), .A2 (idata_3[28]), .B1 (n_79), .B2
       (idata_2[28]), .C (n_11), .Z (odata[28]));
  AO221D0BWP g2259__4319(.A1 (n_67), .A2 (idata_3[27]), .B1 (n_79), .B2
       (idata_2[27]), .C (n_7), .Z (odata[27]));
  AO221D0BWP g2256__8428(.A1 (n_67), .A2 (idata_3[17]), .B1 (n_79), .B2
       (idata_2[17]), .C (n_15), .Z (odata[17]));
  AO221D0BWP g2257__5526(.A1 (n_67), .A2 (idata_3[16]), .B1 (n_79), .B2
       (idata_2[16]), .C (n_20), .Z (odata[16]));
  AO221D0BWP g2258__6783(.A1 (n_67), .A2 (idata_3[15]), .B1 (n_79), .B2
       (idata_2[15]), .C (n_22), .Z (odata[15]));
  AO221D0BWP g2260__3680(.A1 (n_67), .A2 (idata_3[14]), .B1 (n_79), .B2
       (idata_2[14]), .C (n_16), .Z (odata[14]));
  AO221D0BWP g2261__1617(.A1 (n_67), .A2 (idata_3[13]), .B1 (n_79), .B2
       (idata_2[13]), .C (n_23), .Z (odata[13]));
  AO221D0BWP g2266__2802(.A1 (n_67), .A2 (idata_3[11]), .B1 (n_79), .B2
       (idata_2[11]), .C (n_14), .Z (odata[11]));
  AO221D0BWP g2267__1705(.A1 (n_67), .A2 (idata_3[10]), .B1 (n_79), .B2
       (idata_2[10]), .C (n_9), .Z (odata[10]));
  AO221D0BWP g2268__5122(.A1 (n_67), .A2 (idata_3[9]), .B1 (n_79), .B2
       (idata_2[9]), .C (n_6), .Z (odata[9]));
  AO221D0BWP g2252__8246(.A1 (n_67), .A2 (idata_3[7]), .B1 (n_79), .B2
       (idata_2[7]), .C (n_17), .Z (odata[7]));
  AO221D0BWP g2263__7098(.A1 (n_67), .A2 (idata_3[12]), .B1 (n_79), .B2
       (idata_2[12]), .C (n_18), .Z (odata[12]));
  AO221D0BWP g2271__6131(.A1 (n_67), .A2 (idata_3[8]), .B1 (n_79), .B2
       (idata_2[8]), .C (n_24), .Z (odata[8]));
  AO22D0BWP g2331__1881(.A1 (n_67), .A2 (idata_3[19]), .B1
       (idata_2[19]), .B2 (n_79), .Z (n_47));
  AO22D0BWP g2297__5115(.A1 (n_91), .A2 (idata_1[39]), .B1
       (idata_3[39]), .B2 (n_67), .Z (n_46));
  AO22D0BWP g2328__7482(.A1 (n_67), .A2 (idata_3[20]), .B1
       (idata_2[20]), .B2 (n_79), .Z (n_45));
  AO22D0BWP g2329__4733(.A1 (n_67), .A2 (ivalid_3), .B1 (ivalid_2), .B2
       (n_79), .Z (n_44));
  AO22D0BWP g2330__6161(.A1 (n_67), .A2 (ivch_3[1]), .B1 (ivch_2[1]),
       .B2 (n_79), .Z (n_43));
  AO22D0BWP g2327__9315(.A1 (n_67), .A2 (idata_3[36]), .B1
       (idata_2[36]), .B2 (n_79), .Z (n_42));
  AO22D0BWP g2332__9945(.A1 (n_67), .A2 (idata_3[30]), .B1
       (idata_2[30]), .B2 (n_79), .Z (n_41));
  AO22D0BWP g2333__2883(.A1 (n_67), .A2 (ivch_3[0]), .B1 (ivch_2[0]),
       .B2 (n_79), .Z (n_40));
  AO22D0BWP g2334__2346(.A1 (n_67), .A2 (idata_3[35]), .B1
       (idata_2[35]), .B2 (n_79), .Z (n_39));
  AO22D0BWP g2335__1666(.A1 (n_67), .A2 (idata_3[38]), .B1
       (idata_2[38]), .B2 (n_79), .Z (n_38));
  AO22D0BWP g2336__7410(.A1 (n_91), .A2 (idata_1[18]), .B1
       (idata_3[18]), .B2 (n_67), .Z (n_37));
  AO22D0BWP g2321__6417(.A1 (n_67), .A2 (idata_3[22]), .B1
       (idata_2[22]), .B2 (n_79), .Z (n_36));
  AO22D0BWP g2337__5477(.A1 (n_67), .A2 (idata_3[29]), .B1
       (idata_2[29]), .B2 (n_79), .Z (n_35));
  AO22D0BWP g2317__2398(.A1 (n_67), .A2 (idata_3[23]), .B1
       (idata_2[23]), .B2 (n_79), .Z (n_34));
  AO22D0BWP g2295__5107(.A1 (n_67), .A2 (idata_3[6]), .B1 (idata_2[6]),
       .B2 (n_79), .Z (n_33));
  AO22D0BWP g2319__6260(.A1 (n_67), .A2 (idata_3[5]), .B1 (idata_2[5]),
       .B2 (n_79), .Z (n_32));
  AO22D0BWP g2320__4319(.A1 (n_67), .A2 (idata_3[4]), .B1 (idata_2[4]),
       .B2 (n_79), .Z (n_31));
  AO22D0BWP g2316__8428(.A1 (n_67), .A2 (idata_3[0]), .B1 (idata_2[0]),
       .B2 (n_79), .Z (n_30));
  AO22D0BWP g2322__5526(.A1 (n_91), .A2 (idata_1[3]), .B1 (idata_2[3]),
       .B2 (n_79), .Z (n_29));
  AO22D0BWP g2323__6783(.A1 (n_67), .A2 (idata_3[31]), .B1
       (idata_2[31]), .B2 (n_79), .Z (n_28));
  AO22D0BWP g2324__3680(.A1 (n_67), .A2 (idata_3[2]), .B1 (idata_2[2]),
       .B2 (n_79), .Z (n_27));
  AO22D0BWP g2325__1617(.A1 (n_67), .A2 (idata_3[21]), .B1
       (idata_2[21]), .B2 (n_79), .Z (n_26));
  AO22D0BWP g2326__2802(.A1 (n_67), .A2 (idata_3[1]), .B1 (idata_2[1]),
       .B2 (n_79), .Z (n_25));
  AO22D0BWP g2311__1705(.A1 (n_92), .A2 (idata_0[8]), .B1 (idata_1[8]),
       .B2 (n_91), .Z (n_24));
  AO22D0BWP g2303__5122(.A1 (n_92), .A2 (idata_0[13]), .B1
       (idata_1[13]), .B2 (n_91), .Z (n_23));
  AO22D0BWP g2299__8246(.A1 (n_92), .A2 (idata_0[15]), .B1
       (idata_1[15]), .B2 (n_91), .Z (n_22));
  AO22D0BWP g2312__7098(.A1 (n_92), .A2 (idata_0[33]), .B1
       (idata_1[33]), .B2 (n_91), .Z (n_21));
  AO22D0BWP g2296__6131(.A1 (n_92), .A2 (idata_0[16]), .B1
       (idata_1[16]), .B2 (n_91), .Z (n_20));
  AO22D0BWP g2313__1881(.A1 (n_92), .A2 (idata_0[24]), .B1
       (idata_1[24]), .B2 (n_91), .Z (n_19));
  AO22D0BWP g2304__5115(.A1 (n_92), .A2 (idata_0[12]), .B1
       (idata_1[12]), .B2 (n_91), .Z (n_18));
  AO22D0BWP g2314__7482(.A1 (n_92), .A2 (idata_0[7]), .B1 (idata_1[7]),
       .B2 (n_91), .Z (n_17));
  AO22D0BWP g2300__4733(.A1 (n_92), .A2 (idata_0[14]), .B1
       (idata_1[14]), .B2 (n_91), .Z (n_16));
  AO22D0BWP g2315__6161(.A1 (n_92), .A2 (idata_0[17]), .B1
       (idata_1[17]), .B2 (n_91), .Z (n_15));
  AO22D0BWP g2305__9315(.A1 (n_92), .A2 (idata_0[11]), .B1
       (idata_1[11]), .B2 (n_91), .Z (n_14));
  AO22D0BWP g2306__9945(.A1 (n_92), .A2 (idata_0[26]), .B1
       (idata_1[26]), .B2 (n_91), .Z (n_13));
  AO22D0BWP g2318__2883(.A1 (n_92), .A2 (idata_0[32]), .B1
       (idata_1[32]), .B2 (n_91), .Z (n_12));
  AO22D0BWP g2298__2346(.A1 (n_92), .A2 (idata_0[28]), .B1
       (idata_1[28]), .B2 (n_91), .Z (n_11));
  AO22D0BWP g2301__1666(.A1 (n_92), .A2 (idata_0[34]), .B1
       (idata_1[34]), .B2 (n_91), .Z (n_10));
  AO22D0BWP g2307__7410(.A1 (n_92), .A2 (idata_0[10]), .B1
       (idata_1[10]), .B2 (n_91), .Z (n_9));
  AO22D0BWP g2308__6417(.A1 (n_92), .A2 (idata_0[37]), .B1
       (idata_1[37]), .B2 (n_91), .Z (n_8));
  AO22D0BWP g2302__5477(.A1 (n_92), .A2 (idata_0[27]), .B1
       (idata_1[27]), .B2 (n_91), .Z (n_7));
  AO22D0BWP g2309__2398(.A1 (n_92), .A2 (idata_0[9]), .B1 (idata_1[9]),
       .B2 (n_91), .Z (n_6));
  AO22D0BWP g2310__5107(.A1 (n_92), .A2 (idata_0[25]), .B1
       (idata_1[25]), .B2 (n_91), .Z (n_5));
  CKAN2D2BWP g2339__6260(.A1 (n_1), .A2 (n_4), .Z (n_67));
  CKAN2D2BWP g2338__4319(.A1 (n_2), .A2 (n_4), .Z (n_79));
  AN3D2BWP g2340__8428(.A1 (n_3), .A2 (n_4), .A3 (sel[1]), .Z (n_91));
  AN3D2BWP g2341__5526(.A1 (n_3), .A2 (n_0), .A3 (sel[0]), .Z (n_92));
  INR3D0BWP g2342__6783(.A1 (sel[2]), .B1 (sel[3]), .B2 (sel[1]), .ZN
       (n_2));
  INR3D0BWP g2343__3680(.A1 (sel[3]), .B1 (sel[2]), .B2 (sel[1]), .ZN
       (n_1));
  NR2D0BWP g2344__1617(.A1 (sel[3]), .A2 (sel[2]), .ZN (n_3));
  CKND0BWP g2346(.I (sel[0]), .ZN (n_4));
  CKND0BWP g2345(.I (sel[1]), .ZN (n_0));
endmodule
