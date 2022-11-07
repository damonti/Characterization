`timescale 1ps / 1ps
/*****************************************************************************
    Verilog RTL Description
    
    Configured at: 17:29:19 CET (+0100), Monday 31 October 2022
    Configured on: es-eda.ele.tue.nl
    Configured by: 20200969 (Dario Monticelli, Manil)
    
    Created by: Stratus DpOpt 2019.1.04 
*******************************************************************************/

//module ADD #(parameter N=8)(

module ADD(
	in2,
	in1,
	out
	); /* architecture "behavioural" */ 
input [7:0] in2,
	in1;
output [11:0] out;
wire [11:0] asc001;

assign asc001 = (in2)+(in1);

assign out = asc001;
endmodule

/* CADENCE  urf5TQ4= : u9/ySgnWtBlWxVbRXgAU4eg= ** DO NOT EDIT THIS LINE ******/



