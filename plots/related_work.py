import matplotlib
import matplotlib.pyplot as plt
import numpy as np

fig = plt.figure()
ax = fig.add_subplot()
fig.subplots_adjust(top=0.85)


ax.set_ylabel('Generality', fontweight='bold')
#ax.set_xlabel('Model generality', fontweight='bold')

ax.spines[["left", "bottom"]].set_position(("zero"))
# Hide the top and right spines.
ax.spines[["top", "right"]].set_visible(False)
ax.plot(1, 0, ">k", transform=ax.get_yaxis_transform(), clip_on=False)
ax.plot(0, 1, "^k", transform=ax.get_xaxis_transform(), clip_on=False)

cm = plt.cm.get_cmap('RdYlBu_r')
#order: joules our work, apollo, benini
name = ['Joules', 'This work', 'Apollo', 'Bogliolo et al.', 'Wattch', 'Lee et al.', 'McPAT', 'DSENT', 'PrEsto', 'Orion', 'Grannite', 'Yukai et al.' ]
x = [2.8, 2.4, 2.4, 1.5, 0.2, 2, 1.0, 1.0, 1.4, 0.8, 2.2, 2.4 ]
y = [2.8, 2.5, 0.8, 1.2, 2.5, 0.6, 2.6, 2.4, 1.4, 2.3, 2.2, 1.5]
time = [10, 4, 8, 9, 2, 8, 2, 2, 6, 3, 9, 7]
papers = list(zip(name, x,y))
plt.grid()

sc = plt.scatter(x, y, c=time, s=50, cmap=cm, vmin=1, vmax=10)

cbar = fig.colorbar(sc)
cbar.set_ticks([1, 5, 10])
cbar.set_ticklabels(['Low', 'Medium', 'High'])
cbar.set_label("time")

for paper in papers:
    ax.annotate(paper[0], xy=(paper[1], paper[2]), xytext=(paper[1]-0.1, paper[2]+0.08), fontsize=7)


#ax.annotate("", xy=(1, 0), xytext=(0, 0),
##            arrowprops=dict(arrowstyle="->"))
#ax.annotate("", xy=(0, 1), xytext=(0, 0),
#            arrowprops=dict(arrowstyle="->"))

fig.text(0.65, 0.09, 'accuracy', fontweight='bold')
#fig.text(0.09, 0.65, 'accuracy', fontweight='bold')
#fig.text(0.1, 0.9, 'abstract')

# ax.spines['top'].set_visible(False)
# ax.spines['right'].set_visible(False)
# ax.spines['bottom'].set_visible(False)
# ax.spines['left'].set_visible(False)

ax.get_xaxis().set_ticks([])
ax.get_yaxis().set_ticks([])

plt.savefig("related_work.svg")
plt.show()
