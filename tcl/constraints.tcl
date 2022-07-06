current_design $DESIGN
set clock_name "clk"
create_clock -period $CLOCK_PERIOD -name $clock_name [get_db ports $clock_name]
set_clock_uncertainty 0.02 [get_clocks $clock_name]
set_input_delay 0.1 -clock clk [remove_from_collection [all_inputs] {clk rst}]
set_output_delay 0.1 -clock clk [all_outputs]
