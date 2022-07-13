import copy
import os.path
# This is a testbench generator for various toggling activity.
# Given the bitwidth (BW), input patterns for various % is returned.

def compute_next_state(ps):  # n=how many bits to complement;
    """generates one row of the case statement (it toggles n bits from "state" each time it is executed)"""
    ns = []
    for x in ps:

        if x == 1:
            ns.append(0)
        else:
            ns.append(1)
    return ns


def f_transitions(toggle, BW):
    """generate the verilog case(inj_data) for the given toggle and BW"""
    n = int((BW/100)*toggle)  # number of bits to toggle for each transition
    pattern = []  # list of stimulus
    table = []  # final joint stimulus (returned value)
    present_state = []
    for bit in range(0, BW):
        present_state.append(0)  # initial value
    zero_state = copy.copy(present_state)
    next_state = copy.copy(present_state)
    next_state[0] = [1]
    j = 0

    while (next_state != zero_state): 
         #for k in range(0, BW*2, n):  # the variable j indicates the starting bit to toggle
            #the variable n indicates the step (how many bits after the j need to toggle)
        if j+n > BW:  # in case the filter goes above, we wrap it around
            pad = (j+n) - BW
            next_state[j:] = compute_next_state(present_state[j:])
            next_state[:pad] = compute_next_state(present_state[:pad])
            j = pad

        else:
            # complement n bits from "state" and return the result in next
            next_state[j:n+j] = compute_next_state(present_state[j:n+j])
            j = j+n

        present_state_number = "".join([str(i) for i in present_state])
        next_state_number = "".join([str(i) for i in next_state])
        pattern = "".join(["{", str(BW), "'b", present_state_number,
                        "} : inj_data = {", str(BW), "'b", next_state_number, "};\n"])
        table.append(pattern)
        present_state = copy.copy(next_state)
    default = "default : inj_data = {"+str(BW)+"{1'b0}};\n"
    table.append(default)
    return table 

BW = 16
min_step = 100/BW  # minimum percentage step
steps = [min_step]
for i in range(2, BW+1, 1):  # start at 2, up to BW included, increment 1
    steps.append(min_step*i)
    print(steps[i-1])
print(steps)

for toggle in steps:
    table = f_transitions(toggle, BW)
    filename = ""+str(toggle)+"percent_"+str(BW)+"BW"
    path = os.getcwd() + '\\files'
    path_filename = os.path.join(path,filename+".txt")
    file = open(path_filename, "w")
    file.write("//toggle = " + str(toggle) + "\n" + "".join(table))
    #print ("//toggle = ", toggle)
    #print("".join(table))
    
    #print_to_file: copy the template for the given BW and write the generated table in the simulus part. rename it with the given toggle.

############################################################################################



