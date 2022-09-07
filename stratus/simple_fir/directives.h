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

#ifndef _DIRECTIVES_H_
#define _DIRECTIVES_H_
//
//	Deal with the stable COEFF inputs
//
#define THREAD_TAG	HLS_ASSUME_STABLE(coeffs,"coeff_inputs");
#define	COEFFS	   (coeffs.read().table)

#define	PIPE_CMD		HLS_PIPELINE_LOOP(HARD_STALL ,PIPE,"MainPipe");
#define	PLAT_CMD		HLS_CONSTRAIN_LATENCY(0,-1,"MainLoop");
#define	LAT_CMD		HLS_CONSTRAIN_LATENCY(0,LAT,"MainLoop");

#ifdef LAT
#ifdef PIPE
#define WHILE_TAG		LAT_CMD; PIPE_CMD;
#else
#define WHILE_TAG		LAT_CMD
#endif
#else
#ifdef PIPE
#define WHILE_TAG		PLAT_CMD; PIPE_CMD;
#else
#define WHILE_TAG		PLAT_CMD
#endif
#endif


#ifdef DP
#define DP_TAG			HLS_DPOPT_REGION(0,"Accum")
#else
#define DP_TAG
#endif

#endif

