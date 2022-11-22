#########################
#Here you should compute the power of the whole 
# design and compare it with the estimated and vectorless ones
########################
import sys
import os
from random import randint

def rnd_coeff(BW):
    """returns a random string of bits of the specified BW"""
    coeff_list = [] 
    for j in range(BW):
            coeff_list.append(randint(0,1))
    coeff = [str(i) for i in coeff_list] #convert list elements into str
    return ''.join(coeff) #join the elements into a vector


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

TOGGLES = [5, 10, 20, 25, 33, 50, 55, 66, 75, 90, 100]
REPS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
for TOGGLE in TOGGLES: #take one toggle rate
    for REP in REPS:
        #Generate stimuli for given toggle_rate and bitwidth
        os.chdir(SCRIPT_PATH)
        os.system("python3 ./design_stim_vector_gen.py "+DESIGN+" "+str(TOGGLE)+" "+str(BW))

        #for RND_COEFF in ['00000001', '00000010', '00000100', '00001000', '00010000', '00100000', '01000000', '10000000', '11110000', '00001111', '11111111', '00000000']:    
        RND_COEFF = "rnd"

        #RND_COEFF = rnd_coeff(BW) #this returns a random string of bits of the specified BW
    #update run.tcl with the new toggle rate
        with open(SIM_PATH+'/run_xcelium/run.tcl', 'w') as wr:
            wr.write("dumptcf -output /home/20200969/Estimation/sim/"+DESIGN+"/design/tcf/"+DESIGN+"_"+str(TOGGLE)+"percent_rep"+str(REP)+".tcf -scope /tb_fir -dumpportsonly -eot -overwrite \nrun \ndumptcf -end \nexit")
        wr.close()

    # #update testbench with new random coefficients
    #         #CHANGE THE $DESIGN.v FOR THE CHOSEN CONFIGURATION AND WRITE IT INTO $DESIGN_temp.v
        
    #     # with open(RTL_PATH+'/tb_fir.v', 'r') as f:
    #     #     lines = f.readlines()
    #     #     # print(lines)
    #     #     # for k in range(0, len(lines)):
    #     #     #     if lines[k].startswith("    H0"):
    #     #     #         lines[k] = '    H0 <= {8\'b'+str(RND_COEFF)+'}; \n'
    #     #     #     if lines[k].startswith("    H1"):
    #     #     #         lines[k] = '    H1 <= {8\'b'+str(RND_COEFF)+'}; \n'
    #     #     #     if lines[k].startswith("    H2"):
    #     #     #         lines[k] = '    H2 <= {8\'b'+str(RND_COEFF)+'}; \n'
    #     #     #     if lines[k].startswith("    H3"):
    #     #     #         lines[k] = '    H3 <= {8\'b'+str(RND_COEFF)+'}; \n'
    #     #     with open(RTL_PATH+'/tb_fir_temp.v', 'w') as wr:
    #     #         wr.writelines(lines)
    #     # wr.close()
    #     # f.close()


        #execute simulation
        os.chdir(SIM_PATH+"/run_xcelium")
        os.system("xrun -clean -access rwc -input run.tcl -timescale 1ns/1ns -ALLOWREDEFINITION "+RTL_PATH+"/fir.v "+RTL_PATH+"/tb_fir.v "+RTL_PATH+"/adder.v "+RTL_PATH+"/mul.v")


    # JOULES_REPS = ""
    # for i in REPS: JOULES_REPS = JOULES_REPS + str(i) + " " #THE LIST OF %toggle ACTIVITIES
    # JOULES_REPS = JOULES_REPS.strip()
    
    
    os.chdir(WORK_PATH)
    os.system('joules -overwrite -batch -execute "set TOGGLE '+str(TOGGLE)+'" -files {"./../tcl/power/power_'+DESIGN+'.tcl"} -legacy_ui')