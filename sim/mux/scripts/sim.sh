#!/bin/bash
#CONFIG
############################
#FACTOR = 5-1, 4-1, 3-1, 2-1 
#for port in 5 4 3 2
port=2
#do
#for i in 25 50 75 100
#do
FACTOR=${port}-1
#${port}-1 will be a string (i.e. 5-1); $((${port}-1)) will be a number, (i.e. 5-1=4)
#FACTOR=5-1
PORT=$((${port}-1)) 
#PORT=4
PORT_P1=${port} 
#PORT_P1=5

#BW = 64, 32, 16, 8
for Z in {8..64}
do
BW=${Z}BW
#BW=8BW 
#DATAW = 66, 34
DATAW=$((${Z}+2))
#DATAW_P1 = 67, 35
DATAW_P1=$((${Z}+3))
#PERCENT = 25, 50, 75, 100
#PERCENT=${i}percent
#PERCENT=25percent
NETLIST=${FACTOR}_${BW}_netlist
DESIGN=mux
########################################


#RTL SIMULATION
########################################
cd ~/Estimation/sim/mux/
RTL_PATH=~/Estimation/rtl/mux
sed -e "s/define PORT            4/define PORT            ${PORT}/" ${RTL_PATH}/hdl/define.v \
-e "s/define PORT_P1            5/define PORT            ${PORT_P1}/" ${RTL_PATH}/hdl/define.v \
-e "s/define DATAW           66/define DATAW           ${DATAW}/" ${RTL_PATH}/hdl/define.v \
-e "s/define DATAW_P1        67/define DATAW_P1        ${DATAW_P1}/" ${RTL_PATH}/hdl/define.v > ${RTL_PATH}/define_temp.v
sed -e "s/define.v/define_temp.v/" ${RTL_PATH}/hdl/mux${FACTOR}.v > ${RTL_PATH}/mux_temp.v
xrun -access rwc ${RTL_PATH}/mux_temp.v -incdir $RTL_PATH -timescale 10ns/10ps
########################################

#SYNTHESIS
########################################
cd ~/Estimation/work/
genus -batch -files "./../tcl/synth/synth_mux.tcl" -no_gui -overwrite
cp ~/Estimation/work/tech40/mux_10ns_reports/mux_netlist.v $RTL_PATH/netlist/${DESIGN}_${NETLIST}.v
########################################


#NETLIST SIMULATION
########################################
step=$((100 / $Z))
$list="$(seq -s '' $step, $step, 100)"
for i in 25 50 75 100
do
PERCENT=${i}percent
cd ~/Estimation/sim/mux/
RTL_PATH=~/Estimation/rtl/mux
sed -e "s/define.v/define_temp.v/" ${RTL_PATH}/characterization/test_mux_${PERCENT}_${FACTOR}_${BW}.v \
-e "s/dump_mux.*.vcd/dump_mux_${PERCENT}_${FACTOR}_${BW}.vcd/" > ${RTL_PATH}/test_mux_temp.v
xrun -clean -access rwc -timescale 10ns/10ps -ALLOWREDEFINITION -incdir $RTL_PATH /home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/verilog/tcbn40lpbwp_120a/tcbn40lpbwp.v $RTL_PATH/netlist/${DESIGN}_${NETLIST}.v $RTL_PATH/test_mux_temp.v
########################################


#POWER
########################################
cd ~/Estimation/work/
joules -overwrite -batch -execute "set FACTOR ${FACTOR}" -execute "set BW ${BW}" -execute "set PERCENT ${PERCENT}" -files {"./../tcl/power/power_mux.tcl"} -legacy_ui
########################################

#done
#done

#CLEAN
########################################
cd ~/Estimation/sim/mux
rm *.vcd
#rm ${RTL_PATH}/mux_temp.v
#rm ${RTL_PATH}/define_temp.v
########################################




