`timescale 10ns/10ps 

module tb_mux8;


parameter PAYLOAD = 1024; //how many flits per packet
//parameter_N
parameter STEP   = 1.0; 
integer i;

 integer count, seed;
 reg clk; 

 // Inputs
reg [N-1:0] in9,
	in8,
	in7,
	in6,
	in5,
	in4,
	in3,
	in2;
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


mux8_fir mux8_fir (
  .in2(in2), 
  .in3(in3),
  .in4(in4), 
  .in5(in5),
  .in6(in6), 
  .in7(in7),
  .in8(in8), 
  .in9(in9),  
  .ctrl1(ctrl1), 
  .out1(out1)
 );

initial begin
    //initialize input
    $dumpvars(0, tb_mux8.mux8_fir);   
    $dumpoff;  
    
/* Initialization */            
        #0                              
        clk <= {1'b0};                      
        count   = 0;
        in2 <= 0;
        in3 <= 0;
        in4 <= 0;
        in5 <= 0;
        in6 <= 0;
        in7 <= 0;
        in8 <= 0;
        in9 <= 0;
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
        ctrl1 <= j % 8;       
        #(STEP)
		case(inj_data)
//TOGGLE
		endcase

        in2 <= inj_data;  
        in3 <= inj_data; 
        in4 <= inj_data;
        in5 <= inj_data;
        in6 <= inj_data;
        in7 <= inj_data;
        in8 <= inj_data;
        in9 <= inj_data;
        end
end

endtask
      

always #( STEP ) begin 
        $write("ctrl1={%x} ", ctrl1);
        $write("input2={%x} ", in2);
        $write("input3={%x} ", in3);
        $write("input4={%x} ", in4);
        $write("input5={%x} ", in5);
        $write("input6={%x} ", in6);
        $write("input7={%x} ", in7);
        $write("input8={%x} ", in8);
        $write("input9={%x} ", in9);
        $write("output={%x} ", out1); 
        $write("CLK = %d ", count);
        $write("\n"); 
end 

endmodule
