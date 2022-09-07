`timescale 1ps / 1ps
/*****************************************************************************
    Verilog RTL Description
    
    Configured at: 16:18:56 CEST (+0200), Tuesday 06 September 2022
    Configured on: es-eda.ele.tue.nl
    Configured by: 20200969 (Dario Monticelli, Manil)
    
    Created by: Stratus DpOpt 2019.1.04 
*******************************************************************************/

module fir_And_1Ux1U_1U_4_0 (
	in2,
	in1,
	out1
	); /* architecture "behavioural" */ 
input  in2,
	in1;
output  out1;
wire  asc001;

assign asc001 = 
	(in2)
	&(in1);

assign out1 = asc001;
endmodule

/* CADENCE  urf5Sgk= : u9/ySgnWtBlWxVbRXgEd4Og= ** DO NOT EDIT THIS LINE ******/

