//
// Top-level Verilog module

// One of these modules is created for each testcase that involves
// co-simulation.  This one is for the 'BASIC_V' testcase.
// The top-level module contains:
//	- An instances of a co-simulation wrapper module for each instance
//	  simulating in Verilog.
//	- Hub initialization calls that load the shared library for the
//	  simulation.
//
// You can add any other legal Verilog to this template file, and it appear in
// the verilog module.

`timescale 1 ps / 1 ps

module top;

	// RTL wrapper instances for cosim.
	fir_cosim fir0();


	integer n_cur_time;
	initial n_cur_time=0;
	reg [63:0] cur_time;
	initial cur_time=0;

	`include "hub.v"

	// Load library and begin co-simulation.
	initial begin

        // For gate-level simulations we back-annotate the instances with delays
        // from the SDF file
        

		// Open the trace file if that's appropriate.
		if ( hubCurrentProjectDoesTrace( hub_trace_vcd ) )
			$dumpfile( "bdw_work/sims/BASIC_V/verilog.vcd" );
		if ( hubCurrentProjectDoesTrace( hub_trace_vcd ) ) begin
		`ifdef ioConfig_PIN
		
		$dumpvars( 0, fir0.clk );
		$dumpvars( 0, fir0.rst );
		$dumpvars( 0, fir0.coeffs_table_0 );
		$dumpvars( 0, fir0.coeffs_table_1 );
		$dumpvars( 0, fir0.coeffs_table_2 );
		$dumpvars( 0, fir0.coeffs_table_3 );
		$dumpvars( 0, fir0.coeffs_table_4 );
		$dumpvars( 0, fir0.coeffs_table_5 );
		$dumpvars( 0, fir0.coeffs_table_6 );
		$dumpvars( 0, fir0.coeffs_table_7 );
		$dumpvars( 0, fir0.din_busy );
		$dumpvars( 0, fir0.din_vld );
		$dumpvars( 0, fir0.din_data );
		$dumpvars( 0, fir0.dout_busy );
		$dumpvars( 0, fir0.dout_vld );
		$dumpvars( 0, fir0.dout_data );
		
		`endif
			$dumpvars( 4, fir0.fir0 );
		end


		// If the SystemC shared library will be loaded using +qbSetOption+libdef=libname.so
		// from the Verilog simulator's command line, the following line can be left
		// out.  In order to load the shared library directly from Verilog, uncomment
		// the following line using either ther automatically generated SIM_EXEC string,
		// or a hard-coded string giving the path to the shared library.
		//hubLoadLibrary( "bdw_work/sims/BASIC_V/sim_BASIC_V.so", "" );

		// Begin a co-simulation.
		// This task returns after esc_end_cosim() is called from SystemC.
		hubStartCosim;
		#100 $stop;
	end
endmodule

//
// The following wrapper modules are used only for NCSim cosims.
//

`ifdef BDW_NCSC

module fir_nc_cosim(clk,
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
);

input clk;
wire clk;
input rst;
wire rst;
input [7:0] coeffs_table_0;
input [7:0] coeffs_table_1;
input [7:0] coeffs_table_2;
input [7:0] coeffs_table_3;
input [7:0] coeffs_table_4;
input [7:0] coeffs_table_5;
input [7:0] coeffs_table_6;
input [7:0] coeffs_table_7;
wire[7:0] coeffs_table_0;
wire[7:0] coeffs_table_1;
wire[7:0] coeffs_table_2;
wire[7:0] coeffs_table_3;
wire[7:0] coeffs_table_4;
wire[7:0] coeffs_table_5;
wire[7:0] coeffs_table_6;
wire[7:0] coeffs_table_7;
output din_busy;
wire din_busy;
input din_vld;
wire din_vld;
input din_data;
wire[7:0] din_data;
input dout_busy;
wire dout_busy;
output dout_vld;
wire dout_vld;
output dout_data;
wire[10:0] dout_data;

	reg [7:0]coeffs_table_0_delayed;
	always @ (coeffs_table_0) coeffs_table_0_delayed <= coeffs_table_0;
	reg [7:0]coeffs_table_1_delayed;
	always @ (coeffs_table_1) coeffs_table_1_delayed <= coeffs_table_1;
	reg [7:0]coeffs_table_2_delayed;
	always @ (coeffs_table_2) coeffs_table_2_delayed <= coeffs_table_2;
	reg [7:0]coeffs_table_3_delayed;
	always @ (coeffs_table_3) coeffs_table_3_delayed <= coeffs_table_3;
	reg [7:0]coeffs_table_4_delayed;
	always @ (coeffs_table_4) coeffs_table_4_delayed <= coeffs_table_4;
	reg [7:0]coeffs_table_5_delayed;
	always @ (coeffs_table_5) coeffs_table_5_delayed <= coeffs_table_5;
	reg [7:0]coeffs_table_6_delayed;
	always @ (coeffs_table_6) coeffs_table_6_delayed <= coeffs_table_6;
	reg [7:0]coeffs_table_7_delayed;
	always @ (coeffs_table_7) coeffs_table_7_delayed <= coeffs_table_7;
	reg din_vld_delayed;
	always @ (din_vld) din_vld_delayed <= din_vld;
	reg [7:0]din_data_delayed;
	always @ (din_data) din_data_delayed <= din_data;
	reg dout_busy_delayed;
	always @ (dout_busy) dout_busy_delayed <= dout_busy;
fir fir0( 	.clk(clk),
	.rst(rst),
	.coeffs_table_0(coeffs_table_0_delayed),
	.coeffs_table_1(coeffs_table_1_delayed),
	.coeffs_table_2(coeffs_table_2_delayed),
	.coeffs_table_3(coeffs_table_3_delayed),
	.coeffs_table_4(coeffs_table_4_delayed),
	.coeffs_table_5(coeffs_table_5_delayed),
	.coeffs_table_6(coeffs_table_6_delayed),
	.coeffs_table_7(coeffs_table_7_delayed),
	.din_busy(din_busy),
	.din_vld(din_vld_delayed),
	.din_data(din_data_delayed),
	.dout_busy(dout_busy_delayed),
	.dout_vld(dout_vld),
	.dout_data(dout_data)
);

   `include "hub.v"

   initial begin

if ( hubCurrentProjectDoesTrace( hub_trace_vcd ) )
	$dumpfile( "bdw_work/sims/BASIC_V/verilog.vcd" );
if ( hubCurrentProjectDoesTrace( hub_trace_vcd ) ) begin
`ifdef ioConfig_PIN

$dumpvars( 0, fir0.clk );
$dumpvars( 0, fir0.rst );
$dumpvars( 0, fir0.coeffs_table_0 );
$dumpvars( 0, fir0.coeffs_table_1 );
$dumpvars( 0, fir0.coeffs_table_2 );
$dumpvars( 0, fir0.coeffs_table_3 );
$dumpvars( 0, fir0.coeffs_table_4 );
$dumpvars( 0, fir0.coeffs_table_5 );
$dumpvars( 0, fir0.coeffs_table_6 );
$dumpvars( 0, fir0.coeffs_table_7 );
$dumpvars( 0, fir0.din_busy );
$dumpvars( 0, fir0.din_vld );
$dumpvars( 0, fir0.din_data );
$dumpvars( 0, fir0.dout_busy );
$dumpvars( 0, fir0.dout_vld );
$dumpvars( 0, fir0.dout_data );

`endif
	$dumpvars( 4, fir0 );
end
   end

endmodule


`endif


