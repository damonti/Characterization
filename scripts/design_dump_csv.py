import os
import pandas as pd
import sys

if len(sys.argv)!= 2:
    print("Usage: script.py <DESIGN> ")
    sys.exit(1)

DESIGN = str(sys.argv[1])


TOGGLES = [5, 10, 20, 25, 33, 50, 55, 66, 75, 90, 100]
REPS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
DATAFRAMEPATH = "/home/20200969/Estimation/tables/"+DESIGN+"/gt"

for TOGGLE in TOGGLES:
    for REP in REPS:
        FILE = "/home/20200969/Estimation/sim/"+DESIGN+"/design/tcf/"+DESIGN+"_"+str(TOGGLE)+"percent_rep"+str(REP)+".tcf"

        #print("Activity parsed from: "+FILE+" ")
        os.system("python3 ./tcf_parser_ensemble.py "+DESIGN+" "+FILE+" .")
        
        #print("Dataframe dumped as csv. \n ")
        df_toggle = pd.read_csv('design_toggle_ensemble_temp.csv', sep=',')
        #print(df_toggle)
        
        #PARSE GIVEN RPT RETURNING TUPLE [INSTANCE, PWR]
        FILE = "/home/20200969/Estimation/sim/"+DESIGN+"/design/reports/"+DESIGN+"_"+str(TOGGLE)+"percent_avg_rep"+str(REP)+".rpt"
        #print("Power parsed from: "+FILE+" ")
        os.system("python3 ./design_rpt_parser.py "+DESIGN+" "+FILE+" .")
        df_power = pd.read_csv("design_power_temp.csv", sep=",")

        df_merged = pd.merge(df_toggle, df_power, on='Components')
        #print(df_merged)
        print("Dumped dataframe for "+DESIGN+"_"+str(TOGGLE)+"percent_rep"+str(REP))
        
        df_merged.to_csv(DATAFRAMEPATH+"/"+DESIGN+"_"+str(TOGGLE)+"percent_rep"+str(REP)+".csv", sep=',')
        # print("alpha_output: "+FILE+" ")
        # os.system("python3 ./tcf_parser_outputbits.py "+FILE+" .")
        # print("alpha_inputoutput: "+FILE+" ")
        # os.system("python3 ./tcf_parser_inputoutputbits.py "+FILE+" . ")
        # print("alpha_inputoutput_weight: "+FILE+" ")
        # os.system("python3 ./tcf_parser_inputoutputbits_weights.py "+FILE+" . ")
        
        #missing: registers and fir filter 
        # 1) parse register names
        # 2) add filter
        # 3) sort by Name
        # 4) parse power report