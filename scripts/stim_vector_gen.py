############################################################
#Generate the input vectors for component characterization #
#for any BW for 1%->100% with random interleaving          #
############################################################

from sympy import symbols, linsolve, Matrix
from random import randint
import math
import sys

def get_upper_bound(steps, TOGGLE):
    """Returns upper bound"""
    larger_toggles = [i for i in steps if i>=TOGGLE]
    return larger_toggles[0]

def get_lower_bound(steps, TOGGLE):
    """Returns lower bound"""
    smaller_toggles = [i for i in steps if i<=TOGGLE]
    return smaller_toggles[-1]

def generate_toggles_percentage(BW):
    """Returns a list of toggle rates"""
    min_step = 100/BW
    steps = []
    for i in range(0, BW+1): 
        steps.append(round(min_step*i))
    return steps

def compute_transitions(toggle_upper_bound, toggle_lower_bound, TOGGLE, N_TRANSITIONS):
    if (toggle_upper_bound == toggle_lower_bound):
        return [int(N_TRANSITIONS/2), int(N_TRANSITIONS/2)]        
    x, y = symbols('x, y')
    A = Matrix([[toggle_upper_bound/N_TRANSITIONS, toggle_lower_bound/N_TRANSITIONS], [1, 1]])
    b = Matrix([[TOGGLE], [N_TRANSITIONS]])
    solution = []
    solution = [int(list(linsolve((A,b), [x, y]))[0][0]), int(list(linsolve((A,b), [x, y]))[0][1])] #return the solution as a list type
    return solution
    
def rnd_initial_state(BW):
    """Return a list BW long where each bit is an element"""
    state = []
    for i in range(BW):
        state.append(randint(0,1)) #generate string of BW lenght with random 0s and 1s
    return state
    
def merge(state):
    state = [str(i) for i in state] #convert list elements into str
    return ''.join(state) #join the elements into a vector

def generate_transition(state, toggle_rate):
    """Return a random transition for the given toggle_rate starting from the given state"""
    BW = len(state)
    if (toggle_rate == 0):
        return state
    bit_to_toggle = round(BW*toggle_rate/100) #how many bits we need to toggle from state
    #remember if bit_to_toggle>1, you do not want to toggle the same position twice
    toggled_positions = []
    for i in range(bit_to_toggle):
        while(1):
            position = randint(0, BW-1)
            if not (position in toggled_positions): #exit the while when we have a position that has not changed before
                break
        toggled_positions.append(position)
        state[position] = 0 if state[position] else 1
    return state
    
if len(sys.argv)!= 2:
    print("Usage: script.py <toggle_rate_percentage> (integer)")
    sys.exit(1)
#DEFINE DESIGN
N = int(sys.argv[1])
BW = 16
N_TRANSITIONS = 42 #MUST BE AN EVEN NUMBER
TOGGLES = list(range(N, N+1))
#TODO: SWEEP THE TOGGLE ACTIVITY FROM 1 TO 0 TO GENERATE VARIOUS STIMULUS FOR THE GIVEN BW
for TOGGLE in TOGGLES: 

    #GENERATE POSSIBLE TOGGLING PERCENTAGE GIVEN THE BW
    steps = generate_toggles_percentage(BW)

    #GIVEN TOGGLE, FIND UPPER AND LOWER BOUND FOR THE TOGGLE RATE
    toggle_lower_bound = get_lower_bound(steps, TOGGLE)
    toggle_upper_bound = get_upper_bound(steps, TOGGLE)  

    #FIND OUT HOW MANY TRANSITIONS OF UPPER AND LOWER BOUNDS WE NEED TO HAVE (OUT OF 10) SUCH THAT THE SPECIFIED TOGGLE IS MET
    [transitions_upper_bound, transitions_lower_bound] = compute_transitions(toggle_upper_bound, toggle_lower_bound, TOGGLE, N_TRANSITIONS)

    #GENERATE THE NUMBER OF TRANSITIONS FOUND FOR THE GIVEN BOUND
    state = []
    state = rnd_initial_state(BW) #starting input vector
    input_vector = [] #initialize input vector
    input_vector.append(merge(state)) #"state" should be a list of integer when it is passed to the next transition, while it should be a string of digits when it is appended to the input vectors

    for i in range(round(transitions_upper_bound)):
        state = generate_transition(state, toggle_upper_bound)
        input_vector.append(merge(state)) #append vector as a whole string

    for i in range(round(transitions_lower_bound)):
        state = generate_transition(state, toggle_lower_bound)
        input_vector.append(merge(state))
        
    print('\n'.join(input_vector))
    
    #print("\n--------------------------------"+str(TOGGLE)+"\n")

f = open("/home/20200969/Estimation/rtl/fir_8bit/hdl/stimuli.txt", "w")
f.write('\n'.join(input_vector))
f.close()
