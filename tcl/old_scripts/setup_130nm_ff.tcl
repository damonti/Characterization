
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
set LIB_PATH "${LOCAL_DIR}/libraries/TIMING/CUSTOM ${LOCAL_DIR}/libraries/TIMING/STDCELL ${LOCAL_DIR}/libraries/TIMING/IO ${LOCAL_DIR}/libraries/LEF/STDCELL ${LOCAL_DIR}/libraries/LEF/CUSTOM ${LOCAL_DIR}/libraries/LEF/IO"
set RTL_PATH "$LOCAL_DIR/rtl"
set DESIGN "mac"

set_db lp_power_unit mW 
set_db init_lib_search_path $LIB_PATH 
set_db script_search_path $TCL_PATH 
set_db init_hdl_search_path $RTL_PATH 


#TODO: set corners


#libraries
#set LIB_LIST { \
ss_g_1v08_125c.lib \
ss_hvt_1v08_125c.lib \
ram_256x16A_slow_syn.lib \
rom_512x16A_slow_syn.lib  \
pllclk_slow.lib \
}
set LIB_LIST { \
ff_g_1v32_0c.lib \
ff_hvt_1v32_0c.lib }

#set LEF_LIST { \
tsmc13fsg_8lm_tech.lef \
tsmc13g_m_macros.lef \
tsmc13hvt_m_macros.lef \
pllclk.lef \
ram_256X16A.lef \
rom_512x16A.lef \
tpz013g2_7lm.lef \
}

#I left the lef files unchanged from the "ss" corner.
set LEF_LIST { \
tsmc13fsg_8lm_tech.lef \
tsmc13g_m_macros.lef \
tsmc13hvt_m_macros.lef}


# Baseline RTL
#set RTL_LIST { \
alu_32.v \
arb.v \
data_bus_mach.v \
data_sample_mux.v \
decode_i.v \
decoder.v \
digit_reg.v \
conv_subreg.v \
dma.v \
dtmf_recvr_core.v \
execute_i.v \
iopads.v \
m16x16.v \
mult_32_dp.v \
port_bus_mach.v \
prog_bus_mach.v \
ram_128x16_test.v \
ram_256x16_test.v \
results_conv.v \
spi.v \
tdsp_core_glue.v \
tdsp_core_mach.v \
tdsp_core.v \
tdsp_data_mux.v \
tdsp_ds_cs.v \
test_control.v \
ulaw_lin_conv.v \
power_manager.v \
accum_stat.v \
}
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
read_libs $LIB_LIST
## PLE not required for such a small design. keep wireload
#set_db / .interconnect_mode ple
#set_db lef_library $LEF_LIST 
read_physical -lef $LEF_LIST

#either captable or qrc???
# set_db cap_table_file $CAP_TABLE_FILE 
# set_db qrc_tech_file $QRC_TECH_FILE


foreach f $RTL_LIST {
    read_hdl -v2001 $f
}


#use "elaborate parameters {16} mac" to pass the parameter value W=16 
elaborate $DESIGN 
time_info Elaboration
#check for problems
check_design 

#set design constraint
#for now only clock since for now i do not have any constraint to meet beside 
#the clock frequency. or do i need to generate some?
define_clock -period $CLOCK_PERIOD -name CLK { clk }
define_clock -name virtual_io_clock -period ${CLOCK_PERIOD}

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

