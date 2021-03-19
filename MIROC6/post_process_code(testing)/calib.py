import pandas as pd

pcp = pd.read_csv("pcp_calib.csv")
pcp['date'] = pd.to_datetime(pcp['date'], format="%Y/%m/%d")
pcp = pcp.set_index('date')
# print(pcp['1961-1']['pcp'].sum())

outTable = pd.DataFrame()
for year in range(1961,1991):
    for month in range(1,13):
        date_str = str(year) + '-' + str(month)
        outTable.loc[date_str, 'obspcp'] = pcp[date_str]['obspcp'].sum()
        outTable.loc[date_str, 'calibpcp'] = pcp[date_str]['calibpcp'].sum()
        outTable.loc[date_str, 'gcmpcp'] = pcp[date_str]['gcmpcp'].sum()

outTable.to_csv("pcp_calib_month.csv")