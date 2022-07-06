`include "define.v" 
module vcmux ( 
        ovalid0, 
        ovalid1, 

        odata0, 
        odata1, 

        ovch0, 
        ovch1, 

        req0, 
        req1, 

        port0, 
        port1, 

        ovalid, 
        odata,  
        ovch,   
        req,    
        port,   
        vcsel,  

        clk,    
        rst_    
);
input                   ovalid0; 
input                   ovalid1; 

input   [`DATAW:0]      odata0; 
input   [`DATAW:0]      odata1; 

input   [`VCHW:0]       ovch0; 
input   [`VCHW:0]       ovch1; 

input                   req0; 
input                   req1; 

input   [`PORTW:0]      port0; 
input   [`PORTW:0]      port1; 

output                  ovalid; 
output  [`DATAW:0]      odata;  
output  [`VCHW:0]       ovch;   
output                  req;    
output  [`PORTW:0]      port;   
output  [`VCH:0]        vcsel;  

input   clk, rst_; 

reg    [`VCH:0]         last;   
wire   [`VCH:0]         grt;    
wire   [`VCH:0]         hold;   
wire                    anyhold;

assign  hold    = last & {req1, req0};
assign  anyhold = |hold; 
assign  vcsel   = grt;  

always @ (posedge clk) begin          
        if (rst_ == `Enable_)         
                last    <= `VCH_P1'b0;
        else if (last != grt)         
                last    <= grt;       
end                                   

assign  grt[0]  = anyhold ? hold[0] : ( req0);
assign  grt[1]  = anyhold ? hold[1] : (!req0 &  req1);

assign  ovalid  = ovalid0 | ovalid1;
assign  req     = req0 | req1;

assign  odata   = 
                  (last[0] == `Enable) ? odata0 :
                  (last[1] == `Enable) ? odata1 : `DATAW_P1'b0;
assign  ovch    = 
                  (last[0] == `Enable) ? ovch0 :
                  (last[1] == `Enable) ? ovch1 : `VCHW_P1'b0;
assign  port    = 
                  (vcsel[0] == `Enable) ? port0 :
                  (vcsel[1] == `Enable) ? port1 : `PORTW_P1'b0;
endmodule
