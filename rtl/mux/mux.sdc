# ####################################################################

#  Created by Genus(TM) Synthesis Solution 19.11-s087_1 on Mon Aug 08 15:22:03 CEST 2022

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design mux

set_clock_gating_check -setup 0.0 
set_input_delay -add_delay 0.1 [get_ports {idata_0[66]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[65]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[64]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[63]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[62]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[61]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[60]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[59]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[58]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[57]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[56]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[55]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[54]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[53]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[52]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[51]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[50]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[49]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[48]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[47]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[46]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[45]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[44]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[43]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[42]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[41]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[40]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[39]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[38]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[37]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[36]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[35]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[34]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[33]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[32]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[31]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[30]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[29]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[28]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[27]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[26]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[25]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[24]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[23]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[22]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[21]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[20]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[19]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[18]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[17]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[16]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[15]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[14]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[13]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[12]}]
set_input_delay -add_delay 0.1 [get_ports {idata_0[11]}]
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
set_input_delay -add_delay 0.1 [get_ports {idata_1[66]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[65]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[64]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[63]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[62]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[61]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[60]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[59]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[58]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[57]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[56]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[55]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[54]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[53]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[52]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[51]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[50]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[49]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[48]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[47]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[46]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[45]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[44]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[43]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[42]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[41]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[40]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[39]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[38]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[37]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[36]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[35]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[34]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[33]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[32]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[31]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[30]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[29]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[28]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[27]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[26]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[25]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[24]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[23]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[22]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[21]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[20]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[19]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[18]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[17]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[16]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[15]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[14]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[13]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[12]}]
set_input_delay -add_delay 0.1 [get_ports {idata_1[11]}]
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
set_input_delay -add_delay 0.1 [get_ports {idata_2[66]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[65]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[64]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[63]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[62]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[61]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[60]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[59]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[58]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[57]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[56]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[55]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[54]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[53]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[52]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[51]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[50]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[49]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[48]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[47]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[46]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[45]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[44]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[43]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[42]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[41]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[40]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[39]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[38]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[37]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[36]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[35]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[34]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[33]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[32]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[31]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[30]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[29]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[28]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[27]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[26]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[25]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[24]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[23]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[22]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[21]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[20]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[19]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[18]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[17]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[16]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[15]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[14]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[13]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[12]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[11]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[10]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[9]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[8]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[7]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[6]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[5]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[4]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[3]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[2]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[1]}]
set_input_delay -add_delay 0.1 [get_ports {idata_2[0]}]
set_input_delay -add_delay 0.1 [get_ports ivalid_2]
set_input_delay -add_delay 0.1 [get_ports {ivch_2[1]}]
set_input_delay -add_delay 0.1 [get_ports {ivch_2[0]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[66]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[65]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[64]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[63]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[62]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[61]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[60]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[59]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[58]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[57]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[56]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[55]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[54]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[53]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[52]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[51]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[50]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[49]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[48]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[47]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[46]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[45]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[44]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[43]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[42]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[41]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[40]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[39]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[38]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[37]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[36]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[35]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[34]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[33]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[32]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[31]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[30]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[29]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[28]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[27]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[26]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[25]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[24]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[23]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[22]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[21]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[20]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[19]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[18]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[17]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[16]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[15]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[14]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[13]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[12]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[11]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[10]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[9]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[8]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[7]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[6]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[5]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[4]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[3]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[2]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[1]}]
set_input_delay -add_delay 0.1 [get_ports {idata_3[0]}]
set_input_delay -add_delay 0.1 [get_ports ivalid_3]
set_input_delay -add_delay 0.1 [get_ports {ivch_3[1]}]
set_input_delay -add_delay 0.1 [get_ports {ivch_3[0]}]
set_input_delay -add_delay 0.1 [get_ports {sel[3]}]
set_input_delay -add_delay 0.1 [get_ports {sel[2]}]
set_input_delay -add_delay 0.1 [get_ports {sel[1]}]
set_input_delay -add_delay 0.1 [get_ports {sel[0]}]
set_output_delay -add_delay 0.1 [get_ports {odata[66]}]
set_output_delay -add_delay 0.1 [get_ports {odata[65]}]
set_output_delay -add_delay 0.1 [get_ports {odata[64]}]
set_output_delay -add_delay 0.1 [get_ports {odata[63]}]
set_output_delay -add_delay 0.1 [get_ports {odata[62]}]
set_output_delay -add_delay 0.1 [get_ports {odata[61]}]
set_output_delay -add_delay 0.1 [get_ports {odata[60]}]
set_output_delay -add_delay 0.1 [get_ports {odata[59]}]
set_output_delay -add_delay 0.1 [get_ports {odata[58]}]
set_output_delay -add_delay 0.1 [get_ports {odata[57]}]
set_output_delay -add_delay 0.1 [get_ports {odata[56]}]
set_output_delay -add_delay 0.1 [get_ports {odata[55]}]
set_output_delay -add_delay 0.1 [get_ports {odata[54]}]
set_output_delay -add_delay 0.1 [get_ports {odata[53]}]
set_output_delay -add_delay 0.1 [get_ports {odata[52]}]
set_output_delay -add_delay 0.1 [get_ports {odata[51]}]
set_output_delay -add_delay 0.1 [get_ports {odata[50]}]
set_output_delay -add_delay 0.1 [get_ports {odata[49]}]
set_output_delay -add_delay 0.1 [get_ports {odata[48]}]
set_output_delay -add_delay 0.1 [get_ports {odata[47]}]
set_output_delay -add_delay 0.1 [get_ports {odata[46]}]
set_output_delay -add_delay 0.1 [get_ports {odata[45]}]
set_output_delay -add_delay 0.1 [get_ports {odata[44]}]
set_output_delay -add_delay 0.1 [get_ports {odata[43]}]
set_output_delay -add_delay 0.1 [get_ports {odata[42]}]
set_output_delay -add_delay 0.1 [get_ports {odata[41]}]
set_output_delay -add_delay 0.1 [get_ports {odata[40]}]
set_output_delay -add_delay 0.1 [get_ports {odata[39]}]
set_output_delay -add_delay 0.1 [get_ports {odata[38]}]
set_output_delay -add_delay 0.1 [get_ports {odata[37]}]
set_output_delay -add_delay 0.1 [get_ports {odata[36]}]
set_output_delay -add_delay 0.1 [get_ports {odata[35]}]
set_output_delay -add_delay 0.1 [get_ports {odata[34]}]
set_output_delay -add_delay 0.1 [get_ports {odata[33]}]
set_output_delay -add_delay 0.1 [get_ports {odata[32]}]
set_output_delay -add_delay 0.1 [get_ports {odata[31]}]
set_output_delay -add_delay 0.1 [get_ports {odata[30]}]
set_output_delay -add_delay 0.1 [get_ports {odata[29]}]
set_output_delay -add_delay 0.1 [get_ports {odata[28]}]
set_output_delay -add_delay 0.1 [get_ports {odata[27]}]
set_output_delay -add_delay 0.1 [get_ports {odata[26]}]
set_output_delay -add_delay 0.1 [get_ports {odata[25]}]
set_output_delay -add_delay 0.1 [get_ports {odata[24]}]
set_output_delay -add_delay 0.1 [get_ports {odata[23]}]
set_output_delay -add_delay 0.1 [get_ports {odata[22]}]
set_output_delay -add_delay 0.1 [get_ports {odata[21]}]
set_output_delay -add_delay 0.1 [get_ports {odata[20]}]
set_output_delay -add_delay 0.1 [get_ports {odata[19]}]
set_output_delay -add_delay 0.1 [get_ports {odata[18]}]
set_output_delay -add_delay 0.1 [get_ports {odata[17]}]
set_output_delay -add_delay 0.1 [get_ports {odata[16]}]
set_output_delay -add_delay 0.1 [get_ports {odata[15]}]
set_output_delay -add_delay 0.1 [get_ports {odata[14]}]
set_output_delay -add_delay 0.1 [get_ports {odata[13]}]
set_output_delay -add_delay 0.1 [get_ports {odata[12]}]
set_output_delay -add_delay 0.1 [get_ports {odata[11]}]
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
