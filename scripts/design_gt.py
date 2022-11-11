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
    print("Error, invalid arguments. Check directory tree. \nUsage: script.py <DESIGN> <BW>")
    sys.exit(1)


#GENERATE RANDOM TOGGLES
#TOGGLES = [10, 25, 30, 50, 75, 100]
TOGGLES = ["11010011"]
for TOGGLE in TOGGLES: #take one toggle rate
    
    #Generate stimuli for given toggle_rate and bitwidth
    os.chdir(SCRIPT_PATH)
    os.system("python3 ./design_pseudo_random_generator.py "+DESIGN+" "+str(BW))


#update run.tcl with the new toggle rate
    with open(SIM_PATH+'/run_xcelium/run.tcl', 'w') as wr:
        wr.write("dumptcf -output /home/20200969/Estimation/sim/"+DESIGN+"/design/tcf/"+DESIGN+"_"+str(TOGGLE)+"percent.tcf -scope /tb_fir -dumpportsonly -overwrite \nrun \ndumptcf -end \nexit")
    wr.close()

#execute simulation
    os.chdir(SIM_PATH+"/run_xcelium")
    os.system("xrun -clean -access rwc -input run.tcl -timescale 1ns/10ps -ALLOWREDEFINITION "+RTL_PATH+"/fir.v "+RTL_PATH+"/tb_fir.v "+RTL_PATH+"/adder.v "+RTL_PATH+"/mul.v")


JOULES_TOGGLES = ""
for i in TOGGLES: JOULES_TOGGLES = JOULES_TOGGLES + str(i) + " " #THE LIST OF %toggle ACTIVITIES
JOULES_TOGGLES = JOULES_TOGGLES.strip()
os.chdir(WORK_PATH)
os.system('joules -overwrite -batch -execute "set TOGGLES {'+JOULES_TOGGLES+'}" -files {"./../tcl/power/power_'+DESIGN+'.tcl"} -legacy_ui')