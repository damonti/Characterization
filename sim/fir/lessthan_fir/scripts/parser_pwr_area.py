#This parses the reports from jules and creates a dataframe with the features 

import os
import pandas as pd

def area_to_list(CONFIGS, SIM_PATH):
    """Returns a list of the area numbers"""
    RPT_PATH = SIM_PATH+"/reports"
    targets = []
    for CONFIG in range (0, len(CONFIGS)):
        file_path = RPT_PATH + "/" +DESIGN+ "_" + str(CONFIGS[CONFIG][0]) + "BW_netlist.area.rpt" #pick the corresponding area for the corresponding configuration
        with open(file_path, 'r', encoding='utf-8') as f:
            data = f.readlines()
            targets.append(data[13].strip().split()[12]) #append all the power numbers from the reports in a list
    targets_float = [format(float(i), ".3f") for i in targets] #i is in nW, T_clk is 10ns, to retrieve energy in fJ, simply divide by 100.
    return targets_float

def pwr_to_list(CONFIGS, SIM_PATH):
    """Returns a list of the dynamic power numbers"""
    RPT_PATH = SIM_PATH+"/reports"
    targets = []
    for CONFIG in range (0, len(CONFIGS)):
        file_path = RPT_PATH + "/" +DESIGN+ "_" + str(CONFIGS[CONFIG][0]) + "BW_" + str(CONFIGS[CONFIG][1]) + "percent_avg.rpt"
        with open(file_path, 'r', encoding='utf-8') as f:
            data = f.readlines()
            targets.append(data[17].strip().split()[4])
    targets_float = [format(float(i), ".4f") for i in targets] #i is in nW, T_clk is 10ns, to retrieve energy in fJ, simply divide by 100.
    return targets_float


def config_generation():
    """It returns a list of lists with the 3 parameters of the adder sweeping in order"""
    MAX_BITWIDTH = 16
    SUB_LIST = []
    LIST = []
    for BW in range(2, MAX_BITWIDTH+1, 2): #SWEEP THROUGH BITWIDTHS
        min_step = 100/BW  # minimum percentage step
        for i in range(1, BW+1):  # SWEEP THOROUGH PERCENTAGES
            #SUB_LIST = [IN, BW, round(min_step*i)]
            SUB_LIST = [BW, round(min_step*i)] #SUBLIST = [BW, PERCENTAGE]
            LIST.append(SUB_LIST)
    return LIST


DESIGN ="lessthan_fir"
SIM_PATH = os.path.expanduser("~/Estimation/sim/fir/"+DESIGN)
CONFIGS = config_generation() #generate the adder configurations
POWER_TARGETS = pwr_to_list(CONFIGS, SIM_PATH) #generate a csv out of the power data. the CONFIGS is needed to find the parametrized report name
AREA_TARGETS = area_to_list(CONFIGS, SIM_PATH)

#DATA FRAME
header = ['BW', 'PERCENTAGE']
df = pd.DataFrame(CONFIGS, columns=header)
df['Area [um^2]'] = AREA_TARGETS
df['Power [nW]'] = POWER_TARGETS

#print (df)
PATH = SIM_PATH +"/dataframe"
df.to_csv(PATH + '/'+DESIGN+'_configurations.csv', index=False)







