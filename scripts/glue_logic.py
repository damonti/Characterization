import pandas as pd
from matplotlib import pyplot as plt
import sys

if len(sys.argv)!= 3:
    print("Usage: script.py <DESIGN> <PERC>")
    sys.exit(1)
DESIGN = str(sys.argv[1])
PERC = str(sys.argv[2])


plotdata = pd.read_csv("/home/20200969/Estimation/tables/"+DESIGN+"/"+DESIGN+"_"+PERC+"percent_inference.csv").loc[:, ["Components", "power [nW]", "est [nW]", "err_est [%]", "VL", "err_VL [%]"]]
index_labels = plotdata.index.values.tolist()

plotdata_abs = plotdata.loc[:, ["Components", "power [nW]", "est [nW]", "VL"]].drop(index_labels[-1])
plotdata_err = plotdata.loc[:, ["Components", "err_est [%]", "err_VL [%]"]].drop(index_labels[-1])
print(plotdata_abs)
print(plotdata_err)
uw_power = []
for i in plotdata_abs.loc[:, ["power [nW]"]].values.tolist():
    for j in i:
        uw_power = round(j/1000,3)
print(uw_power)


plotdata_abs = plotdata_abs.set_index("Components")
plotdata_abs.plot(kind="bar")
plt.title(DESIGN+"_"+PERC+"percent")
plt.xlabel("Components")
plt.ylabel("Power [nW]")

#print(enumerate(plotdata_err.iloc[:, [1]].values.tolist()))
#rint(plotdata_err.iloc[:, [1]].values.tolist())
err_est =[]
for i in plotdata_err.iloc[:, [1]].values.tolist():
    for j in i:
        err_est.append(str(j))

#print(err_est)
xlocs= range(0,13) #
y_position = []
for i in plotdata_abs.loc[:, ["power [nW]"]].values.tolist():
    for j in i:
        y_position.append(j)
        
#for i, v in enumerate(plotdata_err.iloc[:, [1]].values.tolist()):
for i, v in enumerate(err_est):
    plt.text(xlocs[i] - 0.25, y_position[i], v)
    # plt.text(horizontalalignment="center", , str(v), ha='center')

plt.savefig("bar_chart_"+DESIGN+"_"+PERC+"percent.pdf")
plt.show()
