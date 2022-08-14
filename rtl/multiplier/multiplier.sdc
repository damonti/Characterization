# ####################################################################

#  Created by Genus(TM) Synthesis Solution 19.11-s087_1 on Fri Jul 29 12:50:06 CEST 2022

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design multiplier

create_clock -name "clk" -period 10.0 -waveform {0.0 5.0} [get_ports clk]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {a[3]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {a[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {a[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {a[0]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {b[3]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {b[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {b[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {b[0]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {pdt[7]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {pdt[6]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {pdt[5]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {pdt[4]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {pdt[3]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {pdt[2]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {pdt[1]}]
set_output_delay -clock [get_clocks clk] -add_delay 0.1 [get_ports {pdt[0]}]
set_clock_uncertainty -setup 0.02 [get_clocks clk]
set_clock_uncertainty -hold 0.02 [get_clocks clk]
