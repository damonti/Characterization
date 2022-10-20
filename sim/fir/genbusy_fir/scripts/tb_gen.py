# This is a testbench generator for various toggling activity.
# Given the bitwidth (BW), input patterns for various % is returned.
import copy
import os
import shutil
import time


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
    n = round((BW/100)*toggle)  # number of bits to toggle for each transition
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
    path_tb = RTL_PATH + '/characterization/'  #target file
    path_template = RTL_PATH + '/hdl/' + name_template #original file
    full_path=os.path.join(path_tb,name_tb)
    shutil.copyfile(path_template, full_path)
    #file = open(path_tb, "w")
    #file.write("//toggle = " + str(toggle) + "\n" + "".join(table))
    
    with open(full_path, 'r', encoding='utf-8') as f:
        data = f.readlines()
    for k in range(0, len(data)):
        #if ("//parameter_N" in data[k]):
        #     data[k] = 'parameter N = '+str(int(BW/2))+';\n'

        if ("//INIT" in data[k]): 
            data[k] = "\tinj_data = {"+str(BW)+"{1'b0}};\n"
        
        elif ("//TOGGLE" in data[k]):
            data[k] = table #copy the content of the corresponding activity

    with open(full_path, 'w', encoding='utf-8') as file:
        file.writelines(data)

start = time.time() 
DESIGN ="genbusy_fir"
RTL_PATH = os.path.expanduser("~/Estimation/rtl/fir/"+DESIGN)
#for BW in range (2, 17, 2):
BW = 3
min_step = 100/BW  # minimum percentage step
steps = [] #steps[] list must remain float so that when we call generate_table, the number of toggling bits (n) is correct. If you round to integer, the chunked reminder may cause errors 
for i in range(1, BW+1):  # start at 2, up to BW included, increment 1
    steps.append(round(min_step*i))
for toggle in steps:
    table = generate_table(toggle, BW) #generates the bit transitions (table) for the given BW and toggle activity
    name_tb = "test_"+DESIGN+"_"+str(BW)+"BW_"+str(toggle)+"percent.v"
    name_template = "TB_template_"+DESIGN+".v"
    write_to_template(table, name_tb, name_template, BW) #generates a file with the testbench for the given table
end = time.time()
print(end - start)
    #print ("//toggle = ", toggle)
    #print("".join(table))
    
    #print_to_file: copy the template for the given BW and write the generated table in the simulus part. rename it with the given toggle.

############################################################################################



