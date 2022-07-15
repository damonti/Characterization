/* energy estimation module for a mux */ 
`timescale 10ns/10ps 
`include "define_temp.v" 

module mux_test; 

parameter ENABLE = 1;   
parameter STEP   = 1.0; 
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

        .odata  ( odata    ), //the difference with the other muxes relies here:
        .ovalid ( ovalid   ), //this mux will rout the incoming data to the
        .ovch   ( ovch     ), //port 0

        .sel ( sel ) 
); 

initial begin                            

        $dumpfile("dump_mux.vcd"); 
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

        /* control signals */
        sel <= `PORT_P1'b00;

        #(STEP)
        #(STEP / 2)
        rst_    <= `Disable_;
        #(STEP)

        $write("Start clock %d \n", count);
        $dumpon;
        flag  = 1;
        sel <= 5'b10; //idata_1 is selected as output
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
integer inj_data;      
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

        /* data transfer */ 
	inj_data = {37{1'b0}};
        for (j = 0; j < len; j = j + 1) begin 
                ran0 <= $random(seed);       
                ran1 <= $random(seed);             
                #(STEP)
		case(inj_data)
		{37'b0000000000000000000000000000000000000} : inj_data = {37'b1111111111111111111111000000000000000};
		{37'b1111111111111111111111000000000000000} : inj_data = {37'b0000000111111111111111111111111111111};
		{37'b0000000111111111111111111111111111111} : inj_data = {37'b0000000000000000000000000000011111111};
		{37'b0000000000000000000000000000011111111} : inj_data = {37'b1111111111111100000000000000000000000};
		{37'b1111111111111100000000000000000000000} : inj_data = {37'b1111111111111111111111111111111111110};
		{37'b1111111111111111111111111111111111110} : inj_data = {37'b0000000000000000000001111111111111111};
		{37'b0000000000000000000001111111111111111} : inj_data = {37'b1111110000000000000000000000000000000};
		{37'b1111110000000000000000000000000000000} : inj_data = {37'b1111111111111111111111111111000000000};
		{37'b1111111111111111111111111111000000000} : inj_data = {37'b0000000000000111111111111111111111111};
		{37'b0000000000000111111111111111111111111} : inj_data = {37'b0000000000000000000000000000000000011};
		{37'b0000000000000000000000000000000000011} : inj_data = {37'b1111111111111111111100000000000000000};
		{37'b1111111111111111111100000000000000000} : inj_data = {37'b0000011111111111111111111111111111111};
		{37'b0000011111111111111111111111111111111} : inj_data = {37'b0000000000000000000000000001111111111};
		{37'b0000000000000000000000000001111111111} : inj_data = {37'b1111111111110000000000000000000000000};
		{37'b1111111111110000000000000000000000000} : inj_data = {37'b1111111111111111111111111111111111000};
		{37'b1111111111111111111111111111111111000} : inj_data = {37'b0000000000000000000111111111111111111};
		{37'b0000000000000000000111111111111111111} : inj_data = {37'b1111000000000000000000000000000000000};
		{37'b1111000000000000000000000000000000000} : inj_data = {37'b1111111111111111111111111100000000000};
		{37'b1111111111111111111111111100000000000} : inj_data = {37'b0000000000011111111111111111111111111};
		{37'b0000000000011111111111111111111111111} : inj_data = {37'b0000000000000000000000000000000001111};
		{37'b0000000000000000000000000000000001111} : inj_data = {37'b1111111111111111110000000000000000000};
		{37'b1111111111111111110000000000000000000} : inj_data = {37'b0001111111111111111111111111111111111};
		{37'b0001111111111111111111111111111111111} : inj_data = {37'b0000000000000000000000000111111111111};
		{37'b0000000000000000000000000111111111111} : inj_data = {37'b1111111111000000000000000000000000000};
		{37'b1111111111000000000000000000000000000} : inj_data = {37'b1111111111111111111111111111111100000};
		{37'b1111111111111111111111111111111100000} : inj_data = {37'b0000000000000000011111111111111111111};
		{37'b0000000000000000011111111111111111111} : inj_data = {37'b1100000000000000000000000000000000000};
		{37'b1100000000000000000000000000000000000} : inj_data = {37'b1111111111111111111111110000000000000};
		{37'b1111111111111111111111110000000000000} : inj_data = {37'b0000000001111111111111111111111111111};
		{37'b0000000001111111111111111111111111111} : inj_data = {37'b0000000000000000000000000000000111111};
		{37'b0000000000000000000000000000000111111} : inj_data = {37'b1111111111111111000000000000000000000};
		{37'b1111111111111111000000000000000000000} : inj_data = {37'b0111111111111111111111111111111111111};
		{37'b0111111111111111111111111111111111111} : inj_data = {37'b0000000000000000000000011111111111111};
		{37'b0000000000000000000000011111111111111} : inj_data = {37'b1111111100000000000000000000000000000};
		{37'b1111111100000000000000000000000000000} : inj_data = {37'b1111111111111111111111111111110000000};
		{37'b1111111111111111111111111111110000000} : inj_data = {37'b0000000000000001111111111111111111111};
		{37'b0000000000000001111111111111111111111} : inj_data = {37'b0000000000000000000000000000000000000};
		default : inj_data = {37{1'b0}};
		endcase                           
                if ( n > 0 && enable == 1 ) 
                        idata_0 <= {`TYPE_DATA, ran0, ran1}; 
                if ( n > 1 && enable == 1 )
                        //idata_1 <= inj_data;
			idata_1 <= 2{inj_data};        end                           
        ran0 <= $random(seed);       
        ran1 <= $random(seed);             
        #(STEP)                       
        if ( n > 0 && enable == 1 ) 
                idata_0 <= {`TYPE_TAIL, ran0, ran1}; 
        if ( n > 1 && enable == 1 ) 
                idata_1 <= {`TYPE_TAIL, ran0, ran1}; 

        #(STEP)                               
        idata_0 <= {`TYPE_NONE, 32'h0}; 
        ivalid_0<= `Disable; 
        idata_1 <= {`TYPE_NONE, 32'h0}; 
        ivalid_1<= `Disable; 

end                          
endtask                      

always #( STEP ) begin 
        $write("i0={%x,%x} ", idata_0, ivalid_0);
        $write("i1={%x,%x} ", idata_1, ivalid_1);
        $write("o0={%x,%x} ", odata, ovalid); 
        $write("CLK = %d", count);
        $write("\n"); 
end 
endmodule 
