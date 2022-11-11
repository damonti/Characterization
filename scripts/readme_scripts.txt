component_characterization.py: it takes component.v and tb_component.v as input
    and returns a trained model based on power numbers and toggle activity. 
    It runs:
    - stim_vector_gen.py for stims gen
    - compute_average_power_reports.py for power report parsing
    - dump_model.py to train and dump the model

design_gt.py: it takes the top.v and tb_top.v designs and returns the ground truth 
    power and area numbers for the design and its instances. 
    It runs:
    - stim_vector_gen_design.py for stims gen

design_estimation.py: it dumps a database out of the GT and estimated power 
    and area numbers previously computed.

