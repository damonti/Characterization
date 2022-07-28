/* energy estimation module for an adder */ 
`timescale 10ns/10ps
module tb_multiplier;

parameter PAYLOAD = 20; //how many flits per packet
//parameter_N
parameter STEP   = 1.0; 
integer i;

//Inputs
reg [N-1:0] input1; 
reg [N-1:0] input2;

wire [(N*2-1):0] product; // product

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
multiplier multiplier(
     // // Outputs
     .pdt(product[(N*2-1):0]),
     // // Inputs
     .a(input1[N-1:0]),
     .b(input2[N-1:0]),
     .clk(clk)
);

initial begin  
  // Initialize Inputs
        $dumpfile("dump_multiplier.vcd"); 
        $dumpvars(0,tb_multiplier.multiplier);   
        $dumpoff;  
        #0                              
        clk <= {1'b0};                      
        count   = 0;
        input1 <= 0;
        input2 <= 0;
        #(STEP)
        #(STEP / 2)
        $write("Start clock %d \n", count);
        $dumpon;
        for (i = 0; i < 10; i = i + 1) begin //10 packets are sent. each packet has $PAYLOAD data flits
                send_data( PAYLOAD );
                #(STEP*7)         // Link utilization 4/13=0.30 (flit_rate injection)
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

        input1 <= inj_data[(N-1):0]; //first half 
        input2 <= inj_data[(N*2)-1:N]; //second half
        
        end
end

endtask
      

always #( STEP ) begin 
        $write("input1={%x} ", input1);
        $write("input2={%x} ", input2);
        $write("output={%x} ", product); 
        $write("CLK = %d ", count);
        $write("\n"); 
end 

endmodule
