import os
import shutil
from tkinter.tix import DECREASING

DESIGN = "adder"
WORK_PATH = os.path.expanduser("~/Estimation/work")
SIM_PATH = os.path.expanduser("~/Estimation/sim/"+DESIGN)
RTL_PATH = os.path.expanduser("~/Estimation/rtl/"+DESIGN)


for BW in range(12, 128, 2):
#BW=10
    BW_ = str(BW)+"BW"
    NETLIST = DESIGN+"_"+BW_+"_netlist"


    #RTL SIMULATION
    os.chdir(SIM_PATH)


    #CHANGE THE adder.v FOR THE CHOSEN CONFIGURATION AND WRITE IT INTO adder_temp.v
    with open(RTL_PATH+'/hdl/'+DESIGN+'.v', 'r') as f:
        lines = f.readlines()
        for k in range(0, len(lines)):
            if ("//parameter_N" in lines[k]):
                lines[k] = 'parameter N = '+str(int(BW/2))+';\n'
        with open(RTL_PATH+"/"+DESIGN+"_temp.v", 'w') as wr:
            wr.writelines(lines)

    wr.close()
    f.close()
    #RTL SIM
    os.chdir(SIM_PATH)
    os.system('xrun -access rwc '+RTL_PATH+'/'+DESIGN+'_temp.v -incdir '+RTL_PATH+' -timescale 10ns/10ps')

    #SYNTHESIS
    os.chdir(WORK_PATH)
    os.system('genus -batch -files "./../tcl/synth/synth_'+DESIGN+'.tcl" -no_gui -overwrite')
    shutil.copyfile(WORK_PATH+"/tech40/"+DESIGN+"_10ns_reports/"+DESIGN+"_netlist.v", RTL_PATH+"/netlist/"+NETLIST+".v")

    #NETLIST SIMULATION
    min_step = 100/BW  # minimum percentage step
    steps = []
    for i in range(1, BW+1):  # start at 2, up to BW included, increment 1
        steps.append(round(min_step*i))

    for PERCENT in steps:
        TB = 'test_'+DESIGN+'_'+BW_+'_'+str(PERCENT)+'percent.v'
        PATH_TB = RTL_PATH+'/characterization/'+TB
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

    os.chdir(WORK_PATH)
    pstr = ""
    for i in steps: pstr = pstr + str(i) + " " #THE LIST OF %toggle ACTIVITIES
    pstr = pstr.strip()
    # POWER
    os.system('joules -overwrite -batch -execute "set BW '+BW_+'" -execute "set listPERCENT {'+pstr+'}" -files {"./../tcl/power/power_'+DESIGN+'.tcl"} -legacy_ui')
    os.chdir(SIM_PATH)
    os.system('rm *.vcd')
