`timescale 1ns/10ps 
module tb_dff;

    parameter N = 32;
    parameter STEP = 10;
    integer count, fd;
    reg [N-1:0] inj_data;

    // Inputs
    reg clk;
    reg  [N-1:0] in;
    // Outputs
    wire  [N-1:0] out;
    
    // Instantiate the Unit Under Test (UUT)
    //fir#(.N(N)) fir(
    dff dff(
        .in(in),
        .clk(clk),  
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
    fd = $fopen("/home/20200969/Estimation/rtl/fir_16bit/components/dff/stimuli.txt", "r");
    if (!fd) $display("could not read file");
    while (!$feof(fd)) begin
            $fscanf(fd,"%b", inj_data);
            #(STEP)
            in <= inj_data;
    end
    $dumpoff;
    #(STEP)
    $write("------------------------\n");
    $write("Stop clock %d \n", count);
    $finish;
end

always #( STEP ) begin 
        //$write("inj_data=%b ", inj_data);
        $write("in={%b} ", in);
        $write("out={%b} ", out);
        $write("clk period count= %d", count);
        $write("\n"); 
end 

endmodule




