/****************************************************************************
*
*  Copyright (c) 2015, Cadence Design Systems. All Rights Reserved.
*
*  This file contains confidential information that may not be
*  distributed under any circumstances without the written permision
*  of Cadence Design Systems.
*
****************************************************************************/

#ifdef NCSC
#include <string>
typedef std::string sc_string;
#define SYSTEMC_VERSION 20070314
#endif

#include "fir_cycsim.h"
#include "esc_catrace.h"
#include "verilated.h"
#include "Vfir_rtl.h"


class Vfir_rtl;

class fir_cycsimV : public fir_cycsim
{
    // Port declarations inherited from parent class

    // These signals are used to connect ports that need type conversion to the RTL ports
    sc_signal< uint32_t > coeffs_table_0_I;
    sc_signal< uint32_t > coeffs_table_1_I;
    sc_signal< uint32_t > coeffs_table_2_I;
    sc_signal< uint32_t > coeffs_table_3_I;
    sc_signal< uint32_t > coeffs_table_4_I;
    sc_signal< uint32_t > coeffs_table_5_I;
    sc_signal< uint32_t > coeffs_table_6_I;
    sc_signal< uint32_t > coeffs_table_7_I;
    sc_signal< uint32_t > din_data_I;
    sc_signal< uint32_t > dout_data_O;


    // The following threads are used to do the type conversion.
    inline void thread_coeffs_table_0_I() {
        coeffs_table_0_I = (sc_uint<8>)coeffs_table_0.read();
    };
    inline void thread_coeffs_table_1_I() {
        coeffs_table_1_I = (sc_uint<8>)coeffs_table_1.read();
    };
    inline void thread_coeffs_table_2_I() {
        coeffs_table_2_I = (sc_uint<8>)coeffs_table_2.read();
    };
    inline void thread_coeffs_table_3_I() {
        coeffs_table_3_I = (sc_uint<8>)coeffs_table_3.read();
    };
    inline void thread_coeffs_table_4_I() {
        coeffs_table_4_I = (sc_uint<8>)coeffs_table_4.read();
    };
    inline void thread_coeffs_table_5_I() {
        coeffs_table_5_I = (sc_uint<8>)coeffs_table_5.read();
    };
    inline void thread_coeffs_table_6_I() {
        coeffs_table_6_I = (sc_uint<8>)coeffs_table_6.read();
    };
    inline void thread_coeffs_table_7_I() {
        coeffs_table_7_I = (sc_uint<8>)coeffs_table_7.read();
    };
    inline void thread_din_data_I() {
        din_data_I = (sc_uint<8>)din_data.read();
    };
    inline void thread_dout_data_O() {
        dout_data = dout_data_O.read();
    };


    SC_HAS_PROCESS(fir_cycsimV);

public:

    fir_cycsimV( sc_module_name in_name=sc_module_name(sc_gen_unique_name(" fir") ) )
        : fir_cycsim(in_name)
    {
        // instantiate the verilated module
        fir_cyc0 = new Vfir_rtl( "Vfir" );
        // generate port connections
        fir_cyc0->clk(clk);
        fir_cyc0->rst(rst);
        fir_cyc0->coeffs_table_0(coeffs_table_0_I);
        fir_cyc0->coeffs_table_1(coeffs_table_1_I);
        fir_cyc0->coeffs_table_2(coeffs_table_2_I);
        fir_cyc0->coeffs_table_3(coeffs_table_3_I);
        fir_cyc0->coeffs_table_4(coeffs_table_4_I);
        fir_cyc0->coeffs_table_5(coeffs_table_5_I);
        fir_cyc0->coeffs_table_6(coeffs_table_6_I);
        fir_cyc0->coeffs_table_7(coeffs_table_7_I);
        fir_cyc0->din_busy(din_busy);
        fir_cyc0->din_vld(din_vld);
        fir_cyc0->din_data(din_data_I);
        fir_cyc0->dout_busy(dout_busy);
        fir_cyc0->dout_vld(dout_vld);
        fir_cyc0->dout_data(dout_data_O);


        // setup the type conversion threads
        SC_METHOD( thread_coeffs_table_0_I);
            sensitive << coeffs_table_0;
        SC_METHOD( thread_coeffs_table_1_I);
            sensitive << coeffs_table_1;
        SC_METHOD( thread_coeffs_table_2_I);
            sensitive << coeffs_table_2;
        SC_METHOD( thread_coeffs_table_3_I);
            sensitive << coeffs_table_3;
        SC_METHOD( thread_coeffs_table_4_I);
            sensitive << coeffs_table_4;
        SC_METHOD( thread_coeffs_table_5_I);
            sensitive << coeffs_table_5;
        SC_METHOD( thread_coeffs_table_6_I);
            sensitive << coeffs_table_6;
        SC_METHOD( thread_coeffs_table_7_I);
            sensitive << coeffs_table_7;
        SC_METHOD( thread_din_data_I);
            sensitive << din_data;
        SC_METHOD( thread_dout_data_O);
            sensitive << dout_data_O;


        TraceFileType* tfp = esc_get_ca_trace_file();
        if ( tfp )
        {
            fir_cyc0->trace(tfp,99);
        }
    };

    ~fir_cycsimV()
    {
        delete fir_cyc0;
    }

    void end_of_elaboration()
    {
        esc_open_ca_trace_file();
    }

    void end_of_simulation()
    {
        esc_close_ca_trace_file();
    }

protected:
    Vfir_rtl* fir_cyc0;
};

fir_cycsim* fir_cycsim_factory()
{
    return new fir_cycsimV("fir");
}

class fir_linkup
{
public:
    fir_linkup() {
        extern fir_cycsim* (*fir_cycsim_factory_p)();
        fir_cycsim_factory_p = &fir_cycsim_factory;
    }
};

// Create the one instance of the factory for this verilated model.
fir_linkup fir_cycsimV_link;


