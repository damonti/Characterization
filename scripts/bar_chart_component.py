import pandas as pd
from matplotlib import pyplot as plt
import sys
import matplotlib
matplotlib.style.use('ggplot')
plt.rc('text', usetex=True)

font = {'family': 'Helvetica',
        'weight': 'normal',
        'size': 'small',
}

def convert_nw_to_uw(dataframe):
    uw_power = []
    est_uw_power = []
    for i in dataframe.iloc[:, [1]].values.tolist():
        for j in i:
            uw_power.append(round(j/1000,3))
    est_uw_power = []
    for i in dataframe.iloc[:, [2]].values.tolist():
        for j in i:
            est_uw_power.append(round(j/1000,3))
    return [uw_power, est_uw_power]

def compute_value_yposition(dataframe_err, dataframe_est):
    err_est = []
    y_position_err = []    
    for i in dataframe_err.iloc[:, [1]].values.tolist():
        for j in i:
            if str(j).startswith("-"):
                err_est.append(str(j)[1:])    
            else:
                err_est.append("-"+str(j))
    for i in dataframe_est.iloc[:, [1]].values.tolist():
        for j in i:
            y_position_err.append(j)
    return [err_est, y_position_err]

# font_labels = {'family': 'Helvetica',
#         #'color':  'darkred',
#         'weight': 'normal',
#         'size': 'medium',
# }

# plt.rcParams.update({
#     "text.usetex": True,
#     "font.family": "sans-serif",
#     "font.sans-serif": "Helvetica",
# })


if len(sys.argv)!= 3:
    print("Usage: script.py <DESIGN> <PERC>")
    sys.exit(1)
DESIGN = str(sys.argv[1])
PERC = str(sys.argv[2])


plotdata = pd.read_csv("/home/20200969/Estimation/tables/"+DESIGN+"/"+DESIGN+"_"+PERC+"percent_inference.csv").loc[:, ["Components", "power [nW]", "est [nW]", "err_est [%]", "VL", "err_VL [%]"]]
index_labels = plotdata.index.values.tolist()

# plotdata_abs = plotdata.loc[:, ["Components", "power [nW]", "est [nW]", "VL"]].drop(index_labels[-1])
# plotdata_err = plotdata.loc[:, ["Components", "err_est [%]", "err_VL [%]"]].drop(index_labels[-1])
plotdata_abs = plotdata.loc[:, ["Components", "power [nW]", "est [nW]"]].drop(index_labels[-1])
plotdata_err = plotdata.loc[:, ["Components", "err_est [%]"]].drop(index_labels[-1])
# print(plotdata_abs)
# print(plotdata_err)


#######################################################
#CONVERT nW to uW
[uw_power, est_uw_power] = convert_nw_to_uw(plotdata_abs)
# print(uw_power)
# print(est_uw_power)
#####################################################



#REPLACE nW with uW
plotdata_abs['power [nW]'] = plotdata_abs['power [nW]'].replace(plotdata_abs.loc[:, ["power [nW]"]].values.tolist(), uw_power)
plotdata_abs['est [nW]'] = plotdata_abs['est [nW]'].replace(plotdata_abs.loc[:, ["est [nW]"]].values.tolist(), est_uw_power)

#RENAME COLUMNS
plotdata_abs = plotdata_abs.rename(columns={"power [nW]": "GT", "est [nW]": "Est."})

#########################################################
#PLOT 
plotdata_abs = plotdata_abs.set_index("Components")
plotdata_abs.plot(kind="bar", rot=0)
plt.title(DESIGN+"_"+PERC+"percent")
plt.xlabel("Components")
plt.ylabel("Power [$\mu$W]")

#print(enumerate(plotdata_err.iloc[:, [1]].values.tolist()))
#rint(plotdata_err.iloc[:, [1]].values.tolist())

#############################################
#Compute text position (err%)
[err_est, y_position_err] = compute_value_yposition(plotdata_err, plotdata_abs)
print(err_est)
print(y_position_err)
# gt_pwr = []
# for i in plotdata_abs.iloc[:, [1]].values.tolist():
#     for j in i:
#         gt_pwr.append(str(round(j,2))) 
# print(gt_pwr)

# xlocs= range(0,13) #
# y_position_abs = []
# for i in plotdata_abs.loc[:, ["power [nW]"]].values.tolist():
#     for j in i:
#         y_position_abs.append(j)
########################################################

xlocs= range(0,len(err_est))
for i, v in enumerate(err_est):
    plt.text(xlocs[i] + 0.1, y_position_err[i]+0.2, v+"\%", rotation=45, fontdict=font)

# for i, v in enumerate(gt_pwr):
#     plt.text(xlocs[i] - 0.25, y_position_abs[i], v, rotation=45, fontdict=font)
#     # plt.text(horizontalalignment="center", , str(v), ha='center')

##########################################################




plt.savefig("bar_chart_"+DESIGN+"_"+PERC+"percent.pdf")
plt.show()
