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

def init_data(dataframe_path):
    
    plotdata = pd.read_csv(dataframe_path).loc[:, ["Components", "power [nW]", "est [nW]", "err_est [%]"]]
    index_labels = plotdata.index.values.tolist()

    # plotdata_abs = plotdata.loc[:, ["Components", "power [nW]", "est [nW]", "VL"]].drop(index_labels[-1])
    # plotdata_err = plotdata.loc[:, ["Components", "err_est [%]", "err_VL [%]"]].drop(index_labels[-1])
    plotdata_abs = plotdata.loc[:, ["Components", "power [nW]", "est [nW]"]].drop(index_labels[-1]) #drop last row (fir)
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
    plotdata_abs = plotdata_abs.set_index("Components")
    plotdata_abs = plotdata_abs.rename(columns={"power [nW]": "GT", "est [nW]": "Est."}, 
                                       index ={'add0': 'A0', 'add1': 'A1', 'add2': 'A2', 'mul0': 'M0', 'mul1': 'M1', 'mul2': 'M2', 'mul3': 'M3', 'reg_Q0':"Q0", 'reg_Q1':"Q1", 'reg_Q2':"Q2", 'reg_Y':"Y"})
    #["add0", "add1", "add2", "mul0", "mul1", "mul2", "mul3", "Q0", "Q1", "Q2", "Y"]
    return [plotdata_abs, plotdata_err]
    #########################################################

    


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


if len(sys.argv)!= 2:
    print("Usage: script.py <DESIGN>")
    sys.exit(1)
DESIGN = str(sys.argv[1])

#plt.rc('axes', labelsize=12)
#PERC = [[0,0,"10"], [0,1,"25"], [0,2,"50"], [1,0,"66"], [1,1,"75"], [1,2,"90"]]
#for DESIGN in ["fir_8bit", "fir_12bit", "fir_16bit", "fir_24bit", "fir_32bit"]:
for DESIGN in [DESIGN]:
    CSV_PATH = "/home/20200969/Estimation/tables/"+DESIGN+"/"+DESIGN+"_"


    fig, axes = plt.subplots(nrows=2, ncols=3, sharex=False, sharey=False, figsize=(10, 5))

    fig.subplots_adjust(wspace=0)
    axes[0, 0].set_ylabel("Power [$\mu$W]")
    axes[1, 0].set_ylabel("Power [$\mu$W]")


    for PERC in [[0,0,"10"], [0,1,"25"], [0,2,"50"], [1,0,"66"], [1,1,"75"], [1,2,"90"]]:
        [plotdata, plotdata_err] = init_data(CSV_PATH+PERC[2]+"percent_inference.csv")
        plotdata.plot(ax=axes[PERC[0],PERC[1]], kind="bar", rot=0)
        [err_est, y_position_err] = compute_value_yposition(plotdata_err, plotdata)
        xlocs= range(0,len(err_est))
        for i, v in enumerate(err_est):
            axes[PERC[0],PERC[1]].text(xlocs[i] + 0.1, y_position_err[i]+0.2, v+"\%", rotation=45, fontdict=font)
        axes[PERC[0], PERC[1]].set_title(PERC[2]+"\%", loc='left', fontsize=12) 




    # plot the data with broken axis when the data is too large

    ################
    # [plotdata, plotdata_err] = init_data(CSV_PATH+"10percent_inference.csv")
    # plotdata.plot(ax=axes[PERC[0][0],PERC[0][1]], kind="bar", rot=0)
    # [err_est, y_position_err] = compute_value_yposition(plotdata_err, plotdata)
    # xlocs= range(0,len(err_est))
    # for i, v in enumerate(err_est):
    #     axes[PERC[0][0],PERC[0][1]].text(xlocs[i] + 0.1, y_position_err[i]+0.2, v+"\%", rotation=45, fontdict=font)
    # axes[PERC[0][0], PERC[0][1]].set_title("in = "+PERC[0][2]+"\%", loc='left')

    # [plotdata, plotdata_err] = init_data(CSV_PATH+"90percent_inference.csv")
    # plotdata.plot(ax=axes[PERC[1][0],PERC[1][1]], kind="bar", rot=0)
    # [err_est, y_position_err] = compute_value_yposition(plotdata_err, plotdata)
    # xlocs= range(0,len(err_est))
    # for i, v in enumerate(err_est):
    #     axes[PERC[1][0],PERC[1][1]].text(xlocs[i] + 0.1, y_position_err[i]+0.2, v+"\%", rotation=45, fontdict=font)  
    # axes[PERC[1][0], PERC[1][1]].set_title("in = "+PERC[1][2]+"\%", loc='left')
    ############
    #plt.xlabel("Components")

    # axes[0, 0].ylabel("Power [$\mu$W]")
    # axes[1, 0].ylabel("Power [$\mu$W]")

    #print(enumerate(plotdata_err.iloc[:, [1]].values.tolist()))
    #rint(plotdata_err.iloc[:, [1]].values.tolist())

    #############################################
    #Compute text position (err%)

    # print(err_est)
    # print(y_position_err)
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



    # for i, v in enumerate(gt_pwr):
    #     plt.text(xlocs[i] - 0.25, y_position_abs[i], v, rotation=45, fontdict=font)
    #     # plt.text(horizontalalignment="center", , str(v), ha='center')

    ##########################################################
    #plt.suptitle(DESIGN+": power per component contribution")
    fig.tight_layout(pad=0)
    #plt.imshow(aspect='auto')
    plt.savefig("/home/20200969/Estimation/plots/barchart_"+DESIGN+"_component_subplots.pdf")
    
    plt.close()