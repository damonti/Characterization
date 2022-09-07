/****************************************************************************
*
*  Copyright (c) 2017, Cadence Design Systems. All Rights Reserved.
*
*  This file contains confidential information that may not be
*  distributed under any circumstances without the written permision
*  of Cadence Design Systems.
*
****************************************************************************/


#ifndef _FIR_SC_WRAP_INCLUDED_
#define _FIR_SC_WRAP_INCLUDED_

#include <systemc.h>

struct fir;

#include "defines.h"
#include "cynw_p2p.h"
#include "hls_enums.h"


// Declaration of wrapper with BEH level ports

SC_MODULE(fir_wrapper)
{
public:

	sc_in< bool > clk;
	sc_in< bool > rst;
	sc_in< CoeffTable > coeffs;
	cynw::cynw_p2p_base_in <sc_dt::sc_uint <(int)8 >, HLS::hls_enum <(int)1 > > din;
	cynw::cynw_p2p_base_out <sc_dt::sc_uint <(int)11 >, HLS::hls_enum <(int)1 > > dout;

    
    // These signals are used to connect structured ports or ports that need
    // type conversion to the RTL ports.
    sc_signal< sc_uint< 8 > > coeffs_table_0;
    sc_signal< sc_uint< 8 > > coeffs_table_1;
    sc_signal< sc_uint< 8 > > coeffs_table_2;
    sc_signal< sc_uint< 8 > > coeffs_table_3;
    sc_signal< sc_uint< 8 > > coeffs_table_4;
    sc_signal< sc_uint< 8 > > coeffs_table_5;
    sc_signal< sc_uint< 8 > > coeffs_table_6;
    sc_signal< sc_uint< 8 > > coeffs_table_7;

    
	// create the netlist
    void InitInstances( );
    void InitThreads();

    // delete the netlist
    void DeleteInstances();

    // The following threads are used to connect structured ports to the actual
    // RTL ports.
    void thread_coeffs_table_0();
    void thread_coeffs_table_1();
    void thread_coeffs_table_2();
    void thread_coeffs_table_3();
    void thread_coeffs_table_4();
    void thread_coeffs_table_5();
    void thread_coeffs_table_6();
    void thread_coeffs_table_7();


	SC_HAS_PROCESS(fir_wrapper);

    	fir_wrapper( sc_module_name name = sc_module_name( sc_gen_unique_name("fir")) )
		: sc_module(name)
		  ,clk("clk")
		  	,rst("rst")
		  	,coeffs("coeffs")
		  	,din("din")
		  	,dout("dout")
		  	

		  ,fir0(0)

    {
        InitInstances( );
		InitThreads();
    }

    // destructor
    ~fir_wrapper()
    {
        DeleteInstances();
    }

	fir* fir0;
};

#endif /* _FIR_SC_WRAP_INCLUDED_ */
