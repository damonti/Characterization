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

#ifndef _DEFINES_H_
#define _DEFINES_H_
#include <string>

#define	COEFFS	   (coeffs.read().table)

#define TAPS		8

typedef sc_uint < 8 > input_t;
typedef sc_uint < 11 > output_t;


struct CoeffTable {
    sc_uint<8> table[TAPS];
      CoeffTable() {}

    CoeffTable( const CoeffTable& obj ) {
        copy(obj);
    }

      CoeffTable & operator=(  const CoeffTable & obj ) {
          copy(obj);
          return *this;
      }
      bool operator==( const CoeffTable & obj ) {
		  for(unsigned i = 0; i < TAPS; i++)
			  if (table[i] != obj.table[i])
				  return false;
		  return true;
     }
    void copy( const CoeffTable & obj ) {
		  for(unsigned i = 0; i < TAPS; i++)
			  table[i] = obj.table[i];
     }
};
inline void sc_trace( sc_trace_file* tf, const CoeffTable & obj, const std::string& n )
{
	  for(unsigned i = 0; i < TAPS; i++)
		  sc_trace( tf, obj.table[i], n );
};
inline ostream & operator << ( ostream& os, const CoeffTable  obj )
{
	  for(unsigned i = 0; i < TAPS; i++)
			os << " " << obj.table[i];
    return os;
};
inline istream & operator >> ( istream& is, CoeffTable & obj )
{
    if (!is.get() || !is.good()) return is;
	  for(unsigned i = 0; i < TAPS; i++)
			is >>  obj.table[i];
    while (is.good() && (is.get() != '\n'));
    return is;
}

#endif // _DEFINES_H_
