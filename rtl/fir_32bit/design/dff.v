module DFF
        (input Clk,
        input [63:0] D,
        output reg [63:0]   Q
        );
    
    always@ (posedge Clk)
        Q <= D;
    
endmodule