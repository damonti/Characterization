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

DF_PATH = os.path.expanduser("~/Estimation/sim/adder/dataframe/adder_configurations.csv")
df = pd.read_csv(DF_PATH, sep=',')

df_energy = df[['BW', 'PERCENTAGE', 'Energy [fJ]']].copy()
df_area = df[['BW', 'Area [um^2]']].copy()


X_list_energy = df_energy.drop('Energy [fJ]', axis=1).values #"INPUT", "BW" and "PERCENTAGE"
X_list_area = df_area.drop('Area [um^2]', axis=1).values #"INPUT" and "BW"  

y_energy = df_energy['Energy [fJ]'].values 
y_area = df_area['Area [um^2]'].values

table_values = []
#ENERGY
####################
X_train, X_test, y_train, y_test = train_test_split(X_list_energy, y_energy, test_size=0.2, random_state=4, shuffle=True)


model_params = {
    
    # 'lasso': {
    #     'model': linear_model.Lasso(),
    #     'params' : {
    #         'alpha': [0.01,0.05,0.1],
    #     }  
    # },
    
    # 'linear': {
    #     'model': LinearRegression(),
    #     'params' : {
    #     }
    # },      
    
    # 'svm': {
    #     'model': SVR(gamma='auto'),
    #     'params' : {
    #         'C': [1,10,1000],
    #         'epsilon': [0.1, 0.5, 1],
    #         'kernel': ['rbf','linear']
    #     }  
    # },
    
    # 'random_forest': {
    #     'model': RandomForestRegressor(),
    #     'params' : {
    #         'n_estimators': [1, 50, 100],
    #         'max_features': [1, 10], 
    #     }
    # },
    
    # 'decision_tree': {
    #     'model': DecisionTreeRegressor(),
    #     'params' : {
    #         'max_depth': [1, 10, 100],
    #     }
    # },
    
    'XGB' : {
        'model': GradientBoostingRegressor(),
        'params': {
            'n_estimators': [2000, 2500, 3000],
            "max_depth": [3, 4],
            "min_samples_split": [3, 4, 5],
            "learning_rate": [0.02, 0.05, 0.07],
            "loss": ['squared_error']
        }
    }
}


scores = []

for model_name, mp in model_params.items():
    rg =  GridSearchCV(mp['model'], mp['params'], cv=5, return_train_score=False)
    rg.fit(X_train, y_train)
    scores.append({
        'model': model_name,
        'best_score': rg.best_score_,
        'best_params': rg.best_params_
    })
    
df = pd.DataFrame(scores,columns=['model','best_score','best_params'])
df.to_csv('ML_param_adder_XGB.csv', index=False)