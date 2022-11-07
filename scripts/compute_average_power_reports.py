import os
import sys
import pandas as pd

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

def parse_area_reports(REPORTS_PATH, UNIT):
    temp = []
    with open(REPORTS_PATH+'/'+UNIT+'_area.rpt', 'r') as rd:
        data = rd.readlines()
        temp.append(data[13].strip().split()[4])
    rd.close()
    for i in temp: temp_float = float(i)   #from scientific to float (but still string type)
    AREA_NUMBERS = temp_float
    return AREA_NUMBERS

if len (sys.argv) != 4:
    print ("Usage: script.py <DESIGN> <UNIT> <BW>")
    sys.exit (1)

#DEFINE
DESIGN = str(sys.argv[1])
UNIT = str(sys.argv[2])
BW = int(sys.argv[3])
REPORTS_PATH = os.path.expanduser("~/Estimation/sim/"+DESIGN+"/components/"+UNIT+"/reports")
DATAFRAME_PATH = os.path.expanduser("~/Estimation/sim/"+DESIGN+"/components/"+UNIT+"/dataframe")
REPETITIONS = list(range(0, 100))
TOGGLES = list(range(1, 101))


POWER_NUMBERS = []
AREA_NUMBERS = 0
print("Parsing power numbers... ")
POWER_NUMBERS = parse_power_reports(TOGGLES, REPETITIONS, REPORTS_PATH, UNIT)
print("Done \n")
print("Parsing area numbers... ")
AREA_NUMBERS = parse_area_reports(REPORTS_PATH, UNIT)
print("Done \n")

print("Saving to dataframe... \n")
header = ['BW', 'alpha', 'Power [nW]', 'Area [um^2]']
data = []
for percent, pwr in zip(TOGGLES, range(0,100)):
    data.append([BW, percent, POWER_NUMBERS[pwr], AREA_NUMBERS])

df = pd.DataFrame(data, columns=header)
print(df)  
df.to_csv(DATAFRAME_PATH+'/'+UNIT+'.csv', index=False)
print("Saved in: "+DATAFRAME_PATH+"\n")


