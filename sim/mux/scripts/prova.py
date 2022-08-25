#check that for IN=4 BW=32 and TOGGLE=38 the tcf gives 38%toggle activity. if not, you neet to change how you compute the % in the database because how you compute it in the dataframe does not match how you validate it
import os
import shutil


WORK_PATH = os.path.expanduser("~/Estimation/work")
SIM_PATH = os.path.expanduser("~/Estimation/sim/mux")
RTL_PATH = os.path.expanduser("~/Estimation/rtl/mux")

# PARAM CONFIGURATION
#FACTOR = ["2-1", "3-1", "4-1", "5-1"]
# for PORT in FACTOR:
INPUT=4
PORT = INPUT - 1
PORT_P1 = PORT + 1
FACTOR = str(INPUT)+"-1"
BW=32 
BW_ = str(BW)+"BW"
DATAW = BW+2
DATAW_P1 = BW+3
NETLIST = FACTOR+"_"+BW_+"_netlist"
DESIGN = "mux"


#RTL SIMULATION
os.chdir(SIM_PATH)
#CHANGE THE DEFINE.V FOR THE CHOSEN CONFIGURATION AND WRITE IT INTO DEFINE_TEMP.V
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
    
    with open(RTL_PATH+"/define_temp.v", 'w') as wr:
        wr.writelines(lines)
wr.close()
f.close()
#CHANGE THE MUX.V FOR THE CHOSEN CONFIGURATION AND WRITE IT INTO MUX_TEMP.V
with open(RTL_PATH+'/hdl/mux'+FACTOR+'.v', 'r') as f:
    lines = f.readlines()
    for k in range(0, len(lines)):
        if ("define.v" in lines[k]):
            lines[k] = '`include "define_temp.v" \n'
    with open(RTL_PATH+"/mux_temp.v", 'w') as wr:
        wr.writelines(lines)

wr.close()
f.close()

#NETLIST SIMULATION
min_step = 100/BW  # minimum percentage step
steps = []
for i in range(1, BW+1):  # start at 2, up to BW included, increment 1
    steps.append(round(min_step*i))

# for PERCENT in steps:
#     TB = 'test_mux_'+FACTOR+'_'+BW_+'_'+str(PERCENT)+'percent.v'
#     PATH_TB = RTL_PATH+'/characterization/'+TB
#     with open(PATH_TB, 'r') as f:
#         lines = f.readlines()
#         for k in range(0, len(lines)):
#             if ("define.v" in lines[k]):
#                 lines[k] = "define_temp.v\n"
#             elif ("dump_mux." in lines[k]):
#                 lines[k] = "        $dumpfile(\""+SIM_PATH+"/dump_mux_"+FACTOR+"_"+BW_+"_"+str(PERCENT)+"percent.vcd\");\n"
#         with open(RTL_PATH+'/test_mux_temp.v', 'w') as wr:
#             wr.writelines(lines)
#     wr.close()
#     f.close()
PERCENT=22
TB = 'test_mux_'+FACTOR+'_'+BW_+'_'+str(PERCENT)+'percent.v'
PATH_TB = RTL_PATH+'/characterization/'+TB
with open(PATH_TB, 'r') as f:
    lines = f.readlines()
    for k in range(0, len(lines)):
        if ("define.v" in lines[k]):
            lines[k] = "define_temp.v\n"
        elif ("dump_mux." in lines[k]):
            lines[k] = "        $dumpfile(\""+SIM_PATH+"/dump_mux_"+FACTOR+"_"+BW_+"_"+str(PERCENT)+"percent.vcd\");\n"
    with open(RTL_PATH+'/test_mux_temp.v', 'w') as wr:
        wr.writelines(lines)
wr.close()
f.close()

with open(RTL_PATH+'run.tcl', 'w' ) as tcl:
    tcl.write('dumptcf -output mux_'+FACTOR+'_'+BW_+str(PERCENT)+'percent.tcf -scope mux_test.mux -overwrite \nrun \nexit')
os.system('xrun -clean -access rwc -timescale 10ns/10ps -input run.tcl -ALLOWREDEFINITION -incdir '+RTL_PATH+' /home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/verilog/tcbn40lpbwp_120a/tcbn40lpbwp.v '+RTL_PATH+'/netlist/'+DESIGN+'_'+NETLIST+'.v '+RTL_PATH+'/test_mux_temp.v')

