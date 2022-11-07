#HOW IT IS CALLED IN THE DIRECTORY TREE
set UNIT fir_8bit
#HOW IT IS CALLED IN VERILOG
set DESIGN fir 
set LOCAL_DIR "[exec pwd]/.."
set SYNTH_DIR ${LOCAL_DIR}/work
set SCRIPT_DIR ${LOCAL_DIR}/tcl
set RTL_PATH ${LOCAL_DIR}/rtl/${UNIT}/design
set SIM_PATH ${LOCAL_DIR}/sim/${UNIT}/design
set REPORTS_PATH ${SIM_PATH}/reports
set TECH 40

###################################
set_attribute information_level 9 

##############################


set lib_list "/home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/timing_power_noise/ECSM/tcbn40lpbwp_120b/tcbn40lpbwptc_ecsm.lib"

set lef_list  "/home_old/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwp_120c/lef/HVH_0d5_0/tcbn40lpbwp_8lm5X2ZRDL.lef"

set CAPTABLE /home_old/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwp_120c/techfiles/captable/cln40lp_1p08m+alrdl_5x2z_typical.captab
read_libs $lib_list

set_attribute lef_library $lef_list
set_attribute cap_table_file $CAPTABLE

set_attribute interconnect_mode ple
###############################
#RTL

#set_attribute init_hdl_search_path $RTL_PATH
read_hdl -v2001 ${RTL_PATH}/mul.v
read_hdl -v2001 ${RTL_PATH}/adder.v 
read_hdl -v2001 ${RTL_PATH}/fir.v

set_attribute optimize_merge_flops false 
set_attribute optimize_merge_latches false 
set_attribute merge_combinational_hier_instance false

set_attribute auto_ungroup none
#set_attribute delete_unloaded_insts false 
set_attribute lp_insert_clock_gating true
set_attribute syn_generic_effort high

elaborate $DESIGN

write_db -to_file ${RTL_PATH}/${DESIGN}.db


#set_attribute optimize_merge_seq false

set_attr lp_insert_clock_gating true	
set_attr syn_generic_effort high	
syn_generic 

#read_stimulus -format tcf -file ${SIM_PATH}/tcf/fir_8bit_50percent.tcf -report_missing_signals all -sdb_out ${SIM_PATH}/tcf/stimulus.sdb -resim_cg_enables 
# foreach TOGGLE {10 100} {
# # for {set REP 0} {$REP < 100} {incr REP} {
#     read_stimulus -dut_instance tb_fir -format tcf -file ${SIM_PATH}/tcf/${UNIT}_${TOGGLE}percent.tcf -report_missing_signals all -resim_cg_enables -append
    
# #     #-sdb_out ${SIM_PATH}/tcf/stimulus.sdb
# # }
# }

# write_sdb -out ${SIM_PATH}/tcf/stimulus.sdb
# syn_power
# read_stimulus -format sdb -file ${SIM_PATH}/tcf/stimulus.sdb
# puts stdout "compute_power -mode average"
# compute_power -mode average
# set LENGHT [llength $TOGGLES]

# #for {set i 1} {$i <= $LENGHT} {incr i} {

# report_power -stims /stim#1 -by_hierarchy -unit nW -cols "cells dynamic total" -out ${REPORTS_PATH}/${DESIGN}_10percent_avg.rpt 
# report_power -stims /stim#2 -by_hierarchy -unit nW -cols "cells dynamic total" -out ${REPORTS_PATH}/${DESIGN}_100percent_avg.rpt 

# #}

# #compute_power -mode vectorless
# #report_power -by_hierarchy -unit nW -cols "cells dynamic total" -out ${REPORTS_PATH}/${DESIGN}_vectorless.rpt 
# report_area > ${REPORTS_PATH}/${DESIGN}_area.rpt
# #puts stdout "Done Reporting PPA"


