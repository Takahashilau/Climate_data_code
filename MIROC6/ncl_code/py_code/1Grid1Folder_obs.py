import pandas as pd

def gotNoName(src, dst):
    df_var = pd.read_csv(src)
    stationDict = {56977:7,
                56969:6,
                56964:7,
                56959:6,
                56954:7,
                56951:7,
                56946:2,
                56856:7,
                56751:8,
                56748:3,
                56651:8,
                56548:3,
                56533:3,
                56444:4,
                56137:5,
                56125:1,
                56029:1,
                56018:1}

    for key,value in stationDict.items():     # 用字典，将各站点的降水，气温数据（1961:01:01--2005:12:31）
        df1 = df_var.query('Station == @key') # 提取到对应个格点文件夹
        df1 = df1[731:17167] # 1961:01:01--2005:12:31
        if 'PCP.csv' in src:
            df1['PCP'].to_csv(dst.format(value, key)+"PRCP.dat", header=None, index=False)
        else:
            df1['TMPmax'].to_csv(dst.format(value, key)+"TMAX.dat", header=None, index=False)
            df1['TMPmin'].to_csv(dst.format(value, key)+"TMIN.dat", header=None, index=False)

outPath = "D:/DownScale_SDSM_DATA/Grid{}/OBS_{}_1961_2005/"
gotNoName("PCP.csv", outPath)
gotNoName("TMP.csv", outPath)