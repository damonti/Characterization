import os
import sys
import pandas as pd
##############
#PARSE REPORT AND RETURN DYNAMIC POWER FOR EACH INSTANCE
# ###############


if len (sys.argv) != 4 :
    print ("Usage: script.py <rpt_to_parse> <where_to_dump_statistics>")
    sys.exit (1)
UNIT = sys.argv[1]
file_to_parse = sys.argv[2]
where_to_dump = sys.argv[3]
list_of_instances = []

instances_tuple = []
with open(file_to_parse,'r') as f:
    for line in f:
        temp = line.strip(" ").strip("\n").split(" ")
        #print(temp)
        if '/fir' in temp:
            #print("hello")
            pwr = float(temp[1])
            instances_tuple.append(['z'+UNIT, pwr])
        if '/fir/mul0' in temp:
            pwr = float(temp[1])
            instances_tuple.append(['mul0', pwr])
        if '/fir/mul1' in temp:
            pwr = float(temp[1])
            instances_tuple.append(['mul1', pwr])
        if '/fir/mul2' in temp:
            pwr = float(temp[1])
            instances_tuple.append(['mul2', pwr])
        if '/fir/mul3' in temp:
            pwr = float(temp[1])
            instances_tuple.append(['mul3', pwr])
        if '/fir/add0' in temp:
            pwr = float(temp[1])
            instances_tuple.append(['add0', pwr])
        if '/fir/add1' in temp:
            pwr = float(temp[1])
            instances_tuple.append(['add1', pwr])
        if '/fir/add2' in temp:
            pwr = float(temp[1])
            instances_tuple.append(['add2', pwr])

#LEAF INSTANCES   
file_to_parse_leaf = file_to_parse[:-4] + "_leaf.rpt"
value_Yout = 0
value_Q0 = 0
value_Q1 = 0
value_Q2 = 0
       
with open(file_to_parse_leaf,'r') as f:
    for line in f:
        temp = line.strip(" ").strip("\n").split("/")
        #print(temp)
        if temp[-1].startswith("Yout"):
            value_Yout += round(float(temp[0].split(" ")[0]))
        if temp[-1].startswith("Q0"):
            value_Q0 += round(float(temp[0].split(" ")[0]))
        if temp[-1].startswith("Q1"):
            value_Q1 += round(float(temp[0].split(" ")[0]))
        if temp[-1].startswith("Q2"):
            value_Q2 += round(float(temp[0].split(" ")[0]))

            
            
#print(value_Yout)        
instances_tuple.append(['reg_Y', value_Yout]) 
instances_tuple.append(['reg_Q0', value_Q0]) 
instances_tuple.append(["reg_Q1", value_Q1]) 
instances_tuple.append(["reg_Q2", value_Q2]) 

df = pd.DataFrame(instances_tuple, columns=['Components', 'power [nW]'])
df = df.set_index("Components")
df = df.sort_values('Components')
#print(df)
df.to_csv(where_to_dump+"/design_power_temp.csv", sep=',')