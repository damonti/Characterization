/****************************************************************************
*
*  Copyright (c) 2015, Cadence Design Systems. All Rights Reserved.
*
*  This file contains confidential information that may not be
*  distributed under any circumstances without the written permision
*  of Cadence Design Systems.
*
****************************************************************************/
/****************************************************************************
*
* Verilog Verification wrapper module for the fir module.
*
* This module contains the followng items:
*	- A foreign module definition for use in instantiatin the type_wrapper module
*      which contains the BEH module instance.
*	- An instance of the type_wrapper foreign module.
*   - alwyas blocks each type_wrapper output.
*
****************************************************************************/

`timescale 1 ps / 1 ps

module fir_vlwrapper(
      `ifdef ioConfig_PIN
      
      clk,
       rst,
       coeffs_table_0,
       coeffs_table_1,
       coeffs_table_2,
       coeffs_table_3,
       coeffs_table_4,
       coeffs_table_5,
       coeffs_table_6,
       coeffs_table_7,
       din_busy,
       din_vld,
       din_data,
       dout_busy,
       dout_vld,
       dout_data
      `endif

    );

	`ifdef ioConfig_PIN
	
	input clk;
	input rst;
	input [7:0] coeffs_table_0;
	input [7:0] coeffs_table_1;
	input [7:0] coeffs_table_2;
	input [7:0] coeffs_table_3;
	input [7:0] coeffs_table_4;
	input [7:0] coeffs_table_5;
	input [7:0] coeffs_table_6;
	input [7:0] coeffs_table_7;
	output din_busy;
	reg din_busy;
	wire m_din_busy;
	input din_vld;
	input [7:0] din_data;
	input dout_busy;
	output dout_vld;
	reg dout_vld;
	wire m_dout_vld;
	output [10:0] dout_data;
	reg[10:0] dout_data;
	wire [10:0] m_dout_data;
	
	`endif


    // Instantiate the Verilog module that instantiates the SystemC module
    fir_type_wrapper fir_sc(
        `ifdef ioConfig_PIN
        
        .clk(clk),
         .rst(rst),
         .coeffs_table_0(coeffs_table_0),
         .coeffs_table_1(coeffs_table_1),
         .coeffs_table_2(coeffs_table_2),
         .coeffs_table_3(coeffs_table_3),
         .coeffs_table_4(coeffs_table_4),
         .coeffs_table_5(coeffs_table_5),
         .coeffs_table_6(coeffs_table_6),
         .coeffs_table_7(coeffs_table_7),
         .din_busy(m_din_busy),
         .din_vld(din_vld),
         .din_data(din_data),
         .dout_busy(dout_busy),
         .dout_vld(m_dout_vld),
         .dout_data(m_dout_data)
        `endif

    );

    // Always blocks for non-blocking assignments of type_wrapper outputs to
    // Verilog Verificatoin wrapper outputs.

    `ifdef ioConfig_PIN
    
    always @(m_din_busy)
     begin
      din_busy <= m_din_busy;
     end
    always @(m_dout_vld)
     begin
      dout_vld <= m_dout_vld;
     end
    always @(m_dout_data)
     begin
      dout_data <= m_dout_data;
     end
    
    `endif


endmodule

// This is an internal module that instantiates the user's SystemC input module
// using the Incisive foreign module instantiation feature.
// The name of the module and the names of the inputs and outputs must match
// with those defined in the SystemC type_wrapper module
module fir_type_wrapper(
      `ifdef ioConfig_PIN
      
      clk,
       rst,
       coeffs_table_0,
       coeffs_table_1,
       coeffs_table_2,
       coeffs_table_3,
       coeffs_table_4,
       coeffs_table_5,
       coeffs_table_6,
       coeffs_table_7,
       din_busy,
       din_vld,
       din_data,
       dout_busy,
       dout_vld,
       dout_data
      `endif

    ) (* integer foreign = "SystemC";
    *);

	`ifdef ioConfig_PIN
	
	input clk;
	input rst;
	input [7:0] coeffs_table_0;
	input [7:0] coeffs_table_1;
	input [7:0] coeffs_table_2;
	input [7:0] coeffs_table_3;
	input [7:0] coeffs_table_4;
	input [7:0] coeffs_table_5;
	input [7:0] coeffs_table_6;
	input [7:0] coeffs_table_7;
	output din_busy;
	input din_vld;
	input [7:0] din_data;
	input dout_busy;
	output dout_vld;
	output [10:0] dout_data;
	
	`endif


endmodule
