/****************************************************************************
*
*  Copyright (c) 2015, Cadence Design Systems. All Rights Reserved.
*
*  This file contains confidential information that may not be
*  distributed under any circumstances without the written permision
*  of Cadence Design Systems.
*
****************************************************************************/
/****************************************************************************
*
* This file is used to wrap the three different versions of the DUT
* block called "fir". By default, it will include the behavioral
* model. Otherwise, it will include the RTL C++ or the RTL Verilog
* depending on the definition of either of "RTL" or "COSIM".
*
****************************************************************************/


#include	"fir_sc_wrap.h"
#include	"fir_sc_foreign.h"

// The following threads are used to connect structured ports to the actual
// RTL ports
void fir_wrapper::thread_coeffs_table_0()
{
   coeffs_table_0 = coeffs.read().table[0];
}
void fir_wrapper::thread_coeffs_table_1()
{
   coeffs_table_1 = coeffs.read().table[1];
}
void fir_wrapper::thread_coeffs_table_2()
{
   coeffs_table_2 = coeffs.read().table[2];
}
void fir_wrapper::thread_coeffs_table_3()
{
   coeffs_table_3 = coeffs.read().table[3];
}
void fir_wrapper::thread_coeffs_table_4()
{
   coeffs_table_4 = coeffs.read().table[4];
}
void fir_wrapper::thread_coeffs_table_5()
{
   coeffs_table_5 = coeffs.read().table[5];
}
void fir_wrapper::thread_coeffs_table_6()
{
   coeffs_table_6 = coeffs.read().table[6];
}
void fir_wrapper::thread_coeffs_table_7()
{
   coeffs_table_7 = coeffs.read().table[7];
}


void fir_wrapper::InitInstances(  )
{
	
            
    fir0 = new fir( "fir" );

    fir0->clk(clk);
    fir0->rst(rst);
    fir0->coeffs_table_0(coeffs_table_0);
    fir0->coeffs_table_1(coeffs_table_1);
    fir0->coeffs_table_2(coeffs_table_2);
    fir0->coeffs_table_3(coeffs_table_3);
    fir0->coeffs_table_4(coeffs_table_4);
    fir0->coeffs_table_5(coeffs_table_5);
    fir0->coeffs_table_6(coeffs_table_6);
    fir0->coeffs_table_7(coeffs_table_7);
    fir0->din_busy(din.busy);
    fir0->din_vld(din.vld);
    fir0->din_data(din.data);
    fir0->dout_busy(dout.busy);
    fir0->dout_vld(dout.vld);
    fir0->dout_data(dout.data);

}

void fir_wrapper::InitThreads()
{
    SC_METHOD(thread_coeffs_table_0);
      sensitive << coeffs;
    SC_METHOD(thread_coeffs_table_1);
      sensitive << coeffs;
    SC_METHOD(thread_coeffs_table_2);
      sensitive << coeffs;
    SC_METHOD(thread_coeffs_table_3);
      sensitive << coeffs;
    SC_METHOD(thread_coeffs_table_4);
      sensitive << coeffs;
    SC_METHOD(thread_coeffs_table_5);
      sensitive << coeffs;
    SC_METHOD(thread_coeffs_table_6);
      sensitive << coeffs;
    SC_METHOD(thread_coeffs_table_7);
      sensitive << coeffs;

}

void fir_wrapper::DeleteInstances()
{
    if (fir0)
    {
        delete fir0;
        fir0 = 0;
    }
}

