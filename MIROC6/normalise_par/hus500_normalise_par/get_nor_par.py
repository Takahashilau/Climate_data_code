import os
import pandas as pd

files = os.listdir()
files = [file for file in files if ".txt" in file]
print(files)

i = 0
df1 = pd.DataFrame(columns={"mean", "standard deviation"})
for file in files:
    df2 = pd.read_table(file, header=None)
    df1.loc[i, "mean"] = df2.mean()[0]
    df1.loc[i, "standard deviation"] = df2.std(ddof=0)[0]
    i+=1

df1.to_csv(file.split('_')[0] + "_norlise_par.txt", index=False)