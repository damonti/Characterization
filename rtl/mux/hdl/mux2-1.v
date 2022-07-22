`include "define.v" 
module mux ( 
        idata_0,  
        ivalid_0, 
        ivch_0,   

        idata_1,  
        ivalid_1, 
        ivch_1,   
        
        sel, 

        odata,  
        ovalid, 
        ovch    
);

input    [`DATAW:0]    idata_0;  
input                  ivalid_0; 
input    [`VCHW:0]     ivch_0;   
input    [`DATAW:0]    idata_1;  
input                  ivalid_1; 
input    [`VCHW:0]     ivch_1;   

input    [`PORT:0]     sel;  

output   [`DATAW:0]    odata;  
output                 ovalid; 
output   [`VCHW:0]     ovch;   

assign odata = 
                (sel == `PORT_P1'b01) ? idata_0 : 
                (sel == `PORT_P1'b10) ? idata_1 :  
                `DATAW_P1'b0;

assign ovalid = 
                (sel == `PORT_P1'b01) ? ivalid_0 : 
                (sel == `PORT_P1'b10) ? ivalid_1 : 
                1'b0;
assign ovch = 
                (sel == `PORT_P1'b01) ? ivch_0 : 
                (sel == `PORT_P1'b10) ? ivch_1 : 
                `VCHW_P1'b0;
endmodule