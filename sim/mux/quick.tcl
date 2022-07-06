set REPORT_PATH ${SIM_PATH}/reports
set START 2070
set END 2260

set TB mux_100percent_1interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload.rpt

set TB mux_100percent_64interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload.rpt

suspend

set START 19470
set END 20180
set TB 75percent_8interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/dump_mux_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_packet.rpt

set START 30
set END 21620
set TB 75percent_8interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/dump_mux_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_message.rpt

suspend
set START 2070
set END 2260
set TB mux_100percent_1interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
set TB mux_100percent_2interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload.rpt
set TB mux_100percent_4interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload.rpt
set TB mux_100percent_8interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload.rpt
set TB mux_100percent_16interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload.rpt
set TB mux_100percent_32interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload.rpt
set TB mux_100percent_64interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload.rpt

set TB mux_25percent_1interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload.rpt
set TB mux_25percent_2interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload.rpt
set TB mux_25percent_4interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload.rpt
set TB mux_25percent_8interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload.rpt

set TB mux_75percent_1interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload.rpt
set TB mux_75percent_2interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload.rpt
set TB mux_75percent_4interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload.rpt
set TB mux_75percent_8interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload.rpt



set TB mux_random
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload.rpt


set TB mux_50percent_1interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload.rpt
set TB mux_50percent_2interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload.rpt
set TB mux_50percent_4interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload.rpt
set TB mux_50percent_8interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload.rpt
set TB mux_50percent_16interleaving
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_payload.rpt





suspend
set TB mux_50percent_8interleaving
set INJ 01
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}_${INJ}inj.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_${INJ}inj.rpt

set START 4720
set END 5380
set TB mux_50percent_8interleaving
set INJ 03
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}_${INJ}inj.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_${INJ}inj.rpt

set START 2830
set END 3220
set TB mux_50percent_8interleaving
set INJ 05
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}_${INJ}inj.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_${INJ}inj.rpt

set START 2060
set END 2330
set TB mux_50percent_8interleaving
set INJ 07
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}_${INJ}inj.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_${INJ}inj.rpt

set START 1640
set END 1860
set TB mux_50percent_8interleaving
set INJ 086
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}_${INJ}inj.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_${INJ}inj.rpt

set START 1570
set END 1780
set TB mux_50percent_8interleaving
set INJ 09
read_stimulus -start ${START}ns -end ${END}ns -allow_n_nets -format vcd -file $SIM_PATH/vcd/dump_${TB}_${INJ}inj.vcd -dut_instance /mux_test/mux
compute_power -mode time_based
report_power  -levels all -by_hierarchy -indent_inst -levels all -header -cols "cells static internal switching dynamic total" -unit nW > ${REPORT_PATH}/mux.${TB}_${INJ}inj.rpt
