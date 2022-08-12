import os
import shutil


WORK_PATH = os.path.expanduser("~/Estimation/work")
SIM_PATH = os.path.expanduser("~/Estimation/sim/mux")
RTL_PATH = os.path.expanduser("~/Estimation/rtl/mux")

# PARAM CONFIGURATION
#FACTOR = ["2-1", "3-1", "4-1", "5-1"]
# for PORT in FACTOR:
for INPUT in range(2, 5):

    PORT = INPUT - 1
    PORT_P1 = PORT + 1
    FACTOR = str(INPUT)+"-1"
    for BW in range(8, 65):
    #BW=10
        BW_ = str(BW)+"BW"
        DATAW = BW+2
        DATAW_P1 = BW+3
        NETLIST = FACTOR+"_"+BW_+"_netlist"
        DESIGN = "mux"

        # BW = 8..64
        # for link in BW

        # DIRECTORIES


        #RTL SIMULATION
        os.chdir(SIM_PATH)
        #CHANGE THE DEFINE.V FOR THE CHOSEN CONFIGURATION AND WRITE IT INTO DEFINE_TEMP.V
        with open(RTL_PATH+'/hdl/define.v', 'r') as f:
            lines = f.readlines()
            for k in range(0, len(lines)):
                if ("PORTx" in lines[k]):
                    lines[k] = "`define PORT            "+ str(PORT) + "\n"

                elif ("define PORT_P1x" in lines[k]):
                    lines[k] = "`define PORT_P1          "+ str(PORT_P1) + "\n"

                elif ("define DATAWx" in lines[k]):
                    lines[k] = ("`define DATAW           "+ str(DATAW) + "\n")

                elif ("define DATAW_P1x" in lines[k]):
                    lines[k] = "`define DATAW_P1        "+ str(DATAW_P1) + "\n"
            
            with open(RTL_PATH+"/define_temp.v", 'w') as wr:
                wr.writelines(lines)
        wr.close()
        f.close()
        #CHANGE THE MUX.V FOR THE CHOSEN CONFIGURATION AND WRITE IT INTO MUX_TEMP.V
        with open(RTL_PATH+'/hdl/mux'+FACTOR+'.v', 'r') as f:
            lines = f.readlines()
            for k in range(0, len(lines)):
                if ("define.v" in lines[k]):
                    lines[k] = '`include "define_temp.v" \n'
            with open(RTL_PATH+"/mux_temp.v", 'w') as wr:
                wr.writelines(lines)

        wr.close()
        f.close()
        #RTL SIM
        #os.chdir(SIM_PATH)
        #os.system('xrun -access rwc '+RTL_PATH+'/mux_temp.v -incdir '+RTL_PATH+' -timescale 10ns/10ps')

        #SYNTHESIS
        os.chdir(WORK_PATH)
        os.system('genus -batch -files "./../tcl/synth/synth_mux.tcl" -no_gui -overwrite')
        #shutil.copyfile(WORK_PATH+"/tech40/"+DESIGN+"_10ns_reports/"+DESIGN+"_netlist.v", RTL_PATH+"/netlist/"+DESIGN+"_"+NETLIST+".v")
        shutil.copyfile(WORK_PATH+"/tech40/"+DESIGN+"_10ns_reports/"+DESIGN+".area.rpt", SIM_PATH+"/reports/"+NETLIST+".area.rpt")


