`timescale 1ps / 1ps
/*****************************************************************************
    Verilog RTL Description
    
    Configured at: 21:13:16 CEST (+0200), Wednesday 26 October 2022
    Configured on: es-eda.ele.tue.nl
    Configured by: 20200969 (Dario Monticelli, Manil)
    
    Created by: Stratus DpOpt 2019.1.04 
*******************************************************************************/

module fir_Mul_43Ux8U_46U_1 (
	in2,
	in1,
	out1
	); /* architecture "behavioural" */ 
input [42:0] in2;
input [7:0] in1;
output [45:0] out1;
wire [45:0] asc001;

assign asc001 = 
	+(in2 * in1);

assign out1 = asc001;
endmodule

/* CADENCE  urn3Sgw= : u9/ySgnWtBlWxVbRXgAU4eg= ** DO NOT EDIT THIS LINE ******/

