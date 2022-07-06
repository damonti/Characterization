
if {$TECH == 45} {

    set GPDK045 /opt/tools/technology/cadence/gpdk/45nm/gsclib045_all_v4.4
    set_db / .init_lib_search_path {. ./lib $GPDK045/}
    set lib_list "$GPDK045/gsclib045/timing/slow_vdd1v0_basicCells.lib \
                $GPDK045/gsclib045_hvt/timing/slow_vdd1v0_basicCells_hvt.lib \
                $GPDK045/gsclib045_lvt/timing/slow_vdd1v0_basicCells_lvt.lib"
    
    set lef_list "$GPDK045/gsclib045/lef/gsclib045_tech.lef \ 
                $GPDK045/gsclib045/lef/gsclib045_macro.lef \
                $GPDK045/gsclib045_hvt/lef/gsclib045_hvt_macro.lef \
                $GPDK045/gsclib045_lvt/lef/gsclib045_lvt_macro.lef"

    set_db / .library $lib_list 
    set_db / .lef_library $lef_list
    set_db qrc_tech_file "$GPDK045/gsclib045/qrc/qx/gpdk045.tch"

} elseif {$TECH == 130} {
    #TODO
} elseif {$TECH == 40} {

    set lib_list "/home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/timing_power_noise/ECSM/tcbn40lpbwphvt_120b/tcbn40lpbwphvttc_ecsm.lib \
        /home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/timing_power_noise/ECSM/tcbn40lpbwplvt_120b/tcbn40lpbwplvttc_ecsm.lib \
        /home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/timing_power_noise/ECSM/tcbn40lpbwp_120b/tcbn40lpbwptc_ecsm.lib"

    set lef_list  "/home_old/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwphvt_120c/lef/HVH_0d5_0/tcbn40lpbwphvt_8lm5X2ZRDL.lef \
        /home_old/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwplvt_120c/lef/HVH_0d5_0/tcbn40lpbwplvt_8lm5X2ZRDL.lef \
        /home_old/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwp_120c/lef/HVH_0d5_0/tcbn40lpbwp_8lm5X2ZRDL.lef"

    set CAPTABLE /home_old/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwp_120c/techfiles/captable/cln40lp_1p08m+alrdl_5x2z_typical.captab

    set_db / .library $lib_list 
    set_db / .lef_library $lef_list
    set_db / .cap_table_file $CAPTABLE

} else {
    puts "TECH NODE NOT AVAILABLE"
    suspend
}



#The standard cells in gsclib045 library use the MOSFET devices with standard threshold voltage (Vt).
#The standard cells in gsclib045_hvt library use the MOSFET devices with high threshold voltage (Vt).
#The standard cells in gsclib045_lvt library use the MOSFET devices with low threshold voltage (Vt).

#set_db script_search_path $TCL_PATH 




#TECHNOLOGY
#set LIB_LIST {
#/home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/timing_power_noise/ECSM/tcbn40lpbwplvt_120b/tcbn40lpbwplvttc_ecsm.lib \
#/home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/timing_power_noise/ECSM/tcbn40lpbwphvt_120b/tcbn40lpbwphvttc_ecsm.lib \
#}





#set LEF_LIST { \
#/home_old/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwphvt_120a/lef/HVH_0d5_0/tcbn40lpbwphvt_8lm5X2ZRDL.lef \
#/home_old/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwplvt_120a/lef/HVH_0d5_0/tcbn40lpbwplvt_8lm5X2ZRDL.lef \
#}

#set CAPTABLE /home_old/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwplvt_120c/techfiles/captable/cln40lp_1p08m+alrdl_5x2z_typical.captab



# set CAP_TABLE_FILE ../libraries/tsmc13fsg.capTbl
#set QRC_TECH_FILE ../QRC/t018s6mm.tch

#set_db error_on_lib_lef_pin_inconsistency true

# set_db library $LIB_LIST
#read_libs $LIB_LIST
#read_physical -lef $LEF_LIST

#SET_DB OR READ_LIBS?
#set_db / .library $LIB_LIST
#set_db / .lef_library $LEF_LIST
#set_db / .cap_table_file $CAPTABLE


# Avoid cells (see warnings)
#set avoids {*SEDF* \
#   *SDFN* \
#   *SDFX* \
#   *SDFK* \
#   *SDF* \
#   *DFD* \
#	*DFN* \
#	*DFK* \
#	*DFX*}
#foreach avd $avoids {
#    ::legacy::set_attribute avoid true [vfind / -libcell $avd]
#}

#PLE OR WIRELOAD?
set_db / .interconnect_mode ple