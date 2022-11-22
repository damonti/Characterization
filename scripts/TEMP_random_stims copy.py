#TRYING OUT IF THIS SCRIPTS RETURN RANDOM ACTIVITY BETWEEN 1 AND 100
#EDIT: IT WORKS BUT ALPHA IS ALWAYS 50% AS THOUGHT :)
from numpy import random

stimuli_dec = random.randint(0, 256, (1000)) #100 stimuli 8 bit long
print(stimuli_dec)
# stimuli_str = [str(s) for s in stimuli_dec]

# print(stimuli_str)
# print(len(stimuli_str))
stimuli_bin = [f'{x:08b}' for x in stimuli_dec]
print(stimuli_bin)
# stimuli_bin = [format(x,'b') for x in stimuli_dec]
# print(stimuli_bin)

j=0
toggle_values = []
while j < 8:
    toggle_value = 0
    k=0
    #print ("j="+str(j))
    while k < len(stimuli_bin):
        #print("digit = "+stimuli_bin[k][j])
        #print("k = " +str(k))
        b = stimuli_bin[k][j]
        if (k==0): pre_b=b
        else:
            if pre_b!=b:
                toggle_value +=1 
            pre_b=b
        k += 1
    toggle_values.append(toggle_value)
    #print("toggle vale = " +str(toggle_value))
    j += 1
print("toggle values:")
print(toggle_values)

total_toggles=0
for x in toggle_values:
    total_toggles += x

toggle_rate = total_toggles/(8*1000)
print("alpha = "+str(toggle_rate))

