`include "define.v" 
module mux ( 
        idata_0,  
        ivalid_0, 
        ivch_0,   

        idata_1,  
        ivalid_1, 
        ivch_1,   

        idata_2,  
        ivalid_2, 
        ivch_2,   

        idata_3,  
        ivalid_3, 
        ivch_3,    

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
input    [`DATAW:0]    idata_2;  
input                  ivalid_2; 
input    [`VCHW:0]     ivch_2;   
input    [`DATAW:0]    idata_3;  
input                  ivalid_3; 
input    [`VCHW:0]     ivch_3;     

input    [`PORT:0]     sel;  

output   [`DATAW:0]    odata;  
output                 ovalid; 
output   [`VCHW:0]     ovch;   

assign odata = 
                (sel == `PORT_P1'b0001) ? idata_0 : 
                (sel == `PORT_P1'b0010) ? idata_1 : 
                (sel == `PORT_P1'b0100) ? idata_2 : 
                (sel == `PORT_P1'b1000) ? idata_3 : 
                `DATAW_P1'b0;

assign ovalid = 
                (sel == `PORT_P1'b0001) ? ivalid_0 : 
                (sel == `PORT_P1'b0010) ? ivalid_1 : 
                (sel == `PORT_P1'b0100) ? ivalid_2 : 
                (sel == `PORT_P1'b1000) ? ivalid_3 : 
 
                1'b0;
assign ovch = 
                (sel == `PORT_P1'b0001) ? ivch_0 : 
                (sel == `PORT_P1'b0010) ? ivch_1 : 
                (sel == `PORT_P1'b0100) ? ivch_2 : 
                (sel == `PORT_P1'b1000) ? ivch_3 : 
                `VCHW_P1'b0;
endmodule
