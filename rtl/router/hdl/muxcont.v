`include "define.v" 
module muxcont ( 
        port_0,   
        req_0,    

        port_1,   
        req_1,    

        port_2,   
        req_2,    

        sel, 
        grt, 

        clk, 
        rst_ 
);
parameter       PORTID = 0; 

input  [`PORTW:0] port_0;   
input             req_0;    

input  [`PORTW:0] port_1;   
input             req_1;    

input  [`PORTW:0] port_2;   
input             req_2;    

output [`PORT:0]  sel; 
output [`PORT:0]  grt; 

input             clk, rst_; 

reg    [`PORT:0]  last; 
wire   [`PORT:0]  req;  
wire   [`PORT:0]  grt0; 
wire   [`PORT:0]  hold; 
wire              anyhold;

assign  req[0]  = req_0 & (port_0 == PORTID); 
assign  req[1]  = req_1 & (port_1 == PORTID); 
assign  req[2]  = req_2 & (port_2 == PORTID); 

assign  hold    = last & req; 
assign  anyhold = |hold;      
assign  sel     = last;       

always @ (posedge clk) begin 
        if (rst_ == `Enable_) 
                last    <= `PORT_P1'b0; 
        else if (last != grt)               
                last    <= grt;             
end 

assign  grt[0]  = anyhold ? hold[0] : grt0[0]; 
assign  grt[1]  = anyhold ? hold[1] : grt0[1]; 
assign  grt[2]  = anyhold ? hold[2] : grt0[2]; 

/*                     
 * Arbiter             
 */                    
arb a0 (               
        .req ( req  ), 
        .grt ( grt0 ), 
        .clk ( clk  ), 
        .rst_( rst_ )  
);                     

endmodule
