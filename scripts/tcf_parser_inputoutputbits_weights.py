import sys
import re
import pandas as pd

# if len (sys.argv) != 3 :
#     print ("Usage: script.py <file_to_parse> <where_to_dump>")
#     sys.exit (1)

file_to_parse = "/home/20200969/Estimation/sim/fir_8bit/design/tcf/fir_8bit_bohpercent.tcf"
where_to_dump = "."
list_of_instances = []
# file_to_parse = "/home/20200969/Estimation/validation/fir/fir_8bit/sim/dump_fir_8bit_12percent.tcf"

with open(file_to_parse,'r') as f:
    for line in f:
        data = re.findall(r"[\w']+", line)
        #data = line.split("(")
        #data = [s.strip("\t") for s in data]
        if 'instance' in data:
        #     print(str(data))
            list_of_instances.append(data[1])
            #list_of_instances.append(data[1].split("\"")[1])
        if 'duration' in data:
            sim_time = int(((float(line.split("\"")[1]))/1000000)) #parse simulation time in nanoseconds [ns]
        #     print(str(data))
            
print("Simulation time: "+str(sim_time))
print(list_of_instances)
#list_of_multipliers = [m for m in list_of_instances if m.startswith("fir_Mul_")]
#print(list_of_multipliers)

clock_period = 10 #ns

clock_toggles = int((sim_time/clock_period)) 
print(clock_toggles)

instances_tuple = []

with open(file_to_parse,'r') as f:
    lines = f.readlines() #lines now is a huge list where each line is an element
    i = 0 #line index
    #print(lines)
    for line in lines: #find the element that corresponds to the fir_Mul instance
        if line.startswith("\tinstance(\""):
            instance_name = line.split("\"")[1]
            if not ((instance_name.startswith("tb")) or (instance_name.startswith("fir") )): #in case there's a tb in the tcf, we ignore it
                print(instance_name)
                print(lines[i+2].split("\"")[1])
        #  print( [m for m in line if m.startswith("fir_Mul_")])
            #if line[1] in list_of_multipliers:
                #multiplier_index = list_of_multipliers.index(line[1])
                # print("qua\n")
                value = 0
                how_many_input = 0
                print(lines[i+2+how_many_input].split("\"")[1].startswith("in"))
                while (lines[i+2+how_many_input].split("\"")[1].startswith("in")):
                    how_many_input += 1
                    
                min_w = float(1/(how_many_input/2),3)
                weights = [x*min_w for x in range(0, 8+1)] #list of weights 0.12, 0.25, ...
                for j in range(0, how_many_input):
                    temp = lines[i+2+j].split("\"")[-2]
                    #print(temp.split("  ")[-1])
                    value = value + temp.split(" ")[-1]*weights[j%how_many_input]
                print(value)             
                instance_activity = round(((value/((how_many_input)*clock_toggles))*100),2)
                instances_tuple.append([instance_name, instance_activity])
                print(how_many_input)                
    
        i +=1 #this keeps track of which element_index of the list (line of lines) we currently are parsing
        
#print(instances_tuple)

#for element in instances_tuple:
    #print("Instance: "+str(element[0])+"; activity = "+str(element[1])+"%\n")

df = pd.DataFrame(instances_tuple, columns=['Components', 'alpha'])
df = df.set_index("Components")
print(df)
df.to_csv(where_to_dump+"/instname_toggle.csv", sep=',')

#df = pd.read_csv(where_to_dump+"/instname_toggle.csv")
# print(df)
# print(df['Components'].values) #column as list (giving the column name)
# print(df.iloc[0].tolist()) #row as list (iloc argument is the row index or name)

# print(df)
# #df = pd.read_csv(where_to_dump+"/instname_toggle.csv", index_col="Components")
# df = df.set_index("Components")
# print(df)
# print(df.loc["mul0"]) #return a row: the argument of .loc must be the first element of row
# print(df.iloc[0]) #same as above but we index with integers