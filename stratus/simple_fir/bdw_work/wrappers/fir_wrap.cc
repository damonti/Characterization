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

#if defined(STRATUS_VLG)


#ifndef BDW_PORTS_ONLY
#define BDW_PORTS_ONLY 1
#endif


#include	"fir_rtl.cc"

#else 

#if defined(BDW_HUB)

#include "esc.h"

#if defined(BDW_RTL) || defined(COWARE_RTL_fir)

#define BDW_AUTO_KNOWN 1 


#ifndef BDW_PORTS_ONLY
#define BDW_PORTS_ONLY 1
#endif


#undef fir
#define fir fir_rtl
#	include	"fir_rtl.cc"
#undef fir


#ifdef BDW_PORTS_ONLY
#undef BDW_PORTS_ONLY
#endif



#elif defined(BDW_HOIST) 
#else

#endif
#ifdef BDW_COWARE
#include	"fir_coware.h"
#else
#include	"fir_cosim.h"
#endif

// include for cycle-accurate verilator simulation
#include    "fir_cycsim.h"



// Include the source for the behavioral model so it will be compiled.
#include	"/home/20200969/Estimation/stratus/simple_fir/fir.cc"


#define		fir_INTERNAL


#include	"fir_wrap.h"

// this global pointer indicates whether or not the Verilator cycsim wrapper is present
fir_cycsim* (*fir_cycsim_factory_p)() = 0;

#define MAX_SIMCONFIG_LENGTH 128

#if BDW_WRITEFSDB == 1

#if defined(NC_SYSTEMC) && defined(BDW_NCSC_VER) && BDW_NCSC_VER > 102
#include "fsdb_nc_mix.h"
#else
#if SYSTEMC_VERSION >= 20120701
#include "fsdb_osci.h"
#else
#include "fsdb_trace_file.h"
#endif
#endif 
#if BDW_USE_SCV
#include "scv.h"
#include "scv_tr_fsdb.h"
#endif

#endif /* BDW_WRITEFSDB */

inline void esc_open_fsdb_trace( const char *file_name = "systemc" );
inline void esc_close_fsdb_trace();
inline void esc_close_fsdb_scv_trace();

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


const char * fir_wrapper::simConfigName()
{
	static char defineBuf[MAX_SIMCONFIG_LENGTH];
	const char *simConfig = NULL;
	if ( qbhGetDefine( "BDW_SIM_CONFIG", defineBuf, MAX_SIMCONFIG_LENGTH ) == qbhOK )
	{
		simConfig = defineBuf;
	}
	else
	{
		simConfig = getenv( "BDW_SIM_CONFIG" );
	}

	if ( simConfig == NULL )
	{
		esc_report_error( esc_fatal, "BDW_SIM_CONFIG needs to be set" );
	}

	return simConfig;
}

enum fir_wrapper::Representation fir_wrapper::lookupRepresentation( const char* instName )
{
	const char *simConfig = simConfigName();

	if ( simConfig == NULL )
		return BDWRep_None;

	Representation result;

	qbhProjectHandle hProj;
	qbhError err = qbhGetCurrentProject( &hProj );
	if ( err == qbhErrorNoProject )
	{
		err = qbhOpenProject( "project.tcl", &hProj );

		if ( err != qbhOK )
		{
			esc_report_error( esc_fatal, "could not open project file %s",
							  "project.tcl" );
			return BDWRep_None;
		}
	}

	int iresult = 0;
	err = qbhGetRepresentation(hProj, "fir", simConfig, instName, &iresult );
	result = (Representation)iresult;

	if ( err == qbhOK )
		return result;

	// If this module isn't mentioned in the simConfig, assume it's behavioral.
	if ( err == qbhErrorNotFound ) {
		return BDWRep_Behavioral;
	} else if ( err == qbhErrorBadInstName ) {
		if (instName && *instName) {
			const char* leaf = strrchr( instName, '.' ) + 1;
			esc_report_error( esc_warning, "Instance names were specified for module '%s' in simConfig '%s', but they did not "
			                    "match the actal instance names in the RTL.  Try '%s' or '%s'. Simulating '%s' as BEH.\n",
								 "fir", simConfig, instName, leaf,  "fir" );
		}
		return BDWRep_Behavioral;
	}

    // If we couldn't get a license, then just exit.
    if ( err == qbhErrorNoLicense )
    {
        exit(1);
    }

	return BDWRep_None;
}

void fir_wrapper::InitInstances(  )
{
    enum fir_wrapper::Representation rep =
		fir_wrapper::lookupRepresentation( name() );

	esc_log_wrapper_inst( "fir" );
	esc_log_representation( "fir", name(), rep );

	

	switch ( rep )
	{
		case BDWRep_Gates:
		    fir_cosim0 = new fir_cosim( "fir" );

		    fir_cosim0->clk(clk);
		    fir_cosim0->rst(rst);
		    fir_cosim0->coeffs_table_0(coeffs_table_0);
		    fir_cosim0->coeffs_table_1(coeffs_table_1);
		    fir_cosim0->coeffs_table_2(coeffs_table_2);
		    fir_cosim0->coeffs_table_3(coeffs_table_3);
		    fir_cosim0->coeffs_table_4(coeffs_table_4);
		    fir_cosim0->coeffs_table_5(coeffs_table_5);
		    fir_cosim0->coeffs_table_6(coeffs_table_6);
		    fir_cosim0->coeffs_table_7(coeffs_table_7);
		    fir_cosim0->din_busy(din.busy);
		    fir_cosim0->din_vld(din.vld);
		    fir_cosim0->din_data(din.data);
		    fir_cosim0->dout_busy(dout.busy);
		    fir_cosim0->dout_vld(dout.vld);
		    fir_cosim0->dout_data(dout.data);

			break;
		case BDWRep_RTL_HDL:
		    fir_cosim0 = new fir_cosim( "fir" );

		    fir_cosim0->clk(clk);
		    fir_cosim0->rst(rst);
		    fir_cosim0->coeffs_table_0(coeffs_table_0);
		    fir_cosim0->coeffs_table_1(coeffs_table_1);
		    fir_cosim0->coeffs_table_2(coeffs_table_2);
		    fir_cosim0->coeffs_table_3(coeffs_table_3);
		    fir_cosim0->coeffs_table_4(coeffs_table_4);
		    fir_cosim0->coeffs_table_5(coeffs_table_5);
		    fir_cosim0->coeffs_table_6(coeffs_table_6);
		    fir_cosim0->coeffs_table_7(coeffs_table_7);
		    fir_cosim0->din_busy(din.busy);
		    fir_cosim0->din_vld(din.vld);
		    fir_cosim0->din_data(din.data);
		    fir_cosim0->dout_busy(dout.busy);
		    fir_cosim0->dout_vld(dout.vld);
		    fir_cosim0->dout_data(dout.data);

			break;
        case BDWRep_CYC_HDL:
            if ( fir_cycsim_factory_p )
                fir_cycsim0 = fir_cycsim_factory_p();
            else
            {
                esc_report_error( esc_fatal, "verilator_produced files not available for module fir");
                return;
            }

            esc_report_error( esc_note, " using verilator model for module \"fir\"");

		    fir_cycsim0->clk(clk);
		    fir_cycsim0->rst(rst);
		    fir_cycsim0->coeffs_table_0(coeffs_table_0);
		    fir_cycsim0->coeffs_table_1(coeffs_table_1);
		    fir_cycsim0->coeffs_table_2(coeffs_table_2);
		    fir_cycsim0->coeffs_table_3(coeffs_table_3);
		    fir_cycsim0->coeffs_table_4(coeffs_table_4);
		    fir_cycsim0->coeffs_table_5(coeffs_table_5);
		    fir_cycsim0->coeffs_table_6(coeffs_table_6);
		    fir_cycsim0->coeffs_table_7(coeffs_table_7);
		    fir_cycsim0->din_busy(din.busy);
		    fir_cycsim0->din_vld(din.vld);
		    fir_cycsim0->din_data(din.data);
		    fir_cycsim0->dout_busy(dout.busy);
		    fir_cycsim0->dout_vld(dout.vld);
		    fir_cycsim0->dout_data(dout.data);

			break;
#if defined(BDW_RTL) || defined(COWARE_RTL_fir)
		case BDWRep_RTL_C:
		    fir_rtl0 = new fir_rtl( "fir" );

		    fir_rtl0->clk(clk);
		    fir_rtl0->rst(rst);
		    fir_rtl0->coeffs_table_0(coeffs_table_0);
		    fir_rtl0->coeffs_table_1(coeffs_table_1);
		    fir_rtl0->coeffs_table_2(coeffs_table_2);
		    fir_rtl0->coeffs_table_3(coeffs_table_3);
		    fir_rtl0->coeffs_table_4(coeffs_table_4);
		    fir_rtl0->coeffs_table_5(coeffs_table_5);
		    fir_rtl0->coeffs_table_6(coeffs_table_6);
		    fir_rtl0->coeffs_table_7(coeffs_table_7);
		    fir_rtl0->din_busy(din.busy);
		    fir_rtl0->din_vld(din.vld);
		    fir_rtl0->din_data(din.data);
		    fir_rtl0->dout_busy(dout.busy);
		    fir_rtl0->dout_vld(dout.vld);
		    fir_rtl0->dout_data(dout.data);


			{
			const char *simConfig = fir_wrapper::simConfigName();
			
			if ( simConfig != NULL )
				{
				qbhProjectHandle hProj;
				qbhError err = qbhGetCurrentProject( &hProj );
				if ( err == qbhErrorNoProject )
				{
					err = qbhOpenProject( "project.tcl", &hProj );
			
					if ( err != qbhOK )
					{
						esc_report_error( esc_fatal, "could not open project file %s",
											  "project.tcl" );
							return;
					}
				}
			
				if ( esc_trace_is_enabled( esc_trace_vcd ) ) {
					esc_get_vcd_trace_file();
				}
				if ( esc_trace_is_enabled( esc_trace_fsdb ) ) {
					esc_get_fsdb_trace_file();
				}
				}
			}

			break;
#endif
		case BDWRep_Behavioral:
		    fir0 = new fir( "fir" );

		    fir0->clk(clk);
		    fir0->rst(rst);
		    fir0->coeffs(coeffs);
		    fir0->din.busy(din.busy);
		    fir0->din.vld(din.vld);
		    fir0->din.data(din.data);
		    fir0->dout.busy(dout.busy);
		    fir0->dout.vld(dout.vld);
		    fir0->dout.data(dout.data);


			{
			const char *simConfig = fir_wrapper::simConfigName();
			
			if ( simConfig != NULL )
				{
				qbhProjectHandle hProj;
				qbhError err = qbhGetCurrentProject( &hProj );
				if ( err == qbhErrorNoProject )
				{
					err = qbhOpenProject( "project.tcl", &hProj );
			
					if ( err != qbhOK )
					{
						esc_report_error( esc_fatal, "could not open project file %s",
											  "project.tcl" );
							return;
					}
				}
			
				if ( esc_trace_is_enabled( esc_trace_vcd ) ) {
					esc_get_vcd_trace_file();
				}
				if ( esc_trace_is_enabled( esc_trace_fsdb ) ) {
					esc_get_fsdb_trace_file();
				}
				}
			}

			break;
		case BDWRep_None:
		default:
			esc_report_error( esc_error, "No representation could be determined for simulating instance %s. Please make sure that you used the right name string in the module constructor",
							  name() );
			break;
	}
}

void fir_wrapper::InitThreads()
{
	if ( !isBEH() )
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
}

void fir_wrapper::start_of_simulation()
{

#include <fir_trace.h>

    esc_multiple_writers_warning();
}

void fir_wrapper::CloseTrace()
{
	if ( esc_trace_is_enabled( esc_trace_vcd ) ) {
	esc_close_vcd_trace();
	}
	if ( esc_trace_is_enabled( esc_trace_fsdb ) ) {
		esc_close_fsdb_trace();
		if ( esc_trace_is_enabled( esc_trace_scv ) ) {
			esc_close_fsdb_scv_trace();
		}
	}
}

void fir_wrapper::end_of_simulation()
{
	CloseTrace();
}



void fir_wrapper::DeleteInstances()
{
    if (fir0)
    {
        delete fir0;
        fir0 = 0;
    }
    if (fir_cosim0)
    {
        delete fir_cosim0;
        fir_cosim0 = 0;
    }
    if (fir_cycsim0)
    {
        delete fir_cycsim0;
        fir_cycsim0 = 0;
    }
#if defined(BDW_RTL) || defined(COWARE_RTL_fir)
    if (fir_rtl0)
    {
        delete fir_rtl0;
        fir_rtl0 = 0;
    }
#endif
}

// The following threads are used to connect RTL ports to the actual
// structured ports
void fir_wrapper_r::thread_coeffs()
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


const char * fir_wrapper_r::simConfigName()
{
	static char defineBuf[MAX_SIMCONFIG_LENGTH];
	const char *simConfig = NULL;
	if ( qbhGetDefine( "BDW_SIM_CONFIG", defineBuf, MAX_SIMCONFIG_LENGTH ) == qbhOK )
	{
		simConfig = defineBuf;
	}
	else
	{
		simConfig = getenv( "BDW_SIM_CONFIG" );
	}

	if ( simConfig == NULL )
	{
		esc_report_error( esc_fatal, "BDW_SIM_CONFIG needs to be set" );
	}

	return simConfig;
}

enum fir_wrapper_r::Representation fir_wrapper_r::lookupRepresentation( const char* instName )
{
	const char *simConfig = simConfigName();

	if ( simConfig == NULL )
		return BDWRep_None;

	Representation result;

	qbhProjectHandle hProj;
	qbhError err = qbhGetCurrentProject( &hProj );
	if ( err == qbhErrorNoProject )
	{
		err = qbhOpenProject( "project.tcl", &hProj );

		if ( err != qbhOK )
		{
			esc_report_error( esc_fatal, "could not open project file %s",
							  "project.tcl" );
			return BDWRep_None;
		}
	}

	int iresult = 0;
	err = qbhGetRepresentation(hProj, "fir", simConfig, instName, &iresult );
	result = (Representation)iresult;

	if ( err == qbhOK )
		return result;

	// If this module isn't mentioned in the simConfig, assume it's behavioral.
	if ( err == qbhErrorNotFound )
		return BDWRep_Behavioral;

    // If we couldn't get a license, then just exit.
    if ( err == qbhErrorNoLicense )
    {
        exit(1);
    }

	return BDWRep_None;
}

void fir_wrapper_r::InitInstances()
{
    enum fir_wrapper_r::Representation rep =
		fir_wrapper_r::lookupRepresentation( name() );

	esc_log_wrapper_inst( "fir" );
	esc_log_representation( "fir", name(), rep );

	switch ( rep )
	{
		case BDWRep_Gates:
		    fir_cosim0 = new fir_cosim( "fir" );

		    fir_cosim0->clk(clk);
		    fir_cosim0->rst(rst);
		    fir_cosim0->coeffs_table_0(coeffs_table_0);
		    fir_cosim0->coeffs_table_1(coeffs_table_1);
		    fir_cosim0->coeffs_table_2(coeffs_table_2);
		    fir_cosim0->coeffs_table_3(coeffs_table_3);
		    fir_cosim0->coeffs_table_4(coeffs_table_4);
		    fir_cosim0->coeffs_table_5(coeffs_table_5);
		    fir_cosim0->coeffs_table_6(coeffs_table_6);
		    fir_cosim0->coeffs_table_7(coeffs_table_7);
		    fir_cosim0->din_busy(din_busy);
		    fir_cosim0->din_vld(din_vld);
		    fir_cosim0->din_data(din_data);
		    fir_cosim0->dout_busy(dout_busy);
		    fir_cosim0->dout_vld(dout_vld);
		    fir_cosim0->dout_data(dout_data);

			break;
		case BDWRep_RTL_HDL:
		    fir_cosim0 = new fir_cosim( "fir" );

		    fir_cosim0->clk(clk);
		    fir_cosim0->rst(rst);
		    fir_cosim0->coeffs_table_0(coeffs_table_0);
		    fir_cosim0->coeffs_table_1(coeffs_table_1);
		    fir_cosim0->coeffs_table_2(coeffs_table_2);
		    fir_cosim0->coeffs_table_3(coeffs_table_3);
		    fir_cosim0->coeffs_table_4(coeffs_table_4);
		    fir_cosim0->coeffs_table_5(coeffs_table_5);
		    fir_cosim0->coeffs_table_6(coeffs_table_6);
		    fir_cosim0->coeffs_table_7(coeffs_table_7);
		    fir_cosim0->din_busy(din_busy);
		    fir_cosim0->din_vld(din_vld);
		    fir_cosim0->din_data(din_data);
		    fir_cosim0->dout_busy(dout_busy);
		    fir_cosim0->dout_vld(dout_vld);
		    fir_cosim0->dout_data(dout_data);

			break;
        case BDWRep_CYC_HDL:
            if ( fir_cycsim_factory_p )
                fir_cycsim0 = fir_cycsim_factory_p();
            else
            {
                esc_report_error( esc_fatal, "verilator_produced files not available for module fir");
                return;
            }

            esc_report_error( esc_note, " using verilator model for module \"fir\"");

		    fir_cycsim0->clk(clk);
		    fir_cycsim0->rst(rst);
		    fir_cycsim0->coeffs_table_0(coeffs_table_0);
		    fir_cycsim0->coeffs_table_1(coeffs_table_1);
		    fir_cycsim0->coeffs_table_2(coeffs_table_2);
		    fir_cycsim0->coeffs_table_3(coeffs_table_3);
		    fir_cycsim0->coeffs_table_4(coeffs_table_4);
		    fir_cycsim0->coeffs_table_5(coeffs_table_5);
		    fir_cycsim0->coeffs_table_6(coeffs_table_6);
		    fir_cycsim0->coeffs_table_7(coeffs_table_7);
		    fir_cycsim0->din_busy(din_busy);
		    fir_cycsim0->din_vld(din_vld);
		    fir_cycsim0->din_data(din_data);
		    fir_cycsim0->dout_busy(dout_busy);
		    fir_cycsim0->dout_vld(dout_vld);
		    fir_cycsim0->dout_data(dout_data);

			break;
#if defined(BDW_RTL) || defined(COWARE_RTL_fir)
		case BDWRep_RTL_C:
		    fir_rtl0 = new fir_rtl( "fir" );

		    fir_rtl0->clk(clk);
		    fir_rtl0->rst(rst);
		    fir_rtl0->coeffs_table_0(coeffs_table_0);
		    fir_rtl0->coeffs_table_1(coeffs_table_1);
		    fir_rtl0->coeffs_table_2(coeffs_table_2);
		    fir_rtl0->coeffs_table_3(coeffs_table_3);
		    fir_rtl0->coeffs_table_4(coeffs_table_4);
		    fir_rtl0->coeffs_table_5(coeffs_table_5);
		    fir_rtl0->coeffs_table_6(coeffs_table_6);
		    fir_rtl0->coeffs_table_7(coeffs_table_7);
		    fir_rtl0->din_busy(din_busy);
		    fir_rtl0->din_vld(din_vld);
		    fir_rtl0->din_data(din_data);
		    fir_rtl0->dout_busy(dout_busy);
		    fir_rtl0->dout_vld(dout_vld);
		    fir_rtl0->dout_data(dout_data);


			{
			const char *simConfig = fir_wrapper::simConfigName();
			
			if ( simConfig != NULL )
				{
				qbhProjectHandle hProj;
				qbhError err = qbhGetCurrentProject( &hProj );
				if ( err == qbhErrorNoProject )
				{
					err = qbhOpenProject( "project.tcl", &hProj );
			
					if ( err != qbhOK )
					{
						esc_report_error( esc_fatal, "could not open project file %s",
											  "project.tcl" );
							return;
					}
				}
			
				if ( esc_trace_is_enabled( esc_trace_vcd ) ) {
					esc_get_vcd_trace_file();
				}
				if ( esc_trace_is_enabled( esc_trace_fsdb ) ) {
					esc_get_fsdb_trace_file();
				}
				}
			}

			break;
#endif
		case BDWRep_Behavioral:
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


			{
			const char *simConfig = fir_wrapper::simConfigName();
			
			if ( simConfig != NULL )
				{
				qbhProjectHandle hProj;
				qbhError err = qbhGetCurrentProject( &hProj );
				if ( err == qbhErrorNoProject )
				{
					err = qbhOpenProject( "project.tcl", &hProj );
			
					if ( err != qbhOK )
					{
						esc_report_error( esc_fatal, "could not open project file %s",
											  "project.tcl" );
							return;
					}
				}
			
				if ( esc_trace_is_enabled( esc_trace_vcd ) ) {
					esc_get_vcd_trace_file();
				}
				if ( esc_trace_is_enabled( esc_trace_fsdb ) ) {
					esc_get_fsdb_trace_file();
				}
				}
			}

			break;
		case BDWRep_None:
		default:
			esc_report_error( esc_error, "No representation could be determined for simulating instance %s. Please make sure that you used the right name string in the module constructor",
							  name() );
			break;
	}
}

void fir_wrapper_r::InitThreads()
{
	if ( isBEH() ) 
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
}

void fir_wrapper_r::start_of_simulation()
{

#include <fir_trace.h>

    esc_multiple_writers_warning();
}

void fir_wrapper_r::CloseTrace()
{
	if ( esc_trace_is_enabled( esc_trace_vcd ) ) {
	esc_close_vcd_trace();
	}
	if ( esc_trace_is_enabled( esc_trace_fsdb ) ) {
		esc_close_fsdb_trace();
		if ( esc_trace_is_enabled( esc_trace_scv ) ) {
			esc_close_fsdb_scv_trace();
		}
	}
}

void fir_wrapper_r::end_of_simulation()
{
	CloseTrace();
}



void fir_wrapper_r::DeleteInstances()
{
    if (fir0)
    {
        delete fir0;
        fir0 = 0;
    }
    if (fir_cosim0)
    {
        delete fir_cosim0;
        fir_cosim0 = 0;
    }
    if (fir_cycsim0)
    {
        delete fir_cycsim0;
        fir_cycsim0 = 0;
    }
#if defined(BDW_RTL) || defined(COWARE_RTL_fir)
    if (fir_rtl0)
    {
        delete fir_rtl0;
        fir_rtl0 = 0;
    }
#endif
}

#if BDW_WRITEFSDB == 1

inline void esc_open_fsdb_trace( const char *file_name  )
{
	sc_trace_file *fsdb_file;
#if ( defined(NC_SYSTEMC) && defined(BDW_NCSC_VER) && BDW_NCSC_VER > 102 ) || SYSTEMC_VERSION >= 20120701
    fsdbDumpfile(file_name);
    esc_set_trace_file( fsdb_file, esc_trace_fsdb );
# else

	// SystemC suffixes .fsdb to filenames automatically. Make sure
	// that doesn't get tacked onto a filename that already has the suffix.
	if ( strrchr( file_name, '.' ) != NULL )
	{
		char *trunc_file_name = new char[strlen(file_name)+1];
		strcpy( trunc_file_name, file_name );

		fsdb_file = new fsdb_trace_file( trunc_file_name );
		esc_set_trace_file( fsdb_file, esc_trace_fsdb );

		delete trunc_file_name;
	}
	else
	{
		fsdb_file = new fsdb_trace_file( file_name );
		esc_set_trace_file( fsdb_file, esc_trace_fsdb );
	}
#endif

//
// Novas's SystemC wrapper doesn't have a way to set the time unit as of SystemC 2.1v1.
//
//		((fsdb_trace_file*)fsdb_file)->sc_set_fsdb_time_unit( -12 );
}

inline void esc_close_fsdb_trace()
{
#if ! ((defined(NC_SYSTEMC) &&  defined(BDW_NCSC_VER) && BDW_NCSC_VER > 102) || SYSTEMC_VERSION >= 20120701)
	fsdb_trace_file * fsdb_file =
		(fsdb_trace_file *)esc_trace_file( esc_trace_fsdb );

	if ( fsdb_file != NULL )
	{
		fsdb_file->CloseFile();
		delete fsdb_file;
		esc_set_trace_file( NULL, esc_trace_fsdb );
	}
#endif
}

#else

inline void esc_open_fsdb_trace( const char *file_name )
{
}

inline void esc_close_fsdb_trace()
{
}

#endif

#if BDW_USE_SCV && BDW_WRITEFSDB == 1
static scv_tr_db* local_fsdb_scv_db = 0;

inline void esc_open_fsdb_scv_trace( const char *file_name  )
{
	// Start SCV logging to FSDB if there is not already a database setup.
    if (!esc_get_scv_tr_db() && esc_trace_is_enabled(esc_trace_scv) )
	{
		scv_startup();
		scv_tr_fsdb_init();

		char* scv_file_name = new char[strlen(file_name) + 1];
		strcpy( scv_file_name, file_name );
		char* fsdb_suffix = strstr( scv_file_name, ".fsdb" );
		if (fsdb_suffix)
			*fsdb_suffix = 0;
		local_fsdb_scv_db = new scv_tr_db(scv_file_name);

		delete [] scv_file_name;
		esc_set_scv_tr_db(local_fsdb_scv_db);
		scv_tr_db::set_default_db(local_fsdb_scv_db);
		local_fsdb_scv_db->set_recording(true);
	}
}

inline void esc_close_fsdb_scv_trace()
{
    if ( local_fsdb_scv_db && (local_fsdb_scv_db == esc_get_scv_tr_db() ) ) 
	{
		delete local_fsdb_scv_db;
		local_fsdb_scv_db = 0;
		esc_set_scv_tr_db(0);
	}
}
#else 
inline void esc_open_fsdb_scv_trace( const char *file_name  )
{
}

inline void esc_close_fsdb_scv_trace()
{
}

#endif

class fir_wrapper_fsdb_opener {
public:
	fir_wrapper_fsdb_opener() {
		esc_set_open_fsdb_trace( esc_open_fsdb_trace );
		esc_set_open_fsdb_scv_trace( esc_open_fsdb_scv_trace );
	}
};

static fir_wrapper_fsdb_opener
  fir_wrapper_fsdb_opener_inst;

#else

// Visible to uses of the wrapper outside of the BDW environment.
// Only behavioral SystemC simulation is supported.


// Include the source for the behavioral model so it will be compiled.
#include	"/home/20200969/Estimation/stratus/simple_fir/fir.cc"

#define		fir_INTERNAL


#include	"fir_wrap.h"

const char * fir_wrapper::simConfigName()
{
  return "";
}

enum fir_wrapper::Representation fir_wrapper::lookupRepresentation( const char* instName )
{
  return BDWRep_Behavioral;
}

void fir_wrapper::InitInstances( sc_core::sc_module_name  )
{
	fir0 = new fir( "fir" );

	fir0->clk(clk);
	fir0->rst(rst);
	fir0->coeffs(coeffs);
	fir0->din.busy(din.busy);
	fir0->din.vld(din.vld);
	fir0->din.data(din.data);
	fir0->dout.busy(dout.busy);
	fir0->dout.vld(dout.vld);
	fir0->dout.data(dout.data);

}

void fir_wrapper::InitThreads()
{
}

void fir_wrapper::CloseTrace()
{
}

void fir_wrapper::DeleteInstances()
{
    if (fir0)
    {
        delete fir0;
        fir0 = 0;
    }
}

void fir_wrapper::start_of_simulation()
{
}

void fir_wrapper::end_of_simulation()
{
}



inline void esc_open_fsdb_trace( const char *file_name )
{
}

inline void esc_close_fsdb_trace()
{
}


inline void esc_open_fsdb_scv_trace( const char *file_name  )
{
}

inline void esc_close_fsdb_scv_trace()
{
}

class fir_wrapper_fsdb_opener {
public:
	fir_wrapper_fsdb_opener() {
	}
};

static fir_wrapper_fsdb_opener
  fir_wrapper_fsdb_opener_inst;

#endif

#endif
