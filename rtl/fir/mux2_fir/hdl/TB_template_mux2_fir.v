`timescale 10ns/10ps 

module tb_mux2;


parameter PAYLOAD = 1024; //how many flits per packet
//parameter_N
parameter STEP   = 1.0; 
integer i;

 integer count, seed;
 reg clk; 

 // Inputs
reg [N-1:0] in3, in2;
reg [2:0] ctrl1;
 // Outputs
wire [N-1:0] out1;


 always #( STEP / 2 ) begin 
        clk <= ~clk;       
end 

always #( STEP ) begin     
        count = count + 1; //to stop the simulation
        seed  = seed  + 1; //??
end    


mux2_fir mux2_fir (
  .in2(in2), 
  .in3(in3),  
  .ctrl1(ctrl1), 
  .out1(out1)
 );

initial begin
    //initialize input
    $dumpvars(0, tb_mux2.mux2_fir);   
    $dumpoff;  
    
/* Initialization */            
        #0                              
        clk <= {1'b0};                      
        count   = 0;
        in2 <= 0;
        in3 <= 0;
        ctrl1 <= 3'b001;
        #(STEP)
        #(STEP / 2)
        $write("Start clock %d \n", count);
        $dumpon;
        // for (i = 0; i < 10; i = i + 1) begin //10 packets are sent. each packet has $PAYLOAD data flits
        //         send_data( PAYLOAD );
        //         #(STEP*7)         // Link utilization 4/13=0.30 (flit_rate injection)
        //         $write("------------------------\n");
        // end
        send_data( PAYLOAD );
        #(STEP)
        $write("------------------------\n");
        #(STEP)
        $write("Stop clock %d \n", count);
        $dumpoff;
        $finish;
end

task send_data; 
input [31:0] len; //payload
integer j;
reg [7:0] inj_data;   //"time" is unsigned 64 bit datatype
begin
            /* data transfer */ 
//INIT
        for (j = 0; j < len; j = j + 1) begin   
        ctrl1 <= j % 2;       
        #(STEP)
		case(inj_data)
//TOGGLE
		endcase

        in2 <= inj_data;  
        in3 <= inj_data; 
        end
end

endtask
      

always #( STEP ) begin 
        $write("ctrl1={%x} ", ctrl1);
        $write("input2={%x} ", in2);
        $write("input3={%x} ", in3);
        $write("output={%x} ", out1); 
        $write("CLK = %d ", count);
        $write("\n"); 
end 

endmodule
