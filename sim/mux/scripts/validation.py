#Importing required packages.
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

DF_PATH = os.path.expanduser("~/Estimation/sim/mux/dataframe/mux_configurations.csv")
df = pd.read_csv(DF_PATH, sep=',')

df_energy = df[['INPUT', 'BW', 'PERCENTAGE', 'Energy [fJ]']].copy()
df_area = df[['INPUT', 'BW', 'Area [um^2]']].copy()


X_list_energy = df_energy.drop('Energy [fJ]', axis=1).values #"INPUT", "BW" and "PERCENTAGE"
X_list_area = df_area.drop('Area [um^2]', axis=1).values #"INPUT" and "BW"  

y_energy = df_energy['Energy [fJ]'].values 
y_area = df_area['Area [um^2]'].values


#ENERGY
####################
X_train, X_test, y_train, y_test = train_test_split(X_list_energy, y_energy, test_size=0.2, random_state=4, shuffle=True)

############################################
#EXTREME GRADIENT BOOSTING
params = {
    "n_estimators": 3000,
    "max_depth": 4,
    "min_samples_split": 5,
    "learning_rate": 0.12,
    "loss": "squared_error",
}

reg_xgb = GradientBoostingRegressor(**params)
reg_xgb.fit(X_train, y_train)
y_pred = reg_xgb.predict(X_test)
