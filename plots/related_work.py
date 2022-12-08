import matplotlib
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.colors import ListedColormap

fig = plt.figure()
ax = fig.add_subplot()
fig.subplots_adjust(top=0.85)


ax.set_ylabel('Speed', fontweight='bold')
#ax.set_xlabel('Model generality', fontweight='bold')

ax.spines[["left", "bottom"]].set_position(("zero"))
# Hide the top and right spines.
ax.spines[["top", "right"]].set_visible(False)
ax.plot(1, 0, ">k", transform=ax.get_yaxis_transform(), clip_on=False)
ax.plot(0, 1, "^k", transform=ax.get_xaxis_transform(), clip_on=False)

#cm = plt.cm.get_cmap('RdYlBu_r')
#order: joules our work, apollo, benini
name = ['Joules', 'This work', 'Apollo', 'Bogliolo et al.', 'Wattch', 'Lee et al.', 'McPAT', 'DSENT', 'PrEsto', 'Orion', 'Grannite', 'Yukai et al.', 'Kumar et al.' ]
x = [2.8, 1.90, 2.5, 1.5, 0.2, 2, 1.0, 1.0, 1.4, 0.8, 1.7, 2, 2.2 ]
y = [0.5, 2.10, 1.0, 1.2, 2.5, 0.6, 2.6, 2.4, 1.4, 2.3, 1.7, 1.35, 1.8]
classes = ['Analytical', 'Regression', 'Regression', 'Regression', 'Analytical', 'Regression', 'Analytical', 'Analytical', 'Regression', 'Analytical', 'Regression', 'Regression', 'Regression']
values = [0, 1, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1]
papers = list(zip(name, x,y))
colors = ListedColormap(['tab:blue', 'tab:orange'])

plt.grid()

sc = plt.scatter(x, y, c=values, cmap=colors, s=50)



#sc = plt.scatter(x, y, c=values, cmap=colors, s=50, vmin=1, vmax=10, label=classes)
plt.legend(handles=sc.legend_elements()[0], labels=classes)
#plt.legend(handles=sc.legend_elements()[0], labels=classes)

#cbar = fig.colorbar(sc)
#cbar.set_ticks([1, 10])
#cbar.set_ticklabels(['Low', 'High'])
#cbar.set_label("Abstraction")

for paper in papers:
    ax.annotate(paper[0], xy=(paper[1], paper[2]), xytext=(paper[1]-0.1, paper[2]+0.08), fontsize=7)


#ax.annotate("", xy=(1, 0), xytext=(0, 0),
##            arrowprops=dict(arrowstyle="->"))
#ax.annotate("", xy=(0, 1), xytext=(0, 0),
#            arrowprops=dict(arrowstyle="->"))

fig.text(0.80, 0.09, 'accuracy', fontweight='bold')
#fig.text(0.09, 0.65, 'accuracy', fontweight='bold')
#fig.text(0.1, 0.9, 'abstract')

# ax.spines['top'].set_visible(False)
# ax.spines['right'].set_visible(False)
# ax.spines['bottom'].set_visible(False)
# ax.spines['left'].set_visible(False)

ax.get_xaxis().set_ticks([])
ax.get_yaxis().set_ticks([])

plt.savefig("related_work.pdf")
plt.show()
