#Importing required packages.
import pandas as pd
import seaborn as sns
import matplotlib as mpl
import matplotlib.pyplot as plt
plt.rc('text', usetex=True) 
import matplotlib.patches as mpatches
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
#     "n_estimators": 1000,
#     "max_depth": 4,
#     "min_samples_split": 5,
#     "learning_rate": 0.1,
#     "loss": "squared_error",
# }
# reg_xgb.fit(X_train, y_train)
with open ('./../temp/xgb_model_mux', 'rb') as ml:
    reg_xgb = pickle.load(ml)
ml.close()

y_pred_xgb = reg_xgb.predict(X_test)



#############################################
##RANDOM FOREST
#reg_forest = RandomForestRegressor(n_estimators = 100, random_state = 0)
#reg_forest.fit(X_train, y_train)
#y_pred_forest = reg_forest.predict(X_test)
#
## ###############################################################
## #LASSO
#reg_lasso = linear_model.Lasso(alpha=0.1)
#reg_lasso.fit(X_train, y_train)
#y_pred_lasso = reg_lasso.predict(X_test)
#
#############################################
##DECISION TREE REGRESSOR
#dc_regr = DecisionTreeRegressor(max_depth=10)
#dc_regr.fit(X_train, y_train)
#y_pred_dc = dc_regr.predict(X_test)
#
#############################################
##SVR
#svr = SVR(kernel='rbf', C=1000, epsilon=1)
#svr.fit(X_train, y_train)
#y_pred_svr = svr.predict(X_test)


# fig, axs = plt.subplots(3, 2)
# s=4
# fig.suptitle('x_test versus y_pred energy plots comparison for MUX')
# axs[0, 0].scatter(X_test[:,2], y_pred_lr, s=s, c = X_test[:,1] , cmap='viridis')
# axs[0, 0].set_title("Linear regression")
# axs[1, 0].scatter(X_test[:,2], y_pred_xgb, s=s, c = X_test[:,1] , cmap='viridis')
# axs[1, 0].set_title("XGB regression")
# axs[0, 1].scatter(X_test[:,2], y_pred_svr, s=s, c = X_test[:,1] , cmap='viridis')
# axs[0, 1].set_title("SVR regression")
# axs[1, 1].scatter(X_test[:,2], y_pred_forest, s=s, c = X_test[:,1] , cmap='viridis')
# axs[1, 1].set_title("Random forest regression")
# axs[2, 0].scatter(X_test[:,2], y_pred_lasso, s=s, c = X_test[:,1] , cmap='viridis')
# axs[2, 0].set_title("Lasso regression")
# axs[2, 1].scatter(X_test[:,2], y_pred_dc, s=s, c = X_test[:,1] , cmap='viridis')
# axs[2, 1].set_title("Decision tree regression")
# fig.tight_layout()
# plt.savefig('x_test versus y_pred.pdf')


fig, (ax1, ax2) = plt.subplots(nrows=1, ncols=2, sharex=True, sharey=True)
s=8
#fig.suptitle('x_test versus y_pred energy plots comparison for MUX')
ax1.scatter(X_test[:,2], y_pred_lr, s=s, c = X_test[:,1] , cmap='viridis')
ax1.set_title("Linear regression")
ax1.set(ylabel='Energy [fJ]')
im = ax2.scatter(X_test[:,2], y_pred_xgb, s=s, c = X_test[:,1] , cmap='viridis')

fig.text(0.52,0.005, 'Toggle rate percentage', ha="center", va="center")

ax2.set_title("XGB regression")
fig.tight_layout()
cbar = fig.colorbar(im)
cbar.set_ticks([8, 16, 24, 32])
cbar.set_ticklabels(['8', '16', '24', '32'])
cbar.set_label("datawidth")
plt.savefig('x_test versus y_pred.pdf', bbox_inches = "tight")


# ######################
# #DATA
# plt.title("Energy Test dataframe")
# plt.scatter(X_test[:,2], y_test, s=20, c = X_test[:,1] , cmap='viridis')
# plt.colorbar()
# plt.xlabel('Toggle percentage')
# plt.ylabel('Energy [fJ]')
# plt.savefig("Test dataframe energy.pdf")
# plt.show()


# ######################
# #LINEAR REGRESSION

# #Cross validation
# lr = LinearRegression()
# lr.fit(X_train, y_train)
# y_pred = lr.predict(X_test)

# plt.scatter(X_test[:,2], y_pred, s=20, c = X_test[:,1] , cmap='viridis')
# plt.colorbar()
# plt.title("Energy linear regression prediction")
# plt.xlabel('Toggle percentage')
# plt.ylabel('Energy [fJ]')
# plt.savefig("Energy linear regression dataframe.pdf")
# plt.show()

# plt.title("Energy linear regression: Test vs predicted values")
# plt.scatter(y_test, y_pred, s=20)
# plt.savefig("Energy linear test vs predicted.pdf")
# plt.show()

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
# y_pred = reg_xgb.predict(X_test)
# plt.scatter(X_test[:,2], y_pred, s=20, c = X_test[:,1] , cmap='viridis')
# plt.colorbar()
# plt.title("Energy XGB prediction")
# plt.xlabel('Toggle percentage')
# plt.ylabel('Energy [fJ]')
# plt.savefig("Energy XGB regression dataframe.pdf")
# plt.show()

# plt.title("Energy XGB: Test vs predicted values")
# plt.scatter(y_test, y_pred, s=20)
# plt.savefig("Energy XGB test vs predicted.pdf")
# plt.show()

# ###############################################################
# #RANDOM FOREST
# reg_forest = RandomForestRegressor(n_estimators = 100, random_state = 0)
# reg_forest.fit(X_train, y_train)
# y_pred = reg_forest.predict(X_test)

# plt.scatter(X_test[:,2], y_pred, s=20, c = X_test[:,1] , cmap='viridis')
# plt.colorbar()
# plt.title("Energy random forest prediction")
# plt.xlabel('Toggle percentage')
# plt.ylabel('Energy [fJ]')
# plt.savefig("Energy random forest regression dataframe.pdf")
# plt.show()

# plt.title("Energy random forest: Test vs predicted values")
# plt.scatter(y_test, y_pred, s=20)
# plt.savefig("Energy random forest test vs predicted.pdf")
# plt.show()




# ###############################################################
# #LASSO

# reg_lasso = linear_model.Lasso(alpha=0.1)
# reg_lasso.fit(X_train, y_train)
# y_pred = reg_lasso.predict(X_test)

# plt.scatter(X_test[:,2], y_pred, s=20, c = X_test[:,1] , cmap='viridis')
# plt.colorbar()
# plt.title("Energy Lasso prediction")
# plt.xlabel('Toggle percentage')
# plt.ylabel('Energy [fJ]')
# plt.savefig("Energy Lasso regression dataframe.pdf")
# plt.show()

# plt.title("Energy Lasso: Test vs predicted values")
# plt.scatter(y_test, y_pred, s=20)
# plt.savefig("Energy Lasso test vs predicted.pdf")
# plt.show()

# ###################################################
# #AREA
# ##################################################

# X_train, X_test, y_train, y_test = train_test_split(X_list_area, y_area, test_size=0.3, random_state=4)

# ######################
# #DATA
# plt.title("Area test dataframe")
# plt.scatter(X_test[:,0], y_test, s=20, c = X_test[:,1], cmap='viridis')
# plt.colorbar()
# plt.xticks(range(2,5))
# plt.xlabel('Input ports')
# plt.ylabel('Area [um2]')
# plt.savefig("Test dataframe area.pdf")
# plt.show()

# ######################
# #LINEAR REGRESSION
# lr = LinearRegression()
# lr.fit(X_train, y_train)
# y_pred = lr.predict(X_test)

# plt.scatter(X_test[:,0], y_pred, s=20, c = X_test[:,1], cmap='viridis')
# plt.colorbar()
# plt.title("Area linear prediction")
# plt.xticks(range(2,5))
# plt.xlabel('Input ports')
# plt.ylabel('Area [um2]')
# plt.savefig("Area linear regression dataframe.pdf")
# plt.show()

# plt.title("Area linear: Test vs predicted values")
# plt.scatter(y_test, y_pred, s=20)
# plt.savefig("Area linear test vs predicted.pdf")
# plt.show()

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


# #Metrics
# y_pred = reg_xgb.predict(X_test)
# #print(X_train[:,1])
# #print(X_test[:,1])
# # The mean squared error

# # The coefficient of determination: 1 is perfect prediction

# plt.scatter(X_test[:,0], y_pred, s=20, c = X_test[:,1], cmap='viridis')
# plt.colorbar()
# plt.title("Area XGB prediction")
# plt.xticks(range(2,5))
# plt.xlabel('Input ports')
# plt.ylabel('Area [um2]')
# plt.savefig("Area XGB regression dataframe.pdf")
# plt.show()

# plt.title("Area XGB: Test vs predicted values")
# plt.scatter(y_test, y_pred, s=20)
# plt.savefig("Area XGB test vs predicted.pdf")
# plt.show()

# ###############################################################
# #RANDOM FOREST
# plt.scatter(X_test[:,0], y_pred, s=20, c = X_test[:,1], cmap='viridis')
# plt.colorbar()
# plt.title("Area random forest prediction")
# plt.xticks(range(2,5))
# plt.xlabel('Input ports')
# plt.ylabel('Area [um2]')
# plt.savefig("Area random forest regression dataframe.pdf")
# plt.show()

# plt.title("Area random forest: Test vs predicted values")
# plt.scatter(y_test, y_pred, s=20)
# plt.savefig("Area random forest test vs predicted.pdf")
# plt.show()

# ###############################################################
# #LASSO

# reg_lasso = linear_model.Lasso(alpha=0.1)
# reg_lasso.fit(X_train, y_train)
# y_pred = reg_lasso.predict(X_test)

# plt.scatter(X_test[:,0], y_pred, s=20, c = X_test[:,1], cmap='viridis')
# plt.colorbar()
# plt.title("Area Lasso prediction")
# plt.xticks(range(2,5))
# plt.xlabel('Input ports')
# plt.ylabel('Area [um2]')
# plt.savefig("Area Lasso regression dataframe.pdf")
# plt.show()

# plt.title("Area Lasso: Test vs predicted values")
# plt.scatter(y_test, y_pred, s=20)
# plt.savefig("Area Lasso test vs predicted.pdf")
# plt.show()

