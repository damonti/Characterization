# ####################################################################

#  Created by Genus(TM) Synthesis Solution 19.11-s087_1 on Wed Jul 06 18:50:17 CEST 2022

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design mux

set_clock_gating_check -setup 0.0 
set_input_delay -add_delay 0.1 [get_ports {idata_0[10]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[9]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[8]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[7]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[6]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[5]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[4]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[3]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[2]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[1]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[0]}]
set_input_delay -add_delay 0.1 [get_ports ivalid_0]
set_input_delay -add_delay 0.1 [get_ports {ivch_0[1]}]
set_input_delay -add_delay 0.1 [get_ports {ivch_0[0]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[10]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[9]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[8]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[7]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[6]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[5]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[4]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[3]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[2]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[1]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[0]}]
set_input_delay -add_delay 0.1 [get_ports ivalid_1]
set_input_delay -add_delay 0.1 [get_ports {ivch_1[1]}]
set_input_delay -add_delay 0.1 [get_ports {ivch_1[0]}]
set_input_delay -add_delay 0.1 [get_ports {sel[1]}]
set_input_delay -add_delay 0.1 [get_ports {sel[0]}]
set_output_delay -add_delay 0.1 [get_ports {odata[10]}]
set_output_delay -add_delay 0.1 [get_ports {odata[9]}]
set_output_delay -add_delay 0.1 [get_ports {odata[8]}]
set_output_delay -add_delay 0.1 [get_ports {odata[7]}]
set_output_delay -add_delay 0.1 [get_ports {odata[6]}]
set_output_delay -add_delay 0.1 [get_ports {odata[5]}]
set_output_delay -add_delay 0.1 [get_ports {odata[4]}]
set_output_delay -add_delay 0.1 [get_ports {odata[3]}]
set_output_delay -add_delay 0.1 [get_ports {odata[2]}]
set_output_delay -add_delay 0.1 [get_ports {odata[1]}]
set_output_delay -add_delay 0.1 [get_ports {odata[0]}]
set_output_delay -add_delay 0.1 [get_ports ovalid]
set_output_delay -add_delay 0.1 [get_ports {ovch[1]}]
set_output_delay -add_delay 0.1 [get_ports {ovch[0]}]
