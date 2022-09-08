`timescale 1ps / 1ps
/*****************************************************************************
    Verilog RTL Description
    
    Configured at: timestamp information is unavailable.
    Configured on: es-eda.ele.tue.nl
    Configured by: 20200969 (Dario Monticelli, Manil)
    
    Created by: Stratus DpOpt 2019.1.04 
*******************************************************************************/

module fir_DECODE_8U_25_4 (
	in1,
	out1
	); /* architecture "behavioural" */ 
input [2:0] in1;
output [7:0] out1;
wire [7:0] asc001;

assign asc001 = 8'B00000001 << in1;

assign out1 = asc001;
endmodule

/* CADENCE  urfwSQo= : u9/ySgnWtBlWxVbRXgAU4eg= ** DO NOT EDIT THIS LINE ******/


