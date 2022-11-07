#########################
#Here you should compute the power of the whole 
# design and compare it with the estimated and vectorless ones
########################
import sys
import os
if len(sys.argv)!= 3:
    print("Usage: script.py <DESIGN> <BW> ")
    sys.exit(1)

DESIGN = str(sys.argv[1])
BW = int(sys.argv[2]) #Remember: for add and mul the BW is double
#toggle_rate = int(sys.argv[3])


SCRIPT_PATH = os.path.expanduser("~/Estimation/scripts")
SIM_PATH = os.path.expanduser("~/Estimation/sim/"+DESIGN+"/design")
RTL_PATH = os.path.expanduser("~/Estimation/rtl/"+DESIGN+"/design")
WORK_PATH = os.path.expanduser("~/Estimation/work")
TCL_PATH = os.path.expanduser("~/Estimation/tcl")


isdir = os.path.isdir(SIM_PATH)
if not isdir:  
    print("Error, invalid arguments. Check directory tree. \nUsage: script.py <DESIGN> <UNIT> <BW>")
    sys.exit(1)


#GENERATE RANDOM TOGGLES
TOGGLES = [10, 100]
for TOGGLE in TOGGLES: #take one toggle rate
    
    #Generate stimuli for given toggle_rate and bitwidth
    os.chdir(SCRIPT_PATH)
    os.system("python3 ./stim_vector_gen_design.py "+DESIGN+" "+str(TOGGLE)+" "+str(BW))


#update run.tcl with the new toggle rate
    with open(SIM_PATH+'/run_xcelium/run.tcl', 'w') as wr:
        wr.write("dumptcf -output /home/20200969/Estimation/sim/"+DESIGN+"/design/tcf/"+DESIGN+"_"+str(TOGGLE)+"percent.tcf -scope /tb_fir -dumpportsonly -overwrite \nrun \ndumptcf -end \nexit")
    wr.close()

#execute simulation
    os.chdir(SIM_PATH+"/run_xcelium")
    os.system("xrun -clean -access rwc -input run.tcl -timescale 1ns/10ps -ALLOWREDEFINITION "+RTL_PATH+"/fir.v "+RTL_PATH+"/tb_fir.v "+RTL_PATH+"/adder.v "+RTL_PATH+"/mul.v")

os.chdir(WORK_PATH)
# #POWER ESTIMATION
# #change power.tcl with the new toggle rate
# with open(TCL_PATH+'/power/power_'+DESIGN+".tcl", 'r') as f:
#     lines = f.readlines()
#     for k in range(0, len(lines)):
#         if ("read_stimulus -format tcf" in lines[k]):
#             lines[k] = 'read_stimulus -format tcf -file ${SIM_PATH}/tcf/'+DESIGN+'_'+str(toggle_rate)+'percent.tcf -report_missing_signals all -sdb_out ${SIM_PATH}/tcf/sdb/stimulus.sdb -resim_cg_enables \n'
#         if ("report_power -by_hierarchy" in lines[k]):
#             lines[k] = 'report_power -by_hierarchy -unit nW -cols "cells static internal switching dynamic total" -out /home/20200969/Estimation/sim/fir_8bit/reports/fir_Mul_8Ux8U_12U_4_'+str(toggle_rate)+'percent_avg.rpt \n'
# f.close()

# with open(TCL_PATH+'/power/power_'+DESIGN+'.tcl', 'w') as wr:
#      wr.writelines(lines)
# wr.close()

#os.system('joules -overwrite -files {"./../tcl/power/power_'+DESIGN+'.tcl"} -legacy_ui')

JOULES_TOGGLES = ""
for i in TOGGLES: JOULES_TOGGLES = JOULES_TOGGLES + str(i) + " " #THE LIST OF %toggle ACTIVITIES
JOULES_TOGGLES = JOULES_TOGGLES.strip()

os.system('joules -overwrite -batch -execute "set TOGGLES {'+JOULES_TOGGLES+'}" -files {"./../tcl/power/power_'+DESIGN+'.tcl"} -legacy_ui')