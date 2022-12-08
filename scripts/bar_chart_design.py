import pandas as pd
from matplotlib import pyplot as plt
import numpy as np
import sys
import matplotlib
matplotlib.style.use('ggplot')
plt.rc('text', usetex=True)

font = {'family': 'Helvetica',
        'weight': 'normal',
        'size': 'medium',
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


if len(sys.argv)!= 2:
    print("Usage: script.py <DESIGN> ")
    sys.exit(1)
DESIGN = str(sys.argv[1])

for DESIGN in [DESIGN]:
#for DESIGN in ["fir_8bit", "fir_12bit", "fir_16bit", "fir_24bit", "fir_32bit"]:
    PERC_LIST = ["10", "25", "50", "66", "75", "90"]
    #PERC_LIST = ["10", "25"]
    #READ CSV, GET THE VALUES IN 3 LIST, PLOT THEM
    GLUE = []
    SUM = []
    EST = []
    err_noglue = []
    err_glue = []
    for PERC in PERC_LIST:
        sum_gtpower = 0
        sum_estpower = 0
        dataframe_path = "/home/20200969/Estimation/tables/"+DESIGN+"/"+DESIGN+"_"+PERC+"percent_inference.csv"
        df = pd.read_csv(dataframe_path).loc[:, ["power [nW]", "est [nW]"]]
        index_labels = df.index.values.tolist()
        list_of_components_gtpower = df.loc[:, "power [nW]"].drop(index_labels[-1]).values.tolist() #remove last instance (fir)
        for c in list_of_components_gtpower:
            sum_gtpower += c
        fir_gtpower = df.iloc[-1, 0]
        glue_gtpower = fir_gtpower - sum_gtpower #fir_gtpower = sum_gtpower + glue_gtpower 
        GLUE.append(round(glue_gtpower/1000, 3)) #convert to uW 
        SUM.append(round(sum_gtpower/1000, 3)) #convert to uW

        
        list_of_components_estpower = df.loc[:, "est [nW]"].drop(index_labels[-1]).values.tolist() #remove last instance (fir)
        for c in list_of_components_estpower:
            sum_estpower += c
            
        EST.append(round(float(sum_estpower/1000),3))#convert to uW
        
        #labels values
        err_noglue.append(round(((sum_gtpower - sum_estpower)/sum_gtpower)*100,2))
        err_glue.append(round(((float(fir_gtpower - sum_estpower)/fir_gtpower)*100),2))
        
    # print(err_noglue)
    # print(err_glue)
    # print("SUM: ", SUM)
    # print("GLUE: ", GLUE)
    # print("EST: ", EST)
    #fig = plt.figure(figsize=(10, 7))

    SUM_N = np.array(SUM)
    GLUE_N = np.array(GLUE)
    EST_N = np.array(EST)


    for i in range(len(PERC_LIST)):  
        gt_bar_list = [plt.bar(PERC_LIST, SUM_N, align='edge', width= -0.2, color='tab:red'),
                    plt.bar(PERC_LIST, GLUE_N, align='edge', bottom=SUM, width= -0.2, color='tab:green')]

        est_bar_list = [plt.bar(PERC_LIST, EST_N, align='edge',width= 0.2, color='tab:blue')]


    #PRINT LABELS
    xlocs= range(0,len(PERC_LIST))
    for i, v in enumerate(err_glue):
        plt.text(xlocs[i] + 0.07, EST[i]+60.75, str(v)+"\%", rotation=0, fontdict=font, c='tab:green') #errore glue blue
    for i, v in enumerate(err_noglue):    
        plt.text(xlocs[i] + 0.07, EST[i]+8.05, str(v)+"\%", rotation=0, fontdict=font, c='tab:red') #error noglue black



    plt.legend((gt_bar_list[0][0], gt_bar_list[1][0], est_bar_list[0][0]), ('Components', 'Glue', 'Estimation'), loc='upper left')

    plt.title(DESIGN+": power vs activity for the whole design")
    plt.xlabel("Activity [\%]")
    plt.ylabel("Power [$\mu$W]")
    plt.savefig("/home/20200969/Estimation/plots/barchart_"+DESIGN+"_design.pdf")
    #plt.show()
    plt.close()