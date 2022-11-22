import pandas as pd
from sklearn.model_selection import train_test_split
import time
from sklearn.ensemble import GradientBoostingRegressor
import pickle
import os
import sys



if len(sys.argv)!= 3:
    print("Usage: script.py <DESIGN> <UNIT>")
    sys.exit(1)
DESIGN = str(sys.argv[1])
BIT = DESIGN.split("_")[1]
UNIT = str(sys.argv[2])


SCRIPT_PATH = os.path.expanduser("~/Estimation/scripts")
SIM_PATH = os.path.expanduser("~/Estimation/sim/"+DESIGN+"/components/"+UNIT)
RTL_PATH = os.path.expanduser("~/Estimation/rtl/"+DESIGN+"/components/"+UNIT)
WORK_PATH = os.path.expanduser("~/Estimation/work")
TCL_PATH = os.path.expanduser("~/Estimation/tcl")


MODEL_PATH = os.path.expanduser("~/Estimation/tables/"+DESIGN)

X_test = [[1,2], [3,4]]

with open (MODEL_PATH+'/'+UNIT+'_pwr_model', 'rb') as ml:
    pwr_model = pickle.load(ml)
ml.close()

y_pred = pwr_model.predict(X_test)