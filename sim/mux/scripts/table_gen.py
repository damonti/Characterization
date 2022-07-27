#This parses the reports from jules and creates a dataframe with the features 

import os
import pandas as pd

def pwr_to_list(CONFIGS):
    """Returns a list of the dynamic power numbers"""
    RPT_PATH = os.path.expanduser("~/Estimation/sim/mux/reports")
    targets = []
    for CONFIG in range (0, len(CONFIGS)):
        #file_path = RPT_PATH + "/mux.mux_" + str(CONFIGS[CONFIG][0]) + "-1_" + str(CONFIGS[CONFIG][1]) + "BW_" + str(CONFIGS[CONFIG][2]) + "percent_payload.rpt"
        file_path = RPT_PATH + "/mux.mux_2-1_" + str(CONFIGS[CONFIG][0]) + "BW_" + str(CONFIGS[CONFIG][1]) + "percent_payload.rpt"
        with open(file_path, 'r', encoding='utf-8') as f:
            data = f.readlines()
            targets.append(data[17].strip().split()[4])
    targets_float = [format(float(i)/100, ".4f") for i in targets] #i is in nW, T_clk is 10ns, to retrieve energy in fJ, simply divide by 100.
    return targets_float


def config_generation(IN):
    """It returns a list of lists with the 3 parameters of the mux sweeping in order"""
    MAX_BITWIDTH = 64
    SUB_LIST = []
    LIST = []
    #IN = 2
    for BW in range(8, MAX_BITWIDTH+1): #SWEEP THROUGH BITWIDTHS
        min_step = 100/BW  # minimum percentage step
        for i in range(1, BW+1):  # SWEEP THOROUGH PERCENTAGES
            #SUB_LIST = [IN, BW, round(min_step*i)]
            SUB_LIST = [BW, round(min_step*i)]
            LIST.append(SUB_LIST)
    return LIST

IN=2
CONFIGS = config_generation(IN) #generate the mux configurations
TARGETS = pwr_to_list(CONFIGS) #generate a csv out of the power data. the CONFIGS is needed to find the parametrized report name

#DATA FRAME
#header = ['INPUT', 'BW', 'PERCENTAGE']
header = ['technology [nm]', 'latency [ns]', 'datawidth', 'n_inputs', 'num_pipeline_stages', 'toggling activity [%]', 'action', 'energy [fJ]', 'area [um^2]']
df = pd.DataFrame(columns=header)
df['energy [fJ]'] = TARGETS
df['datawidth'] = [item[0] for item in CONFIGS]
df['technology [nm]'] = '45'
df['latency [ns]'] = '10'
df['n_inputs'] = IN
df['num_pipeline_stages'] = '0'
df['toggling activity [%]'] = [item[1] for item in CONFIGS]
df['action'] = 'add'
df['energy [fJ]'] = TARGETS
df['area [um^2]'] = '0'
#print (df)
PATH = os.path.expanduser("~/Estimation/tables/")
df.to_csv(PATH + 'mux.csv', index=False)


#MUX_PATH = os.path.expanduser("~/Estimation/sim/mux")
#with open(MUX_PATH+"daje.txt", 'w') as wr:
#    for x in TARGETS:
#        wr.write(str(x) + "\n")
#    wr.close()
#print (TARGETS)






