begin
	f = addfile("/mnt/d/CMIP6/MIROC6/ssp245/va_day_MIROC6_ssp245_r1i1p1f1_gn_20880101-20881231.nc", "r")
	va = f->va
	va(31,3,88,57) = 0
	fout = addfile("va_day_MIROC6_ssp245_r1i1p1f1_gn_20880101-20881231.nc", "c")
	fout->va = va
end