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

DF_PATH = os.path.expanduser("~/Estimation/sim/adder/dataframe/adder_configurations.csv")
df = pd.read_csv(DF_PATH, sep=',')

df_energy = df[['BW', 'PERCENTAGE', 'Energy [fJ]']].copy()
df_area = df[['BW', 'Area [um^2]']].copy()


X_list_energy = df_energy.drop('Energy [fJ]', axis=1).values #"INPUT", "BW" and "PERCENTAGE"
X_list_area = df_area.drop('Area [um^2]', axis=1).values #"INPUT" and "BW"  

y_energy = df_energy['Energy [fJ]'].values 
y_area = df_area['Area [um^2]'].values


#ENERGY
####################
X_train, X_test, y_train, y_test = train_test_split(X_list_energy, y_energy, test_size=0.2, random_state=4, shuffle=True)

#######################
#Cross validation
k = 10
kf = KFold(n_splits=k, random_state=1, shuffle=True) #generate the cross-validation estimator to split the lists into train ad test


table_values = []


######################
#LINEAR REGRESSION
lr = LinearRegression()
lr.fit(X_train, y_train)
y_pred = lr.predict(X_test)
result = cross_val_score(lr , X_list_energy, y_energy, scoring='r2', cv=kf) #use the MAE metrics for the cross validation
linear_cv = mean(absolute(result))


f = open("Metrics.txt", "w")
f.write("**ENERGY METRICS**\n")
f.write("Linear Crossvalidation: " + format(linear_cv) + "\n")
f.write("Linear regression MAE: " + str(mean_absolute_error(y_test, y_pred)) + "\n")
f.write("Linear regression MSE: " + str(mean_squared_error(y_test, y_pred)) + "\n")
f.write("Linear regression MAPE: " + str(mean_absolute_percentage_error(y_test, y_pred)) + "\n")
ML = "Linear"
table_values.append([ML,"Cross-validation",format(linear_cv)])
table_values.append([ML,"MAE",str(mean_absolute_error(y_test, y_pred))])
table_values.append([ML,"MSE",str(mean_squared_error(y_test, y_pred))])
table_values.append([ML,"MAPE",str(mean_absolute_percentage_error(y_test, y_pred))])


######################
#Support Vector regression SVG

##HOW TO DEFINE THE SVG PARAMETERS:
# C_arr = [10**i for i in range(-1, 4)]
# eps_arr = [10**i for i in range(0, -6, -1)]
# hyper_arr = []
# hyper_cols =  ['c','epsilon','correlation']
# for C in C_arr:
#     for epsilon in eps_arr:
#         model = SVR(kernel='rbf', C=C, epsilon=epsilon)
#         svr = model.fit(X_train, y_train)
#         Y_pred = model.predict(X_test)
#         corr = stats.pearsonr(y_test,Y_pred)[0]
#         hyper_arr.append([C,epsilon,corr])

# hyper_df = pd.DataFrame(hyper_arr,columns= hyper_cols)
# hyper_df = hyper_df.sort_values(by=['correlation'], ascending=False)
# hyper_df
#c=1000.0  epsilon=1.00000 return the best correlation (0.996)

svr = SVR(kernel='rbf', C=1000, epsilon=1)
svr.fit(X_train, y_train)
y_pred = svr.predict(X_test)
result = cross_val_score(svr , X_list_energy, y_energy, scoring='r2', cv=kf) #use the MAE metrics for the cross validation
svr_cv = mean(absolute(result))
f.write("SVG Cross validation " + format(svr_cv) + "\n")
f.write("SVG regression MAE: " + str(mean_absolute_error(y_test, y_pred)) + "\n")
f.write("SVG regression MSE: " + str(mean_squared_error(y_test, y_pred)) + "\n")
f.write("SVG regression MAPE: " + str(mean_absolute_percentage_error(y_test, y_pred)) + "\n")
ML = "SVG"
table_values.append([ML,"Cross-validation",format(svr_cv)])
table_values.append([ML,"MAE",str(mean_absolute_error(y_test, y_pred))])
table_values.append([ML,"MSE",str(mean_squared_error(y_test, y_pred))])
table_values.append([ML,"MAPE",str(mean_absolute_percentage_error(y_test, y_pred))])

############################################
#DECISION TREE REGRESSOR

dc_regr = DecisionTreeRegressor(max_depth=10)
dc_regr.fit(X_train, y_train)
y_pred = dc_regr.predict(X_test)
result = cross_val_score(dc_regr , X_list_energy, y_energy, scoring='r2', cv=kf) #use the MAE metrics for the cross validation
dc_cv = mean(absolute(result))
f.write("Decision tree Cross validation " + format(dc_cv) + "\n")
f.write("Decision tree regression MAE: " + str(mean_absolute_error(y_test, y_pred)) + "\n")
f.write("Decision tree regression MSE: " + str(mean_squared_error(y_test, y_pred)) + "\n")
f.write("Decision tree regression MAPE: " + str(mean_absolute_percentage_error(y_test, y_pred)) + "\n")
ML = "Decision tree"
table_values.append([ML,"Cross-validation",format(dc_cv)])
table_values.append([ML,"MAE",str(mean_absolute_error(y_test, y_pred))])
table_values.append([ML,"MSE",str(mean_squared_error(y_test, y_pred))])
table_values.append([ML,"MAPE",str(mean_absolute_percentage_error(y_test, y_pred))])

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
result = cross_val_score(reg_xgb, X_list_energy, y_energy, scoring='r2', cv=kf) #use the MAE metrics for the cross validation
reg_xgb_cv = mean(absolute(result))
y_pred = reg_xgb.predict(X_test)

f.write("XGB Cross validation avg r-squared: "+format(reg_xgb_cv)+"\n")
f.write("XGB regression MAE: "+ str(mean_absolute_error(y_test, y_pred))+ "\n")
f.write("XGB regression MSE: " + str(mean_squared_error(y_test, y_pred))+ "\n")
f.write("XGB regression MAPE: " + str(mean_absolute_percentage_error(y_test, y_pred)) + "\n")

ML = "XGB"
table_values.append([ML,"Cross-validation",format(reg_xgb_cv)])
table_values.append([ML,"MAE",str(mean_absolute_error(y_test, y_pred))])
table_values.append([ML,"MSE",str(mean_squared_error(y_test, y_pred))])
table_values.append([ML,"MAPE",str(mean_absolute_percentage_error(y_test, y_pred))])


###############################################################
#RANDOM FOREST
reg_forest = RandomForestRegressor(n_estimators = 1000, random_state = 0)
reg_forest.fit(X_train, y_train)
result = cross_val_score(reg_forest, X_list_energy, y_energy, scoring='r2', cv=kf) #use the MAE metrics for the cross validation
reg_forest_cv = mean(absolute(result))
y_pred = reg_forest.predict(X_test)

f.write("Random forest Cross validation avg r-squared: "+format(reg_forest_cv)+"\n")
f.write("Random forest regression MAE: " + str(mean_absolute_error(y_test, y_pred)) + "\n")
f.write("Random forest regression MSE: " + str(mean_squared_error(y_test, y_pred)) + "\n")
f.write("Random forest regression MAPE: " + str(mean_absolute_percentage_error(y_test, y_pred)) + "\n")

ML = "Random forest"
table_values.append([ML,"Cross-validation",format(reg_forest_cv)])
table_values.append([ML,"MAE",str(mean_absolute_error(y_test, y_pred))])
table_values.append([ML,"MSE",str(mean_squared_error(y_test, y_pred))])
table_values.append([ML,"MAPE",str(mean_absolute_percentage_error(y_test, y_pred))])


###############################################################
#LASSO

reg_lasso = linear_model.Lasso(alpha=0.1)
reg_lasso.fit(X_train, y_train)
result = cross_val_score(reg_lasso, X_list_energy, y_energy, scoring='r2', cv=kf) #use the MAE metrics for the cross validation
reg_lasso_cv = mean(absolute(result))
y_pred = reg_lasso.predict(X_test)
f.write("Lasso cross validation avg r-squared: "+format(reg_lasso_cv)+"\n")
f.write("Lasso regression MAE: " + str(mean_absolute_error(y_test, y_pred)) + "\n")
f.write("Lasso regression MSE: " + str(mean_squared_error(y_test, y_pred)) + "\n")
f.write("Lasso regression MAPE: " + str(mean_absolute_percentage_error(y_test, y_pred)) + "\n")

ML = "Lasso"
table_values.append([ML,"Cross-validation",format(reg_lasso_cv)])
table_values.append([ML,"MAE",str(mean_absolute_error(y_test, y_pred))])
table_values.append([ML,"MSE",str(mean_squared_error(y_test, y_pred))])
table_values.append([ML,"MAPE",str(mean_absolute_percentage_error(y_test, y_pred))])


#DUMP ENERGY METRICS
table_columns =  ['ML','Metric','Score']
table_df = pd.DataFrame(table_values, columns=table_columns)
table_df.to_csv('ML metrics.csv', index=False)



###################################################
#AREA
##################################################

X_train, X_test, y_train, y_test = train_test_split(X_list_area, y_area, test_size=0.3, random_state=4)

k = 10
kf = KFold(n_splits=k, random_state=1, shuffle=True) #generate the cross-validation estimator to split the lists into train ad test
lr = LinearRegression()
 
result = cross_val_score(lr , X_list_area, y_area, scoring='r2', cv=kf) #use the MAE metrics for the cross validation
linear_cv = mean(absolute(result))

######################
#LINEAR REGRESSION
lr.fit(X_train, y_train)
y_pred = lr.predict(X_test)

# The coefficients
f.write("\n**AREA METRICS**\nCoefficients linear regression: "+ str(lr.coef_)+ "\n")
f.write("Linear Cross validation avg r-squared: " + format(linear_cv) + "\n")

# The mean squared error
f.write("Linear regression MAE: %.2f " + str(mean_absolute_error(y_test, y_pred)) + "\n")
f.write("Linear regression MSE: %.2f " + str(mean_squared_error(y_test, y_pred)) + "\n")
# The coefficient of determination: 1 is perfect prediction

############################################
#EXTREME GRADIENT BOOSTING
params = {
    "n_estimators": 100,
    "max_depth": 4,
    "min_samples_split": 5,
    "learning_rate": 0.1,
    "loss": "squared_error",
}

reg_xgb = ensemble.GradientBoostingRegressor(**params)
reg_xgb.fit(X_train, y_train)

#Cross validation
result = cross_val_score(reg_xgb, X_list_area, y_area, scoring='r2', cv=kf) #use the MAE metrics for the cross validation
reg_xgb_cv = mean(absolute(result))



f.write("XGB Cross validation avg r-squared: "+format(reg_xgb_cv)+"\n")
#Metrics
y_pred = reg_xgb.predict(X_test)
#print(X_train[:,1])
#print(X_test[:,1])
# The mean squared error
f.write("XGB regression MAE: "+ str(mean_absolute_error(y_test, y_pred))+ "\n")
f.write("XGB regression MSE: " + str(mean_squared_error(y_test, y_pred))+ "\n")
# The coefficient of determination: 1 is perfect prediction


###############################################################
#RANDOM FOREST
reg_forest = RandomForestRegressor(n_estimators = 100, random_state = 0)
reg_forest.fit(X_train, y_train)

#Cross validation
result = cross_val_score(reg_forest, X_list_area, y_area, scoring='r2', cv=kf) #use the MAE metrics for the cross validation
reg_forest_cv = mean(absolute(result))
f.write("Random forest Cross validation avg r-squared: "+format(reg_forest_cv)+"\n")
#Metrics
y_pred = reg_forest.predict(X_test)
#print(X_train[:,1])
#print(X_test[:,1])
# The mean squared error
f.write("Random forest regression MAE: " + str(mean_absolute_error(y_test, y_pred)) + "\n")
f.write("Random forest regression MSE: " + str(mean_squared_error(y_test, y_pred)) + "\n")
# The coefficient of determination: 1 is perfect prediction


###############################################################
#LASSO

reg_lasso = linear_model.Lasso(alpha=0.1)
reg_lasso.fit(X_train, y_train)

#Cross validation
result = cross_val_score(reg_lasso, X_list_area, y_area, scoring='r2', cv=kf) #use the MAE metrics for the cross validation
reg_lasso_cv = mean(absolute(result))
f.write("Lasso cross validation avg r-squared: "+format(reg_lasso_cv)+"\n")
#Metrics
y_pred = reg_lasso.predict(X_test)
f.write("Lasso regression MAE: " + str(mean_absolute_error(y_test, y_pred)) + "\n")
f.write("Lasso regression MSE: " + str(mean_squared_error(y_test, y_pred)) + "\n")


f.close()