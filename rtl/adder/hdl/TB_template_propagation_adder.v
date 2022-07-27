/* energy estimation module for an adder */ 
`timescale 10ns/10ps 

module tb_adder;
parameter PAYLOAD = 20; //how many flits per packet
//parameter_N
parameter STEP   = 1.0; 
integer i, f;
 // Inputs
 reg [31:0] input1; 
 reg [31:0] input2;
 // Outputs
 wire [31:0] sum;
 integer count, seed;
 reg clk; 

 always #( STEP / 2 ) begin 
        clk <= ~clk;       
end 

always #( STEP ) begin     
        count = count + 1; 
        seed  = seed  + 1; 
end    

 // Instantiate the Unit Under Test (UUT)
adder adder (
  .input1(input1), 
  .input2(input2), 
  .sum(sum)
 );

 initial begin
  // Initialize Inputs
        $dumpfile("dump_adder.vcd"); 
        $dumpvars(0,tb_adder.adder);   
        $dumpoff;  

/* Initialization */            
        #0                              
        clk <= {1'b0};                      
        count   = 0;
        input1 <= 0;
        input2 <= 0;
        #(STEP)
        #(STEP / 2)
        $write("Start clock %d \n", count);
        $dumpon;
        f = $fopen("adder_output.txt","a+");
        for (i = 0; i < 2; i = i + 1) begin //10 packets are sent. each packet has 20 data flits (payload, len=20)
                send_data( PAYLOAD );
                #(STEP*2)         // Link utilization 4/13=0.30 (flit_rate injection)
                $write("------------------------\n");
        end
        #(STEP)
        $write("Stop clock %d \n", count);
        $dumpoff;
        $finish;
end

task send_data; 
input [31:0] len; //payload
integer j;
//reg   [31:0] ran0;   
//reg   [31:0] ran1;
time inj_data;   //"time" is unsigned 64 bit datatype
begin
            /* data transfer */ 
//INIT
        for (j = 0; j < len; j = j + 1) begin          
        #(STEP)
		case(inj_data)
//TOGGLE
		endcase

        input2 <= inj_data[(N-1):0]; //first half 
        input1 <= inj_data[(N*2)-1:N]; //second half
        
        $fwrite(f,"%b ",input1);
        $fwrite(f,"%b ",input2);
        $fwrite(f,"%b\n",sum);
        end
end

endtask
      

always #( STEP ) begin
 
        $write("CLK = %d ", count);
        $write("\n"); 
end 

endmodule