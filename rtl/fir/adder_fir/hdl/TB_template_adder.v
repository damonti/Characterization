`timescale 10ns/10ps 

module tb_adder;


parameter PAYLOAD = 1024; //how many flits per packet
//parameter_N
parameter STEP   = 1.0; 
integer i;

 integer count, seed;
 reg clk; 

 // Inputs
 reg [N-1:0] in1; 
 reg [N-1:0] in2;
 // Outputs
 wire [N-1:0] out1;




 always #( STEP / 2 ) begin 
        clk <= ~clk;       
end 

always #( STEP ) begin     
        count = count + 1; //to stop the simulation
        seed  = seed  + 1; //??
end    


adder_fir adder_fir (
  .in1(in1), 
  .in2(in2), 
  .out1(out1)
 );

initial begin
    //initialize input
    $dumpvars(0,tb_adder.adder_fir);   
    $dumpoff;  
    
/* Initialization */            
        #0                              
        clk <= {1'b0};                      
        count   = 0;
        in1 <= 0;
        in2 <= 0;
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
time inj_data;   //"time" is unsigned 64 bit datatype
begin
            /* data transfer */ 
//INIT
        for (j = 0; j < len; j = j + 1) begin          
        #(STEP)
		case(inj_data)
//TOGGLE
		endcase

        in1 <= inj_data[(N-1):0]; //first half 
        in2 <= inj_data[(N*2)-1:N]; //second half
        
        end
end

endtask
      

always #( STEP ) begin 
        $write("input1={%x} ", in1);
        $write("input2={%x} ", in2);
        $write("output={%x} ", out1); 
        $write("CLK = %d ", count);
        $write("\n"); 
end 

endmodule
