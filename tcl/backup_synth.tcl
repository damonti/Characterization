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


###############################
set CLOCK_PERIOD 10 
set LOCAL_DIR "[exec pwd]/.."
set SYNTH_DIR ${LOCAL_DIR}/work
set SCRIPT_DIR ${LOCAL_DIR}/tcl
set DESIGN noc
set TECH 40
set ELAB_JDB noc.elab.db
set DESIGN noc
###################################

source $SCRIPT_DIR/backup_tech.tcl

set_db hdl_track_filename_row_col 1
set_db hdl_search_path ${LOCAL_DIR}/rtl/nocgen/mesh_3x3_8buf_4vch
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

foreach f $RTL_LIST {
    read_hdl $f
}

set_db auto_ungroup none

#this is for renaming issues
reset_naming_rules

elaborate $DESIGN
check_design -unresolved
source ${SCRIPT_DIR}/constraints.tcl
write_db -all -to_file $ELAB_JDB
puts stdout "Elab JDB Created: $ELAB_JDB"

