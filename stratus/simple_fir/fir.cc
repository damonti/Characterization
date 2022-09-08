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

#include "fir.h"
void fir::FirThread()
{
    HLS_ASSUME_STABLE(coeffs,"coeff_inputs");
    {
        HLS_DEFINE_PROTOCOL("reset");
        // Reset the interfaces
        din.reset();
        dout.reset();
        wait();
    }
    input_t shift_reg[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
    output_t r;

    while (1)
    {
        //HLS_PIPELINE_LOOP( SOFT_STALL, 1, "main_loop");
        //HLS_CONSTRAIN_LATENCY(0 , HLS_ACHIEVABLE,"main_loop");

        for (unsigned i = 0; i < (TAPS-1); i++)
            shift_reg[i] = shift_reg[i + 1];
        shift_reg[7] = din.get();   // get the next value.

        {
            r = 0;
            for (unsigned i = 0; i < TAPS; i++)
            {
#if defined(USE_DPOPT)
                HLS_DPOPT_REGION( NO_ALTS|BEFORE_UNROLL, "multiply");
#endif
                r += COEFFS[i] * shift_reg[i];
            }
            r /= 16;
        }
        dout.put(r);
    }
}
