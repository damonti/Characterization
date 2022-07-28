#This parses the reports from jules and creates a dataframe with the features 

import os
import pandas as pd


def area_to_list(CONFIGS):
    """Returns a list of the area numbers"""
    RPT_PATH = os.path.expanduser("~/Estimation/sim/multiplier/reports")
    targets = []
    for CONFIG in range (0, len(CONFIGS)):
        file_path = RPT_PATH + "/multiplier_" + str(CONFIGS[CONFIG][1]) + "BW_" + str(CONFIGS[CONFIG][0])+ "pip_netlist.area.rpt"
        with open(file_path, 'r', encoding='utf-8') as f:
            data = f.readlines()
            targets.append(data[13].strip().split()[12]) #append all the power numbers from the reports in a list
    targets_float = [format(float(i), ".3f") for i in targets] #i is in nW, T_clk is 10ns, to retrieve energy in fJ, simply divide by 100.
    return targets_float


def pwr_to_list(CONFIGS):
    """Returns a list of the dynamic power numbers"""
    RPT_PATH = os.path.expanduser("~/Estimation/sim/multiplier/reports")
    targets = []
    for CONFIG in range (0, len(CONFIGS)):
        file_path = RPT_PATH + "/multiplier_" + str(CONFIGS[CONFIG][1]) + "BW_" + str(CONFIGS[CONFIG][0])+ "pip_"  +str(CONFIGS[CONFIG][2]) + "percent_payload.rpt"
        with open(file_path, 'r', encoding='utf-8') as f:
            data = f.readlines()
            targets.append(data[17].strip().split()[4]) #append all the power numbers from the reports in a list
    targets_float = [format(float(i)/100, ".4f") for i in targets] #i is in nW, T_clk is 10ns, to retrieve energy in fJ, simply divide by 100.
    return targets_float


def config_generation():
    """It returns a list of lists with the 3 parameters of the multiplier sweeping in order"""
    MAX_BITWIDTH = 64
    SUB_LIST = []
    LIST = []
    PIPELINE = 1
    #for PIPELINE in range(0, 3):
    for BW in range(8, MAX_BITWIDTH+1, 2): #SWEEP THROUGH BITWIDTHS
        min_step = 100/BW  # minimum percentage step
        for i in range(1, BW+1):  # SWEEP THOROUGH PERCENTAGES
            SUB_LIST = [PIPELINE, BW, round(min_step*i)] #SUBLIST = [BW, PERCENTAGE]
            LIST.append(SUB_LIST)
    return LIST


CONFIGS = config_generation() #generate the multiplier configurations
ENERGY_TARGETS = pwr_to_list(CONFIGS) #generate a csv out of the power data. the CONFIGS is needed to find the parametrized report name
AREA_TARGETS = area_to_list(CONFIGS)

#DATA FRAME
header = ['technology [nm]', 'latency [ns]', 'datawidth', 'num_pipeline_stages', 'toggling activity [%]', 'action', 'energy [fJ]', 'area [um^2]']
#df = pd.DataFrame(CONFIGS, columns=header)
df = pd.DataFrame(columns=header)

df['datawidth'] = [item[1] for item in CONFIGS]
df['technology [nm]'] = '40'
df['latency [ns]'] = '10'
df['num_pipeline_stages'] = [item[0] for item in CONFIGS]
df['toggling activity [%]'] = [item[2] for item in CONFIGS]
df['action'] = 'mul'
df['energy [fJ]'] = ENERGY_TARGETS
df['area [um^2]'] = AREA_TARGETS

#print (df)
PATH = os.path.expanduser("~/Estimation/tables/")
df.to_csv(PATH + 'int_multiplier.csv', index=False)







