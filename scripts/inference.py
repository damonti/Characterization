import pandas as pd
from sklearn.model_selection import train_test_split
import time
from sklearn.ensemble import GradientBoostingRegressor
import pickle
import os
import sys

#TAKES FIR.CSV AS INPUT AND RETURN THE PWR ESTIMATION FOR THE PARSED ACTIVITY

if len(sys.argv)!= 2:
    print("Usage: script.py <DESIGN> ")
    sys.exit(1)
DESIGN = str(sys.argv[1])


MODEL_PATH = os.path.expanduser("~/Estimation/tables/"+DESIGN)

with open (MODEL_PATH+'/adder_pwr_model', 'rb') as ml:
    adder_model = pickle.load(ml)
ml.close()

with open (MODEL_PATH+'/multiplier_pwr_model', 'rb') as ml:
    multiplier_model = pickle.load(ml)
ml.close()

with open (MODEL_PATH+'/dff_pwr_model', 'rb') as ml:
    dff_model = pickle.load(ml)
ml.close()

TOGGLES = [10, 25, 50, 66, 75, 90]
for TOGGLE in TOGGLES:
    file_to_parse = MODEL_PATH+"/"+DESIGN+"_"+str(TOGGLE)+"percent.csv"
    df_data = pd.read_csv(file_to_parse)
    X_test = df_data.iloc[:, 1:4].values.tolist()
    #print(X_test)
    y_pred = []
    for component in range(0, len(X_test)-1):

        if X_test[component][0].startswith("add"):
            y_pred.append(adder_model.predict([X_test[component][1:3]])[0])
        
        if X_test[component][0].startswith("mul"):
            y_pred.append(multiplier_model.predict([X_test[component][1:3]])[0])
            
        if X_test[component][0].startswith("reg"):
            y_pred.append(dff_model.predict([X_test[component][1:3]])[0])
    
    fir_pred = 0
    for x in y_pred:
        fir_pred += x
    y_pred.append(fir_pred)

    #print(y_pred)
    df_data["est [nW]"] = y_pred
    
    #computing error with GT
    # print(df_data.columns.tolist())
    # print(df_data)
    # print(df_data.loc[:, ["power [nW]", "est [nW]"]].values.tolist())
    
    
    gt_est = df_data.loc[:, ["power [nW]", "est [nW]"]].values.tolist()
    errors = []
    for element in gt_est:
        error = round(((element[0] - element[1])/element[0])*100,2)
        errors.append(error)
    #print(errors)
        
    df_data["err_est [%]"] = errors
    
    df_data.to_csv(MODEL_PATH+"/"+DESIGN+"_"+str(TOGGLE)+"percent_inference.csv", sep=',', index=False)

