begin
	f = addfile("/mnt/d/CMIP6/MIROC6/historical/pr_day_MIROC6_historical_r1i1p1f1_gn_20100101-20141231.nc", "r")
	pr = f->pr
	prT42 = f2gsh_Wrap(pr, (/64, 128/), 0)
	prT42 = prT42*86400
	prT42@units = "mm"
	fout = addfile("pr_day_MIROC6_historical_r1i1p1f1_gn_20100101-20141231_T42.nc", "c")
	fout->pr = prT42
end