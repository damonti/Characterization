import sys

# if len (sys.argv) != 2 :
#     print ("Usage: script.py <file_to_parse>")
#     sys.exit (1)



# file_to_parse = sys.argv[1]

list_of_instances = []
file_to_parse = "/home/20200969/Estimation/validation/fir/fir_8bit/sim/dump_fir_8bit_12percent.tcf"

with open(file_to_parse,'r') as f:
    for line in f:
        data = line.split("(")
        data = [s.strip("\t") for s in data]
        if 'instance' in data:
            list_of_instances.append(data[1].split("\"")[1])

print(list_of_instances)
list_of_multipliers = [m for m in list_of_instances if m.startswith("fir_Mul_")]
print(list_of_multipliers)

clock_period = 10
simulation_period = 100
clock_toggles = simulation_period/clock_period
INPUT_MULTIPLIER=8
multiplier_tuple =[]
with open(file_to_parse,'r') as f:
    lines = f.readlines()
    i = 0
    #print(lines)
    for line in lines:
        if line.startswith("\tinstance(\"fir_Mul_"):
            instance_name = line.split("\"")[1]
      #  print( [m for m in line if m.startswith("fir_Mul_")])
        #if line[1] in list_of_multipliers:
            #multiplier_index = list_of_multipliers.index(line[1])
            # print("qua\n")
        
            value = 0
            for j in range(0, (INPUT_MULTIPLIER*2)+1):
                value += int(lines[i+2+j].split("\"")[-2][-1])
            multiplier_activity = round((value/((INPUT_MULTIPLIER*2)*clock_toggles))*100)
            multiplier_tuple.append([instance_name, multiplier_activity])
        i +=1
print(value)
print(multiplier_tuple)
