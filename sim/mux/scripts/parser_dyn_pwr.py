import os

def pwr_to_list(CONFIGS):
    """Returns a list of the dynamic power numbers"""
    RPT_PATH = os.path.expanduser("~/Estimation/sim/mux/reports")
    targets = []
    for CONFIG in range (0, len(CONFIGS)):
        file_path = RPT_PATH + "/mux.mux_" + str(CONFIGS[CONFIG][0]) + "-1_" + str(CONFIGS[CONFIG][1]) + "BW_" + str(CONFIGS[CONFIG][2]) + "percent_payload.rpt"
        with open(file_path, 'r', encoding='utf-8') as f:
            data = f.readlines()
            targets.append(data[17].strip().split()[4]) 
    return targets



# line = "   74 7.37677e+00 2.92304e+03 7.81901e+03 1.07420e+04 1.07494e+04 /mux    "
# line = line.strip().split()[4]
# print (line)
# print (line[0])

def config_generation():
    """It returns a list of lists with the 3 parameters of the mux sweeping in order"""
    MAX_BITWIDTH = 64
    SUB_LIST = []
    LIST = []
    IN = 2
    for BW in range(8, MAX_BITWIDTH+1): #SWEEP THROUGH BITWIDTHS
        min_step = 100/BW  # minimum percentage step
        for i in range(1, BW+1):  # SWEEP THOROUGH PERCENTAGES
            SUB_LIST = [IN, BW, round(min_step*i)]
            LIST.append(SUB_LIST)
    return LIST


CONFIGS = config_generation() #generate the mux configurations
TARGETS = pwr_to_list(CONFIGS) #generate a csv out of the power data. the CONFIGS is needed to find the parametrized report name

# MUX_PATH = os.path.expanduser("~/Estimation/sim/mux")
# with open(MUX_PATH+"daje.txt", 'w') as wr:
#     for x in TARGETS:
#         wr.write(x + "\n")
#     wr.close()
#print (TARGETS)






