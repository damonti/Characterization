`timescale 10ns / 10ps
/*****************************************************************************
    Verilog RTL Description
    
    Configured at: 12:17:11 CEST (+0200), Monday 03 October 2022
    Configured on: es-eda.ele.tue.nl
    Configured by: 20200969 (Dario Monticelli, Manil)
    
    Created by: Stratus DpOpt 2019.1.04 
*******************************************************************************/

module multiplier_fir (
	in2,
	in1,
	out1
	); /* architecture "behavioural" */ 
parameter N = 16;
input [N-1:0] in2;
input [N-1:0] in1;
output [N+2:0] out1;
wire [N+2:0] asc001;

assign asc001 = 
	+(in1 * in2);

assign out1 = asc001;
endmodule

/* CADENCE  urb0TQ4= : u9/ySgnWtBlWxVbRXgAU4eg= ** DO NOT EDIT THIS LINE ******/
