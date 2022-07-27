/* energy estimation module for an adder */ 
`timescale 10ns/10ps 

module tb_adder;
parameter PAYLOAD = 20; //how many flits per packet
parameter N = 22;
parameter STEP   = 1.0; 
integer i;
 // Inputs
 reg [N-1:0] input1; //time is unsigned 64 bit integer
 reg [N-1:0] input2;
 // Outputs
 wire [N-1:0] sum;
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
        for (i = 0; i < 10; i = i + 1) begin //10 packets are sent. each packet has 20 data flits (payload, len=20)
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
	inj_data = {44{1'b0}};
        for (j = 0; j < len; j = j + 1) begin          
        #(STEP)
		case(inj_data)
		{44'b00000000000000000000000000000000000000000000} : inj_data = {44'b11110000000000000000000000000000000000000000};
		{44'b11110000000000000000000000000000000000000000} : inj_data = {44'b11111111000000000000000000000000000000000000};
		{44'b11111111000000000000000000000000000000000000} : inj_data = {44'b11111111111100000000000000000000000000000000};
		{44'b11111111111100000000000000000000000000000000} : inj_data = {44'b11111111111111110000000000000000000000000000};
		{44'b11111111111111110000000000000000000000000000} : inj_data = {44'b11111111111111111111000000000000000000000000};
		{44'b11111111111111111111000000000000000000000000} : inj_data = {44'b11111111111111111111111100000000000000000000};
		{44'b11111111111111111111111100000000000000000000} : inj_data = {44'b11111111111111111111111111110000000000000000};
		{44'b11111111111111111111111111110000000000000000} : inj_data = {44'b11111111111111111111111111111111000000000000};
		{44'b11111111111111111111111111111111000000000000} : inj_data = {44'b11111111111111111111111111111111111100000000};
		{44'b11111111111111111111111111111111111100000000} : inj_data = {44'b11111111111111111111111111111111111111110000};
		{44'b11111111111111111111111111111111111111110000} : inj_data = {44'b11111111111111111111111111111111111111111111};
		{44'b11111111111111111111111111111111111111111111} : inj_data = {44'b00001111111111111111111111111111111111111111};
		{44'b00001111111111111111111111111111111111111111} : inj_data = {44'b00000000111111111111111111111111111111111111};
		{44'b00000000111111111111111111111111111111111111} : inj_data = {44'b00000000000011111111111111111111111111111111};
		{44'b00000000000011111111111111111111111111111111} : inj_data = {44'b00000000000000001111111111111111111111111111};
		{44'b00000000000000001111111111111111111111111111} : inj_data = {44'b00000000000000000000111111111111111111111111};
		{44'b00000000000000000000111111111111111111111111} : inj_data = {44'b00000000000000000000000011111111111111111111};
		{44'b00000000000000000000000011111111111111111111} : inj_data = {44'b00000000000000000000000000001111111111111111};
		{44'b00000000000000000000000000001111111111111111} : inj_data = {44'b00000000000000000000000000000000111111111111};
		{44'b00000000000000000000000000000000111111111111} : inj_data = {44'b00000000000000000000000000000000000011111111};
		{44'b00000000000000000000000000000000000011111111} : inj_data = {44'b00000000000000000000000000000000000000001111};
		{44'b00000000000000000000000000000000000000001111} : inj_data = {44'b00000000000000000000000000000000000000000000};
		default : inj_data = {44{1'b0}};
		endcase

        input1 <= inj_data[(N-1):0]; //first half 
        input2 <= inj_data[(N*2)-1:N]; //second half
        
        end
end

endtask
      

always #( STEP ) begin 
        $write("input1={%x} ", input1);
        $write("input2={%x} ", input2);
        $write("output={%x} ", sum); 
        $write("CLK = %d ", count);
        $write("\n"); 
end 

endmodule