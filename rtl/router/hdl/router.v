`include "define.v" 
module router ( 
        idata_0,  
        ivalid_0, 
        ivch_0,   
        oack_0,   
        ordy_0,   
        olck_0,   

        idata_1,  
        ivalid_1, 
        ivch_1,   
        oack_1,   
        ordy_1,   
        olck_1,   

        idata_2,  
        ivalid_2, 
        ivch_2,   
        oack_2,   
        ordy_2,   
        olck_2,   

        odata_0,  
        ovalid_0, 
        ovch_0,   
        iack_0,   
        ilck_0,   

        odata_1,  
        ovalid_1, 
        ovch_1,   
        iack_1,   
        ilck_1,   

        odata_2,  
        ovalid_2, 
        ovch_2,   
        iack_2,   
        ilck_2,   

        my_xpos, 
        my_ypos, 

        clk, 
        rst_ 
);
parameter       ROUTERID = 0;

input   [`DATAW:0] idata_0;  
input              ivalid_0; 
input   [`VCHW:0]  ivch_0;   
output  [`VCH:0]   oack_0;   
output  [`VCH:0]   ordy_0;   
output  [`VCH:0]   olck_0;   

input   [`DATAW:0] idata_1;  
input              ivalid_1; 
input   [`VCHW:0]  ivch_1;   
output  [`VCH:0]   oack_1;   
output  [`VCH:0]   ordy_1;   
output  [`VCH:0]   olck_1;   

input   [`DATAW:0] idata_2;  
input              ivalid_2; 
input   [`VCHW:0]  ivch_2;   
output  [`VCH:0]   oack_2;   
output  [`VCH:0]   ordy_2;   
output  [`VCH:0]   olck_2;   

output  [`DATAW:0] odata_0;  
output             ovalid_0; 
output  [`VCHW:0]  ovch_0;   
input   [`VCH:0]   iack_0;   
input   [`VCH:0]   ilck_0;   

output  [`DATAW:0] odata_1;  
output             ovalid_1; 
output  [`VCHW:0]  ovch_1;   
input   [`VCH:0]   iack_1;   
input   [`VCH:0]   ilck_1;   

output  [`DATAW:0] odata_2;  
output             ovalid_2; 
output  [`VCHW:0]  ovch_2;   
input   [`VCH:0]   iack_2;   
input   [`VCH:0]   ilck_2;   

input [`ARRAYW:0]  my_xpos; 
input [`ARRAYW:0]  my_ypos; 

input    clk;  
input    rst_; 

/* 
 * Wires from input channels (ic_) 
 */ 
wire [`DATAW:0] ic_odata_0; 
wire [`DATAW:0] ic_odata_1; 
wire [`DATAW:0] ic_odata_2; 

wire            ic_ovalid_0; 
wire            ic_ovalid_1; 
wire            ic_ovalid_2; 

wire [`VCHW:0]  ic_ovch_0; 
wire [`VCHW:0]  ic_ovch_1; 
wire [`VCHW:0]  ic_ovch_2; 

wire [`PORTW:0] ic_port_0; 
wire [`PORTW:0] ic_port_1; 
wire [`PORTW:0] ic_port_2; 

wire            ic_req_0; 
wire            ic_req_1; 
wire            ic_req_2; 

/* 
 * Wires from crossbar (cb_) 
 */ 
wire [`DATAW:0] cb_odata_0; 
wire [`DATAW:0] cb_odata_1; 
wire [`DATAW:0] cb_odata_2; 

wire            cb_ovalid_0; 
wire            cb_ovalid_1; 
wire            cb_ovalid_2; 

wire [`VCHW:0]  cb_ovch_0; 
wire [`VCHW:0]  cb_ovch_1; 
wire [`VCHW:0]  cb_ovch_2; 

wire [`PORT:0]  cb_grt_0; 
wire [`PORT:0]  cb_grt_1; 
wire [`PORT:0]  cb_grt_2; 

/* 
 * Wires from output channels (oc_) 
 */ 
wire [`VCH:0]   oc_ordy_0; 
wire [`VCH:0]   oc_ordy_1; 
wire [`VCH:0]   oc_ordy_2; 

wire [`VCH:0]   oc_olck_0; 
wire [`VCH:0]   oc_olck_1; 
wire [`VCH:0]   oc_olck_2; 

/* 
 * Input physical channels 
 */ 
inputc #( ROUTERID, 0 ) ic_0 ( 
       .idata ( idata_0     ), 
       .ivalid( ivalid_0    ), 
       .ivch  ( ivch_0      ), 
       .oack  ( oack_0      ), 
       .ordy  ( ordy_0      ), 
       .olck  ( olck_0      ), 

       .odata ( ic_odata_0  ), 
       .ovalid( ic_ovalid_0 ), 
       .ovch  ( ic_ovch_0   ), 

       .irdy_0( oc_ordy_0   ), 
       .irdy_1( oc_ordy_1   ), 
       .irdy_2( oc_ordy_2   ), 
       .ilck_0( oc_olck_0   ), 
       .ilck_1( oc_olck_1   ), 
       .ilck_2( oc_olck_2   ), 

       .grt_0 ( cb_grt_0[0] ), 
       .grt_1 ( cb_grt_0[1] ), 
       .grt_2 ( cb_grt_0[2] ), 

       .port  ( ic_port_0   ), 
       .req   ( ic_req_0    ), 

       .my_xpos( my_xpos    ),  
       .my_ypos( my_ypos    ),  

       .clk ( clk  ),          
       .rst_( rst_ )           
);                             

inputc #( ROUTERID, 1 ) ic_1 ( 
       .idata ( idata_1     ), 
       .ivalid( ivalid_1    ), 
       .ivch  ( ivch_1      ), 
       .oack  ( oack_1      ), 
       .ordy  ( ordy_1      ), 
       .olck  ( olck_1      ), 

       .odata ( ic_odata_1  ), 
       .ovalid( ic_ovalid_1 ), 
       .ovch  ( ic_ovch_1   ), 

       .irdy_0( oc_ordy_0   ), 
       .irdy_1( oc_ordy_1   ), 
       .irdy_2( oc_ordy_2   ), 
       .ilck_0( oc_olck_0   ), 
       .ilck_1( oc_olck_1   ), 
       .ilck_2( oc_olck_2   ), 

       .grt_0 ( cb_grt_1[0] ), 
       .grt_1 ( cb_grt_1[1] ), 
       .grt_2 ( cb_grt_1[2] ), 

       .port  ( ic_port_1   ), 
       .req   ( ic_req_1    ), 

       .my_xpos( my_xpos    ),  
       .my_ypos( my_ypos    ),  

       .clk ( clk  ),          
       .rst_( rst_ )           
);                             

inputc #( ROUTERID, 2 ) ic_2 ( 
       .idata ( idata_2     ), 
       .ivalid( ivalid_2    ), 
       .ivch  ( ivch_2      ), 
       .oack  ( oack_2      ), 
       .ordy  ( ordy_2      ), 
       .olck  ( olck_2      ), 

       .odata ( ic_odata_2  ), 
       .ovalid( ic_ovalid_2 ), 
       .ovch  ( ic_ovch_2   ), 

       .irdy_0( oc_ordy_0   ), 
       .irdy_1( oc_ordy_1   ), 
       .irdy_2( oc_ordy_2   ), 
       .ilck_0( oc_olck_0   ), 
       .ilck_1( oc_olck_1   ), 
       .ilck_2( oc_olck_2   ), 

       .grt_0 ( cb_grt_2[0] ), 
       .grt_1 ( cb_grt_2[1] ), 
       .grt_2 ( cb_grt_2[2] ), 

       .port  ( ic_port_2   ), 
       .req   ( ic_req_2    ), 

       .my_xpos( my_xpos    ),  
       .my_ypos( my_ypos    ),  

       .clk ( clk  ),          
       .rst_( rst_ )           
);                             


/* 
 * Crossbar switch 
 */ 
cb cb ( 
        .idata_0 ( ic_odata_0  ), 
        .ivalid_0( ic_ovalid_0 ), 
        .ivch_0  ( ic_ovch_0   ), 
        .port_0  ( ic_port_0   ), 
        .req_0   ( ic_req_0    ), 
        .grt_0   ( cb_grt_0    ), 

        .idata_1 ( ic_odata_1  ), 
        .ivalid_1( ic_ovalid_1 ), 
        .ivch_1  ( ic_ovch_1   ), 
        .port_1  ( ic_port_1   ), 
        .req_1   ( ic_req_1    ), 
        .grt_1   ( cb_grt_1    ), 

        .idata_2 ( ic_odata_2  ), 
        .ivalid_2( ic_ovalid_2 ), 
        .ivch_2  ( ic_ovch_2   ), 
        .port_2  ( ic_port_2   ), 
        .req_2   ( ic_req_2    ), 
        .grt_2   ( cb_grt_2    ), 

        .odata_0 ( cb_odata_0  ), 
        .ovalid_0( cb_ovalid_0 ), 
        .ovch_0  ( cb_ovch_0   ), 

        .odata_1 ( cb_odata_1  ), 
        .ovalid_1( cb_ovalid_1 ), 
        .ovch_1  ( cb_ovch_1   ), 

        .odata_2 ( cb_odata_2  ), 
        .ovalid_2( cb_ovalid_2 ), 
        .ovch_2  ( cb_ovch_2   ), 

        .clk ( clk  ),
        .rst_( rst_ ) 
);                    

/* 
 * Output channels 
 */ 
outputc #( ROUTERID, 0 ) oc_0 ( 
       .idata ( cb_odata_0  ), 
       .ivalid( cb_ovalid_0 ), 
       .ivch  ( cb_ovch_0   ), 

       .odata ( odata_0     ), 
       .ovalid( ovalid_0    ), 
       .ovch  ( ovch_0      ), 

       .iack  ( iack_0      ), 
       .ordy  ( oc_ordy_0   ), 

       .ilck  ( ilck_0      ), 
       .olck  ( oc_olck_0   ), 

       .clk ( clk  ),
       .rst_( rst_ ) 
);                  

outputc #( ROUTERID, 1 ) oc_1 ( 
       .idata ( cb_odata_1  ), 
       .ivalid( cb_ovalid_1 ), 
       .ivch  ( cb_ovch_1   ), 

       .odata ( odata_1     ), 
       .ovalid( ovalid_1    ), 
       .ovch  ( ovch_1      ), 

       .iack  ( iack_1      ), 
       .ordy  ( oc_ordy_1   ), 

       .ilck  ( ilck_1      ), 
       .olck  ( oc_olck_1   ), 

       .clk ( clk  ),
       .rst_( rst_ ) 
);                  

outputc #( ROUTERID, 2 ) oc_2 ( 
       .idata ( cb_odata_2  ), 
       .ivalid( cb_ovalid_2 ), 
       .ivch  ( cb_ovch_2   ), 

       .odata ( odata_2     ), 
       .ovalid( ovalid_2    ), 
       .ovch  ( ovch_2      ), 

       .iack  ( iack_2      ), 
       .ordy  ( oc_ordy_2   ), 

       .ilck  ( ilck_2      ), 
       .olck  ( oc_olck_2   ), 

       .clk ( clk  ),
       .rst_( rst_ ) 
);                  

endmodule
