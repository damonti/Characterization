#Importing required packages.
from locale import dcgettext
import pandas as pd
from sklearn.model_selection import train_test_split, KFold, cross_val_score
from sklearn import ensemble, linear_model
import os
from sklearn.linear_model import LinearRegression, LogisticRegression
from sklearn.ensemble import GradientBoostingRegressor, RandomForestRegressor
import xgboost as xgb
from sklearn.svm import SVR
from scipy import stats
from sklearn.tree import DecisionTreeRegressor
from sklearn.model_selection import GridSearchCV, RandomizedSearchCV

DESIGN ="multiplier_fir"
SIM_PATH = os.path.expanduser("~/Estimation/sim/fir/"+DESIGN)
DF_PATH = SIM_PATH+ "/dataframe/"+DESIGN+"_configurations.csv"
df = pd.read_csv(DF_PATH, sep=',')

df_energy = df[['BW', 'PERCENTAGE', 'Power [nW]']].copy()
df_area = df[['BW', 'Area [um^2]']].copy()


X_list_energy = df_energy.drop('Power [nW]', axis=1).values #"INPUT", "BW" and "PERCENTAGE"
X_list_area = df_area.drop('Area [um^2]', axis=1).values #"INPUT" and "BW"  

y_energy = df_energy['Power [nW]'].values 
y_area = df_area['Area [um^2]'].values

table_values = []
#ENERGY
####################
X_train, X_test, y_train, y_test = train_test_split(X_list_energy, y_energy, test_size=0.2, random_state=4, shuffle=True)


model_params = {
    
    # 'lasso': {
    #     'model': linear_model.Lasso(),
    #     'params' : {
    #         'alpha': [0.01, 0.05, 0.1, 0.13],
    #         'fit_intercept': [True, False]
    #     }  
    # },
    
    # 'linear': {
    #     'model': LinearRegression(),
    #     'params' : {
    #         'fit_intercept': [True, False]
    #     }
    # },      
    
    # 'svr': {
    #     'model': SVR(gamma='auto'),
    #     'params' : {
    #         'C': [75, 125],
    #         'epsilon': [0.06, 0.14],
    #         'kernel': ['rbf', 'linear', 'poly'],
    #         #'degree': [3, 4],
    #         #'coef0' : [0.0, 0.1, 1.0],
    #     }  
    # },
    
    # 'random_forest': {
    #     'model': RandomForestRegressor(),
    #     'params' : {
    #         'n_estimators': [50, 100, 500],
    #         'max_features': [1, 10], 
    #         'criterion' : ["squared_error", "absolute_error", "poisson"],
    #         'max_depth' : ["None", 4]
    #     }
    # },
    
    # 'decision_tree': {
    #     'model': DecisionTreeRegressor(),
    #     'params' : {
    #         'max_depth': [1, 10, 100],
    #         'splitter' : ["best", "random"],
    #         'criterion' : ["squared_error", "friedman_mse", "absolute_error", "poisson"]
    #     }
    # },
    
    'XGB' : {
        'model': GradientBoostingRegressor(),
        'params': {
            'n_estimators': [1800, 2000, 2200],
            "max_depth": [3],
            "min_samples_split": [3],
            "learning_rate": [0.1, 0.08, 0.12],
            "loss": ['squared_error' , 'huber'],
            #"loss": ['squared_error', 'absolute_error', 'huber', 'quantile'],
            #"criterion" : ['friedman_mse', 'squared_error', 'mse']
        }
    },
    
    # 'Ada' : {
    #     'model': AdaBoostRegressor(),
    #     'params': {
    #         'n_estimators': [1000, 2000, 3000],
    #         "max_depth": [3, 4],
    #         "min_samples_split": [3, 4],
    #         "learning_rate": [0.05, 0.1],
    #         "loss": ['squared_error' , 'huber'],
    #         #"loss": ['squared_error', 'absolute_error', 'huber', 'quantile'],
    #         #"criterion" : ['friedman_mse', 'squared_error', 'mse']
    #     }
    # }
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
    
df = pd.DataFrame(scores,columns=['model','best_score','best_params'])
df.to_csv(SIM_PATH+'/ML/ML_param_tuning_XGB.csv', index=False)