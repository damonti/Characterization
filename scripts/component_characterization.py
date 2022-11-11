import os
import sys

if len(sys.argv)!= 4:
    print("Usage: script.py <DESIGN> <UNIT> <BW>")
    sys.exit(1)

DESIGN = str(sys.argv[1])
UNIT = str(sys.argv[2])
BW = int(sys.argv[3]) #Remember: for add and mul the BW is double


SCRIPT_PATH = os.path.expanduser("~/Estimation/scripts")
SIM_PATH = os.path.expanduser("~/Estimation/sim/"+DESIGN+"/components/"+UNIT)
RTL_PATH = os.path.expanduser("~/Estimation/rtl/"+DESIGN+"/components/"+UNIT)
WORK_PATH = os.path.expanduser("~/Estimation/work")
TCL_PATH = os.path.expanduser("~/Estimation/tcl")
LOG_PATH = os.path.expanduser("~/Estimation/logs")
#Check if arguments are valid
isdir = os.path.isdir(SIM_PATH)
if not isdir:  
    print("Error, invalid arguments. Check directory tree. \nUsage: script.py <DESIGN> <UNIT> <BW>")
    sys.exit(1)

REPETITIONS = list(range(0, 10))
#TOGGLES = list(range(11, 12))
TOGGLES = [47.69]
for TOGGLE in TOGGLES: #take one toggle rate
    for rep in REPETITIONS: #repeat each toggle rate 100 times so that interleaving is averaged
        
        
        #Generate stimuli for given toggle_rate and bitwidth
        os.system("python3 "+SCRIPT_PATH+"/component_stim_vector_gen.py "+UNIT+" "+str(TOGGLE)+" "+str(BW))
 
        #update run.tcl with the new toggle rate
        with open(SIM_PATH+'/run_xcelium/run.tcl', 'w') as wr:
            wr.write("dumptcf -output "+SIM_PATH+"/tcf/"+UNIT+"_"+str(TOGGLE)+"percent_#"+str(rep)+".tcf -scope /tb_"+UNIT+" -dumpportsonly -overwrite \nrun \ndumptcf -end \nexit")
        wr.close()

        #execute simulation
        os.chdir(SIM_PATH+"/run_xcelium")
        os.system("xrun -clean -access rwc -input run.tcl -timescale 1ns/10ps -ALLOWREDEFINITION "+RTL_PATH+"/"+UNIT+".v "+RTL_PATH+"/tb_"+UNIT+".v")

    os.chdir(WORK_PATH)

# JOULES_TOGGLE_RATES = ""
# for i in TOGGLE_RATES: JOULES_TOGGLE_RATES = JOULES_TOGGLE_RATES + str(i) + " " #THE LIST OF TOGGLE_RATES
# JOULES_TOGGLE_RATES = JOULES_TOGGLE_RATES.strip()

# JOULES_REPETITIONS = ""
# for i in REPETITIONS: JOULES_REPETITIONS = JOULES_REPETITIONS + str(i) + " " #THE LIST OF REPS
# JOULES_REPETITIONS = JOULES_REPETITIONS.strip()

    os.system('joules -overwrite -batch -execute "set TOGGLE '+str(TOGGLE)+'" -files {"./../tcl/power/power_'+UNIT+'.tcl"} -legacy_ui')

print("Power and area reports saved in "+SIM_PATH+"\\reports \n")


#RETURN DATAFRAME FOR THE COMPONENT
#os.system("python3 "+SCRIPT_PATH+"/compute_average_power_reports.py "+DESIGN+" "+UNIT+" "+str(BW))

#DELETE TCF AND REPORTS
#print("Removing stimuli (.tcf) and reports... \n")
#os.system("rm "+SIM_PATH+"/reports/*.rpt")
#os.system("rm "+SIM_PATH+"/tcf/*.tcf")

#Hyperparameter tuning and choose the best to train model
#os.system("python3 "+SCRIPT_PATH+"/dump_model.py "+DESIGN+" "+UNIT)



