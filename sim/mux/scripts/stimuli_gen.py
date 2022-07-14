# This is a testbench generator for various toggling activity.
# Given the bitwidth (BW), input patterns for various % is returned.
import copy
import os.path
import shutil
import time
import math

def compute_next_state(ps):  # n=how many bits to complement;
    """generates one row of the case statement (it toggles n bits from "state" each time it is executed)"""
    ns = []
    for x in ps:

        if x == 1:
            ns.append(0)
        else:
            ns.append(1)
    return ns


def generate_table(toggle, BW):
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

    x=0
    while ((next_state != zero_state) and x<100): 
        x+=1
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
        pattern = "".join(["\t\t{", str(BW), "'b", present_state_number,
                        "} : inj_data = {", str(BW), "'b", next_state_number, "};\n"])
        table.append(pattern)
        present_state = copy.copy(next_state)
    default = "\t\tdefault : inj_data = {"+str(BW)+"{1'b0}};\n"
    table.append(default)
    return "".join(table) 

def write_to_template(table, name_tb, name_template, BW):
    """Generate the complete testbench for the given table"""
    path_tb = os.getcwd() + '\\testbench\\'  #target file
    tb = name_tb + '.v'
    path_template = os.getcwd() + '\\template\\' + name_template + '.v' #original file
    full_path=os.path.join(path_tb,tb)
    shutil.copyfile(path_template, full_path)
    #file = open(path_tb, "w")
    #file.write("//toggle = " + str(toggle) + "\n" + "".join(table))
    
    with open(full_path, 'r', encoding='utf-8') as f:
        data = f.readlines()
    for k in range(0, len(data)):
        if ("//INIT" in data[k]): 
            data[k] = "\tinj_data = {"+str(BW)+"{1'b0}};\n"
        
        elif ("//TOGGLE" in data[k]):
            data[k] = table #copy the content of the corresponding activity
        
        elif ('//INJ_DATA' in data[k]):
            if (BW>32):
                data[k] = "\t\t\tidata_1 <= 2{inj_data};"
            else:
                data[k] = "\t\t\tidata_1 <= inj_data;"

    with open(full_path, 'w', encoding='utf-8') as file:
        file.writelines(data)

start = time.time()
FACTOR = "2-1"
for BW in range(8, 64+1):
    min_step = 100/BW  # minimum percentage step
    steps = [math.floor(min_step)]
    for i in range(2, BW+1, 1):  # start at 2, up to BW included, increment 1
        steps.append(math.floor(min_step*i))
    for toggle in steps:
        table = generate_table(toggle, BW) #generates the bit transitions (table) for the given BW and toggle activity
        name_tb = "test_mux_"+FACTOR+"_"+str(BW)+"BW_"+str(toggle)+"percent"
        name_template = "TEMPLATE_"+FACTOR
        write_to_template(table, name_tb, name_template, BW) #generates a file with the testbench for the given table
end = time.time()
print(end - start)
    #print ("//toggle = ", toggle)
    #print("".join(table))
    
    #print_to_file: copy the template for the given BW and write the generated table in the simulus part. rename it with the given toggle.

############################################################################################


