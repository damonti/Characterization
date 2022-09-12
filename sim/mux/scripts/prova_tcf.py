import os
import shutil

FACTOR = "2-1"
BW_ = "8BW"
WORK_PATH = os.path.expanduser("~/Estimation/work")
SIM_PATH = os.path.expanduser("~/Estimation/sim/mux")
RTL_PATH = os.path.expanduser("~/Estimation/rtl/mux")


os.chdir(WORK_PATH)
    # POWER
os.system('joules -overwrite -batch -execute "set FACTOR '+FACTOR+'" -execute "set BW '+BW_ +
            '" -execute "set listPERCENT 12" -files {"./../tcl/power/power_mux_tcf.tcl"} -legacy_ui')
os.chdir(SIM_PATH)
# os.system('rm *.tcf')

"/home/20200969/Estimation/rtl/mux/dump_mux_2-1_8BW_100percent.tcf"
