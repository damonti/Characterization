#Importing required packages.
import pandas as pd
import seaborn as sns
import matplotlib as mpl
import matplotlib.pyplot as plt
from matplotlib import cm  
#from sklearn.linear_model import SGDClassifier
from sklearn.metrics import mean_squared_error, r2_score, mean_absolute_error, accuracy_score
from sklearn.preprocessing import StandardScaler, LabelEncoder
from sklearn.model_selection import train_test_split, KFold, cross_val_score
from sklearn import ensemble
import os
import numpy as np
from numpy import mean
from numpy import absolute
from sklearn.linear_model import LinearRegression, LogisticRegression
from sklearn.ensemble import RandomForestRegressor
import xgboost as xgb
import scikitplot as skplt

DF_PATH = os.path.expanduser("~/Estimation/sim/adder/dataframe/adder_configurations.csv")
df = pd.read_csv(DF_PATH, sep=',')



X_list = df.drop('POWER [nW]', axis=1).values #"BW" and "PERCENTAGE"
y_list = df['POWER [nW]'].values #"POWER [nW]""


####################
k = 10
kf = KFold(n_splits=k, random_state=1, shuffle=True) #generate the cross-validation estimator to split the lists into train ad test
lr = LinearRegression()
 
result = cross_val_score(lr , X_list, y_list, scoring='r2', cv=kf) #use the MAE metrics for the cross validation
linear_cv = mean(absolute(result))


###################
X_train, X_test, y_train, y_test = train_test_split(X_list, y_list, test_size=0.3, random_state=4)


######################
#Linear regression
lr.fit(X_train, y_train)
y_pred = lr.predict(X_test)
#print(X_train[:,1])
#print(X_test[:,1])
# The coefficients
f = open("Metrics.txt", "w")
f.write("Cross validation avg r-squared: " + format(linear_cv) + "\n")
f.write("Coefficients linear regression: "+ str(lr.coef_)+ "\n")
# The mean squared error
f.write("Linear regression MAE: %.2f " + str(mean_absolute_error(y_test, y_pred)) + "\n")
f.write("Linear regression MSE: %.2f " + str(mean_squared_error(y_test, y_pred)) + "\n")
# The coefficient of determination: 1 is perfect prediction

plt.title("Test dataframe")
#plt.scatter(X_test[:,1], y_test, color="black") #Displaying for x=percentage, and BW is parametrized
cmap = cm.get_cmap("plasma")
#groups = df.groupby('BW')
#for bw, group in groups:
#    plt.scatter(X_test[:,1], y_test, c = cmap(1.*X_test[:,0]/max(X_test[:,0])), label=bw)
plt.scatter(X_test[:,0], y_test, s=20, c = cmap(1.*X_test[:,1]/max(X_test[:,1])))

plt.colorbar()
#plt.plot(X_test[:,1], mean(y_pred), c = 'blue') 

#sns.lmplot(x='PERCENTAGE', y='POWER [nW]', data=df, hue='color', fit_reg=False)
#add colors for each set of BW
plt.xlabel('Bitwidth')
plt.ylabel('Power [nW]')
plt.savefig('destination_path.eps', format='eps')
#.plot(X_test[:,1], y_pred, color="blue", linewidth=3)
plt.show()


plt.scatter(X_test[:,0], y_pred, s=20, c = cmap(1.*X_test[:,1]/max(X_test[:,1])))
plt.title("Linear regression prediction")
plt.xlabel('Bitwidth')
plt.ylabel('Power [nW]')
plt.show()
plt.title("Linear regression: Test vs predicted values")
plt.scatter(y_test, y_pred)
plt.show()
# ######################
#Extrebe gradient boosting
# xgb_model = xgb.XGBRegressor(objective="reg:linear", random_state=42)
# xgb_model.fit(X_train, y_train)
# score = xgb_model.score(X_train, y_train)
# print("Training score: ", score)

# result = cross_val_score(xgb_model, X_list, y_list, scoring='r2', cv=kf) #use the MAE metrics for the cross validation
# xgb_cv = mean(absolute(result))
# print("Cross validation avg r-squared: {}".format(xgb_cv))


# print("CV mean score: ", cv_score)
# y_pred = xgb_model.predict(X_test)
# mse=mean_squared_error(y_test, y_pred)
# print("MSE: ", mse)
# print("RMSE: ", mse**(1/2.0))
# #print("XGBoost root MSE:", np.sqrt(mse))
# #xgb.plot_importance(xgb_model)


# # The mean squared error
# print("XGB MSE: %.2f \n" % mean_squared_error(y_test, y_pred))
# print("XGB MAE: %.2f \n" % mean_absolute_error(y_test, y_pred))
# # The coefficient of determination: 1 is perfect prediction
# print("XBG Coefficient of determination: %.2f \n" % r2_score(y_test, y_pred))
# # Plot outputs
# plt.scatter(X_test, y_test, color="black")
# plt.plot(X_test, y_pred, color="blue", linewidth=3)

# # plt.xticks(())
# # plt.yticks(())

# # plt.show()



# # #rfc = RandomForestClassifier(n_estimators=200)
# # #rfc.fit(X_train, y_train)
# # #pred_rfc = rfc.predict(X_test)

# # #  print(classification_report(y_test, pred_rfc))


############################################
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
result = cross_val_score(reg_xgb, X_list, y_list, scoring='r2', cv=kf) #use the MAE metrics for the cross validation
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

plt.title("XGB regression prediction")

cmap = cm.get_cmap("plasma")
plt.scatter(X_test[:,0], y_pred, s=20, c = cmap(1.*X_test[:,1]/max(X_test[:,1])))
plt.xlabel('Bitwidth')
plt.ylabel('Power [nW]')
plt.show()
plt.title("XGB: Test vs predicted values")
plt.scatter(y_test, y_pred)
plt.show()
###############################################################

reg_forest = RandomForestRegressor(n_estimators = 100, random_state = 0)
reg_forest.fit(X_train, y_train)

#Cross validation
result = cross_val_score(reg_forest, X_list, y_list, scoring='r2', cv=kf) #use the MAE metrics for the cross validation
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
f.close()
plt.title("Random forest regression prediction")

cmap = cm.get_cmap("plasma")
plt.scatter(X_test[:,0], y_pred, s=20, c = cmap(1.*X_test[:,1]/max(X_test[:,1])))
plt.xlabel('Bitwidth')
plt.ylabel('Power [nW]')
plt.show()
plt.title("Random forest: Test vs predicted values")
plt.scatter(y_test, y_pred)
plt.show()


#INSERT LASSO