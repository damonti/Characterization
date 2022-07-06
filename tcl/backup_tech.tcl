set lib_directory /home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/timing_power_noise/ECSM
set_db lib_search_path ". $lib_directory"
set lef_list "/home_old/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwphvt_120c/lef/HVH_0d5_0/tcbn40lpbwphvt_8lm5X2ZRDL.lef \
        /home_old/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwplvt_120c/lef/HVH_0d5_0/tcbn40lpbwplvt_8lm5X2ZRDL.lef \
        /home_old/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwp_120c/lef/HVH_0d5_0/tcbn40lpbwp_8lm5X2ZRDL.lef"
read_libs $lib_directory/tcbn40lpbwphvt_120b/tcbn40lpbwphvttc_ecsm.lib $lib_directory/tcbn40lpbwplvt_120b/tcbn40lpbwplvttc_ecsm.lib $lib_directory/tcbn40lpbwp_120b/tcbn40lpbwptc_ecsm.lib
    
set_db / .lef_library $lef_list
#set_db / .lef_library {${lef_directory}/tcbn40lpbwphvt_120c/lef/HVH_0d5_0/tcbn40lpbwphvt_8lm5X2ZRDL.lef ${lef_directory}/tcbn40lpbwplvt_120c/lef/HVH_0d5_0/tcbn40lpbwplvt_8lm5X2ZRDL.lef ${lef_directory}/tcbn40lpbwp_120c/lef/HVH_0d5_0/tcbn40lpbwp_8lm5X2ZRDL.lef}
 
set_db cap_table_file /home_old/tech/tsmc/40nm/TSMCHOME/digital/Back_End/lef/tcbn40lpbwp_120c/techfiles/captable/cln40lp_1p08m+alrdl_5x2z_typical.captab
