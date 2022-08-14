module multiplier ( a, b, clk, pdt);
  /*
  * parameter 'N' is the width of multiplier/multiplicand;.Application Notes 10-5
  * parameter 'level' is the intended number of stages of the
  * pipelined multiplier;
  * which is typically the smallest integer greater than or equal
  * to base 2 logarithm of 'N'
  */

parameter N = 4;
parameter level = 3;
  input [N-1 : 0] a;
  input [N-1 : 0] b;
  input clk;
  output [2*N-1 : 0] pdt;
  reg [N-1 : 0] a_int, b_int;
  reg [2*N-1 : 0] pdt_int [level-1 : 0];
  integer i;

  assign pdt = pdt_int [level-1];

  always @ (posedge clk)
  begin

    // registering input of the multiplier
    a_int <= a;
    b_int <= b;

    // 'level' levels of registers to be inferred at the output
    // of the multiplier
    pdt_int[0] <= a_int * b_int;
    for(i =1;i <level;i =i +1) begin
      pdt_int [i] <= pdt_int [i-1];
    end

  end
endmodule