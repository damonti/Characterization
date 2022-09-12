import os
import shutil


WORK_PATH = os.path.expanduser("~/Estimation/work")
SIM_PATH = os.path.expanduser("~/Estimation/sim/mux")
RTL_PATH = os.path.expanduser("~/Estimation/rtl/mux")

# PARAM CONFIGURATION
#FACTOR = ["2-1", "3-1", "4-1", "5-1"]
# for PORT in FACTOR:
for INPUT in range(2, 3):

    PORT = INPUT - 1
    PORT_P1 = PORT + 1
    FACTOR = str(INPUT)+"-1"
    for BW in range(8, 9):
    #BW=10
        BW_ = str(BW)+"BW"
        DATAW = BW+2
        DATAW_P1 = BW+3
        NETLIST = FACTOR+"_"+BW_+"_netlist"
        DESIGN = "mux"

        # BW = 8..64
        # for link in BW

        # DIRECTORIES


        # #RTL SIMULATION
        # os.chdir(SIM_PATH)
        # #CHANGE THE DEFINE.V FOR THE CHOSEN CONFIGURATION AND WRITE IT INTO DEFINE_TEMP.V
        # with open(RTL_PATH+'/hdl/define.v', 'r') as f:
        #     lines = f.readlines()
        #     for k in range(0, len(lines)):
        #         if ("PORTx" in lines[k]):
        #             lines[k] = "`define PORT            "+ str(PORT) + "\n"

        #         elif ("define PORT_P1x" in lines[k]):
        #             lines[k] = "`define PORT_P1          "+ str(PORT_P1) + "\n"

        #         elif ("define DATAWx" in lines[k]):
        #             lines[k] = ("`define DATAW           "+ str(DATAW) + "\n")

        #         elif ("define DATAW_P1x" in lines[k]):
        #             lines[k] = "`define DATAW_P1        "+ str(DATAW_P1) + "\n"
            
        #     with open(RTL_PATH+"/define_temp.v", 'w') as wr:
        #         wr.writelines(lines)
        # wr.close()
        # f.close()
        # #CHANGE THE MUX.V FOR THE CHOSEN CONFIGURATION AND WRITE IT INTO MUX_TEMP.V
        # with open(RTL_PATH+'/hdl/mux'+FACTOR+'.v', 'r') as f:
        #     lines = f.readlines()
        #     for k in range(0, len(lines)):
        #         if ("define.v" in lines[k]):
        #             lines[k] = '`include "define_temp.v" \n'
        #     with open(RTL_PATH+"/mux_temp.v", 'w') as wr:
        #         wr.writelines(lines)

        # wr.close()
        # f.close()
        # #RTL SIM
        # os.chdir(SIM_PATH)
        # os.system('xrun -access rwc '+RTL_PATH+'/mux_temp.v -incdir '+RTL_PATH+' -timescale 10ns/10ps')

        # #SYNTHESIS
        # os.chdir(WORK_PATH)
        # os.system('genus -batch -files "./../tcl/synth/synth_mux.tcl" -no_gui -overwrite')
        # shutil.copyfile(WORK_PATH+"/tech40/"+DESIGN+"_10ns_reports/"+DESIGN+"_netlist.v", RTL_PATH+"/netlist/"+DESIGN+"_"+NETLIST+".v")
        # shutil.copyfile(WORK_PATH+"/tech40/"+DESIGN+"_10ns_reports/"+DESIGN+".area.rpt", SIM_PATH+"/reports/"+NETLIST+".area.rpt")

        #CREATE THE DEFINE_TEMP.V
        # with open(RTL_PATH+'/hdl/define.v', 'r') as f:
        #     lines = f.readlines()
        #     for k in range(0, len(lines)):
        #         if ("PORTx" in lines[k]):
        #             lines[k] = "`define PORT            "+ str(PORT) + "\n"

        #         elif ("define PORT_P1x" in lines[k]):
        #             lines[k] = "`define PORT_P1          "+ str(PORT_P1) + "\n"

        #         elif ("define DATAWx" in lines[k]):
        #             lines[k] = ("`define DATAW           "+ str(DATAW) + "\n")

        #         elif ("define DATAW_P1x" in lines[k]):
        #             lines[k] = "`define DATAW_P1        "+ str(DATAW_P1) + "\n"
            
        #     with open(RTL_PATH+"/define_temp.v", 'w') as wr:
        #         wr.writelines(lines)
        # wr.close()
        # f.close()
        
        #NETLIST SIMULATION
        min_step = 100/BW  # minimum percentage step
        steps = []
        for i in range(1, BW+1):  # start at 2, up to BW included, increment 1
            steps.append(round(min_step*i))

        # for PERCENT in steps:
        #     TB = 'test_mux_'+FACTOR+'_'+BW_+'_'+str(PERCENT)+'percent.v'
        #     PATH_TB = RTL_PATH+'/characterization/'+TB
        #     with open(PATH_TB, 'r') as f:
        #         lines = f.readlines()
        #         for k in range(0, len(lines)):
        #             if ("define.v" in lines[k]):
        #                 lines[k] = "define_temp.v\n"
        #             elif ("dump_mux." in lines[k]):
        #                 lines[k] = "//        $dumpfile(\""+SIM_PATH+"/dump_mux_"+FACTOR+"_"+BW_+"_"+str(PERCENT)+"percent.vcd\");\n"
        #         with open(RTL_PATH+'/test_mux_temp.v', 'w') as wr:
        #             wr.writelines(lines)
        #     wr.close()
        #     f.close()
        #     with open(RTL_PATH+'/dump.tcl', 'w') as wr:
        #         wr.write("dumptcf -output "+RTL_PATH+"/dump_mux_"+FACTOR+"_"+BW_+"_"+str(PERCENT)+"percent.tcf -scope mux_test.mux -overwrite \nrun \nexit")
        #     wr.close()
        #     os.system('xrun -clean -access rwc -input '+RTL_PATH+'/dump.tcl -timescale 10ns/10ps -ALLOWREDEFINITION -incdir '+RTL_PATH+' /home_old/tech/tsmc/40nm/TSMCHOME/digital/Front_End/verilog/tcbn40lpbwp_120a/tcbn40lpbwp.v '+RTL_PATH+'/netlist/'+DESIGN+'_'+NETLIST+'.v '+RTL_PATH+'/test_mux_temp.v')

        #HERE YOU NEED TO COMPUTE THE REAL ACTIVITY FROM THE TCF; CREATE A LIST WITH THE SAME ORDER OF THE FAKE ACTIVITY; AND THEN PRINT REPORTS WITH CORRECT ACTIVITY
        value = 0
        values = 0
        i = 0
        skip = 0
        toggle_activity = []
        for PERCENT in steps:
            value = 0
            values = 0
            i = 0
            skip = 0
            TCF = RTL_PATH+'/dump_mux_'+FACTOR+'_'+BW_+'_'+str(PERCENT)+'percent.tcf'
            with open(TCF, 'r') as f:
                lines = f.readlines()
                for k in range(0, len(lines)):
                    if ("\t\t\t\"idata_1[" in lines[k]):
                        if (skip>=3):
                            value = int(lines[k].rsplit(' ', 1)[-1][0:-3])
                            print(value)
                            values =+ value
                            i =+ 1
                        else:
                            skip = skip + 1
                    elif ("duration" in lines[k]):
                        sim_time = float(lines[k].rsplit('\t', 1)[-1][1:-3])
                        print(sim_time)
            toggle_activity.append("{:.2f}".format(100*((values/i)/(sim_time*10**-7))))
            print(toggle_activity)
                
        # os.chdir(WORK_PATH)
        # pstr = ""
        # for i in steps: pstr = pstr + str(i) + " "
        # pstr = pstr.strip()
        #     # POWER
        # os.system('joules -overwrite -batch -execute "set FACTOR '+FACTOR+'" -execute "set BW '+BW_ +
        #             '" -execute "set listPERCENT {'+pstr+'}" -files {"./../tcl/power/power_mux.tcl"} -legacy_ui')
        # os.chdir(SIM_PATH)
        # os.system('rm *.tcf')
