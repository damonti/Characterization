import matplotlib.pyplot as plt
import numpy as np
import pandas as pd 
#DISPLAY THE NORMALIZED MAE OF THE VARIOUS ML ALGORITHMS FOR EACH COMPONENT

####################################
#ENERGY

# Define Data
df = pd.read_csv('~/Estimation/sim/mux/scripts/temp/ML metrics.csv')
print(df)

data=[["mux", 500, 100, 350, 250, 400, 600],
      ["adder", 130, 536, 402, 500, 350, 250],
      ["multiplier", 230, 330, 500, 450, 600, 298]
     ]

# Plot multiple groups

df.plot(x="component", y=["linear", "lasso", "Random Forest", "XGB", "Decision Tree", "SVG"], kind="bar",
 figsize=(8,4))

# Show

plt.show()




components = ['multiplexer', 'adder', 'multiplier']
linear_MAPE = [100-18.44, 100-67.31, 100-31.01]
lasso_MAPE = [100-18.35, 100-66.31, 30.98]
gradboosting_MAPE = [100-1.42, 100-3.56, 100-1.60]
forest_MAPE = [100-1.99, 100-4.62, 100-4.27]

x = np.arange(len(components))  # the label locations
width = 0.25  # the width of the bars

fig, ax = plt.subplots()
rects1 = ax.bar(x - 3*(width/2), linear_MAPE, width, label='linear')
rects2 = ax.bar(x - width/2, lasso_MAPE, width, label='lasso')
rects3 = ax.bar(x + width/2, gradboosting_MAPE, width, label='XGB')
rects4 = ax.bar(x + 3*(width/2), forest_MAPE, width, label='rnd forest')

# Add some text for labels, title and custom x-axis tick labels, etc.
ax.set_ylabel('1 - MAPE')
ax.set_title('Energy MAPE scores ML algorithms')
ax.set_xticks(x, components)
ax.legend()

ax.bar_label(rects1, padding=3)
ax.bar_label(rects2, padding=3)
ax.bar_label(rects3, padding=3)
ax.bar_label(rects4, padding=3)

fig.tight_layout()
plt.savefig("histogram_ML_mux.pdf")
plt.show()



####################################
#AREA
# linear_MAE = [11.91, 0, 314.04]
# lasso_MAE = [11.91, 0, 314.04]
# gradboosting_MAE = [0.03, 0, 1.53]
# forest_MAE = [0.01, 1.81, 0]

# x = np.arange(len(components))  # the label locations
# width = 0.35  # the width of the bars

# fig, ax = plt.subplots()
# rects1 = ax.bar(x - 3*(width/2), linear_MAE, width, label='linear')
# rects2 = ax.bar(x - width/2, lasso_MAE, width, label='lasso')
# rects3 = ax.bar(x + width/2, gradboosting_MAE, width, label='XGB')
# rects4 = ax.bar(x + 3*(width/2), forest_MAE, width, label='rnd forest')

# # Add some text for labels, title and custom x-axis tick labels, etc.
# ax.set_ylabel('MAE')
# ax.set_title('Area MAE scores ML algorithms')
# ax.set_xticks(x, components)
# ax.legend()

# ax.bar_label(rects1, padding=3)
# ax.bar_label(rects2, padding=3)
# ax.bar_label(rects3, padding=3)
# ax.bar_label(rects4, padding=3)

# fig.tight_layout()

# plt.show()