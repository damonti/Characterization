`timescale 1ps / 1ps
/*****************************************************************************
    Verilog RTL Description
    
    Configured at: 17:00:05 CEST (+0200), Tuesday 06 September 2022
    Configured on: es-eda.ele.tue.nl
    Configured by: 20200969 (Dario Monticelli, Manil)
    
    Created by: Stratus DpOpt 2019.1.04 
*******************************************************************************/

module fir_gen_busy_r_4_1 (
	in1,
	in2,
	in3,
	in4,
	out1
	); /* architecture "behavioural" */ 
input  in1,
	in2,
	in3,
	in4;
output [2:0] out1;
wire  asc004,
	asc005,
	asc007,
	asc009,
	asc010,
	asc012,
	asc014;
wire [2:0] asc015;

assign asc005 = 
	(in3)
	|(in1);

assign asc004 = 
	(in2)
	&(asc005);

assign asc007 = 
	(asc004)
	|(in4);

assign asc012 = 
	((~asc004));

assign asc010 = 
	(in1)
	&(asc012);

assign asc009 = 
	(asc010)
	|(in4);

assign asc014 = 
	((~asc009));

assign asc015 = {asc007,asc009,asc014};

assign out1 = asc015;
endmodule

/* CADENCE  v7nxSAo= : u9/ySgnWtBlWxVbRXgAU4eg= ** DO NOT EDIT THIS LINE ******/


