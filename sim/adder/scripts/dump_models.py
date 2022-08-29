#Importing required packages.
from locale import dcgettext
import pandas as pd
import seaborn as sns
import matplotlib as mpl
import matplotlib.pyplot as plt
plt.rc('text', usetex=True) 
from matplotlib import cm  
#from sklearn.linear_model import SGDClassifier
from sklearn.metrics import mean_squared_error, r2_score, mean_absolute_error, accuracy_score, mean_absolute_percentage_error
from sklearn.preprocessing import StandardScaler, LabelEncoder
from sklearn.model_selection import train_test_split, KFold, cross_val_score
from sklearn import ensemble, linear_model
import os
import numpy as np
from numpy import mean
from numpy import absolute
from sklearn.linear_model import LinearRegression, LogisticRegression
from sklearn.ensemble import GradientBoostingRegressor, RandomForestRegressor
import xgboost as xgb
import scikitplot as skplt
from sklearn.svm import SVR
from scipy import stats
from sklearn.tree import DecisionTreeRegressor
#from parameter_tuning.py derive the best parameters for each model given the dataset
#then use this to dump the models with the best fitting parameters
import pickle
import time

DF_PATH = os.path.expanduser("~/Estimation/sim/adder/dataframe/adder_configurations.csv")
df = pd.read_csv(DF_PATH, sep=',')

df_energy = df[['BW', 'PERCENTAGE', 'Energy [fJ]']].copy()
df_area = df[['BW', 'Area [um^2]']].copy()


X_list_energy = df_energy.drop('Energy [fJ]', axis=1).values #"INPUT", "BW" and "PERCENTAGE"
X_list_area = df_area.drop('Area [um^2]', axis=1).values #"INPUT" and "BW"  

y_energy = df_energy['Energy [fJ]'].values 
y_area = df_area['Area [um^2]'].values

X_train, X_test, y_train, y_test = train_test_split(X_list_energy, y_energy, test_size=0.2, random_state=4, shuffle=True)


#EXTREME GRADIENT BOOSTING
params = {
    "n_estimators": 2000,
    "max_depth": 3,
    "min_samples_split": 4,
    "learning_rate": 0.05,
    "loss": "squared_error",
}
reg_xgb = ensemble.GradientBoostingRegressor(**params)
start = time.time()
reg_xgb.fit(X_train, y_train)
stop = time.time()
print(f"Training time XGB: {stop - start}s")
with open('xgb_model_mux', 'wb') as f:
    pickle.dump(reg_xgb, f)
f.close()

#to load it:
#with open ('xgb_model', 'rb') as f:
#    xgb_model = pickle.load(f)

#LASSO
reg_lasso = linear_model.Lasso(alpha=0.1)
start = time.time()
reg_lasso.fit(X_train, y_train)
stop = time.time()
print(f"Training time lasso: {stop - start}s")
with open('lasso_model_mux', 'wb') as f:
    pickle.dump(reg_lasso, f)
f.close()

#Random forest
reg_forest = RandomForestRegressor(max_features=10, n_estimators = 100)
start = time.time()
reg_forest.fit(X_train, y_train)
stop = time.time()
print(f"Training time random forest: {stop - start}s")
with open('RandomForest_model_mux', 'wb') as f:
    pickle.dump(reg_forest, f)
f.close()

#Decision tree
reg_dc = DecisionTreeRegressor(max_depth=100)
start = time.time()
reg_dc.fit(X_train, y_train)
stop = time.time()
print(f"Training time decision tree: {stop - start}s")
with open('DecisionTree_model_mux', 'wb') as f:
    pickle.dump(reg_dc, f)
f.close()


#SVR
reg_svr = SVR(kernel='linear', C=10, epsilon=1)
start = time.time()
reg_svr.fit(X_train, y_train)
stop = time.time()
print(f"Training time svr: {stop - start}s")
with open('svr_model_mux', 'wb') as f:
    pickle.dump(reg_svr, f)
f.close()

#LINEAR REGRESSION
reg_lr = LinearRegression()
start = time.time()
reg_lr.fit(X_train, y_train)
stop = time.time()
print(f"Training time linear reg: {stop - start}s")
with open('linear_model_mux', 'wb') as f:
    pickle.dump(reg_lr, f)
f.close()