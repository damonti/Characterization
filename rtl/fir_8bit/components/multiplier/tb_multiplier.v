`timescale 1ns/10ps 
module tb_multiplier;

    parameter N = 16;
    parameter STEP = 10;
    integer count, fd;
    reg [N-1:0] inj_data;

    // Inputs
    reg clk, rst;
    reg  [(N/2)-1:0] in1, in2;
    // Outputs
    wire  [N-1:0] out;
    
    // Instantiate the Unit Under Test (UUT)
    //fir#(.N(N)) fir(
    multiplier multiplier(
        .in1(in1),
        .in2(in2),  
        .out(out)
    );

    
    
    //Generate a clock with 10 ns clock period.
always #(STEP/2) begin
        clk <= ~clk;
end
always #( STEP ) begin     
        count = count + 1; //to stop the simulation
end    
//Initialize and apply the inputs.
    initial begin
    //$dumpvars(0, tb_fir);    
    #0
    clk <= {1'b0};
    #(STEP)
    #(STEP / 2)
    count = 0;
    #(STEP)
    $write("Start clock %d \n", count);

    $dumpon;
    //in2[2:0] <= {3'b111};
    fd = $fopen("/home/20200969/Estimation/rtl/fir_8bit/components/multiplier/stimuli.txt", "r");
    if (!fd) $display("could not read file");
    while (!$feof(fd)) begin
            $fscanf(fd,"%b", inj_data);
            #(STEP)
            in1 <= inj_data[(N/2)-1:0];
            in2 <= inj_data[N-1:(N/2)];
    end
    $dumpoff;
    #(STEP)
    $write("------------------------\n");
    $write("Stop clock %d \n", count);
    $finish;
end

always #( STEP ) begin 
        //$write("inj_data=%b ", inj_data);
        $write("in1={%b} ", in1);
        $write("in2={%b} ", in2);
        $write("out={%b} ", out);
        $write("clk period count= %d", count);
        $write("\n"); 
end 

endmodule




