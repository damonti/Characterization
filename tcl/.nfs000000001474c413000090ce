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
set LOCAL_DIR "[exec pwd]/.."
set SYNTH_DIR ${LOCAL_DIR}/work
set SCRIPT_DIR ${LOCAL_DIR}/tcl
set RTL_PATH ${LOCAL_DIR}/rtl/mesh_3x3_8buf_4vch
set SIM_PATH ${LOCAL_DIR}/sim/mesh_3x3_8buf_4vch
set DESIGN noc
set TECH 40
###################################
set_db information_level 9 
source ./../tcl/tech_settings.tcl
#RTL
read_netlist $RTL_PATH/noc_netlist.v

read_sdc $RTL_PATH/noc.sdc
#read_spef <spef file> ????
suspend
#send_packet
read_stimulus -start 125ns -end 225ns -interval_size 10ns -allow_n_nets -format vcd -file $SIM_PATH/dump_complement.vcd -dut_instance /noc_test/noc -sdb_out complement.database -resim_cg_enables

#compute power
estimate_data_buffers
gen_clock_tree
compute_power -mode time_based

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
