###############################################################################
#
# Copyright (c) 2019 Cadence Design Systems, Inc. All rights reserved worldwide.
#
# The code contained herein is the proprietary and confidential information
# of Cadence or its licensors, and is supplied subject to a previously
# executed license and maintenance agreement between Cadence and customer.
# This code is intended for use with Cadence high-level synthesis tools and
# may not be used with other high-level synthesis tools. Permission is only
# granted to distribute the code as indicated. Cadence grants permission for
# customer to distribute a copy of this code to any partner to aid in designing
# or verifying the customer's intellectual property, as long as such
# distribution includes a restriction of no additional distributions from the
# partner, unless the partner receives permission directly from Cadence.
#
# ALL CODE FURNISHED BY CADENCE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
# KIND, AND CADENCE SPECIFICALLY DISCLAIMS ANY WARRANTY OF NONINFRINGEMENT,
# FITNESS FOR A PARTICULAR PURPOSE OR MERCHANTABILITY. CADENCE SHALL NOT BE
# LIABLE FOR ANY COSTS OF PROCUREMENT OF SUBSTITUTES, LOSS OF PROFITS,
# INTERRUPTION OF BUSINESS, OR FOR ANY OTHER SPECIAL, CONSEQUENTIAL OR
# INCIDENTAL DAMAGES, HOWEVER CAUSED, WHETHER FOR BREACH OF WARRANTY,
# CONTRACT, TORT, NEGLIGENCE, STRICT LIABILITY OR OTHERWISE.
#
################################################################################

#
# Technology Libraries
#
#set LIB_PATH "[get_install_path]/share/stratus/techlibs/GPDK045/gsclib045_svt_v4.4/gsclib045/timing"
#set LIB_LEAF "slow_vdd1v2_basicCells.lib"
#use_tech_lib    "$LIB_PATH/$LIB_LEAF"
use_tech_lib "/home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/timing_power_noise/ECSM/tcbn40lpbwp_120b/tcbn40lpbwpwc_ecsm.lib"

#####################################################################
# c++ compiler options
######################################################################
set CLOCK_PERIOD 10
set_attr cc_options " -DCLOCK_PERIOD=$CLOCK_PERIOD"
set_attr hls_cc_options " -DCLOCK_PERIOD=$CLOCK_PERIOD"

######################################################################
# stratus_hls Options
# This is a set of reasonable default options
######################################################################
#
# Global synthesis attributes.
#

set_attr clock_period           $CLOCK_PERIOD
set_attr message_detail         2
set_attr default_input_delay    0.1
set_attr path_delay_limit       120
set_attr prints                 off
set_attr rtl_annotation			op,stack

set_attr output_style_structure_only off
set_attr output_style_mux expl_case
set_attr output_style_reset_all_async on
#set_attr output_style_separate_memories on

set_attr flatten_arrays all
set_attr unroll_loops off

set_attr output_style_separate_behaviors off

# Control automatic creation of custom datapath components
# op creates non-square parts, expr creates components for design-specific expressions
set_attr dpopt_auto op ;# off, array, op, expr
# Uncomment the next line to enable C++14
# set_systemc_options -version 2.3 -gcc 6.3

######################################################################
# System Module Configurations
######################################################################

define_system_module main main.cc 
define_system_module System system.cc 
define_system_module tb tb.cc 

######################################################################
# Synthesis Module Configurations
######################################################################
define_hls_module fir fir.cc

define_io_config * PIN

define_hls_config fir BASIC
define_hls_config fir DPOPT       -DUSE_DPOPT

######################################################################
# Simulation Configurations
######################################################################
use_verilog_simulator incisive ;# 'mti' or 'incisive' or 'vcs' or 'vcsi''
enable_waveform_logging -vcd ;# to store signal transitions vcd or fsdb
set_attr end_of_sim_command "make cmp_result"

# A behavioral PIN-level configuration
define_sim_config B {fir BEH}

# The following rules are TCL code to create a simulation configuration
# for RTL_V for each hls_config defined.
foreach config [find -hls_config *] {
  set cname [get_attr name $config]
  define_sim_config ${cname}_V "fir RTL_V $cname"
}

######################################################################
# Genus Logic Synthesis Configurations
######################################################################
define_logic_synthesis_config G {fir -all} \
    -options \
        {BDW_LS_NOGATES 1}

