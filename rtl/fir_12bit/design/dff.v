module DFF
        (input Clk,
        input [23:0] D,
        output reg [23:0]   Q
        );
    
    always@ (posedge Clk)
        Q <= D;
    
endmodule