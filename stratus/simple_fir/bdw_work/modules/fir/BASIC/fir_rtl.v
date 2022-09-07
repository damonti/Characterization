// Generated by stratus_hls 19.25-s100  (93142.260418)
// Wed Sep  7 10:39:56 2022
// from fir.cc

`timescale 1ps / 1ps

      
module fir(clk, rst, coeffs_table_0, coeffs_table_1, coeffs_table_2, coeffs_table_3, coeffs_table_4, coeffs_table_5, coeffs_table_6, coeffs_table_7, din_busy, din_vld, din_data, dout_busy, dout_vld, dout_data);

      input clk;
      input rst;
      input [7:0] coeffs_table_0;
      input [7:0] coeffs_table_1;
      input [7:0] coeffs_table_2;
      input [7:0] coeffs_table_3;
      input [7:0] coeffs_table_4;
      input [7:0] coeffs_table_5;
      input [7:0] coeffs_table_6;
      input [7:0] coeffs_table_7;
      input din_vld;
      input [7:0] din_data;
      input dout_busy;
      output din_busy;
      output dout_vld;
      output [10:0] dout_data;

         // rtl_instance:fir/fir_logic_1_1
         // Resource=fir_logic_1, Function=partition : Inputs=1,1,8,8,8,8,8,8,8,8,8,1,1 Outputs=1,1,11
         // variable: fir:fir.h:32:1 fir:
         fir_logic_1 fir_logic_1_1(
                       .clk( clk ),
                       .rst( rst ),
                       .coeffs_table_1( coeffs_table_1 ),
                       .coeffs_table_0( coeffs_table_0 ),
                       .coeffs_table_2( coeffs_table_2 ),
                       .coeffs_table_3( coeffs_table_3 ),
                       .coeffs_table_4( coeffs_table_4 ),
                       .coeffs_table_5( coeffs_table_5 ),
                       .coeffs_table_6( coeffs_table_6 ),
                       .din_data( din_data ),
                       .coeffs_table_7( coeffs_table_7 ),
                       .din_busy( din_busy ),
                       .din_vld( din_vld ),
                       .dout_vld( dout_vld ),
                       .dout_busy( dout_busy ),
                       .dout_data( dout_data )
                     );


endmodule

