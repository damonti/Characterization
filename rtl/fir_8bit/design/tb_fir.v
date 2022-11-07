`timescale 1ns/10ps 
module tb_fir;

    parameter N = 8;
    parameter STEP = 10;
    integer count, fd;
    reg [N-1:0] inj_data;

    // Inputs
    reg clk, rst;
    reg  [N-1:0] Xin;
    reg [7:0] H0, H1, H2, H3;
    // Outputs
    wire  [11:0] Yout;
    
    // Instantiate the Unit Under Test (UUT)
    //fir#(.N(N)) fir(
    fir fir(
        .clk(clk),
        .rst(rst),  
        .Xin(Xin),
        .H0(H0),
        .H1(H1),
        .H2(H2),
        .H3(H3),
        .Yout(Yout)
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
    rst <= {1'b0};
    #(STEP)
    #(STEP / 2)
    count = 0;
    rst <= {1'b1};
    #(STEP)
    rst <= {1'b0};
    $write("Start clock %d \n", count);
    H0 <= {8'b00000001};
    H1 <= {8'b00000001};
    H2 <= {8'b00000001};
    H3 <= {8'b00000001};

    $dumpon;
    // Xin = {8'b00000001}; #STEP;
    // Xin = {8'b00000011};  #STEP;
    // Xin = {8'b00000111};  #STEP;
    // Xin = {8'b00001111}; #STEP;
    // Xin = {8'b00011111}; #STEP;
    // Xin = {8'b00111111};  #STEP;
    // Xin = {8'b01111111}; #STEP;
    // Xin = {8'b11111111};  #STEP;
    // Xin = {8'b11111110};  #STEP;
    // Xin = {8'b11111100};  #STEP;
    $dumpon;
    fd = $fopen("/home/20200969/Estimation/rtl/fir_8bit/design/stimuli.txt", "r");
    if (!fd) $display("could not read file");
    while (!$feof(fd)) begin
            $fscanf(fd,"%b", inj_data);
            #(STEP)
            Xin <= inj_data;
            //in1 <= inj_data[(N/2)-1:0];
            //in2 <= inj_data[N-1:(N/2)];
    end
    $dumpoff;
    #(STEP)
    $write("------------------------\n");
    $write("Stop clock %d \n", count);
    $finish;
end

always #( STEP ) begin 
        //$write("inj_data=%b ", inj_data);
        $write("Xin={%b} ", Xin);
        $write("Yout={%b} ", Yout);
        $write("clk period count= %d", count);
        $write("\n"); 
end 

endmodule




