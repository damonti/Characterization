#!/bin/bash
#CONFIG
#PORTS = 2 3 4 5
#for port in 5 4 3 2
#do
for i in 25 50 75 100
do
#VCH= 2 3 4
#BW = 64, 32
BW=64BW 
#DATAW = 66, 34
DATAW=66
#DATAW_P1 = 67, 35
DATAW_P1=67
#PERCENT = 25, 50, 75, 100
PERCENT=${i}percent
#PERCENT=100percent

#RTL SIMULATION
cd ~/Estimation/sim/router/
RTL_PATH=~/Estimation/rtl/router/hdl
sed -e "s/define DATAW           66/define DATAW           ${DATAW}/" ${RTL_PATH}/hdl/define.v \
-e "s/define DATAW_P1        67/define DATAW_P1        ${DATAW_P1}/" ${RTL_PATH}/hdl/define.v > ${RTL_PATH}/define_temp.v
sed -e "s/define.v/define_temp.v/" ${RTL_PATH}/hdl/router.v > ${RTL_PATH}/router_temp.v
sed -e "s/define.v/define_temp.v/" ${RTL_PATH}/hdl/arb.v > ${RTL_PATH}/arb_temp.v
sed -e "s/define.v/define_temp.v/" ${RTL_PATH}/hdl/fifo.v > ${RTL_PATH}/fifo_temp.v
sed -e "s/define.v/define_temp.v/" ${RTL_PATH}/hdl/mux.v > ${RTL_PATH}/mux_temp.v
sed -e "s/define.v/define_temp.v/" ${RTL_PATH}/hdl/rtcomp.v > ${RTL_PATH}/rtcomp_temp.v
sed -e "s/define.v/define_temp.v/" ${RTL_PATH}/hdl/muxcont.v > ${RTL_PATH}/muxcont_temp.v
sed -e "s/define.v/define_temp.v/" ${RTL_PATH}/hdl/inputc.v > ${RTL_PATH}/inputc_temp.v
sed -e "s/define.v/define_temp.v/" ${RTL_PATH}/hdl/vc.v > ${RTL_PATH}/vc_temp.v
sed -e "s/define.v/define_temp.v/" ${RTL_PATH}/hdl/cb.v > ${RTL_PATH}/cb_temp.v
sed -e "s/define.v/define_temp.v/" ${RTL_PATH}/hdl/outputc.v > ${RTL_PATH}/outputc_temp.v
sed -e "s/define.v/define_temp.v/" ${RTL_PATH}/hdl/vcmux.v > ${RTL_PATH}/vcmux_temp.v
xrun -access rwc $RTL_PATH/router_temp.v -incdir $RTL_PATH/hdl -timescale 10ns/10ps

#SYNTHESIS
cd ~/Estimation/work/
genus -batch -files "./../tcl/synth/synth_router.tcl" -no_gui -overwrite
cp ~/Estimation/work/tech40/router_10ns_reports/router_netlist.v $RTL_PATH/netlist/router${BW}_netlist.v
cp ~/Estimation/work/tech40/router_10ns_reports/router.sdc $RTL_PATH/router.sdc

#NETLIST SIMULATION
cd ~/Estimation/sim/router/
RTL_PATH=~/Estimation/rtl/router
sed -e "s/define.v/define_temp.v/" ${RTL_PATH}/characterization/test_router_${PERCENT}_${BW}.v \
-e "s/dump_router_.*.vcd/dump_router_${PERCENT}_${BW}.vcd/" > ${RTL_PATH}/test_router_temp.v
xrun -clean -access rwc -timescale 10ns/10ps -ALLOWREDEFINITION -incdir $RTL_PATH/hdl /home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/verilog/tcbn40lpbwp_120a/tcbn40lpbwp.v $RTL_PATH/netlist/router_${BW}BW_netlist.v $RTL_PATH/test_router_${PERCENT}_${BW}BW.v

#-input input.cmd

#POWER
cd ~/Estimation/work/
joules -overwrite -batch -execute "set BW ${BW}" -execute "set PERCENT ${PERCENT}" -files {"./../tcl/power_router.tcl"} -legacy_ui
#-batch
#done
#done
#CLEAN
#rm ${RTL_PATH}/router_temp.v
#rm ${RTL_PATH}/define_temp.v




