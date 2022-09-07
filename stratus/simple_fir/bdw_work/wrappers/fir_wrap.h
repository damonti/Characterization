/****************************************************************************
*
*  Copyright (c) 2015, Cadence Design Systems. All Rights Reserved.
*
*  This file contains confidential information that may not be
*  distributed under any circumstances without the written permision
*  of Cadence Design Systems.
*
****************************************************************************/


#ifndef _FIR_WRAP_INCLUDED_
#define _FIR_WRAP_INCLUDED_

#if !defined(ioConfig_PIN)
#if defined(_p_ioConfig_PIN)
#define ioConfig_PIN 1
#endif
#endif


/* Save ioConfig define values for parent module and define those for this module's ioConfigs. */
#if defined(ioConfig_PIN)
#if defined(ioConfig) && defined(_wrap_ioConfig) && !defined(_local_ioConfig)
#undef ioConfig
#define ioConfig _local_ioConfig
#define _local_ioConfig PIN
#endif
#endif


#if defined(STRATUS_VLG) 

#include <systemc.h>

#define fir_wrapper fir

/* This is the section that is seen during processing by stratus_vlg of a module
 * that instantiates the module defined by this wrapper.
 */
SC_MODULE(fir)
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

	SC_CTOR(fir);
};

#elif defined(CYNTHHL) || defined(BDW_EXTRACT)

/* This is the section seen during processing by stratus_hls or bdw_extract of a module 
 * that instantiates the module defined by this wrapper.
 */
#include <systemc.h>

#include "defines.h"
#include "cynw_p2p.h"
#include "hls_enums.h"


#define fir_wrapper fir

/* Only port declarations are required for nested modules.
 */
SC_MODULE(fir)
{
public:
	sc_in< bool > clk;
	sc_in< bool > rst;
	sc_in< CoeffTable > coeffs;
	cynw::cynw_p2p_base_in <sc_dt::sc_uint <(int)8 >, HLS::hls_enum <(int)1 > > din;
	cynw::cynw_p2p_base_out <sc_dt::sc_uint <(int)11 >, HLS::hls_enum <(int)1 > > dout;


	SC_HAS_PROCESS(fir);
    	fir_wrapper( sc_module_name name = sc_module_name( sc_gen_unique_name("fir")) );
};

#else

#include <esc.h>


/* This is the section seen during processing by gcc either when the module
 * itself is compiled, or when a module that instantiates it is compiled.
 */

struct fir;
struct fir_cosim;
struct fir_cycsim;
struct fir_rtl;

#ifdef BDW_COWARE
#include	"fir_coware.h"
#endif

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

    
	enum Representation { BDWRep_None, BDWRep_Behavioral, BDWRep_RTL_C, BDWRep_RTL_HDL, BDWRep_Gates, BDWRep_CYC_HDL };
	static const char * simConfigName();
	static Representation lookupRepresentation( const char* instName );
	// create the netlist
    void InitInstances( );
    void InitThreads();

    // delete the netlist
    void DeleteInstances();

	void CloseTrace();
	void start_of_simulation();
	void end_of_simulation();


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
		  	

		  ,fir0(0), fir_cosim0(0), fir_rtl0(0), fir_cycsim0(0)
		

    {
        InitInstances( );
		InitThreads();
    }


    // destructor
    ~fir_wrapper()
    {
        DeleteInstances();

		CloseTrace();
    }

    bool isBEH() { return ( fir_wrapper::lookupRepresentation( name() ) == BDWRep_Behavioral ); }
    bool isRTL_C() { return ( fir_wrapper::lookupRepresentation( name() ) == BDWRep_RTL_C ); }
    bool isRTL_V() { return ( fir_wrapper::lookupRepresentation( name() ) == BDWRep_RTL_HDL ); }
    bool isGATES_V() { return ( fir_wrapper::lookupRepresentation( name() ) == BDWRep_Gates ); }
	bool isCosim() { return ( isRTL_V() || isGATES_V() ); }
    bool isCycsim() { return ( fir_wrapper::lookupRepresentation( name() ) == BDWRep_CYC_HDL ); }

	fir* behModule() { return fir0; }
	fir_cosim* cosimModule() { return fir_cosim0; }
	fir_cycsim* cycsimModule() { return fir_cycsim0; }
	fir_rtl* rtlModule() { return fir_rtl0; }

	fir* fir0;
	fir_cosim* fir_cosim0;
	fir_rtl* fir_rtl0;
	fir_cycsim* fir_cycsim0;
};

// Declaration of wrapper with RTL level ports

SC_MODULE(fir_wrapper_r)
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

    
	enum Representation { BDWRep_None, BDWRep_Behavioral, BDWRep_RTL_C, BDWRep_RTL_HDL, BDWRep_Gates, BDWRep_CYC_HDL };

	static const char * simConfigName();
	static Representation lookupRepresentation( const char* instName );
	// create the netlist
    void InitInstances();
    void InitThreads();

    // delete the netlist
    void DeleteInstances();

	void CloseTrace();
	void start_of_simulation();
	void end_of_simulation();


    // The following threads are used to connect structured ports to the actual
    // RTL ports.
    void thread_coeffs();


	SC_HAS_PROCESS(fir_wrapper_r);

	fir_wrapper_r( sc_module_name name = sc_module_name( sc_gen_unique_name("fir")) )
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
		  	

		  ,fir0(0), fir_cosim0(0), fir_rtl0(0), fir_cycsim0(0)
		

    {
        InitInstances();
        InitThreads();
		end_module();
    }


    // destructor
    ~fir_wrapper_r()
    {
        DeleteInstances();

		CloseTrace();
    }

    bool isBEH() { return ( fir_wrapper_r::lookupRepresentation( name() ) == BDWRep_Behavioral ); }
    bool isRTL_C() { return ( fir_wrapper_r::lookupRepresentation( name() ) == BDWRep_RTL_C ); }
    bool isRTL_V() { return ( fir_wrapper_r::lookupRepresentation( name() ) == BDWRep_RTL_HDL ); }
    bool isGATES_V() { return ( fir_wrapper_r::lookupRepresentation( name() ) == BDWRep_Gates ); }
	bool isCosim() { return ( isRTL_V() || isGATES_V() ); }
    bool isCycsim() { return ( fir_wrapper_r::lookupRepresentation( name() ) == BDWRep_CYC_HDL ); }

	fir* behModule() { return fir0; }
	fir_cosim* cosimModule() { return fir_cosim0; }
	fir_cycsim* cycsimModule() { return fir_cycsim0; }
	fir_rtl* rtlModule() { return fir_rtl0; }

protected:
	fir* fir0;
	fir_cosim* fir_cosim0;
	fir_rtl* fir_rtl0;
	fir_cycsim* fir_cycsim0;
};

#endif

/* Restore ioConfig define values for parent module. */
#if defined(ioConfig_PIN)
#if defined(ioConfig) && defined(_wrap_ioConfig) && defined(_local_ioConfig)
#undef _local_ioConfig
#undef ioConfig
#define ioConfig _wrap_ioConfig
#endif
#endif

#endif /*  */
