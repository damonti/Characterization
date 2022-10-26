import os
import shutil
#from tkinter.tix import DECREASING
import copy
import shutil
import subprocess
def compute_next_state(ps):  # n=how many bits to complement;
    """generates one row of the case statement (it toggles n bits from "state" each time it is executed)"""
    ns = []
    for x in ps:

        if x == 1:
            ns.append(0)
        else:
            ns.append(1)
    return ns


def generate_table_decimal(toggle, BW):
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
    while (x!=100):
    #while ((next_state != zero_state) and x<100): 
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
        pattern = "".join([str(int(present_state_number, 2)),
                        "\n"])
        
        table.append(pattern)
        present_state = copy.copy(next_state)
    return "".join(table) 

BW = 43 
UNIT = "43bit"
DESIGN = "fir_"+UNIT
WORK_PATH = os.path.expanduser("~/Estimation/work")
SIM_PATH = os.path.expanduser("~/Estimation/validation/fir/"+DESIGN+"/sim")
RTL_PATH = os.path.expanduser("~/Estimation/validation/fir/"+DESIGN+"/hdl")
TB_PATH = os.path.expanduser("~/Estimation/validation/fir/"+DESIGN+"/tb")
STRATUS_PATH = os.path.expanduser("~/Estimation/stratus/approx_hls/stratus_hls/examples/myhls_simple_fir")
TCL_PATH = os.path.expanduser("~/Estimation/tcl")
STRATUS_RTL_PATH = STRATUS_PATH+"/bdw_work/modules/fir/HLS0/v_rtl"

#DELETE PREVIOUS DESIGN
# os.chdir(STRATUS_RTL_PATH)
# subprocess.run(["rm", "*.v"])

#GENERATE TBs
min_step = 100/BW  # minimum percentage step
steps = []
for i in range(1, BW+1):  # start at 2, up to BW included, increment 1
    steps.append(round(min_step*i))
#steps = [36]

# for PERCENT in steps:
#     #change name to tcf
#     TCF_NAME = "dump_"+DESIGN+"_"+str(PERCENT)+"percent.tcf"
#     with open(STRATUS_PATH+'/runtcftemplate.tcl', 'w') as wr:
#         wr.write("dumptcf -scope sc_main.System.fir_wrapper.fir -output "+SIM_PATH+"/"+TCF_NAME+" -overwrite \nrun \ndumptcf -end \nexit")
#         wr.close()
#     #change stimulus to reflect the percentage
#     table = generate_table_decimal(PERCENT, BW)
#     with open(STRATUS_PATH+'/stimulus.dat', 'w') as wr:
#         wr.write(table)
#         wr.close()
#     #run simulation 
#     os.chdir(STRATUS_PATH)
#     #ATTENTION! SOLVE THIS OR RUN IT MANUALLY!
#     #os.system('make sim_V_HLS0') 
#     subprocess.run(["make", "sim_V_HLS0"])

# #COPY STRUCTURAL

# v_files = os.listdir(STRATUS_RTL_PATH)
# for v_file in v_files:
#     shutil.copy2(STRATUS_RTL_PATH+"/"+v_file, RTL_PATH)
# shutil.copy2(STRATUS_RTL_PATH+"/../fir_rtl.v", RTL_PATH)
# with open(RTL_PATH+'/fir_rtl.v', 'r') as f:
#     lines = f.readlines()
#     for k in range(0, len(lines)):
#         if ("module fir" in lines[k]):
#            lines[k] = "module "+DESIGN+"(clk, rst, coeffs_table_0, coeffs_table_1, coeffs_table_2, coeffs_table_3, coeffs_table_4, coeffs_table_5, coeffs_table_6, coeffs_table_7, din_busy, din_vld, din_data, dout_busy, dout_vld, dout_data);"
#     with open(TCL_PATH+"/synth/synth_"+DESIGN+".tcl", 'w') as wr:
#         wr.writelines(lines)
# wr.close()
# f.close()



# #SYNTHESIS
# v_list = ["set RTL_LIST {\\ \n"]
# #Update the genus script with the verilog list
# for v_file in v_files:
#    v_list.append(v_file + " \\ \n")
# v_list.append("fir_rtl.v \\ \n")
# v_list.append("}") 
# os.chdir(WORK_PATH)

# with open(TCL_PATH+'/synth/synth_fir_template.tcl', 'r') as f:
#     lines = f.readlines()
#     for k in range(0, len(lines)):
#         if ("#set DESIGN" in lines[k]):
#            lines[k] = "set DESIGN \""+DESIGN+"\" \n"
#         if ("#VERILOG_LIST" in lines[k]):
#            lines[k] = "".join(v_list)
#     with open(TCL_PATH+"/synth/synth_"+DESIGN+".tcl", 'w') as wr:
#         wr.writelines(lines)
# wr.close()
# f.close()

# os.chdir(WORK_PATH)
# os.system('genus -batch -files "./../tcl/synth/synth_'+DESIGN+'.tcl" -no_gui -overwrite')
# #COPY NETLIST IN /TB
# shutil.copyfile(WORK_PATH+"/tech40/"+DESIGN+"_10ns_reports/"+DESIGN+"_netlist.v", RTL_PATH+"/"+DESIGN+"_netlist.v")
# shutil.copyfile(WORK_PATH+"/tech40/"+DESIGN+"_10ns_reports/"+DESIGN+".area.rpt", TB_PATH+"/../reports/"+DESIGN+".area.rpt")
# shutil.copyfile(WORK_PATH+"/tech40/"+DESIGN+"_10ns_reports/"+DESIGN+".sdc", TB_PATH+"/"+DESIGN+".sdc")


# for toggle in steps:
#     os.chdir(TB_PATH + "/")
#     table = generate_table_decimal(toggle, BW) #generates the bit transitions (table) for the given BW and toggle activity
#     #name_tb = "tb_"+DESIGN+"_"+str(toggle)+"percent.v"
#     stimuli = open("stimuli.txt", 'w')
#     stimuli.write(table)
#     stimuli.close()
#     os.chdir(SIM_PATH + "/")
# #EXECUTE SIMULATION IN /SIM AND DUMP TCFs 
#     with open('run.tcl', 'w') as wr:
#         wr.write("dumptcf -output "+SIM_PATH+"/dump_"+DESIGN+"_"+str(toggle)+"percent.tcf -scope tb_fir."+DESIGN+" -overwrite \nrun \nexit")
#         wr.close()
#     os.system('xrun -clean -access rwc -input '+SIM_PATH+'/run.tcl -timescale 10ns/10ps -ALLOWREDEFINITION -incdir '+RTL_PATH+' /home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/verilog/tcbn40lpbwp_120a/tcbn40lpbwp.v '+TB_PATH+'/'+DESIGN+'_netlist.v '+TB_PATH+'/tb_'+DESIGN+'.v '+RTL_PATH+'/*.v ' )
#     #os.system('xrun -clean -access rwc -input '+SIM_PATH+'/run.tcl -timescale 10ns/10ps -ALLOWREDEFINITION -incdir '+RTL_PATH+' /home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/verilog/tcbn40lpbwp_120a/tcbn40lpbwp.v '+TB_PATH+'/'+DESIGN+'_netlist.v '+TB_PATH+'/tb_'+DESIGN+'.v '+RTL_PATH+'/fir_Add_11Ux11U_11U_4.v '+RTL_PATH+'/fir_Add_3U_4_4.v '+RTL_PATH+'/fir_Add_3Ux1U_4U_4.v '+RTL_PATH+'/fir_And_1Ux1U_1U_1.v '+RTL_PATH+'/fir_gen_busy_r_1.v '+RTL_PATH+'/fir_LessThan_1U_10_4.v '+RTL_PATH+'/fir_logic_1.v '+RTL_PATH+'/fir_Mul_8Ux8U_11U_4.v '+RTL_PATH+'/fir_N_Mux_8_8_12_4.v '+RTL_PATH+'/fir_N_Muxb_1_2_11_4.v '+RTL_PATH+'/fir_Not_1U_1U_1.v '+RTL_PATH+'/fir_Or_1Ux1U_1U_4.v '+RTL_PATH+'/fir_Xor_1Ux1U_1U_1.v '+RTL_PATH+'/fir_RAM_8X8_1.v'  )
#     #os.system('xrun -clean -access rwc -input '+SIM_PATH+'/run.tcl -timescale 10ns/10ps -ALLOWREDEFINITION -top '+TB_PATH+'/'+DESIGN+'_netlist.v /home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/verilog/tcbn40lpbwp_120a/tcbn40lpbwp.v '+TB_PATH+'/tb_'+DESIGN+'.v '+RTL_PATH+'/fir_Add_11Ux11U_11U_4.v '+RTL_PATH+'/fir_LessThan_1U_10_4.v '+RTL_PATH+'/fir_Mul_8Ux8U_11U_4.v '+RTL_PATH+'/fir_RAM_8X8_1.v '+RTL_PATH+'/fir_N_Muxb_1_2_11_4.v ')

#RUN POWER ANALYSIS
os.chdir(WORK_PATH)
pstr = ""
for i in steps: pstr = pstr + str(i) + " " #THE LIST OF %toggle ACTIVITIES
pstr = pstr.strip()
# POWER
os.system('joules -overwrite -batch -execute "set listPERCENT {'+pstr+'}" -files {"./../tcl/power/power_'+DESIGN+'.tcl"} -legacy_ui')

#os.chdir(SIM_PATH)
#os.system('rm *.tcf')