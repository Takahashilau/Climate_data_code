begin
    path = "/mnt/e/CMIP6/IPSL-CM6A-LR/historical/"
    zgFile = systemfunc("ls " + path + "zg_*.nc")

    f_zg = addfile(zgFile, "r")
    zg = f_zg->zg
    zg_1d = ndtooned(zg)
    valid_zg = ind(ismissing(zg_1d))
    
    print(zgFile)
    print(valid_zg)
end