puts "Write reports"
write_snapshot -outdir $_REPORTS_PATH/snapshot -tag final
report_summary -directory $_REPORTS_PATH
report area -detail -physical > $_REPORTS_PATH/$DESIGN.area.rpt
report timing > $_REPORTS_PATH/$DESIGN.timing.rpt
report gates -power > $_REPORTS_PATH/$DESIGN.gates.rpt
report design_rules > $_REPORTS_PATH/$DESIGN.rules.rpt
report power -by_hierarchy -indent_inst -levels all -header -cols "cells static dynamic total" -unit nW > $_REPORTS_PATH/$DESIGN.power.rpt
report summary > $_REPORTS_PATH/$DESIGN.summary.rpt
report message
report clocks > $_REPORTS_PATH/$DESIGN.clock.rpt
report_messages -all > $_REPORTS_PATH/$DESIGN.warnings.rpt
report_ple > $_REPORTS_PATH/$DESIGN.ple.rpt
report_nets > $_REPORTS_PATH/$DESIGN.nets.rpt
report_qor > $_REPORTS_PATH/$DESIGN.qor.rpt
report_sequential -hier > $_REPORTS_PATH/$DESIGN.sequential.rpt
report timing -max_paths 100  > $_REPORTS_PATH/$DESIGN.timing.rpt

puts "Write sdc and netlists"
write_sdc > $_REPORTS_PATH/$DESIGN.sdc
write_hdl > $_REPORTS_PATH/netlist/$DESIGN.v
write_sdc > $RTL_PATH/$DESIGN.sdc
write_hdl > $_REPORTS_PATH/${DESIGN}_netlist.v
write_script > $_REPORTS_PATH/netlist/${DESIGN}_restore_script.g
#to restore the design: load libs, read netlist, source restore_script