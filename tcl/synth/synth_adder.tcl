
# *********************************************************
# * Script Name  : Genus initialization script
# *********************************************************

#Cloc period in ns 
set CLOCK_PERIOD 10 
set DATE [clock format [clock seconds] -format "%b%d-%T"]
set DESIGN "adder"
set LOCAL_DIR "[exec pwd]/.."
set SYNTH_DIR ${LOCAL_DIR}/work
set TCL_PATH "${LOCAL_DIR}/tcl"
set _REPORTS_PATH "${LOCAL_DIR}/work/tech40/${DESIGN}_${CLOCK_PERIOD}ns_reports" 
set _OUTPUTS_PATH "${LOCAL_DIR}/work/${DESIGN}_outputs" 
set RTL_PATH "$LOCAL_DIR/rtl/${DESIGN}"




set_db script_search_path $TCL_PATH 
set_db / .init_hdl_search_path $RTL_PATH



#TECHNOLOGY
set lib_list "/home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/timing_power_noise/ECSM/tcbn40lpbwp_120b/tcbn40lpbwpwc_ecsm.lib"

set lef_list  "/home_old/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwp_120c/lef/HVH_0d5_0/tcbn40lpbwp_8lm5X2ZRDL.lef"

set CAPTABLE /home_old/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwp_120c/techfiles/captable/cln40lp_1p08m+alrdl_5x2z_typical.captab

set_db / .library $lib_list 
set_db / .lef_library $lef_list
set_db / .cap_table_file $CAPTABLE


#RTL
set RTL_LIST {\
adder_temp.v \
}

#this is for reports
set_db hdl_track_filename_row_col true 


#Low power optimizations: (i.e. clock gating, leakage/dynamic opt ratio, ...)  
source ${TCL_PATH}/lowpower.tcl


foreach f $RTL_LIST {
    read_hdl -sv $f
}

set_db / .auto_ungroup none

#use "elaborate parameters {16} ${DESIGN}" to pass the parameter value W=16 
elaborate $DESIGN 
time_info Elaboration
#check for problems
check_design -unresolved $DESIGN

####################################
#set design constraint
#source ${TCL_PATH}/constraints.tcl #if no clock in the module (i.e. combiantional circuit) comment this command
current_design $DESIGN
set_input_delay 0.1 [all_inputs]
set_output_delay 0.1 [all_outputs]

####################################
#generic synth
source ${TCL_PATH}/map.tcl

####################################
#Reports
source ${TCL_PATH}/reports.tcl


