/* energy estimation module for a mux */ 
`timescale 10ns/10ps 
`include "define.v" 

module mux_test; 

parameter ENABLE = 1;   
parameter STEP   = 1.0; 
//parameter STREAM = __NUM_STREAM__;
parameter STREAM = 5; 

integer i, j; 
integer count, seed, flag; 
reg clk, rst_; 

/* input/output mux */ 
reg    [`DATAW:0]    idata_0;  
reg                  ivalid_0; 
reg    [`VCHW:0]     ivch_0;   
reg    [`DATAW:0]    idata_1;  
reg                  ivalid_1; 
reg    [`VCHW:0]     ivch_1;   
reg    [`DATAW:0]    idata_2;  
reg                  ivalid_2; 
reg    [`VCHW:0]     ivch_2;   
reg    [`DATAW:0]    idata_3;  
reg                  ivalid_3; 
reg    [`VCHW:0]     ivch_3;   
reg    [`DATAW:0]    idata_4;  
reg                  ivalid_4; 
reg    [`VCHW:0]     ivch_4;   

reg    [`PORT:0]     sel;  

wire   [`DATAW:0]    odata;  
wire                 ovalid; 
wire   [`VCHW:0]     ovch;

always #( STEP / 2 ) begin 
        clk <= ~clk;       
end 

always #( STEP ) begin     
        count = count + 1; 
        seed  = seed  + 1; 
end                        

mux mux ( 
        .idata_0  ( idata_0  ), 
        .ivalid_0 ( ivalid_0 ), 
        .ivch_0   ( ivch_0   ), 

        .idata_1  ( idata_1  ), 
        .ivalid_1 ( ivalid_1 ), 
        .ivch_1   ( ivch_1   ), 

        .idata_2  ( idata_2  ), 
        .ivalid_2 ( ivalid_2 ), 
        .ivch_2   ( ivch_2   ), 

        .idata_3  ( idata_3  ), 
        .ivalid_3 ( ivalid_3 ), 
        .ivch_3   ( ivch_3   ), 

        .idata_4  ( idata_4  ), 
        .ivalid_4 ( ivalid_4 ), 
        .ivch_4   ( ivch_4   ), 

        .odata  ( odata    ), //the difference with the other muxes relies here:
        .ovalid ( ovalid   ), //this mux will rout the incoming data to the
        .ovch   ( ovch     ), //port 0

        .sel ( sel ) 
); 

initial begin                            

        $dumpfile("dump_mux_25percent_4interleaving.vcd"); 
        $dumpvars(0,mux_test.mux);   
        $dumpoff;                       
        `ifdef __POST_PR__               
        $sdf_annotate("router.sdf", noc_test.noc.n0, , "sdf.log", "MAXIMUM");
        `endif                           

        /* Initialization */            
        #0                              
        clk     <= `High;               
        rst_    <= `Enable_;            
        count   = 0;                    
        flag    = 0;                    

        /* port0 */              
        idata_0 <= `DATAW_P1'b0; 
        ivalid_0<= `Disable;     
        ivch_0  <= `VCHW_P1'b0;  
  

        /* port1 */              
        idata_1 <= `DATAW_P1'b0; 
        ivalid_1<= `Disable;     
        ivch_1  <= `VCHW_P1'b0;  
  

        /* port2 */              
        idata_2 <= `DATAW_P1'b0; 
        ivalid_2<= `Disable;     
        ivch_2  <= `VCHW_P1'b0;  
 

        /* port3 */              
        idata_3 <= `DATAW_P1'b0; 
        ivalid_3<= `Disable;     
        ivch_3  <= `VCHW_P1'b0;  
  

        /* port4 */              
        idata_4 <= `DATAW_P1'b0; 
        ivalid_4<= `Disable;     
        ivch_4  <= `VCHW_P1'b0;  

        /* control signals */
        sel <= `PORT_P1'b00000; //'

        #(STEP)
        #(STEP / 2)
        rst_    <= `Disable_;
        #(STEP)

        $write("Start clock %d \n", count);
        $dumpon;
        flag  = 1;
        sel <= 5'b00010; //idata_1 is selected as output
        for (i = 0; i < 10; i = i + 1) begin //10 packets are sent. each packet has 20 data flits (payload, len=20)
                send_data( STREAM, 20, ENABLE );
                #(STEP*7)         // Link utilization 4/13=0.30 (flit_rate injection)
                $write("------------------------\n");
        end
        flag = 0;

        #(STEP)
        $write("Stop clock %d \n", count);
        $dumpoff;
        $finish;
end

task send_data; 
input [31:0] n;      
input [31:0] len; //payload
input [31:0] enable; 
reg   [31:0] ran0;   
reg   [31:0] ran1;
reg   [4:0] sel;
integer   inj_data; //32 bit data    
//reg   [31:0] ran2;   
//reg   [31:0] ran3;   
begin                
        /* Initialization */ 
        if ( n > 0 && enable == 1 ) begin 
                idata_0 <= {`TYPE_HEAD, 32'h0, 32'h09}; 
                ivalid_0<= `Enable; 
        end 
        if ( n > 1 && enable == 1 ) begin 
                idata_1 <= {`TYPE_HEAD, 32'h0, 32'h04}; 
                ivalid_1<= `Enable; 
        end 
        if ( n > 2 && enable == 1 ) begin 
                idata_2 <= {`TYPE_HEAD, 32'h0, 32'h01}; 
                ivalid_2<= `Enable; 
        end 
        if ( n > 3 && enable == 1 ) begin 
                idata_3 <= {`TYPE_HEAD, 32'h0, 32'h06}; 
                ivalid_3<= `Enable; 
        end 
        if ( n > 4 && enable == 1 ) begin 
                idata_4 <= {`TYPE_HEAD, 32'h0, 32'h05}; 
                ivalid_4<= `Enable; 
        end 

        /* data transfer */ 
        inj_data = 0;
        for (j = 0; j < len; j = j + 1) begin 
                ran0 <= $random(seed);       
                ran1 <= $random(seed);       
                //ran2 <= $random(seed);       
                //ran3 <= $random(seed);       
                #(STEP)
                /* 25% SWITCHING ACTIVITY; 4 bit interleaving */
		case(inj_data)
                        {2{8'b0}} : inj_data = {2{8'b00000011}};
                        {2{8'b00000011}} : inj_data = {2{8'b00001111}};
                        {2{8'b00001111}} : inj_data = {2{8'b00111111}};
                        {2{8'b00111111}} : inj_data = {2{8'b11111111}};
                        {2{8'b11111111}} : inj_data = {2{8'b11111100}};
                        {2{8'b11111100}} : inj_data = {2{8'b11110000}};
                        {2{8'b11110000}} : inj_data = {2{8'b11000000}};
                        {2{8'b11000000}} : inj_data = {2{8'b00000000}};
                        default : inj_data = {32{1'b0}};
		endcase                       
                if ( n > 0 && enable == 1 ) 
                        idata_0 <= {`TYPE_DATA, ran0, ran1}; 
                if ( n > 1 && enable == 1 )
                        idata_1 <= {2{inj_data}};
                //        idata_1 <= {`TYPE_DATA, ran0, ran1}; 
                if ( n > 2 && enable == 1 ) 
                        idata_2 <= {`TYPE_DATA, ran0, ran1}; 
                if ( n > 3 && enable == 1 ) 
                        idata_3 <= {`TYPE_DATA, ran0, ran1}; 
                if ( n > 4 && enable == 1 ) 
                        idata_4 <= {`TYPE_DATA, ran0, ran1}; 
        end                           
        ran0 <= $random(seed);       
        ran1 <= $random(seed);       
        //ran2 <= $random(seed);       
        //ran3 <= $random(seed);       
        #(STEP)                       
        if ( n > 0 && enable == 1 ) 
                idata_0 <= {`TYPE_TAIL, ran0, ran1}; 
        if ( n > 1 && enable == 1 ) 
                idata_1 <= {`TYPE_TAIL, ran0, ran1}; 
        if ( n > 2 && enable == 1 ) 
                idata_2 <= {`TYPE_TAIL, ran0, ran1}; 
        if ( n > 3 && enable == 1 ) 
                idata_3 <= {`TYPE_TAIL, ran0, ran1}; 
        if ( n > 4 && enable == 1 ) 
                idata_4 <= {`TYPE_TAIL, ran0, ran1}; 
        #(STEP)                               
        idata_0 <= {`TYPE_NONE, 64'h0}; 
        ivalid_0<= `Disable; 
        idata_1 <= {`TYPE_NONE, 64'h0}; 
        ivalid_1<= `Disable; 
        idata_2 <= {`TYPE_NONE, 64'h0}; 
        ivalid_2<= `Disable; 
        idata_3 <= {`TYPE_NONE, 64'h0}; 
        ivalid_3<= `Disable; 
        idata_4 <= {`TYPE_NONE, 64'h0}; 
        ivalid_4<= `Disable; 
end                          
endtask                      

always #( STEP ) begin 
        $write("i0={%x,%x} ", idata_0, ivalid_0);
        $write("i1={%x,%x} ", idata_1, ivalid_1);
        $write("i2={%x,%x} ", idata_2, ivalid_2);
        $write("i3={%x,%x} ", idata_3, ivalid_3);
        $write("i4={%x,%x} ", idata_4, ivalid_4); 
        $write("o0={%x,%x} ", odata, ovalid); 
        $write("CLK = %d", count);
        $write("\n"); 
end 
endmodule 
