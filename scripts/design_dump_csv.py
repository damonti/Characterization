import os
import pandas as pd
TOGGLES = [5, 10, 20, 25, 33, 50, 55, 66, 75, 90, 100]
REPS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
UNIT = "fir_32bit"
DATAFRAMEPATH = "/home/20200969/Estimation/tables/"+UNIT+"/gt"

for TOGGLE in TOGGLES:
    for REP in REPS:
        FILE = "/home/20200969/Estimation/sim/"+UNIT+"/design/tcf/"+UNIT+"_"+str(TOGGLE)+"percent_rep"+str(REP)+".tcf"

        #print("Activity parsed from: "+FILE+" ")
        os.system("python3 ./tcf_parser_ensamble.py "+UNIT+" "+FILE+" .")
        
        #print("Dataframe dumped as csv. \n ")
        df_toggle = pd.read_csv('design_toggle_ensamble_temp.csv', sep=',')
        #print(df_toggle)
        
        #PARSE GIVEN RPT RETURNING TUPLE [INSTANCE, PWR]
        FILE = "/home/20200969/Estimation/sim/"+UNIT+"/design/reports/"+UNIT+"_"+str(TOGGLE)+"percent_avg_rep"+str(REP)+".rpt"
        #print("Power parsed from: "+FILE+" ")
        os.system("python3 ./design_rpt_parser.py "+UNIT+" "+FILE+" .")
        df_power = pd.read_csv("design_power_temp.csv", sep=",")

        df_merged = pd.merge(df_toggle, df_power, on='Components')
        #print(df_merged)
        print("Dumped dataframe for "+UNIT+"_"+str(TOGGLE)+"percent_rep"+str(REP))
        
        df_merged.to_csv(DATAFRAMEPATH+"/"+UNIT+"_"+str(TOGGLE)+"percent_rep"+str(REP)+".csv", sep=',')
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