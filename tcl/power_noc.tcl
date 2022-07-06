###############################
set CLOCK_PERIOD 10 
set LOCAL_DIR "[exec pwd]/.."
set SYNTH_DIR ${LOCAL_DIR}/work
set SCRIPT_DIR ${LOCAL_DIR}/tcl
set DESIGN noc
set TECH 40
#TOPOLOGY options: ring16_8buf_2vch, mesh_3x3_8buf_4vch, mesh_4x4_16buf_4vch
set TOPOLOGY mesh_4x4_16buf_4vch

###################################

#set_db / .init_lib_search_path {. ./lib digital/Front_End/timing_power_noise/ECSM/tcbn40lpbwp12t40m1plvt_200a/}
#set_db / .script_search_path {. ../tcl }
#set_db / .init_hdl_search_path {. ../rtl/nocgen .}
#set_db / .information_level 7 

source $SCRIPT_DIR/tech_settings.tcl

source $SCRIPT_DIR/postsynth/postsynth_noc.tcl
