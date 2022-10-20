`timescale 1ps / 1ps
/*****************************************************************************
    Verilog RTL Description
    
    Configured at: 12:17:15 CEST (+0200), Monday 03 October 2022
    Configured on: es-eda.ele.tue.nl
    Configured by: 20200969 (Dario Monticelli, Manil)
    
    Created by: Stratus DpOpt 2019.1.04 
*******************************************************************************/

module fir_gen_busy_r_1 (
	in1,
	in2,
	in3,
	out1
	); /* architecture "behavioural" */ 
input  in1,
	in2,
	in3;
output [2:0] out1;
wire  asc003,
	asc004,
	asc006,
	asc008,
	asc010;
wire [2:0] asc011;

assign asc004 = 
	(in3)
	|(in1);

assign asc003 = 
	(in2)
	&(asc004);

assign asc008 = 
	((~asc003));

assign asc006 = 
	(in1)
	&(asc008);

assign asc010 = 
	((~asc006));

assign asc011 = {asc003,asc006,asc010};

assign out1 = asc011;
endmodule

/* CADENCE  uLn1QwA= : u9/ySgnWtBlWxVbRXgAU4eg= ** DO NOT EDIT THIS LINE ******/



