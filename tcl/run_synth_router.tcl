###########################
#PARAMETERS
set CLOCK_PERIOD 100 
#40, 45
set TECH 40
set START_C 1 
set END_C 4
###########################
set DATE [clock format [clock seconds] -format "%b%d-%T"]
set LOCAL_DIR "[exec pwd]/.."
set SYNTH_DIR ${LOCAL_DIR}/work
set SCRIPT_DIR ${LOCAL_DIR}/tcl
set REPORT_DIR ${LOCAL_DIR}/work/tech${TECH}


########################
#LIBRARY SETUP
set techsettings "/home/20200969/Estimation/tcl/tech_settings.tcl"
if [file exists $techsettings] {
    source $techsettings
} else {
    puts "NO TECH SETTINGS FOUND"
    suspend
}

#########################
#RTL
set RTL_LIST {\
vcmux.v \
vc.v \
rtcomp.v \
router.v \
outputc.v \
muxcont.v \
mux.v \
inputc.v \
fifo.v \
cb.v \
arb.v \
}




for {set i 1} {$i <= 1} {incr i} {
    set DESIGN router${i}
    set CONF "/home/20200969/Estimation/tcl/synth_c${i}.tcl"
if [file exists $CONF] {
    source $CONF

} else {
    puts "NO SYNTH SCRIPT FOR $CONF FOUND"
    suspend
}
}

#set CLOCK_PERIOD 1000
#for {set i 1} {$i <= 3} {incr i} {
#    set DESIGN router${i}
#    set CONF "/home/20200969/Estimation/tcl/synth_c${i}.tcl"
#    source $CONF
#}


#########################################
#CONFIG_1: BUFFERSIZE=2, VCH=1
#set C1 "/home/20200969/Estimation/tcl/synth_c1.tcl"
#if [file exists $C1] {
#    source $C1
#} else {
#   puts "ERROR: NO SYNTH SCRIPT FOR ${C1} FOUND"
#    suspend
#}


#CONFIG_2: BUFFERSIZE=5, VCH=2


#CONFIG_3: BUFFERSIZE=8, VCH=4


#CONFIG_4: BUFFERSIZE=16, VCH=8
