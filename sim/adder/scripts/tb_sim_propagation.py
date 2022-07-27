import os
import shutil
from tkinter.tix import DECREASING

DESIGN = "adder"
WORK_PATH = os.path.expanduser("~/Estimation/work")
SIM_PATH = os.path.expanduser("~/Estimation/sim/"+DESIGN)
RTL_PATH = os.path.expanduser("~/Estimation/rtl/"+DESIGN)


for BW in range(8, 10, 2):
#BW=10
    BW_ = str(BW)+"BW"
    NETLIST = DESIGN+"_"+BW_+"_netlist"

    #NETLIST SIMULATION
    min_step = 100/BW  # minimum percentage step
    steps = []
    for i in range(1, BW+1):  # start at 2, up to BW included, increment 1
        steps.append(round(min_step*i))

    for PERCENT in steps:
        TB = 'test_'+DESIGN+'_'+BW_+'_'+str(PERCENT)+'percent.v'
        PATH_TB = RTL_PATH+'/propagation/'+TB
        with open(PATH_TB, 'r') as f:
            lines = f.readlines()
            for k in range(0, len(lines)):
                if ("dump_"+DESIGN+"." in lines[k]):
                    lines[k] = "        $dumpfile(\""+SIM_PATH+"/dump_"+DESIGN+"_"+BW_+"_"+str(PERCENT)+"percent.vcd\");\n"
            with open(RTL_PATH+'/test_'+DESIGN+'_temp.v', 'w') as wr:
                wr.writelines(lines)
        wr.close()
        f.close()
        os.system('xrun -clean -access rwc -timescale 10ns/10ps -ALLOWREDEFINITION -incdir '+RTL_PATH+' /home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/verilog/tcbn40lpbwp_120a/tcbn40lpbwp.v '+RTL_PATH+'/netlist/'+NETLIST+'.v '+RTL_PATH+'/test_'+DESIGN+'_temp.v')

    os.chdir(SIM_PATH)
    os.system('rm *.vcd')
