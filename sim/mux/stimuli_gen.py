import copy
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
    pattern = [""]  # list of stimulus
    table = ""  # final joint stimulus (returned value)
    present_state = []
    for bit in range(0, BW):
        present_state.append(0)  # initial value
    next_state = copy.copy(present_state)


    j = 0
    for k in range(0, BW**2, n):  # the variable j enumerates the current state

        if j+n > BW:  # in case the filter goes above, we wrap it around
            pad = (j+n) - BW
            next_state[j:] = compute_next_state(present_state[j:])
            next_state[:pad] = compute_next_state(present_state[:pad])
            j = pad

        else:
            # complement n bits from "state" and return the result in next
            next_state[j:n+j] = compute_next_state(present_state[j:n+j])
            j = j+n
            #print("next_state=", next_state)
        #present_state_number = [str(i) for i in present_state]
        present_state_number = "".join([str(i) for i in present_state])
        next_state_number = "".join([str(i) for i in next_state])

        #print (present_state)
        #print (next_state)
        #print ("present_state_number=",present_state_number)
        #print ("next_state_number",next_state_number)
        pattern = "".join(["{", str(BW), "'b", present_state_number,
                        "} : inj_data = {", str(BW), "'b", next_state_number, "};"])
        #pattern.append ["{{0}'b",present_state_number,"} : inj_data = {",BW,"'b",next_state_number,"};"]
        print(pattern)
        present_state = copy.copy(next_state)

    # return table = '/n'.join(pattern)

    print("".join(["default : inj_data = {", str(BW), "'b", str(0)*BW, "};"]))


BW = 8
min_step = 100/BW  # minimum percentage step
steps = [min_step]
for i in range(2, BW+1, 1):  # start at 2, up to BW included, increment 1
    steps.append(min_step*i)
    print(steps[i-1])
print(steps)

for toggle in steps:
    table = f_transitions(toggle, BW)
    # print_to_file(table)

    print_to_file: copy the template for the given BW and write the generated table in the simulus part. rename it with the given toggle.

############################################################################################


##########################################################################
#
