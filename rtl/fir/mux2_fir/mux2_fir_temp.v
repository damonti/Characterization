`timescale 10ns / 10ps
/*****************************************************************************
    Verilog RTL Description
    
    Configured at: 12:17:11 CEST (+0200), Monday 03 October 2022
    Configured on: es-eda.ele.tue.nl
    Configured by: 20200969 (Dario Monticelli, Manil)
    
    Created by: Stratus DpOpt 2019.1.04 
*******************************************************************************/

module mux2_fir (
	in3,
	in2,
	ctrl1,
	out1
	); /* architecture "behavioural" */ 
parameter N = 8;
input [N-1:0] in3, in2;
input ctrl1;
output [N-1:0] out1;
wire [N-1:0] asc001;

reg [N-1:0] asc001_tmp_0;
assign asc001 = asc001_tmp_0;
always @ (ctrl1 or in2 or in3) begin
	case (ctrl1)
		1'B1 : asc001_tmp_0 = in2 ;
		default : asc001_tmp_0 = in3 ;
	endcase
end

assign out1 = asc001;
endmodule

/* CADENCE  uLH1SgE= : u9/ySgnWtBlWxVbRXgAU4eg= ** DO NOT EDIT THIS LINE ******/



