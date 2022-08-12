import matplotlib.pyplot as plt
import numpy as np

#DISPLAY THE NORMALIZED MAE OF THE VARIOUS ML ALGORITHMS FOR EACH COMPONENT

####################################
#ENERGY
components = ['multiplexer', 'adder', 'multiplier']
linear_MAE = [8.91, 46.17, 860]
lasso_MAE = [8.92, 46.16, 859]
gradboosting_MAE = [1.90, 5.56, 169.80]
forest_MAE = [1.87, 7.00, 171.38]

x = np.arange(len(components))  # the label locations
width = 0.25  # the width of the bars

fig, ax = plt.subplots()
rects1 = ax.bar(x - 3*(width/2), linear_MAE, width, label='linear')
rects2 = ax.bar(x - width/2, lasso_MAE, width, label='lasso')
rects3 = ax.bar(x + width/2, gradboosting_MAE, width, label='XGB')
rects4 = ax.bar(x + 3*(width/2), forest_MAE, width, label='rnd forest')

# Add some text for labels, title and custom x-axis tick labels, etc.
ax.set_ylabel('MAE')
ax.set_title('Energy MAE scores ML algorithms')
ax.set_xticks(x, components)
ax.legend()

ax.bar_label(rects1, padding=3)
ax.bar_label(rects2, padding=3)
ax.bar_label(rects3, padding=3)
ax.bar_label(rects4, padding=3)

fig.tight_layout()

plt.show()



####################################
#AREA
linear_MAE = [11.91, 0, 314.04]
lasso_MAE = [11.91, 0, 314.04]
gradboosting_MAE = [0.03, 0, 1.53]
forest_MAE = [0.01, 1.81, 0]

x = np.arange(len(components))  # the label locations
width = 0.35  # the width of the bars

fig, ax = plt.subplots()
rects1 = ax.bar(x - 3*(width/2), linear_MAE, width, label='linear')
rects2 = ax.bar(x - width/2, lasso_MAE, width, label='lasso')
rects3 = ax.bar(x + width/2, gradboosting_MAE, width, label='XGB')
rects4 = ax.bar(x + 3*(width/2), forest_MAE, width, label='rnd forest')

# Add some text for labels, title and custom x-axis tick labels, etc.
ax.set_ylabel('MAE')
ax.set_title('Area MAE scores ML algorithms')
ax.set_xticks(x, components)
ax.legend()

ax.bar_label(rects1, padding=3)
ax.bar_label(rects2, padding=3)
ax.bar_label(rects3, padding=3)
ax.bar_label(rects4, padding=3)

fig.tight_layout()

plt.show()