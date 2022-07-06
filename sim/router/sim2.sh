#!/bin/bash
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