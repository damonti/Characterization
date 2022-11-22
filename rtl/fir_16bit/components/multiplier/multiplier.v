`timescale 10ns/1ns 
/*****************************************************************************
    Verilog RTL Description
    
    Configured at: 17:29:21 CET (+0100), Monday 31 October 2022
    Configured on: es-eda.ele.tue.nl
    Configured by: 20200969 (Dario Monticelli, Manil)
    
    Created by: Stratus DpOpt 2019.1.04 
*******************************************************************************/

//module MUL #(parameter N=8)
module multiplier
    (
	in2,
	in1,
	out
	); /* architecture "behavioural" */ 
input [15:0] in2,in1;
output [31:0] out;
wire [31:0] asc001;

assign asc001 = (in1 * in2);

assign out = asc001;
endmodule

/* CADENCE  urb2Tg8= : u9/ySgnWtBlWxVbRXgAU4eg= ** DO NOT EDIT THIS LINE ******/

