begin
    path = "/mnt/e/CMIP6/IPSL-CM6A-LR/historical/"
    husFile = systemfunc("ls " + path + "hus_*.nc")

    f_hus = addfile(husFile, "r")
    hus = f_hus->hus
    hus_1d = ndtooned(hus)
    valid_hus = ind(ismissing(hus_1d))
    
    print(husFile)
    print(valid_hus)
end