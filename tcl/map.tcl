#generic synth
set_db syn_generic_effort high
syn_generic
puts "Runtime & Memory after 'syn_generic'"
time_info GENERIC

#mapping synth
set_db syn_map_effort high
syn_map
puts "Runtime & Memory after 'syn_map'"
time_info MAPPED



#opt synth
set_db syn_opt_effort high
syn_opt

report_qor