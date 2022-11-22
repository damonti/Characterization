import os
import sys
import pandas as pd
##############
#PARSE 100 POWER REPORTS FOR THE GIVEN TOGGLE AND RETURN AVERAGE
###############

def parse_power_reports(TOGGLES, REPETITIONS, REPORTS_PATH, UNIT):
    for TOGGLE in TOGGLES: #take one toggle rate
        temp = []
        for rep in REPETITIONS:
            with open(REPORTS_PATH+'/'+UNIT+'_'+str(TOGGLE)+'percent_#'+str(rep)+'_avg.rpt', 'r') as rd:
                data = rd.readlines()
                temp.append(data[5].strip().split()[1])
            rd.close()
        temp_float = [float(i) for i in temp]  #from scientific to float (but still string type)
        avg = sum(temp_float)/len(temp_float)
        POWER_NUMBERS.append(round(avg,2))
    return POWER_NUMBERS



DESIGN = "fir_8bit"
UNIT = "multiplier"
REPORTS_PATH = os.path.expanduser("~/Estimation/sim/"+DESIGN+"/components/"+UNIT+"/reports")
#DATAFRAME_PATH = os.path.expanduser("~/Estimation/sim/"+DESIGN+"/components/"+UNIT+"/dataframe")
#REPETITIONS = list(range(1, 100))
REPETITIONS = [15]
TOGGLES = [100]
POWER_NUMBERS = []
POWER_NUMBERS = parse_power_reports(TOGGLES, REPETITIONS, REPORTS_PATH, UNIT)
print("Average power across 100 reps = "+str(POWER_NUMBERS))