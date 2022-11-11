#########################
#Here you should compute the power of the whole 
# design and compare it with the estimated and vectorless ones
########################
import sys
import os
import pandas as pd
import numpy as np
import pickle

def power_inference(instance, toggle):
    
    if instance.startswith("add"):
        MODEL_PATH = os.path.expanduser("/home/20200969/Estimation/sim/fir_8bit/components/adder/dataframe/adder_power_model")      
    elif instance.startswith("mul"):
        MODEL_PATH = os.path.expanduser("/home/20200969/Estimation/sim/fir_8bit/components/multiplier/dataframe/multiplier_power_model")
    else:
        print("Attention! this instance ("+instance+") do not have an associated model! Check the path")
        sys.exit(1)
    
    with open (MODEL_PATH, 'rb') as ml:
        model = pickle.load(ml)
    ml.close()
    y_pred = model.predict([[toggle]])
    return float(y_pred)

def parse_power_reports(TOGGLE, REPORTS_PATH, UNIT, N_INSTANCES):
    instances_tuple = []
    i=0
    with open(REPORTS_PATH+'/'+UNIT+'_'+str(TOGGLE)+'percent_avg.rpt', 'r') as rd:
        lines = rd.readlines()
        for line in lines: 
            if line.startswith("Cells"):
                i = lines.index(line) 
            
                for j in range(0, N_INSTANCES):
                    pwr = float(lines[i+2+j].strip(" ").split(" ")[1])
                    print("pwr_"+str(j)+" = "+str(pwr))
                    inst_name = lines[i+2+j].strip("\n").split("/")[-1].strip(" ")
                    print("inst_name_"+str(j)+" = "+inst_name)
                    #print(temp.split("  ")[-1])
                    instances_tuple.append([inst_name, round(pwr,2)])
    rd.close()
    return instances_tuple

# def parse_area_reports(REPORTS_PATH, UNIT):
#     temp = []
#     with open(REPORTS_PATH+'/'+UNIT+'_area.rpt', 'r') as rd:
#         data = rd.readlines()
#         temp.append(data[13].strip().split()[4])
#     rd.close()
#     for i in temp: temp_float = float(i)   #from scientific to float (but still string type)
#     AREA_NUMBERS = temp_float
#     return AREA_NUMBERS




if len(sys.argv)!= 3:
    print("Usage: script.py <DESIGN> <BW> ")
    sys.exit(1)

DESIGN = str(sys.argv[1])
BW = int(sys.argv[2]) #Remember: for add and mul the BW is double
#toggle_rate = int(sys.argv[3])


SCRIPT_PATH = os.path.expanduser("~/Estimation/scripts")
SIM_PATH = os.path.expanduser("~/Estimation/sim/"+DESIGN+"/design")
DF_PATH = os.path.expanduser("~/Estimation/sim/"+DESIGN+"/design/dataframe")
RTL_PATH = os.path.expanduser("~/Estimation/rtl/"+DESIGN+"/design")
REPORTS_PATH = SIM_PATH+"/reports"
WORK_PATH = os.path.expanduser("~/Estimation/work")
TCL_PATH = os.path.expanduser("~/Estimation/tcl")


isdir = os.path.isdir(SIM_PATH)
if not isdir:  
    print("Error, invalid arguments. Check directory tree. \nUsage: script.py <DESIGN> <BW>")
    sys.exit(1)


#GENERATE RANDOM TOGGLES
TOGGLES = [10, 25, 30, 50, 75, 100]
for TOGGLE in [10]: #take one toggle rate
    
    #PARSE EACH TCF AND RETURN DATAFRAME WITH GT ALONGSIDE ESTIMATIONS
    
    #Get components' names
    #os.system("python3 tcf_parser.py /home/20200969/Estimation/sim/"+DESIGN+"/design/tcf/"+DESIGN+"_"+TOGGLE+"percent.tcf "+DF_PATH+" ") #dump csv with instance,toggle;
    df = pd.read_csv(DF_PATH+'/instname_toggle.csv')
    df = df.set_index("Components")
    #add one row for the topmodule with the toggle 
    df.loc['fir'] = TOGGLE
    N_INSTANCES = 8
    print(df)
    #get GT and append to df
    gt_power = parse_power_reports(TOGGLE, REPORTS_PATH, DESIGN, N_INSTANCES)
    print(gt_power)
    df["GT"] = np.nan
    print(df)
    for i in range(0, len(df)):
        #ACCESSING IT BY LABEL (much easier)
        df.at[gt_power[i][0], 'GT'] = gt_power[i][1]
        #IF YOU WANT TO ACCESS BY INTEGER#
        #df_inst_index = df.index.get_loc(gt_power[i][0]) #index of the instance in the dataframe
        #df.iat[df_inst_index, 1]= gt_power[i][1]
       
    print(df)
    
    #get est and append to df
    est_power = []
    toggles = []
    for i in range(0, len(df)-1): #-1 because the last one is the fir that i do not estimate by inference but by summation 
        toggles.append(df.iloc[i, 0]) #get toggles in order
    instances = list(df.index.values)
    print(instances)
    print(toggles)
    
    for i in range(0, len(df)-1): #-1 because the last one is the fir that i do not estimate by inference but by summation 
        temp = power_inference(instances[i], toggles[i])
        print(temp)
        est_power.append(temp)
    print(est_power)
    #compute fir (las one) by summing all the above estimated power
    fir_power = 0
    for i in est_power: fir_power += est_power[i]
    est_power.append(fir_power)
    
    #append to dataframe
    df["EST"] = est_power
    print(df)

    #get err wrt est

    #get vectorless and append to df
    
    #get err wrt vectorless
    
    #get gt area
    
    #get est area
    
    
    
    
#     #Generate stimuli for given toggle_rate and bitwidth
#     os.chdir(SCRIPT_PATH)
#     os.system("python3 ./stim_vector_gen_design.py "+DESIGN+" "+str(TOGGLE)+" "+str(BW))


# #update run.tcl with the new toggle rate
#     with open(SIM_PATH+'/run_xcelium/run.tcl', 'w') as wr:
#         wr.write("dumptcf -output /home/20200969/Estimation/sim/"+DESIGN+"/design/tcf/"+DESIGN+"_"+str(TOGGLE)+"percent.tcf -scope /tb_fir -dumpportsonly -overwrite \nrun \ndumptcf -end \nexit")
#     wr.close()

# #execute simulation
#     os.chdir(SIM_PATH+"/run_xcelium")
#     os.system("xrun -clean -access rwc -input run.tcl -timescale 1ns/10ps -ALLOWREDEFINITION "+RTL_PATH+"/fir.v "+RTL_PATH+"/tb_fir.v "+RTL_PATH+"/adder.v "+RTL_PATH+"/mul.v")


# JOULES_TOGGLES = ""
# for i in TOGGLES: JOULES_TOGGLES = JOULES_TOGGLES + str(i) + " " #THE LIST OF %toggle ACTIVITIES
# JOULES_TOGGLES = JOULES_TOGGLES.strip()
# os.chdir(WORK_PATH)
# os.system('joules -overwrite -batch -execute "set TOGGLES {'+JOULES_TOGGLES+'}" -files {"./../tcl/power/power_'+DESIGN+'.tcl"} -legacy_ui')