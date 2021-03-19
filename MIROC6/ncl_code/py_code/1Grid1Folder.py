## 该脚本将CMIP的19种变量按照格点分类，即每个格点文件夹Grid{i}仅含有该格点19个变量。
import os
import shutil

def recurrence(path,file_list):
    for file in os.listdir(path):
        fs = os.path.join(path, file)
        if os.path.isfile(fs):
            file_list.append(fs)
        elif os.path.isdir(fs):
            recurrence(fs, file_list)

def copyFile(src, dst):
    f = []
    recurrence(src, f)

    for i in range(1,9):
        regex = str(i) + ".dat"
        for file in f:
            if regex in file:
                shutil.copy(file, dst.format(i))

inPath = ["D:/Climate_data_code/sdsm_input_file",
        "D:/Climate_data_code/sdsm_ssp126_file",
        "D:/Climate_data_code/sdsm_ssp245_file",
        "D:/Climate_data_code/sdsm_ssp585_file",
        "D:/Climate_data_code/sdsm_ncep_file"]
outPath = ["D:/DownScale_SDSM_DATA/Grid{}/MIROC6_historical_1961_2005/",
        "D:/DownScale_SDSM_DATA/Grid{}/MIROC6_ssp126_2015_2100/",
        "D:/DownScale_SDSM_DATA/Grid{}/MIROC6_ssp245_2015_2100/",
        "D:/DownScale_SDSM_DATA/Grid{}/MIROC6_ssp585_2015_2100/",
        "D:/DownScale_SDSM_DATA/Grid{}/NCEP-NCAR_1961_2005/"]

for i in range(len(inPath)):
    copyFile(inPath[i], outPath[i])