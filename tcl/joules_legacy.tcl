#Resources:
#Understanding power computation in Joules: https://support.cadence.com/apex/ArticleAttachmentPortal?id=a1O3w000009beGwEAI&pageName=ArticleContent
#Webpage: https://support.cadence.com/apex/ArticleAttachmentPortal?id=a1O3w000009xwR6EAI&pageName=ArticleContent

##################################################################
#To dump (elab.db) after elaboration, the flow is as follows:

#read_libs <list_of_libraries>
#read_hdl <list_of_rtl_files>
#elaborate
#write_db elab.db

##################################################################
#Then, for the power analysis flow with RTL stimulus and Gate level Mapped Netlist

#rtlstim2gate -init elab.db -keep_libraries  (elab.db is clean DB file (steps mentioned below) dumped after elaboration)​
#read_netlist <mapped netlist> (mapped netlist, user can also use mapped DB from genus instead of netlist i.e read_db <mapped.db>)
#rtlstim2gate -rules (optional)
#read_sdc <SDC file>
#read_spef <spef file>
#read_stimulus -file <RTL stimulus file> -out <stimulus database>
#compute_power
#report_power​​

#If you get any issues/errors related to the “rtlstim2gate” command, refer to the following article: https://support.cadence.com/apex/ArticleAttachmentPortal?id=a1O0V000009MnoOUAS&pageName=ArticleContent​​.


#::legacy::set_attr common_ui 1
###############################
set CLOCK_PERIOD 10 
set TOPOLOGY mesh_4x4_16buf_4vch_cg
set TB tb1
set START 130
set END 370
set LOCAL_DIR "[exec pwd]/.."
set SYNTH_DIR ${LOCAL_DIR}/work
set SCRIPT_DIR ${LOCAL_DIR}/tcl
set RTL_PATH ${LOCAL_DIR}/rtl/${TOPOLOGY}
set SIM_PATH ${LOCAL_DIR}/sim/${TOPOLOGY}
set DESIGN noc
set TECH 40
###################################
set_attribute information_level 9 

##############################


set lib_list "/home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/timing_power_noise/ECSM/tcbn40lpbwphvt_120b/tcbn40lpbwphvttc_ecsm.lib \
        /home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/timing_power_noise/ECSM/tcbn40lpbwplvt_120b/tcbn40lpbwplvttc_ecsm.lib \
        /home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/timing_power_noise/ECSM/tcbn40lpbwp_120b/tcbn40lpbwptc_ecsm.lib"

set lef_list  "/home_old/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwphvt_120c/lef/HVH_0d5_0/tcbn40lpbwphvt_8lm5X2ZRDL.lef \
        /home_old/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwplvt_120c/lef/HVH_0d5_0/tcbn40lpbwplvt_8lm5X2ZRDL.lef \
        /home_old/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwp_120c/lef/HVH_0d5_0/tcbn40lpbwp_8lm5X2ZRDL.lef"

set CAPTABLE /home_old/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwp_120c/techfiles/captable/cln40lp_1p08m+alrdl_5x2z_typical.captab
read_libs $lib_list

set_attribute lef_library $lef_list
set_attribute cap_table_file $CAPTABLE

set_attribute interconnect_mode ple
###############################
#RTL
read_netlist $RTL_PATH/noc_netlist.v

read_sdc $RTL_PATH/noc.sdc
suspend
set TB tb1
set START 13
set END 33
set ALIAS message
suspend
read_stimulus -start ${START}ns -end ${END}ns -interval_size 1ns -allow_n_nets -format vcd -file $SIM_PATH/dump_${TB}.vcd -dut_instance /noc_test/noc -alias ${ALIAS}_${TB}
compute_power -mode time_based -stim /${ALIAS}_${TB} -append
report_power -stims {/message_tb1/frame#[1:20]} -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static dynamic total" -unit nW > ${SIM_PATH}/noc.power_joules_${TOPOLOGY}_${TB}_message.rpt
report_power -stims {/message_tb1/frame#[5:6]} -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static dynamic total" -unit nW > ${SIM_PATH}/noc.power_joules_${TOPOLOGY}_${TB}_flit.rpt

set START 0
set END 13
set ALIAS init
read_stimulus -start ${START}ns -end ${END}ns -interval_size 1ns -allow_n_nets -format vcd -file $SIM_PATH/dump_${TB}.vcd -dut_instance /noc_test/noc -alias ${ALIAS}_${TB}
compute_power -mode time_based -stim /${ALIAS}_${TB} -append
report_power -stims {/init_tb1/frame#[1:13]} -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static dynamic total" -unit nW > ${SIM_PATH}/noc.power_joules_${TOPOLOGY}_${TB}_${ALIAS}.rpt

set START 100
set END 200
set ALIAS idle
read_stimulus -start ${START}ns -end ${END}ns -interval_size 10ns -allow_n_nets -format vcd -file $SIM_PATH/dump_${TB}.vcd -dut_instance /noc_test/noc -alias ${ALIAS}_${TB}
compute_power -mode time_based -stim /${ALIAS}_${TB} -append
report_power -stims {/idle_tb1/frame#[1:10]} -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static dynamic total" -unit nW > ${SIM_PATH}/noc.power_joules_${TOPOLOGY}_${TB}_${ALIAS}.rpt


###NEW TESTBENCH
set TB tb2
set START 13
set END 33
set ALIAS message
read_stimulus -start ${START}ns -end ${END}ns -interval_size 1ns -allow_n_nets -format vcd -file $SIM_PATH/dump_${TB}.vcd -dut_instance /noc_test/noc -alias ${ALIAS}_${TB}
compute_power -mode time_based -stim /${ALIAS}_${TB} -append
report_power -stims {/message_tb2/frame#[1:20]} -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static dynamic total" -unit nW > ${SIM_PATH}/noc.power_joules_${TOPOLOGY}_${TB}_message.rpt
report_power -stims {/message_tb2/frame#[5:6]} -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static dynamic total" -unit nW > ${SIM_PATH}/noc.power_joules_${TOPOLOGY}_${TB}_flit.rpt



set START 0
set END 13
set ALIAS init
read_stimulus -start ${START}ns -end ${END}ns -interval_size 1ns -allow_n_nets -format vcd -file $SIM_PATH/dump_${TB}.vcd -dut_instance /noc_test/noc -alias ${ALIAS}_${TB}
compute_power -mode time_based -stim /${ALIAS}_${TB} -append
report_power -stims {/init_tb2/frame#[1:13]} -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static dynamic total" -unit nW > ${SIM_PATH}/noc.power_joules_${TOPOLOGY}_${TB}_${ALIAS}.rpt

set START 100
set END 200
set ALIAS idle
read_stimulus -start ${START}ns -end ${END}ns -interval_size 10ns -allow_n_nets -format vcd -file $SIM_PATH/dump_${TB}.vcd -dut_instance /noc_test/noc -alias ${ALIAS}_${TB}
compute_power -mode time_based -stim /${ALIAS}_${TB} -append
report_power -stims {/idle_tb2/frame#[1:10]} -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static dynamic total" -unit nW > ${SIM_PATH}/noc.power_joules_${TOPOLOGY}_${TB}_${ALIAS}.rpt

























suspend
################################################################################################################################################################################################################################################

set TB tb2
read_stimulus -append -start ${START}ns -end ${END}ns -interval_size 20ns -allow_n_nets -format vcd -file $SIM_PATH/dump_${TB}.vcd -dut_instance /noc_test/noc
compute_power -mode time_based -append -stim /stim#2
report_power -stims {/stim#2/frame#[1:12]} -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static dynamic total" -unit uW > ${SIM_PATH}/noc.power_joules_${TOPOLOGY}_${TB}_130ns_370ns.rpt

suspend
read_stimulus -start 125ns -end 210ns -interval_size 5ns -allow_n_nets -format vcd -file $SIM_PATH/dump_tb5.vcd -dut_instance /noc_test/noc
compute_power -mode time_based -stim /stim#1
propagate_activity -mode time_based -stim /stim#1
report_power -append -stims /stim#1 -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static dynamic total" -unit nW -stims /stim#1 > ${SIM_PATH}/noc.power_joules_mesh_3x3_tb5_send_packet.rpt
#NB: when I run report_power, the stimulus used is stim0, instead of stim1. "ERROR: power is not computed for stim#1" (even though it is)
#THINGS TO NOTICE: 1 WE READ MANY FRAMES BUT THEN IN COMPUTE POWER IT IS READ AS SINGLE FRAME; 2 REPORT_POWER DOES NOT RECOGNIZE STIM1 AND GOES WITH STIM0 (vectorless); 3 POWER DOES NOT CHANGE FOR SENDPACKET AND ONEPACKET
#compute_power -mode time_based -stim /stim#1/frame#1 -stim /stim#1/frame#2 -stim /stim#1/frame#3 -stim /stim#1/frame#4
#report_activity -out ${SIM_PATH}/noc.activity_joules_mesh_3x3_tb5_send_packet
#report_power -unit mW -format "%.3f" -out ${SIM_PATH}/noc.activity_joules_mesh_3x3_tb5_send_packet.rpt


#one_packet
read_stimulus -start 155ns -end 165ns -interval_size 1ns -allow_n_nets -format vcd -file $SIM_PATH/dump_tb5.vcd -dut_instance /noc_test/noc
compute_power -mode time_based -stim /stim#1
propagate_activity -mode time_based -stim /stim#1
report power -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static dynamic total" -unit nW > ${SIM_PATH}/noc.power_joules_mesh_3x3_tb5_one_packet.rpt
#read_stimulus -file $SIM_PATH/dump_tb5.vcd -top_instance /noc_test/noc -cycles 1 clk
#########################################
#idle:
read_stimulus -start 300ns -end 500ns -interval_size 20ns -allow_n_nets -format vcd -file $SIM_PATH/dump_tb5.vcd -dut_instance /noc_test/noc
compute_power -mode average -stim /stim#1
propagate_activity -stim /stim#1
report power -by_hierarchy -indent_inst -levels all -header -cols "cells static dynamic total" -unit nW > ${SIM_PATH}/noc.power_joules_mesh_3x3_tb5_idle.rpt

#initialization
read_stimulus -start 15ns -end 25ns -interval_size 1ns -allow_n_nets -format vcd -file $SIM_PATH/dump_tb5.vcd -dut_instance /noc_test/noc
compute_power -mode average -stim /stim#1
propagate_activity -mode time_based -stim /stim#1
report power -by_hierarchy -indent_inst -levels all -header -cols "cells static dynamic total" -unit nW > ${SIM_PATH}/noc.power_joules_mesh_3x3_tb5_initialization.rpt
#plot_net_distribution -xkey fanout
set TB tb4
set STAGE initpower
compute_power -mode average -out RTL_PATH/noc.power_engine_mesh_3x3_${TB}_${STAGE}.rpt
compute_power -mode average -out RTL_PATH/noc.power_engine_mesh_3x3_tb4_idlepower.rpt
#POWER PERFORMANCE AREA (PPA)
report_activity -out ${SYNTH_DIR}/JOULES_PROVA
report_power    -unit mW -format "%.3f" -out ${SYNTH_DIR}/JOULES_PROVA -append
report power -by_hierarchy -indent_inst -levels all -header -cols "cells static dynamic total" -unit nW > ./../sim/mesh_3x3_8buf_4vch/${DESIGN}_${TB}_${STAGE}.power.rpt


write_db ./DB/pwr_db.jdb
write_power_db -base_name ./DB/pwr_db

#to reload the databases..
#read_db ./DB/pwr_db.jdb
#read_power_db -base_name ./DB/pwr_db
#report_power ...

plot_power_profile -stim /stim#1 -by_category memory register logic clock -format native
plot_power_profile -stim /stim#2 -by_category memory register logic clock -format native
report_icgc_efficiency -out ${SYNTH_DIR}/JOULES_PROVA -append
#
cdn_cat ${SYNTH_DIR}/JOULES_PROVA
puts stdout "Done Reporting PPA"
