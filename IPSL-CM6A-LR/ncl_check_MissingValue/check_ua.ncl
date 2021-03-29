begin
    path = "/mnt/e/CMIP6/IPSL-CM6A-LR/historical/"
    uaFile = systemfunc("ls " + path + "ua_*.nc")

    f_ua = addfile(uaFile, "r")
    ua = f_ua->ua
    ua_1d = ndtooned(ua)
    valid_ua = ind(ismissing(ua_1d))
    
    print(uaFile)
    print(valid_ua)
end