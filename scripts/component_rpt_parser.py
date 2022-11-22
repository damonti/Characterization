import os
import sys
import pandas as pd
##############
#PARSE REPORT AND RETURN DYNAMIC POWER FOR EACH INSTANCE
# ###############


if len (sys.argv) != 3 :
    print ("Usage: script.py <rpt_to_parse> <where_to_dump_statistics>")
    sys.exit (1)

file_to_parse = sys.argv[1]
where_to_dump = sys.argv[2]
list_of_instances = []

instances_tuple = []
with open(file_to_parse,'r') as f:
    for line in f:
        temp = line.strip(" ").strip("\n").split(" ")
        #print(temp)
        if '/multiplier' in temp:
            pwr = float(temp[1])
            instances_tuple.append(['mul', pwr])
        if '/adder' in temp:
            pwr = float(temp[1])
            instances_tuple.append(['add', pwr])
        if '/dff' in temp:
            pwr = float(temp[1])
            instances_tuple.append(['dff', pwr])



df = pd.DataFrame(instances_tuple, columns=['Components', 'power [nW]'])
df = df.set_index("Components")
df = df.sort_values('Components')
#print(df)
df.to_csv(where_to_dump+"/design_power_temp.csv", sep=',')