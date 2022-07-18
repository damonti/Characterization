#Importing required packages.
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from sklearn.ensemble import RandomForestClassifier
from sklearn.svm import SVC
#from sklearn.linear_model import SGDClassifier
from sklearn.metrics import confusion_matrix, classification_report, mean_squared_error
from sklearn.preprocessing import StandardScaler, LabelEncoder
from sklearn.model_selection import train_test_split
import os
import numpy as np
from sklearn.linear_model import LinearRegression
import xgboost as xgb
import scikitplot as skplt

DF_PATH = os.path.expanduser("~/Estimation/sim/mux/DataFrame/mux_configurations.csv")
df = pd.read_csv(DF_PATH, sep=',')

X_list = df.drop('POWER [nW]', axis=1).values #generate the mux configurations
y_list = df['POWER [nW]'].values #generate a csv out of the power data. the CONFIGS is needed to find the parametrized report name

X_train, X_test, y_train, y_test = train_test_split(X_list, y_list, test_size=0.3, random_state=4)

lr = LinearRegression()
lr.fit(X_train, y_train)
pred_lr = lr.predict(X_test)

print("Linear regression root MSE:", np.sqrt(mean_squared_error(y_test, pred_lr)), "\n")
#linear cross validation
skplt.estimators.plot_learning_curve(LinearRegression(), X_list, y_list,
                                     cv=7, shuffle=True, scoring="r2", n_jobs=-1,
                                     figsize=(6,4), title_fontsize="large", text_fontsize="large",
                                     title="Boston Regression Learning Curve ");

#Lasso

xgb_model = xgb.XGBRegressor(objective="reg:linear", random_state=42)
xgb_model.fit(X_train, y_train)
y_pred = xgb_model.predict(X_test)
mse=mean_squared_error(y_test, y_pred)

print("XGBoost root MSE:", np.sqrt(mse))
xgb.plot_importance(xgb_model)




#rfc = RandomForestClassifier(n_estimators=200)
#rfc.fit(X_train, y_train)
#pred_rfc = rfc.predict(X_test)

#  print(classification_report(y_test, pred_rfc))