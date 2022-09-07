`timescale 1ps / 1ps
/*****************************************************************************
    Verilog RTL Description
    
    Configured at: 16:19:03 CEST (+0200), Tuesday 06 September 2022
    Configured on: es-eda.ele.tue.nl
    Configured by: 20200969 (Dario Monticelli, Manil)
    
    Created by: Stratus DpOpt 2019.1.04 
*******************************************************************************/

module fir_Mul_8Ux8U_11U_1_0 (
	in2,
	in1,
	out1
	); /* architecture "behavioural" */ 
input [7:0] in2,
	in1;
output [10:0] out1;
wire [10:0] asc001;

assign asc001 = 
	+(in1 * in2);

assign out1 = asc001;
endmodule

/* CADENCE  urb2Tw8= : u9/ySgnWtBlWxVbRXgEd4Og= ** DO NOT EDIT THIS LINE ******/

