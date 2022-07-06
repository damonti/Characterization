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

integer txt_in;
integer txt_out;
integer r = 1;
integer h = 0;

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

        $dumpfile("dump_mux_inputpattern.vcd"); 
        $dumpvars(0,mux_test.mux);   
        $dumpoff;    
        
        txt_in = $fopen("stimuli.txt", "r");  
        txt_out = $fopen("out.txt","w");                

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
        //input vectors
        //for (h = 0; h < 100; h++) begin
        while (r!=0) begin
                r = $fscanf(txt_in,"%b %b %b %b %b %b %b %b %b %b %b %b %b %b %b %b\n",sel, idata_0, ivalid_0, ivch_0, idata_1, ivalid_1, ivch_1, idata_2, ivalid_2, ivch_2, idata_3, ivalid_3, ivch_3, idata_4, ivalid_4, ivch_4);
                #(STEP) //this defines how many cycles between readings; in this case one clock cycle.
                $fwrite(txt_out,"%b\n", odata);
        end
        $finish;
        $fclose(txt_in);
        $fclose(txt_out);

        flag = 0;

        #(STEP)
        $write("Stop clock %d \n", count);
        $dumpoff;
        $finish;
        $stop;
end

always #( STEP ) begin 
        $write("i0={%x,%x}" , idata_0, ivalid_0);
        $write("i1={%x,%x}" , idata_1, ivalid_1);
        $write("i2={%x,%x}" , idata_2, ivalid_2);
        $write("i3={%x,%x}" , idata_3, ivalid_3);
        $write("i4={%x,%x}" , idata_4, ivalid_4); 
        $write("o0={%x,%x}" , odata, ovalid); 
        $write("CLK = %d", count);
        $write("r = %d", r);
        $write("\n"); 
end 
endmodule 
