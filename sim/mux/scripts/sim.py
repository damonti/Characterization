import os
import math
import shutil
import pdb

#############PARAM CONFIGURATION
#FACTOR = ["2-1", "3-1", "4-1", "5-1"]
#for PORT in FACTOR:
INPUT = 2

PORT = INPUT - 1
PORT_P1 = PORT + 1
FACTOR = str(INPUT)+"-1"
BW = 8
BW_ = str(BW)+"BW"
DATAW = BW+2
DATAW_P1 = BW+3
NETLIST = FACTOR+"_"+BW_+"_netlist"
DESIGN = "mux"

#BW = 8..64
#for link in BW

#DIRECTORIES

WORK_PATH = os.path.expanduser("~/Estimation/work")
SIM_PATH = os.path.expanduser("~/Estimation/sim/mux")
RTL_PATH = os.path.expanduser("~/Estimation/rtl/mux")

#RTL SIMULATION
os.chdir(SIM_PATH)
with open(RTL_PATH+'/hdl/define.v', 'r') as f:
    lines = f.readlines()
    for k in range(0, len(lines)):
        if ("PORTx" in lines[k]):
            lines[k] = "`define PORT            "+ str(PORT) + "\n"
        
        elif ("define PORT_P1x" in lines[k]):
            lines[k] = "`define PORT_P1          "+ str(PORT_P1) + "\n"
        
        elif ("define DATAWx" in lines[k]):
            lines[k] = ("`define DATAW           "+ str(DATAW) + "\n")
        
        elif ("define DATAW_P1x" in lines[k]):
            lines[k] = "`define DATAW_P1        "+ str(DATAW_P1) + "\n"
           
    with open(SIM_PATH+"/define_temp.v", 'w') as wr:
        wr.writelines(lines)
wr.close()
f.close()

with open(RTL_PATH+'/hdl/mux'+FACTOR+'.v', 'r') as f:
    lines = f.readlines()
    for k in range(0, len(lines)):
        if ("define.v" in lines[k]):
            lines[k] = "define_temp.v\n"    

    with open("./../mux_temp.v", 'w') as wr:
        wr.writelines(lines)
        
wr.close()
f.close()       
#RTL SIM
os.chdir(SIM_PATH)
os.system('xrun -access rwc '+RTL_PATH+'/mux_temp.v -incdir $RTL_PATH -timescale 10ns/10ps')

#SYNTHESIS
os.chdir(WORK_PATH)
#os.system('genus -batch -files "./../tcl/synth/synth_mux.tcl" -no_gui -overwrite')
shutil.copyfile(WORK_PATH+"/tech40/mux_10ns_reports/mux_netlist.v", RTL_PATH+"/netlist/"+DESIGN+"}_"+NETLIST+".v")

#NETLIST SIMULATION
pdb.set_trace()
min_step = 100/BW  # minimum percentage step
steps = [math.floor(min_step)]
for i in range(2, BW+1, 1):  # start at 2, up to BW included, increment 1
    steps.append(math.floor(min_step*i))


for PERCENT in steps:
    TB = 'test_mux_'+FACTOR+'_'+BW_+'_'+str(PERCENT)+'percent.v'
    PATH_TB = RTL_PATH+'/characterization/'+TB
    with open(PATH_TB, 'r') as f:
     lines = f.readlines()
    for k in range(0, len(lines)):
        if ("define.v" in lines[k]):
            lines[k] = "define_temp.v\n"  
        elif ("dump_mux." in lines[k]):
            lines[k] = "        $dumpfile(\"dump_mux+"+FACTOR+"_"+BW_+"_"+str(PERCENT)+"percent.vcd\");"
    with open(RTL_PATH+'test_mux_temp', 'w') as wr:
        wr.writelines(lines)
    os.system('xrun -clean -access rwc -timescale 10ns/10ps -ALLOWREDEFINITION -incdir '+RTL_PATH+' /home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/verilog/tcbn40lpbwp_120a/tcbn40lpbwp.v '+RTL_PATH+'/netlist/'+DESIGN+'_'+NETLIST+'.v '+RTL_PATH+'/test_mux_temp.v')
    wr.close()
    f.close()  

#POWER
os.chdir(WORK_PATH)
os.system('joules -overwrite -batch -execute "set FACTOR '+FACTOR+'" -execute "set BW '+BW+'" -execute "set PERCENT '+str(PERCENT)+'" -files {"./../tcl/power/power_mux.tcl"} -legacy_ui')