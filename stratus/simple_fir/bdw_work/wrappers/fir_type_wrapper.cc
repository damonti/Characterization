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
* This file contains the fir_type_wrapper module
* for use in the verilog verification wrapper fir_vlwrapper.v
* It creats an instance of the fir module and has threads
* for converting the BEH ports to RTL level ports on the wrapper.
*
****************************************************************************/

#include "fir_type_wrapper.h"


SC_MODULE_EXPORT(fir_type_wrapper)

// The following threads are used to connect RTL ports to the actual
// structured ports
void fir_type_wrapper::thread_coeffs()
{
   CoeffTable tmp;
   tmp.table[0] = coeffs_table_0.read();
   tmp.table[1] = coeffs_table_1.read();
   tmp.table[2] = coeffs_table_2.read();
   tmp.table[3] = coeffs_table_3.read();
   tmp.table[4] = coeffs_table_4.read();
   tmp.table[5] = coeffs_table_5.read();
   tmp.table[6] = coeffs_table_6.read();
   tmp.table[7] = coeffs_table_7.read();
   coeffs.write(tmp);
}


void fir_type_wrapper::InitInstances()
{
    fir0 = new fir( "fir" );

    fir0->clk(clk);
    fir0->rst(rst);
    fir0->coeffs(coeffs);
    fir0->din.busy(din_busy);
    fir0->din.vld(din_vld);
    fir0->din.data(din_data);
    fir0->dout.busy(dout_busy);
    fir0->dout.vld(dout_vld);
    fir0->dout.data(dout_data);

}

void fir_type_wrapper::InitThreads()
{
    SC_METHOD(thread_coeffs);
      sensitive << coeffs_table_0;
      sensitive << coeffs_table_1;
      sensitive << coeffs_table_2;
      sensitive << coeffs_table_3;
      sensitive << coeffs_table_4;
      sensitive << coeffs_table_5;
      sensitive << coeffs_table_6;
      sensitive << coeffs_table_7;

}

void fir_type_wrapper::DeleteInstances()
{
        delete fir0;
        fir0 = 0;
}

