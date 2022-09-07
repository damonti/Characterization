/****************************************************************************
 *
 *  Copyright (c) 2015, Cadence Design Systems. All Rights Reserved.
 *
 *  This file contains confidential information that may not be
 *  distributed under any circumstances without the written permision
 *  of Cadence Design Systems.
 *
 ***************************************************************************/

#ifndef _FIR_CYCSIM_INCLUDED_
#define _FIR_CYCSIM_INCLUDED_

#include "systemc.h"
#include "cynthhl.h"

SC_MODULE(fir_cycsim)
{

	// Port declarations.
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


	fir_cycsim( sc_module_name in_name=sc_module_name(sc_gen_unique_name(" fir") ) )
		: sc_module(in_name)
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
		  	

    {
    };
};

#endif
