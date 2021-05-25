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

inPath = ["E:/Climate_data_code/MRI-ESM2-0/sdsm_historical_file",
        "E:/Climate_data_code/MRI-ESM2-0/sdsm_ssp126_file",
        "E:/Climate_data_code/MRI-ESM2-0/sdsm_ssp245_file",
        "E:/Climate_data_code/MRI-ESM2-0/sdsm_ssp585_file"]
        #"E:/Climate_data_code/sdsm_ncep_file"]
outPath = ["E:/DownScale_SDSM_DATA/Grid{}/MRI-ESM2-0_historical_1961_2005/",
        "E:/DownScale_SDSM_DATA/Grid{}/MRI-ESM2-0_ssp126_2015_2100/",
        "E:/DownScale_SDSM_DATA/Grid{}/MRI-ESM2-0_ssp245_2015_2100/",
        "E:/DownScale_SDSM_DATA/Grid{}/MRI-ESM2-0_ssp585_2015_2100/"]
        #"E:/DownScale_SDSM_DATA/Grid{}/NCEP-NCAR_1961_2005/"]

for i in range(1, 9):
    for path in outPath:
        if not os.path.exists(path.format(i)):
            os.mkdir(path.format(i))

for i in range(len(inPath)):
    copyFile(inPath[i], outPath[i])

#copyFile("E:/Climate_data_code/MIROC6/sdsm_ncep_file", "E:/DownScale_SDSM_DATA/Grid{}/NCEP-NCAR_1961_2005/")