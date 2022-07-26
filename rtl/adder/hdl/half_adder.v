module half_adder(
    x, //INPUT1
    y, //INPUT2
    s, //SUM
    c  //CARRY
); 
   input x,y;
   output s,c;
   assign s=x^y;
   assign c=x&y;
endmodule // half adder