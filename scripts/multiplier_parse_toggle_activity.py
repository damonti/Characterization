import os
import re
import pandas as pd
import sys
#TAKE AS INPUT ALL THE RPT AND TCF, AVERAGE THE REPETITIONS (10 REPS FOR EACH INPUT%), BUILD A 100 ENTRIES DATAFRAME THAT CAN BE USED FOR TRAINING (ALTHOUGH A BIT FEW ENTRIES)
# AVERAGING IS NEEDED TO AVERAGE OUT THE OUTLINERS DUE TO RANDOM INTERLEAVING BETWEEN SUBSEQUENT CYCLES THAT AFFECT POWER IN DIFFERENT WAYS 
if len(sys.argv)!= 3:
    print("Usage: script.py <DESIGN> <UNIT> ")
    sys.exit(1)

DESIGN = str(sys.argv[1])
UNIT = str(sys.argv[2])
BIT = DESIGN.split("_")[1]

TOGGLES = list(range(1, 101))
REPS = list(range(1,10))

DATAFRAMEPATH = "/home/20200969/Estimation/sim/"+DESIGN+"/components/"+UNIT+"/dataframe"
instances_tuple = []
for TOGGLE in TOGGLES:
    for REP in REPS:
        file_to_parse = DATAFRAMEPATH+"/../tcf/"+UNIT+"_"+str(TOGGLE)+"percent_#"+str(REP)+".tcf"
        list_of_instances = []
        with open(file_to_parse,'r') as f:
            for line in f:
                data = re.findall(r"[\w']+", line)
                #print(data)
                #data = line.split("(")
                #data = [s.strip("\t") for s in data]
                if 'instance' in data:
                #     print(str(data))
                    list_of_instances.append(data[1])
                    #list_of_instances.append(data[1].split("\"")[1])
                if 'duration' in data:
                    sim_time = int(((float(line.split("\"")[1]))/1000000)) #parse simulation time in nanoseconds [ns]
                #     print(str(data))
        f.close()
            
        clock_period = 10 #ns
        clock_toggles = int((sim_time/clock_period))
        
        with open(file_to_parse,'r') as f:
            lines = f.readlines() #lines now is a huge list where each line is an element
            i = 0 #line index
            #print(lines)
            for line in lines: #find the element that corresponds to the fir_Mul instance
                if line.startswith("\tinstance(\""):
                    instance_name = line.split("\"")[1]
                    if not ((instance_name.startswith("tb")) or (instance_name.startswith("fir") )): #in case there's a tb in the tcf, we ignore it
                        #print("Instance name: " + instance_name)
                        #print("First bitline: " +str(lines[i+2].split("\"")[1]))
                #  print( [m for m in line if m.startswith("fir_Mul_")])
                    #if line[1] in list_of_multipliers:
                        #multiplier_index = list_of_multipliers.index(line[1])
                        # print("qua\n")
                        input_value = 0
                        input_value_weighted = 0
                        output_value = 0
                        how_many_input = 0
                        how_many_output = 0
                        
                        
                        while (lines[i+2+how_many_input].split("\"")[1].startswith("in")):
                            #print("Counting input bitline: " +str(lines[i+2+how_many_input].split("\"")[1]))
                            how_many_input += 1
                        #print("how_many_input = " + str(how_many_input))
                        
                        while ( (not lines[i+2+how_many_input+how_many_output].startswith("\t\t}") ) and lines[i+2+how_many_input+how_many_output].split("\"")[1].startswith("out")): 
                            #print("Counting output bitline: " +str(lines[i+2+how_many_input+how_many_output].split("\"")[1])) 
                            how_many_output += 1  
                        #print("how_many_output = " + str(how_many_output))
                        
                        for j in range(0, how_many_input):
                            temp = lines[i+2+j].split("\"")[-2]
                            #print(temp.split("  ")[-1])
                            input_value += int(temp.split(" ")[-1])
                        #print("Input total toggles = " + str(input_value))
                        
                        # if instance_name.startswith("mul"):
                        #     weights = [0.56, 0.67, 0.79, 0.88, 1, 0.96, 0.85, 0.69]
                        #     for j in range(0, how_many_input):
                        #         weight_index = j%(int((how_many_input)/2))
                        #         # print("how_many_inputs = "+str(how_many_input))
                        #         # print("j%how_many_inputs = "+str(weight_index))
                        #         #print("current weight = "+str(weights[weight_index]))
                        #         temp = lines[i+2+j].split("\"")[-2]
                        #         #print("bitline toggles = "+str(temp))
                        #         #print(temp.split("  ")[-1])
                        #         input_value_weighted += round(int(temp.split(" ")[-1])*weights[weight_index],4)
                            
                        for j in range(0, how_many_output):
                            temp = lines[i+2+how_many_input+j].split("\"")[-2]
                            #print(temp.split("  ")[-1])
                            output_value += int(temp.split(" ")[-1])
                        #print("Output total toggles = " + str(output_value))
                        f.close() 
                
                        input_instance_activity = round(((input_value/((how_many_input)*clock_toggles))*100),2)
                        output_instance_activity = round(((output_value/((how_many_output)*clock_toggles))*100),2)
                        inputoutput_instance_activity = round((((input_value+output_value)/((how_many_input+how_many_output)*clock_toggles))*100),2)
                        
                        # if instance_name.startswith("mul"):
                        #     inputoutput_weighted_instance_activity = round((((input_value_weighted+output_value)/((how_many_input+how_many_output)*clock_toggles))*100),2)
                        # else:
                        #     inputoutput_weighted_instance_activity = inputoutput_instance_activity
                                
                        # print("input_instance_activity = "+ str(input_instance_activity))
                        # print("output_instance_activity = "+ str(output_instance_activity))
                        # print("inputoutput_instance_activity = "+ str(inputoutput_instance_activity))
                        
                        
                        file_to_parse=DATAFRAMEPATH+"/../reports/"+UNIT+"_"+str(TOGGLE)+"percent_#"+str(REP)+"_avg.rpt"
                        with open(file_to_parse,'r') as f:
                            for line in f:
                                temp = line.strip(" ").strip("\n").split(" ")
                                #print(temp)
                                if '/multiplier' in temp:
                                    pwr = float(temp[1])
                                # if '/adder' in temp:
                                #     pwr = float(temp[1])
                                #     instances_tuple.append(['add', pwr])
                                # if '/dff' in temp:
                                #     pwr = float(temp[1])
                                #     instances_tuple.append(['dff', pwr])
                        f.close()
                        
                        #power

                        instances_tuple.append([instance_name, input_instance_activity, output_instance_activity, inputoutput_instance_activity, pwr])
                
                i +=1
                    
                        
df_original = pd.DataFrame(instances_tuple, columns=['Components', 'alpha_in', 'alpha_out', 'alpha_inout', 'Power [nW]'])
#cmpute mean before 
temp_df_list_activity = []
temp_df_list_power = []
n_reps = len(REPS)
for i in range(0, len(df_original.index), n_reps):
    temp_df = df_original.iloc[i:i+n_reps, :-1].mean(axis=0) #temp_df will store the average of same input activity runs
    temp_df_list_activity.append(temp_df)
    power_offset = df_original.iloc[i:i+n_reps, [-1]].mean(axis=0) - (df_original.iloc[i:i+n_reps, [-1]].mean(axis=0) * 0)
    temp_df_list_power.append(power_offset)

#df = df.set_index("Components")
#df = df.sort_values('alpha_in')


#MERGING THE AVERAGED ACTIVITY WITH THE ACERAGED POWER VALUES
df_new = pd.DataFrame(temp_df_list_activity)
df_new["Power [nW]"]= pd.DataFrame(temp_df_list_power)
print("final")
print(pd.DataFrame(df_new))


where_to_dump = "/home/20200969/Estimation/tables/"+DESIGN
df_new.to_csv(where_to_dump+"/"+UNIT+"_"+BIT+"_table.csv", sep=',')
    
                
