# ####################################################################

#  Created by Genus(TM) Synthesis Solution 19.11-s087_1 on Wed Oct 26 16:24:34 CEST 2022

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design fir_8bit

set_clock_gating_check -setup 0.0 
set_input_delay -add_delay 0.1 [get_ports clk]
set_input_delay -add_delay 0.1 [get_ports rst]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_0[7]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_0[6]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_0[5]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_0[4]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_0[3]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_0[2]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_0[1]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_0[0]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_1[7]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_1[6]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_1[5]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_1[4]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_1[3]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_1[2]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_1[1]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_1[0]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_2[7]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_2[6]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_2[5]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_2[4]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_2[3]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_2[2]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_2[1]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_2[0]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_3[7]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_3[6]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_3[5]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_3[4]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_3[3]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_3[2]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_3[1]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_3[0]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_4[7]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_4[6]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_4[5]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_4[4]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_4[3]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_4[2]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_4[1]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_4[0]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_5[7]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_5[6]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_5[5]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_5[4]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_5[3]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_5[2]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_5[1]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_5[0]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_6[7]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_6[6]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_6[5]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_6[4]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_6[3]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_6[2]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_6[1]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_6[0]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_7[7]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_7[6]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_7[5]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_7[4]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_7[3]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_7[2]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_7[1]}]
set_input_delay -add_delay 0.1 [get_ports {coeffs_table_7[0]}]
set_input_delay -add_delay 0.1 [get_ports din_vld]
set_input_delay -add_delay 0.1 [get_ports {din_data[7]}]
set_input_delay -add_delay 0.1 [get_ports {din_data[6]}]
set_input_delay -add_delay 0.1 [get_ports {din_data[5]}]
set_input_delay -add_delay 0.1 [get_ports {din_data[4]}]
set_input_delay -add_delay 0.1 [get_ports {din_data[3]}]
set_input_delay -add_delay 0.1 [get_ports {din_data[2]}]
set_input_delay -add_delay 0.1 [get_ports {din_data[1]}]
set_input_delay -add_delay 0.1 [get_ports {din_data[0]}]
set_input_delay -add_delay 0.1 [get_ports dout_busy]
set_output_delay -add_delay 0.1 [get_ports din_busy]
set_output_delay -add_delay 0.1 [get_ports dout_vld]
set_output_delay -add_delay 0.1 [get_ports {dout_data[10]}]
set_output_delay -add_delay 0.1 [get_ports {dout_data[9]}]
set_output_delay -add_delay 0.1 [get_ports {dout_data[8]}]
set_output_delay -add_delay 0.1 [get_ports {dout_data[7]}]
set_output_delay -add_delay 0.1 [get_ports {dout_data[6]}]
set_output_delay -add_delay 0.1 [get_ports {dout_data[5]}]
set_output_delay -add_delay 0.1 [get_ports {dout_data[4]}]
set_output_delay -add_delay 0.1 [get_ports {dout_data[3]}]
set_output_delay -add_delay 0.1 [get_ports {dout_data[2]}]
set_output_delay -add_delay 0.1 [get_ports {dout_data[1]}]
set_output_delay -add_delay 0.1 [get_ports {dout_data[0]}]
