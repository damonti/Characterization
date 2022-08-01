set DESIGN adder
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
read_netlist $RTL_PATH/netlist/${DESIGN}_${BW}_netlist.v

read_sdc $RTL_PATH/${DESIGN}.sdc
#if ck 100Mhx then time windows 130-370; if ck 1GHz then time windows 12-37

foreach PERCENT $listPERCENT {
    set REPORT_PATH ${SIM_PATH}/reports
    set START 1650
    set END 1830
    set TB "${DESIGN}_${BW}_${PERCENT}percent"
    read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/dump_${TB}.vcd -dut_instance /tb_adder/adder
    compute_power -mode time_based
    report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/${TB}_payload.rpt
}




















#NB: when I run report_power, the stimulus used is stim0, instead of stim1. "ERROR: power is not computed for stim#1" (even though it is)
#THINGS TO NOTICE: 1 WE READ MANY FRAMES BUT THEN IN COMPUTE POWER IT IS READ AS SINGLE FRAME; 2 REPORT_POWER DOES NOT RECOGNIZE STIM1 AND GOES WITH STIM0 (vectorless); 3 POWER DOES NOT CHANGE FOR SENDPACKET AND ONEPACKET
#compute_power -mode time_based -stim /stim#1/frame#1 -stim /stim#1/frame#2 -stim /stim#1/frame#3 -stim /stim#1/frame#4
#report_activity -out ${SIM_PATH}/noc.activity_joules_mesh_3x3_tb5_send_packet
#report_power -unit mW -format "%.3f" -out ${SIM_PATH}/noc.activity_joules_mesh_3x3_tb5_send_packet.rpt


#one_packet
#read_stimulus -file $SIM_PATH/dump_tb5.vcd -top_instance /noc_test/noc -cycles 1 clk

#write_db ./DB/pwr_db.jdb
#write_power_db -base_name ./DB/pwr_db

#to reload the databases..
#read_db ./DB/pwr_db.jdb
#read_power_db -base_name ./DB/pwr_db
#report_power ...

#plot_power_profile -stim /stim#1 -by_category memory register logic clock -format native
#plot_power_profile -stim /stim#2 -by_category memory register logic clock -format native
#report_icgc_efficiency -out ${SYNTH_DIR}/JOULES_PROVA -append
#
#cdn_cat ${SYNTH_DIR}/JOULES_PROVA
puts stdout "Done Reporting PPA"
