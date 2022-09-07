`timescale 1ps / 1ps
/*****************************************************************************
    Verilog RTL Description
    
    Configured at: 16:19:51 CEST (+0200), Tuesday 06 September 2022
    Configured on: es-eda.ele.tue.nl
    Configured by: 20200969 (Dario Monticelli, Manil)
    
    Created by: Stratus DpOpt 2019.1.04 
*******************************************************************************/

module fir_multiply_4_0 (
	in1,
	in2,
	in3,
	out1
	); /* architecture "behavioural" */ 
input [10:0] in1;
input [7:0] in2,
	in3;
output [10:0] out1;
wire [10:0] asc001;

wire [10:0] asc001_tmp_0;
assign asc001_tmp_0 = 
	+(in1);
assign asc001 = asc001_tmp_0
	+(in3 * in2);

assign out1 = asc001;
endmodule

/* CADENCE  ubb4SA8= : u9/ySgnWtBlWxVbRXgEd4Og= ** DO NOT EDIT THIS LINE ******/

