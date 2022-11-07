import sys
import re

if len (sys.argv) != 2 :
    print ("Usage: script.py <file_to_parse>")
    sys.exit (1)

file_to_parse = sys.argv[1]

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
            sim_time = int((float(line.split("\"")[1]))/1000000) #parse simulation time in nanoseconds [ns]
        #     print(str(data))
            
print("Simulation time: "+str(sim_time))
#print(list_of_instances)
list_of_multipliers = [m for m in list_of_instances if m.startswith("fir_Mul_")]
#print(list_of_multipliers)

clock_period = 10 #ns


#CHECK HERE IF *2 OR NOT
clock_toggles = int((sim_time/clock_period)) 

INPUT_MULTIPLIER=8
multiplier_tuple =[]
with open(file_to_parse,'r') as f:
    lines = f.readlines() #the file is a huge list where each line is an element
    i = 0
    #print(lines)
    for line in lines: #find the element that corresponds to the fir_Mul instance
        if line.startswith("\tinstance(\"fir_Mul_"):
            instance_name = line.split("\"")[1]
      #  print( [m for m in line if m.startswith("fir_Mul_")])
        #if line[1] in list_of_multipliers:
            #multiplier_index = list_of_multipliers.index(line[1])
            # print("qua\n")
        
            value = 0
            for j in range(0, (INPUT_MULTIPLIER*2)+1): #sum the values by indexing 2 elements of the list after the one with the instance name
                temp = lines[i+2+j].split("\"")[-2]
                #print(temp.split("  ")[-1])
                value += int(temp.split(" ")[-1])
            multiplier_activity = round((value/((INPUT_MULTIPLIER*2)*clock_toggles))*100)
            multiplier_tuple.append([instance_name, multiplier_activity])
            print(value)
        i +=1 #this keeps track of which element_index of the list (line of lines) we currently are parsing
            
#print(multiplier_tuple)

for element in multiplier_tuple:
    print("Instance: "+str(element[0])+"; activity = "+str(element[1])+"%\n")
