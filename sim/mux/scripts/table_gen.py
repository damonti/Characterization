#This parses the reports from jules and creates a dataframe with the features 

import os
import pandas as pd

def area_to_list(CONFIGS):
    """Returns a list of the area numbers"""
    RPT_PATH = os.path.expanduser("~/Estimation/sim/mux/reports")
    targets = []
    for CONFIG in range (0, len(CONFIGS)):
        file_path = RPT_PATH + "/" +str(CONFIGS[CONFIG][0])+ "-1_" + str(CONFIGS[CONFIG][1]) + "BW_netlist.area.rpt" #pick the corresponding area for the corresponding configuration
        with open(file_path, 'r', encoding='utf-8') as f:
            data = f.readlines()
            targets.append(data[13].strip().split()[12]) #append all the power numbers from the reports in a list
    targets_float = [format(float(i), ".3f") for i in targets] #i is in nW, T_clk is 10ns, to retrieve energy in fJ, simply divide by 100.
    return targets_float

def pwr_to_list(CONFIGS):
    """Returns a list of the dynamic power numbers"""
    RPT_PATH = os.path.expanduser("~/Estimation/sim/mux/reports")
    targets = []
    for CONFIG in range (0, len(CONFIGS)):
        #file_path = RPT_PATH + "/mux.mux_" + str(CONFIGS[CONFIG][0]) + "-1_" + str(CONFIGS[CONFIG][1]) + "BW_" + str(CONFIGS[CONFIG][2]) + "percent_payload.rpt"
        file_path = RPT_PATH + "/mux.mux_"+ str(CONFIGS[CONFIG][0]) +"-1_" + str(CONFIGS[CONFIG][1]) + "BW_" + str(CONFIGS[CONFIG][2]) + "percent_payload.rpt"
        with open(file_path, 'r', encoding='utf-8') as f:
            data = f.readlines()
            targets.append(data[17].strip().split()[4])
    targets_float = [format(float(i)/100, ".4f") for i in targets] #i is in nW, T_clk is 10ns, to retrieve energy in fJ, simply divide by 100.
    return targets_float


def config_generation(IN):
    """It returns a list of lists with the 3 parameters of the mux sweeping in order"""
    MAX_BITWIDTH = 32 #up to 64
    SUB_LIST = []
    LIST = []
    for INPUT in range(2, IN+1): #the mux has 2, 3 or 4 input ports
        for BW in range(8, MAX_BITWIDTH+1): #SWEEP THROUGH BITWIDTHS
            min_step = 100/BW  # minimum percentage step
            for i in range(1, BW+1):  # SWEEP THOROUGH PERCENTAGES
                SUB_LIST = [INPUT, BW, round(min_step*i)]
                #SUB_LIST = [BW, round(min_step*i)]
                LIST.append(SUB_LIST)
    return LIST

IN = 4 #specify the highest nuber of inputs of the mux
CONFIGS = config_generation(IN) #generate the mux configurations
ENERGY_TARGETS = pwr_to_list(CONFIGS) #generate a csv out of the power data. the CONFIGS is needed to find the parametrized report name
AREA_TARGETS = area_to_list(CONFIGS)

#DATA FRAME
#header = ['INPUT', 'BW', 'PERCENTAGE']
header = ['technology [nm]', 'latency [ns]', 'datawidth', 'n_inputs', 'num_pipeline_stages', 'toggling activity [%]', 'action', 'energy [fJ]', 'area [um^2]']
df = pd.DataFrame(columns=header)
df['energy [fJ]'] = ENERGY_TARGETS
df['datawidth'] = [item[1] for item in CONFIGS]
df['technology [nm]'] = '40'
df['latency [ns]'] = '10'
df['n_inputs'] = [item[0] for item in CONFIGS]
df['num_pipeline_stages'] = '0'
df['toggling activity [%]'] = [item[2] for item in CONFIGS]
df['action'] = 'transfer'
df['energy [fJ]'] = ENERGY_TARGETS
df['area [um^2]'] = AREA_TARGETS
#print (df)
PATH = os.path.expanduser("~/Estimation/tables/")
df.to_csv(PATH + 'mux.csv', index=False)


#MUX_PATH = os.path.expanduser("~/Estimation/sim/mux")
#with open(MUX_PATH+"daje.txt", 'w') as wr:
#    for x in TARGETS:
#        wr.write(str(x) + "\n")
#    wr.close()
#print (TARGETS)






