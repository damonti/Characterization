component_characterization.py: it takes component.v and tb_component.v as inputand returns a trained model based on power numbers and toggle activity. 
    It runs:
    - stim_vector_gen.py for stims gen
    - compute_average_power_reports.py for power report parsing
    - component_parse_toggle_activity: parse power reports and tcfs and output a component.csv in /tables directory
    - dump_model.py read component.csv (name, in, out, pwr) of that component and dump the trained power model

Once the component characterization is performed, to perform the estimation:
parse the dataframe from design_dump_csv.py and perform the inference from specified fir dataframe, feeding the model with the parsed activity and return estimated power and error wrt ground truth
    - design_dump_csv.py: it dumps a database out of the GT and estimated power and area numbers previously computed.

design_gt.py: it takes the top.v and tb_top.v designs and returns the ground truth power and area numbers for the design and its instances. 
    It runs:
    - stim_vector_gen_design.py for stims gen







