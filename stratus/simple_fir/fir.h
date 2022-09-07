///////////////////////////////////////////////////////////////////////////////
//
// Copyright (c) 2019 Cadence Design Systems, Inc. All rights reserved worldwide.
//
// The code contained herein is the proprietary and confidential information
// of Cadence or its licensors, and is supplied subject to a previously
// executed license and maintenance agreement between Cadence and customer.
// This code is intended for use with Cadence high-level synthesis tools and
// may not be used with other high-level synthesis tools. Permission is only
// granted to distribute the code as indicated. Cadence grants permission for
// customer to distribute a copy of this code to any partner to aid in designing
// or verifying the customer's intellectual property, as long as such
// distribution includes a restriction of no additional distributions from the
// partner, unless the partner receives permission directly from Cadence.
//
// ALL CODE FURNISHED BY CADENCE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
// KIND, AND CADENCE SPECIFICALLY DISCLAIMS ANY WARRANTY OF NONINFRINGEMENT,
// FITNESS FOR A PARTICULAR PURPOSE OR MERCHANTABILITY. CADENCE SHALL NOT BE
// LIABLE FOR ANY COSTS OF PROCUREMENT OF SUBSTITUTES, LOSS OF PROFITS,
// INTERRUPTION OF BUSINESS, OR FOR ANY OTHER SPECIAL, CONSEQUENTIAL OR
// INCIDENTAL DAMAGES, HOWEVER CAUSED, WHETHER FOR BREACH OF WARRANTY,
// CONTRACT, TORT, NEGLIGENCE, STRICT LIABILITY OR OTHERWISE.
//
////////////////////////////////////////////////////////////////////////////////

#ifndef _FIR_H_
#define _FIR_H_

#include <cynw_p2p.h>
#include "defines.h"

SC_MODULE(fir)
{
public:
    // Declare the clock and reset ports
    sc_in_clk clk;
    sc_in < bool > rst;
    sc_in < CoeffTable > coeffs;

    // Declare the input port and the output port.
    // The template specializations <input_t or output_t> configure the
    // modular interfaces to carry the desired datatypes.
    cynw_p2p < input_t, ioConfig >::in din; // The input port
    cynw_p2p < output_t, ioConfig >::out dout;  // The output port

  SC_CTOR(fir):clk("clk"), rst("rst"), coeffs("coeffs"), din("din"), dout("dout")
    {

        SC_CTHREAD(FirThread, clk.pos());
        reset_signal_is(rst, 0);

        // Connect the clk and rst signals to the modular interface ports
        din.clk_rst(clk, rst);
        dout.clk_rst(clk, rst);
    }

  protected:
    void FirThread();           // the thread function
};

#endif // _FIR_H_
