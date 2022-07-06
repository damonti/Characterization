`include "define.v" 
module arb ( 
        req, 
        grt, 
        clk, 
        rst_ 
);

input  [`PORT:0]  req;      
output [`PORT:0]  grt;      
input             clk, rst_;

wire    [`PORTW:0]  pri0id;         /* client ID of the no.1 priority */ 
wire    [`PORTW:0]  pri1id;         /* client ID of the no.2 priority */ 
wire    [`PORTW:0]  pri2id;         /* client ID of the no.3 priority */ 
wire                    pri0grt;        /* enabled if pri0 is granted */ 
wire                    pri1grt;        /* enabled if pri1 is granted */ 
wire                    pri2grt;        /* enabled if pri2 is granted */ 

reg     [`PORTW:0]  pri [0:`PORT]; 

assign  pri0grt =  req[pri0id]; 
assign  pri1grt = ~req[pri0id] &  req[pri1id]; 
assign  pri2grt = ~req[pri0id] & ~req[pri1id] &  req[pri2id]; 

assign  grt[0]  = 
		(pri0id == 0) ?  pri0grt : 
		(pri1id == 0) ? ~pri0grt &  pri1grt : 
		(pri2id == 0) ? ~pri0grt & ~pri1grt &  pri2grt : 
		`Disable; 
assign  grt[1]  = 
		(pri0id == 1) ?  pri0grt : 
		(pri1id == 1) ? ~pri0grt &  pri1grt : 
		(pri2id == 1) ? ~pri0grt & ~pri1grt &  pri2grt : 
		`Disable; 
assign  grt[2]  = 
		(pri0id == 2) ?  pri0grt : 
		(pri1id == 2) ? ~pri0grt &  pri1grt : 
		(pri2id == 2) ? ~pri0grt & ~pri1grt &  pri2grt : 
		`Disable; 

assign  pri0id  = (pri[0] == 0) ? 0 : (pri[1] == 0) ? 1 : 2;
assign  pri1id  = (pri[0] == 1) ? 0 : (pri[1] == 1) ? 1 : 2;
assign  pri2id  = (pri[0] == 2) ? 0 : (pri[1] == 2) ? 1 : 2;

always @ (posedge clk) begin 
	if (rst_ == `Enable_) begin 
		pri[0]  <= 0;           /* client0's initial priority */ 
		pri[1]  <= 1;           /* client1's initial priority */ 
		pri[2]  <= 2;           /* client2's initial priority */ 
	end else if (grt[0]) begin 
		pri[0]  <= `PORT;
		if (pri[1] > pri[0]) pri[1]     <= pri[1] - 1; 
		if (pri[2] > pri[0]) pri[2]     <= pri[2] - 1; 
	end else if (grt[1]) begin 
		if (pri[0] > pri[1]) pri[0]     <= pri[0] - 1; 
		pri[1]  <= `PORT;
		if (pri[2] > pri[1]) pri[2]     <= pri[2] - 1; 
	end else if (grt[2]) begin 
		if (pri[0] > pri[2]) pri[0]     <= pri[0] - 1; 
		if (pri[1] > pri[2]) pri[1]     <= pri[1] - 1; 
		pri[2]  <= `PORT;
	end 
end 

endmodule
