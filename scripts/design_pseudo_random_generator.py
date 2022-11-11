from random import randint
import sys

def merge(state):
    state = [str(i) for i in state] #convert list elements into str
    return ''.join(state) #join the elements into a vector

if len(sys.argv)!= 3:
    print("Usage: script.py <DESIGN> <BW>")
    sys.exit(1)
    
DESIGN = (sys.argv[1])
BW = int(sys.argv[2])
N_TRANSITIONS = 1000 #MUST BE AN EVEN NUMBER



stimuli = [] #set of input vectors

for i in range(N_TRANSITIONS):
    stimulus = [] #current input vector   
    for j in range(BW):
            stimulus.append(randint(0,1))
    stimuli.append(merge(stimulus)) #"state" should be a list of integer when it is passed to the next transition, while it should be a string of digits when it is appended to the input vectors
        
f = open("/home/20200969/Estimation/rtl/"+DESIGN+"/design/stimuli.txt", "w")
f.write('\n'.join(stimuli))
f.close()