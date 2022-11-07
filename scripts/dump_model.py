import pandas as pd
from sklearn.model_selection import train_test_split
import time
from sklearn.ensemble import GradientBoostingRegressor
import pickle
import os
import sys
from sklearn.model_selection import GridSearchCV


def dump_xgb_model(UNIT, VALUE, DF_PATH, X_train, y_train, params):
    reg_xgb = GradientBoostingRegressor(**params)
    print("Started training... \n")
    start = time.time()
    reg_xgb.fit(X_train, y_train)
    stop = time.time()
    print(f"Training time: {stop - start}s \n")
    DUMP_PATH = DF_PATH+"/"+UNIT+"_"+VALUE+"_model"
    with open(DUMP_PATH, 'wb') as f:
        pickle.dump(reg_xgb, f)
    f.close()
    return DUMP_PATH



if len(sys.argv)!= 3:
    print("Usage: script.py <DESIGN> <UNIT>")
    sys.exit(1)
DESIGN = str(sys.argv[1])
UNIT = str(sys.argv[2])


SCRIPT_PATH = os.path.expanduser("~/Estimation/scripts")
SIM_PATH = os.path.expanduser("~/Estimation/sim/"+DESIGN+"/components/"+UNIT)
RTL_PATH = os.path.expanduser("~/Estimation/rtl/"+DESIGN+"/components/"+UNIT)
WORK_PATH = os.path.expanduser("~/Estimation/work")
TCL_PATH = os.path.expanduser("~/Estimation/tcl")


DF_PATH = SIM_PATH+"/dataframe"
df = pd.read_csv(DF_PATH+'/'+UNIT+'.csv', sep=',')

df_power = df[['alpha', 'Power [nW]']].copy()
x_list_power = df_power.drop('Power [nW]', axis=1).values
y_power = df_power['Power [nW]'].values 

X_train, X_test, y_train, y_test = train_test_split(x_list_power, y_power, test_size=0.2, random_state=4, shuffle=True)

print("Tuning the hyperparameters on the dataframe... ")
start = time.time()

model_params = {

    'XGB' : {
        'model': GradientBoostingRegressor(),
        'params': {
            'n_estimators': [1200, 2000, 3000],
            "max_depth": [3, 4],
            "min_samples_split": [3],
            "learning_rate": [0.1, 0.01],
            "loss": ['squared_error' , 'huber'],
            #"loss": ['squared_error', 'absolute_error', 'huber', 'quantile'],
            #"criterion" : ['friedman_mse', 'squared_error', 'mse']
        }
    },
}

scores = []

for model_name, mp in model_params.items():
    rg =  GridSearchCV(mp['model'], mp['params'], cv=5, return_train_score=False, n_jobs=-1)
    rg.fit(X_train, y_train)
    scores.append({
        'model': model_name,
        'best_score': rg.best_score_,
        'best_params': rg.best_params_
    })

stop = time.time()    
print("Done. \n ")
print(f"Hyperparameter tuning time: {stop - start}s")


df = pd.DataFrame(scores,columns=['model','best_score','best_params'])
df.to_csv(DF_PATH+'/'+UNIT+'_hp_tuning_XGB.csv', index=False)

# params = {
#     'n_estimators': 1200,
#     "max_depth": 3,
#     "min_samples_split": 3,
#     "learning_rate": 0.1,
#     "loss": 'huber',
# }

VALUE = "power"
DUMP_PATH = dump_xgb_model(UNIT, VALUE, DF_PATH, X_train, y_train, params)
print("Model dumped in: "+DUMP_PATH)