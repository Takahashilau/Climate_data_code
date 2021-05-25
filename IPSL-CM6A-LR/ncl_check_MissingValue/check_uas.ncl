begin
    path = "/mnt/e/CMIP6/IPSL-CM6A-LR/historical/"
    uasFile = systemfunc("ls " + path + "uas_*.nc")

    f_uas = addfile(uasFile, "r")
    uas = f_uas->uas
    uas_1d = ndtooned(uas)
    valid_uas = ind(ismissing(uas_1d))
    
    print(uasFile)
    print(valid_uas)
end