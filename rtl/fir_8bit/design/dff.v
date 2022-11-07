module DFF
        (input Clk,
        input [15:0] D,
        output reg [15:0]   Q
        );
    
    always@ (posedge Clk)
        Q <= D;
    
endmodule