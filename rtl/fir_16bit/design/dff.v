module DFF
        (input Clk,
        input [31:0] D,
        output reg [31:0]   Q
        );
    
    always@ (posedge Clk)
        Q <= D;
    
endmodule