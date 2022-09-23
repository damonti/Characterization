set DESIGN mux
set LOCAL_DIR "[exec pwd]/.."
set SYNTH_DIR ${LOCAL_DIR}/work
set SCRIPT_DIR ${LOCAL_DIR}/tcl
set RTL_PATH ${LOCAL_DIR}/rtl/${DESIGN}
set SIM_PATH ${LOCAL_DIR}/sim/${DESIGN}
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
::legacy::set_attribute init_hdl_search_path $RTL_PATH
read_netlist $RTL_PATH/netlist/${DESIGN}_${FACTOR}_${BW}_netlist.v
read_sdc $RTL_PATH/mux.sdc
#if ck 100Mhx then time windows 130-370; if ck 1GHz then time windows 12-37

set PERCENT $listPERCENT 
set REPORT_PATH ${SIM_PATH}/reports
set TB "mux_${FACTOR}_${BW}_${PERCENT}percent"
read_stimulus -allow_n_nets -format tcf -file $RTL_PATH/dump_${TB}.tcf -dut_instance /mux
compute_power -mode average
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload_zero.rpt


puts stdout "Done Reporting PPA"
