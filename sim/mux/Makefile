.PHONY: param sim synth postsynth power clean
#REMEMBER TO CHANGE: timescale, topology

#CONFIG
#FACTOR = 5-1, 4-1, 3-1, 2-1 
targets:
	@echo "targets: [ sim | gui | clean ]"

param:
	FACTOR = 4-1
	PORT = 3
	PORT_P1 = 4 
 	#BW = 64, 32 ,16
  	BW = 64BW


#RTL SIMULATION
sim: 
	cd ~/Estimation/sim/mux/
	RTL_PATH=~/Estimation/rtl/mux
	sed -e "s/define PORT            4/define PORT            ${PORT}/" ${RTL_PATH}/hdl/define.v \
	-e "s/define PORT_P1            5/define PORT            ${PORT_P1}/" > ${RTL_PATH}/define_temp.v
	sed -e "s/define.v/define_temp.v/" ${RTL_PATH}/hdl/mux${FACTOR}.v > ${RTL_PATH}/mux_temp.v
	xrun -access rwc ${RTL_PATH}/mux_temp.v -incdir $RTL_PATH -timescale 10ns/10ps


#SYNTHESIS
synth:
	cd ~/Estimation/work/
	genus -batch -files "./../tcl/synth/synth_mux.tcl" -no_gui -overwrite
	cp ~/Estimation/work/tech40/mux_10ns_reports/mux_netlist.v $RTL_PATH/netlist/mux${FACTOR}_netlist.v

#NETLIST SIMULATION
postsynth:
	cd ~/Estimation/sim/mux/
	RTL_PATH=~/Estimation/rtl/mux
	sed -e "s/define.v/define_temp.v/" ${RTL_PATH}/characterization/test_mux_50percent_${FACTOR}_${BW}.v \
	-e "s/dump_mux_50percent_8interleaving.vcd/dump_${FACTOR}_${BW}.vcd/" > ${RTL_PATH}/test_mux_temp.v
	xrun -clean -access rwc -timescale 10ns/10ps -ALLOWREDEFINITION -incdir $RTL_PATH /home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/verilog/tcbn40lpbwp_120a/tcbn40lpbwp.v $RTL_PATH/netlist/mux${FACTOR}_netlist.v $RTL_PATH/test_mux_temp.v

#-input input.cmd

#POWER
power:
	cd ~/Estimation/work/
	joules -overwrite -batch -execute "set FACTOR ${FACTOR}" -execute "set BW ${BW}" -files {"./../tcl/power_mux.tcl"} -legacy_ui
 
#CLEAN
clean:
	rm ${RTL_PATH}/mux${FACTOR}_temp.v




