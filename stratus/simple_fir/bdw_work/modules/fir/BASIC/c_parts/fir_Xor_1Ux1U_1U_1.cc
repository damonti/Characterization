// Generated by stratus_hls 19.25-s100  (93142.260418)
// Wed Sep  7 16:24:57 2022
// from fir.cc
#include "fir_Xor_1Ux1U_1U_1.h"

struct fir_Xor_1Ux1U_1U_1;
fir_Xor_1Ux1U_1U_1::fir_Xor_1Ux1U_1U_1(sc_module_name name) : sc_module(name) 
    ,in2("in2")
    ,in1("in1")
    ,out1("out1")
{
  SC_METHOD(fir_Xor_1Ux1U_1U_1_thread_1);
  sensitive << ( in2 );
  sensitive << ( in1 );

}
void fir_Xor_1Ux1U_1U_1::fir_Xor_1Ux1U_1U_1_thread_1(){
  out1 = (sc_uint<1> ) (in2.read() ^ in1.read());
}