set PARAM router_2buf_1vch

set _REPORTS_PATH "${REPORT_DIR}/${PARAM}_${DATE}_${CLOCK_PERIOD}ps_${TECH}_reports" 
set RTL_PATH "$LOCAL_DIR/rtl/nocgen/${PARAM}"
set_db init_hdl_search_path $RTL_PATH 


#this is for reports
set_db hdl_track_filename_row_col true 

##########################################################
#RTL
foreach f $RTL_LIST {
    read_hdl -v2001 $f
}

set_db / .auto_ungroup none

##########################################################
#ELABORATION
elaborate $DESIGN 
time_info Elaboration
#check for problems
check_design -unresolved $DESIGN 

##########################################################
#SDC
#set design constraint
#for now only clock since for now i do not have any constraint to meet beside 
#the clock frequency. or do i need to generate some?
source ${SCRIPT_DIR}/router_constraints.tcl

  

##########################################################
#SYNTHESIS
source ${SCRIPT_DIR}/map.tcl




##########################################################
#REPORTS
source ${SCRIPT_DIR}/reports.tcl


##########################################################
#FINISH
puts "Final Runtime & Memory."
time_info FINAL

puts "C${i} FINISHED"


