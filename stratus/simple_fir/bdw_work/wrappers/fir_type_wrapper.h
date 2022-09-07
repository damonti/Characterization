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


#ifndef _FIR_TYPE_WRAP_INCLUDED_
#define _FIR_TYPE_WRAP_INCLUDED_

#if !defined(ioConfig_PIN)
#if defined(_p_ioConfig_PIN)
#define ioConfig_PIN 1
#endif
#endif


#include <systemc.h>
#include "fir.h"


// Declaration of wrapper with RTL level ports

SC_MODULE(fir_type_wrapper)
{
public:

	sc_in< bool > clk;
	sc_in< bool > rst;
	sc_in< sc_uint< 8 > > coeffs_table_0;
	sc_in< sc_uint< 8 > > coeffs_table_1;
	sc_in< sc_uint< 8 > > coeffs_table_2;
	sc_in< sc_uint< 8 > > coeffs_table_3;
	sc_in< sc_uint< 8 > > coeffs_table_4;
	sc_in< sc_uint< 8 > > coeffs_table_5;
	sc_in< sc_uint< 8 > > coeffs_table_6;
	sc_in< sc_uint< 8 > > coeffs_table_7;
	sc_out< bool > din_busy;
	sc_in< bool > din_vld;
	sc_in< sc_uint< 8 > > din_data;
	sc_in< bool > dout_busy;
	sc_out< bool > dout_vld;
	sc_out< sc_uint< 11 > > dout_data;

    
    // These signals are used to connect structured ports or ports that need
    // type conversion to the RTL ports.
    sc_signal< CoeffTable > coeffs;

    

	// create the netlist
    void InitInstances();
    void InitThreads();

    // delete the netlist
    void DeleteInstances();

    // The following threads are used to connect structured ports to the actual
    // RTL ports.
    void thread_coeffs();


	SC_HAS_PROCESS(fir_type_wrapper);

	fir_type_wrapper( sc_module_name name = sc_module_name( sc_gen_unique_name("fir")) )
		: sc_module(name)
		  ,clk("clk")
		  	,rst("rst")
		  	,coeffs_table_0("coeffs_table_0"),
		  coeffs_table_1("coeffs_table_1"),
		  coeffs_table_2("coeffs_table_2"),
		  coeffs_table_3("coeffs_table_3"),
		  coeffs_table_4("coeffs_table_4"),
		  coeffs_table_5("coeffs_table_5"),
		  coeffs_table_6("coeffs_table_6"),
		  coeffs_table_7("coeffs_table_7")
		  	,din_busy("din_busy")
		  	,din_vld("din_vld")
		  	,din_data("din_data")
		  	,dout_busy("dout_busy")
		  	,dout_vld("dout_vld")
		  	,dout_data("dout_data")
		  	

		  ,fir0(0)
		

    {
        InitInstances();
        InitThreads();
		end_module();
    }


    // destructor
    ~fir_type_wrapper()
    {
        DeleteInstances();
    }


protected:
	fir* fir0;
};

#endif /*  */
