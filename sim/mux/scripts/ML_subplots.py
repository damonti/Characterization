#Importing required packages.
import pandas as pd
import seaborn as sns
import matplotlib as mpl
import matplotlib.pyplot as plt
plt.rc('text', usetex=True) 

from matplotlib import cm  
#from sklearn.linear_model import SGDClassifier
from sklearn.metrics import mean_squared_error, r2_score, mean_absolute_error, accuracy_score
from sklearn.preprocessing import StandardScaler, LabelEncoder
from sklearn.model_selection import train_test_split, KFold, cross_val_score
from sklearn import ensemble, linear_model
import os
import numpy as np
from numpy import mean
from numpy import absolute
from sklearn.linear_model import LinearRegression, LogisticRegression
from sklearn.ensemble import RandomForestRegressor
import xgboost as xgb
import scikitplot as skplt
from sklearn.svm import SVR
from sklearn.tree import DecisionTreeRegressor
import pickle

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
X_train, X_test, y_train, y_test = train_test_split(X_list_energy, y_energy, test_size=0.3, random_state=4)


############################################
#LINEAR REGRESSION
# lr = LinearRegression()
# lr.fit(X_train, y_train) #trainin the ML algorithm with the training dataset
with open ('./../temp/linear_model_mux', 'rb') as ml:
    lr = pickle.load(ml)
ml.close()
y_pred_lr = lr.predict(X_test) #predicting the values of the test dataset



############################################
#EXTREME GRADIENT BOOSTING
# params = {
#     "n_estimators": 100,
#     "max_depth": 4,
#     "min_samples_split": 5,
#     "learning_rate": 0.1,
#     "loss": "squared_error",
# }

# reg_xgb = ensemble.GradientBoostingRegressor(**params)
# reg_xgb.fit(X_train, y_train)
with open ('./../temp/xgb_model_mux', 'rb') as ml:
    reg_xgb = pickle.load(ml)
ml.close()
y_pred_xgb = reg_xgb.predict(X_test)


# ###############################################################
# #LASSO
# reg_lasso = linear_model.Lasso(alpha=0.1)
# reg_lasso.fit(X_train, y_train)
with open ('./../temp/lasso_model_mux', 'rb') as ml:
    reg_lasso = pickle.load(ml)
ml.close()
y_pred_lasso = reg_lasso.predict(X_test)

############################################
#DECISION TREE REGRESSOR
# dc_regr = DecisionTreeRegressor(max_depth=10)
# dc_regr.fit(X_train, y_train)
with open ('./../temp/DecisionTree_model_mux', 'rb') as ml:
    dc_regr = pickle.load(ml)
ml.close()
y_pred_dc = dc_regr.predict(X_test)

############################################
#RANDOM FOREST
# reg_forest = RandomForestRegressor(n_estimators = 100, random_state = 0)
# reg_forest.fit(X_train, y_train)
with open ('./../temp/RandomForest_model_mux', 'rb') as ml:
    reg_forest = pickle.load(ml)
ml.close()
y_pred_forest = reg_forest.predict(X_test)

############################################
#SVR
# svr = SVR(kernel='rbf', C=1000, epsilon=1)
# svr.fit(X_train, y_train)
with open ('./../temp/svr_model_mux', 'rb') as ml:
    svr = pickle.load(ml)
ml.close()
y_pred_svr = svr.predict(X_test)

#now plot the various predicted against the test data for the various algorithms into 4 subplots

fig, axs = plt.subplots(3, 2, sharex=True, sharey=True)
s=4
font_size=9 #subplot title font size
pad_size=2 #subplot title distance from its subplot
#fig.suptitle('y_test versus y_pred energy plots comparison for MUX')
axs[0, 0].scatter(y_test, y_pred_lr, s=s)
axs[0, 0].set_title("Linear regression", fontsize=font_size, pad=pad_size)
axs[2, 0].scatter(y_test, y_pred_xgb, s=s)
axs[2, 0].set_title("XGB regression", fontsize=font_size, pad=pad_size)
axs[0, 1].scatter(y_test, y_pred_svr, s=s)
axs[0, 1].set_title("SVR regression", fontsize=font_size, pad=pad_size)
axs[1, 1].scatter(y_test, y_pred_forest, s=s)
axs[1, 1].set_title("Random forest regression", fontsize=font_size, pad=pad_size)
axs[1, 0].scatter(y_test, y_pred_lasso, s=s)
axs[1, 0].set_title("Lasso regression", fontsize=font_size, pad=pad_size)
axs[2, 1].scatter(y_test, y_pred_dc, s=s)
axs[2, 1].set_title("Decision tree regression", fontsize=font_size, pad=pad_size)

fig.text(0.5,0.04, "Energy training data [fJ]", ha="center", va="center")
fig.text(0.05,0.5, "Energy testing data [fJ]", ha="center", va="center", rotation=90)
#for ax in axs.flat:
#    ax.set(xlabel='Energy training data [fJ]', ylabel='Energy testing data [fJ]')

#to hide the values of internal axis
for ax in axs.flat:
    ax.label_outer()
    
plt.savefig('y_test versus y_pred.pdf', bbox_inches = "tight")


###################################################
#AREA
##################################################

# X_train, X_test, y_train, y_test = train_test_split(X_list_area, y_area, test_size=0.3, random_state=4)

# ############################################
# #LINEAR REGRESSION
# lr = LinearRegression()
# lr.fit(X_train, y_train) #trainin the ML algorithm with the training dataset
# y_pred_lr = lr.predict(X_test) #predicting the values of the test dataset



# ############################################
# #EXTREME GRADIENT BOOSTING
# params = {
#     "n_estimators": 100,
#     "max_depth": 4,
#     "min_samples_split": 5,
#     "learning_rate": 0.1,
#     "loss": "squared_error",
# }

# reg_xgb = ensemble.GradientBoostingRegressor(**params)
# reg_xgb.fit(X_train, y_train)
# y_pred_xgb = reg_xgb.predict(X_test)




# ############################################
# #RANDOM FOREST
# reg_forest = RandomForestRegressor(n_estimators = 100, random_state = 0)
# reg_forest.fit(X_train, y_train)
# y_pred_forest = reg_forest.predict(X_test)


# ############################################
# #SVR

# svr = SVR(kernel='rbf', C=1000, epsilon=1)
# svr.fit(X_train, y_train)
# y_pred_svr = svr.predict(X_test)

# #now plot the various predicted against the test data for the various algorithms into 4 subplots

# fig, axs = plt.subplots(2, 2)
# fig.suptitle('Area prediction ML algorithms comparison for MUX component')
# axs[0, 0].scatter(y_test, y_pred_lr, s=10)
# axs[0, 0].set_title("Linear regression")
# axs[1, 0].scatter(y_test, y_pred_xgb, s=10)
# axs[1, 0].set_title("XGB regression")
# axs[0, 1].scatter(y_test, y_pred_svr, s=10)
# axs[0, 1].set_title("SVG regression")
# axs[1, 1].scatter(y_test, y_pred_forest, s=10)
# axs[1, 1].set_title("Random forest regression")
# fig.tight_layout()
# plt.savefig('ML area mux.pdf')



