#This parses the reports from jules and creates a dataframe with the features 

import os
import pandas as pd

def pwr_to_list(CONFIGS):
    """Returns a list of the dynamic power numbers"""
    RPT_PATH = os.path.expanduser("~/Estimation/sim/adder/reports")
    targets = []
    for CONFIG in range (0, len(CONFIGS)):
        file_path = RPT_PATH + "/adder_" + str(CONFIGS[CONFIG][0]) + "BW_" + str(CONFIGS[CONFIG][1]) + "percent_payload.rpt"
        with open(file_path, 'r', encoding='utf-8') as f:
            data = f.readlines()
            targets.append(data[17].strip().split()[4])
    targets_float = [format(float(i)/1000, ".4f") for i in targets]
    return targets_float


def config_generation():
    """It returns a list of lists with the 3 parameters of the adder sweeping in order"""
    MAX_BITWIDTH = 64
    SUB_LIST = []
    LIST = []
    for BW in range(8, MAX_BITWIDTH+1, 2): #SWEEP THROUGH BITWIDTHS
        min_step = 100/BW  # minimum percentage step
        for i in range(1, BW+1):  # SWEEP THOROUGH PERCENTAGES
            #SUB_LIST = [IN, BW, round(min_step*i)]
            SUB_LIST = [BW, round(min_step*i)] #SUBLIST = [BW, PERCENTAGE]
            LIST.append(SUB_LIST)
    return LIST


CONFIGS = config_generation() #generate the adder configurations
TARGETS = pwr_to_list(CONFIGS) #generate a csv out of the power data. the CONFIGS is needed to find the parametrized report name

#DATA FRAME
#header = ['INPUT', 'BW', 'PERCENTAGE']
header = ['BW', 'PERCENTAGE']
df = pd.DataFrame(CONFIGS, columns=header)
df['POWER [nW]'] = TARGETS
#print (df)
PATH = os.path.expanduser("~/Estimation/sim/adder/dataframe")
df.to_csv(PATH + '/adder_configurations.csv', index=False)







