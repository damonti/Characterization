
# *********************************************************
# * Script Name  : Genus initialization script
# *********************************************************

#1Ghz
set CLOCK_PERIOD 100000 
set DATE [clock format [clock seconds] -format "%b%d-%T"]
set LOCAL_DIR "[exec pwd]/.."
set SYNTH_DIR ${LOCAL_DIR}/work
set TCL_PATH "${LOCAL_DIR}/tcl $LOCAL_DIR/constraints"
set _REPORTS_PATH "${LOCAL_DIR}/work/${DATE}_${CLOCK_PERIOD}_reports" 
set _OUTPUTS_PATH "${LOCAL_DIR}/work/${DATE}_${CLOCK_PERIOD}_outputs" 
set RTL_PATH "$LOCAL_DIR/rtl"
set DESIGN "mac"
set libdir "/opt/tech/tsmc/40nm/TSMCHOME/digital"

# Set corner
set th_voltage LR
set tc_voltage 1.10
set tc_temperature 25
set wc_voltage 0.99
set wc_temperature 125
set CORNER ${th_voltage}_ss40_${wc_voltage}V_${wc_temperature}C



set_db lp_power_unit mW 
set_db / .init_lib_search_path {. ./lib digital/Front_End/timing_power_noise/ECSM/tcbn40lpbwp12t40m1plvt_200a/}
set_db script_search_path $TCL_PATH 
set_db init_hdl_search_path $RTL_PATH 


#TODO: set corners


#libraries
set LIB_LIST { 
    "/opt/tech/tsmc/40nm/TSMCHOME/digital/Front_End/timing_power_noise/ECSM/tcbn40lpbwp12t40m1plvt_200a/tcbn40lpbwp12t40m1plvtwc_ecsm.lib"}
    
#/opt/tech/tsmc/40nm/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tpfn40lpgv2od3_120a/tpfn40lpgv2od3wcz.lib

#LEF files
set LEF_LIST { "/opt/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwp12t40m1plvt_131a/lef/HVH_0d5_0/tcbn40lpbwp12t40m1plvt_8lm5X2ZRDL.lef \
                           /opt/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwp12t40m1p_131a/lef/HVH_0d5_0/tcbn40lpbwp12t40m1p_8lm5X2ZRDL.lef \
                           /opt/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tpfn40lpgv2od3_120a/mt_2/8lm/lef/tpfn40lpgv2od3_8lm.lef \
                           /opt/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tpbn45v_140a/cup/8m/8M_5X2Z/lef/tpbn45v_8lm.lef "}
#captable
set rcw_captables "$libdir/Back_End/lef/tcbn40lpbwp12t40m1plvt_131a/techfiles/captable/cln40lp_1p08m+alrdl_5x2z_rcworst.captab"
#SET RTL
set RTL_LIST {\
add.v \
mul.v \
mac.v
}

#read_hdl $RTL_LIST

# set CAP_TABLE_FILE ../libraries/tsmc13fsg.capTbl
#set QRC_TECH_FILE ../QRC/t018s6mm.tch

#suppress_messages {LBR-30 LBR-31 LBR-40 LBR-41 LBR-72 LBR-77 LBR-162}

#this is for reports
set_db hdl_track_filename_row_col true 



#set_db error_on_lib_lef_pin_inconsistency true

# set_db library $LIB_LIST
#read_libs $LIB_LIST
set_db / .library $LIB_LIST
set_db / .lef_library $LEF_LIST
set_db / .cap_table_file $rcw_captables 
## PLE not required for such a small design. keep wireload
#set_db / .interconnect_mode ple
#set_db lef_library $LEF_LIST 
#read_physical -lef $LEF_LIST

#either captable or qrc???
# set_db cap_table_file $CAP_TABLE_FILE 
# set_db qrc_tech_file $QRC_TECH_FILE

set_db / .auto_ungroup none

foreach f $RTL_LIST {
    read_hdl -v2001 $f
}

set_db / .auto_ungroup none
#use "elaborate parameters {16} mac" to pass the parameter value W=16 
elaborate $DESIGN 
time_info Elaboration
#check for problems
check_design 

#set design constraint
#for now only clock since for now i do not have any constraint to meet beside 
#the clock frequency. or do i need to generate some?
current_design $DESIGN
define_clock -name "CLK" -period $CLOCK_PERIOD [get_ports clk]
#define_clock -name virtual_io_clock -period ${CLOCK_PERIOD}

#read activity (for now vcd generated from modelsim)
read_vcd ./../rtl/vcd_mac.vcd



#generic synth
set_db syn_generic_effort medium
syn_generic
puts "Runtime & Memory after 'syn_generic'"
time_info GENERIC
report_dp > $_REPORTS_PATH/generic/${DESIGN}_datapath.rpt
write_snapshot -outdir $_REPORTS_PATH -tag generic
report_summary -directory $_REPORTS_PATH

#mapping synth
set_db syn_map_effort medium
syn_map
puts "Runtime & Memory after 'syn_map'"
time_info MAPPED
write_snapshot -outdir $_REPORTS_PATH -tag map
report_summary -directory $_REPORTS_PATH
report_dp > $_REPORTS_PATH/map/${DESIGN}_datapath.rpt


#opt synth
set_db syn_opt_effort medium
syn_opt
write_snapshot -outdir $_REPORTS_PATH -tag syn_opt
report_summary -directory $_REPORTS_PATH

report_qor

puts "Runtime & Memory after 'syn_opt'"

write_snapshot -outdir $_REPORTS_PATH -tag final
report_summary -directory $_REPORTS_PATH

puts "Write reports"
report area -detail > $_REPORTS_PATH/$DESIGN.area.rpt
report timing > $_REPORTS_PATH/$DESIGN.timing.rpt
report gates > $_REPORTS_PATH/$DESIGN.gates.rpt
report design_rules > $_REPORTS_PATH/$DESIGN.rules.rpt
report power -by_hierarchy -indent_inst -levels all -header -cols "cells static dynamic total" -unit nW > $_REPORTS_PATH/$DESIGN.power.rpt
report summary > $_REPORTS_PATH/$DESIGN.summary.rpt
report message

puts "Write sdc and netlists"
write_sdc > $_REPORTS_PATH/$DESIGN.sdc
write_hdl -generic > $_REPORTS_PATH/netlist/$DESIGN.generic.v
write -mapped > $_REPORTS_PATH/netlist/$DESIGN.mapped.v
puts "Final Runtime & Memory."
time_info FINAL

