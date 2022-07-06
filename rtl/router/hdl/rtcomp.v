`include "define.v" 
module rtcomp (
	addr,
	ivch,
	en,
	port,
	ovch,

	my_xpos,
	my_ypos,

	clk,
	rst_
);
input	[`ENTRYW:0]	addr;
input	[`ENTRYW:0]	ivch;
input			en;
output	[`PORTW:0]	port;
output	[`VCHW:0]	ovch;

input	[`ARRAYW:0]	my_xpos;
input	[`ARRAYW:0]	my_ypos;

input	clk;
input	rst_;

wire	[`PORTW:0]	port0;
reg	[`PORTW:0]	port1;
wire	[`VCHW:0]	ovch0;
reg	[`VCHW:0]	ovch1;

wire	[`ARRAYW:0]	dst_xpos;
wire	[`ARRAYW:0]	dst_ypos;
wire	[`ARRAYW:0]	delta_x1;	/* For torus */
wire	[`ARRAYW:0]	delta_x3;	/* For torus */

assign	dst_xpos= addr[`DSTX_MSB:`DSTX_LSB];
//assign	dst_ypos= addr[`DSTY_MSB:`DSTY_LSB];

assign	port	= en ? port0 : port1;
assign	ovch	= en ? ovch0 : ovch1;

always @ (posedge clk) begin
	if (rst_ == `Enable_) begin
		port1	<= 0;
		ovch1	<= 0;
	end else if (en) begin
		port1	<= port0;
		ovch1	<= ovch0;
	end
end
assign	port0	= ( dst_xpos == my_xpos ) ? 2 :
                  ( dst_xpos > my_xpos ) ? 0 : 1;
/* The same virtual channel is used. */
assign ovch0	= ivch;
endmodule
