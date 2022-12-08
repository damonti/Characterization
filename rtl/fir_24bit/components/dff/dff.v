`timescale 1ps / 1ps
/*****************************************************************************
    Verilog RTL Description
    
    Configured at: 17:29:19 CET (+0100), Monday 31 October 2022
    Configured on: es-eda.ele.tue.nl
    Configured by: 20200969 (Dario Monticelli, Manil)
    
    Created by: Stratus DpOpt 2019.1.04 
*******************************************************************************/

//module ADD #(parameter N=8)(

module dff(
    in,
	out,
    clk
	); /* architecture "behavioural" */ 
input [47:0] in;
output [47:0] out;
input clk;
reg [47:0] temp_out;

assign out = temp_out;

always@ (posedge clk)
    temp_out <= in;

endmodule

/* CADENCE  urf5TQ4= : u9/ySgnWtBlWxVbRXgAU4eg= ** DO NOT EDIT THIS LINE ******/



