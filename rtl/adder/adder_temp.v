module adder(
    input1,
    input2,
    sum
);

parameter N = 32;
input [N-1:0] input1, input2;
output [N-1:0] sum;
wire  carry_out;
wire [N-1:0] carry;
genvar i;
generate 
   for(i=0;i<N;i=i+1)
    begin: generate_N_bit_Adder
        if(i==0) 
            half_adder f(input1[0],input2[0],sum[0],carry[0]);
        else
            full_adder f(input1[i],input2[i],carry[i-1],sum[i],carry[i]); //the last carry will be lost (overflow)
    end
    assign carry_out = carry[N-1];
endgenerate
endmodule 


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


module full_adder(
    x,
    y,
    c_in,
    s,
    c_out
);
   input x,y,c_in;
   output s,c_out;
 assign s = (x^y) ^ c_in;
 assign c_out = (y&c_in)| (x&y) | (x&c_in);
endmodule // full_adder
