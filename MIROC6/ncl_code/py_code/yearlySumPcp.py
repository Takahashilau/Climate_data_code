import pandas as pd

pcp = pd.read_csv('PCP.csv')
stations = [56977,
            56969,
            56964,
            56959,
            56954,
            56951,
            56946,
            56856,
            56751,
            56748,
            56651,
            56548,
            56533,
            56444,
            56137,
            56125,
            56029,
            56018]

outTable = pd.DataFrame()
for station in stations:
    for year in range(1959,2017):
        df = pcp.query('Station == @station')
        df = df[df['Date'].str.contains((str(year)))]
        outTable.loc[str(station), str(year)] = df['PCP'].sum()

outTable.to_csv('yearlySumPcp.csv')