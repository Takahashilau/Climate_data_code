begin
    path = "/mnt/e/CMIP6/IPSL-CM6A-LR/historical/"
    tasFile = systemfunc("ls " + path + "tas_*.nc")

    f_tas = addfile(tasFile, "r")
    tas = f_tas->tas
    tas_1d = ndtooned(tas)
    valid_tas = ind(ismissing(tas_1d))
    
    print(tasFile)
    print(valid_tas)
end