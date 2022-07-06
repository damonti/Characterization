
# *********************************************************
# * Script Name  : Genus initialization script
# *********************************************************

#Cloc period in ps 
set CLOCK_PERIOD 10000 
set DATE [clock format [clock seconds] -format "%b%d-%T"]
set DESIGN "noc"
set TOPOLOGY "mesh_2x2_64w_2buf_random"
set LOCAL_DIR "[exec pwd]/.."
set SYNTH_DIR ${LOCAL_DIR}/work
#set TCL_PATH "${LOCAL_DIR}/tcl $LOCAL_DIR/constraints"
set _REPORTS_PATH "${LOCAL_DIR}/work/${TOPOLOGY}_${DATE}_${CLOCK_PERIOD}ps_reports" 
set _OUTPUTS_PATH "${LOCAL_DIR}/work/${TOPOLOGY}_${DATE}_outputs" 
set RTL_PATH "$LOCAL_DIR/rtl/nocgen/${TOPOLOGY}"

set GPDK045 /opt/tools/technology/cadence/gpdk/45nm/gsclib045_all_v4.4


set_db init_lib_search_path "./lib $GPDK045/"
#set_db script_search_path $TCL_PATH 
set_db init_hdl_search_path $RTL_PATH 



#TECHNOLOGY
#set LIB_LIST {
#/home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/timing_power_noise/ECSM/tcbn40lpbwplvt_120b/tcbn40lpbwplvttc_ecsm.lib \
#/home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/timing_power_noise/ECSM/tcbn40lpbwphvt_120b/tcbn40lpbwphvttc_ecsm.lib \
#}

set file_list " \ /opt/tools/technology/cadence/gpdk/45nm/gsclib045_all_v4.4/gsclib045/lef/gsclib045_tech.lef \ 
                $GPDK045/gsclib045/lef/gsclib045_macro.lef "
set_db lef_library $file_list



#set LEF_LIST { \
#/home_old/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwphvt_120a/lef/HVH_0d5_0/tcbn40lpbwphvt_8lm5X2ZRDL.lef \
#/home_old/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwplvt_120a/lef/HVH_0d5_0/tcbn40lpbwplvt_8lm5X2ZRDL.lef \
#}

#set CAPTABLE /home_old/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwplvt_120c/techfiles/captable/cln40lp_1p08m+alrdl_5x2z_typical.captab


#RTL
set RTL_LIST {\
vcmux.v \
vc.v \
rtcomp.v \
router.v \
outputc.v \
muxcont.v \
mux.v \
noc.v \
inputc.v \
fifo.v \
cb.v \
arb.v \
}



# set CAP_TABLE_FILE ../libraries/tsmc13fsg.capTbl
#set QRC_TECH_FILE ../QRC/t018s6mm.tch

#suppress_messages {LBR-30 LBR-31 LBR-40 LBR-41 LBR-72 LBR-77 LBR-162}

#this is for reports
set_db hdl_track_filename_row_col true 



#set_db error_on_lib_lef_pin_inconsistency true

# set_db library $LIB_LIST
#read_libs $LIB_LIST
#read_physical -lef $LEF_LIST

#SET_DB OR READ_LIBS?
#set_db / .library $LIB_LIST
#set_db / .lef_library $LEF_LIST
#set_db / .cap_table_file $CAPTABLE
set_db qrc_tech_file " \ /opt/tools/technology/cadence/gpdk/45nm/gsclib045_all_v4.4/gsclib045/qrc/qx/gpdk045.tch"
#PLE OR WIRELOAD?
set_db / .interconnect_mode ple



foreach f $RTL_LIST {
    read_hdl -v2001 $f
}

set_db / .auto_ungroup none

#use "elaborate parameters {16} mac" to pass the parameter value W=16 
elaborate $DESIGN 
time_info Elaboration
#check for problems
check_design -unresolved

#set design constraint
#for now only clock since for now i do not have any constraint to meet beside 
#the clock frequency. or do i need to generate some?
define_clock -name clk -period $CLOCK_PERIOD 
set_input_delay 0.1 -clock clk [remove_from_collection [all_inputs] {clk rst}]
set_output_delay 0.1 -clock clk [all_outputs]
#set_clock_uncertainty -setup -clock CLK 0.01  

#define_clock -name virtual_io_clock -period ${CLOCK_PERIOD}

#read activity (for now vcd generated from modelsim)
#read_vcd ./../rtl/vcd_mac.vcd



#generic synth
set_db syn_generic_effort medium
syn_generic
puts "Runtime & Memory after 'syn_generic'"
time_info GENERIC
#report_dp > $_REPORTS_PATH/generic/${DESIGN}_datapath.rpt
#write_snapshot -outdir $_REPORTS_PATH -tag generic
#report_summary -directory $_REPORTS_PATH

#mapping synth
set_db syn_map_effort medium
syn_map
puts "Runtime & Memory after 'syn_map'"
time_info MAPPED
#write_snapshot -outdir $_REPORTS_PATH -tag map
#report_summary -directory $_REPORTS_PATH
#report_dp > $_REPORTS_PATH/map/${DESIGN}_datapath.rpt


#opt synth
set_db syn_opt_effort medium
syn_opt
#write_snapshot -outdir $_REPORTS_PATH -tag syn_opt
#report_summary -directory $_REPORTS_PATH

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
write_hdl -generic > $_REPORTS_PATH/netlist/generic/$DESIGN.generic.v
write_hdl > $_REPORTS_PATH/netlist/$DESIGN.v
#write_design -innovus -base_name $_REPORTS_PATH/netlist/innovus/$DESIGN

puts "Final Runtime & Memory."
time_info FINAL

