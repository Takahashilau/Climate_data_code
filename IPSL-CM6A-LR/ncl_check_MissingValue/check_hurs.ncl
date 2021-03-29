begin
    path = "/mnt/e/CMIP6/IPSL-CM6A-LR/historical/"
    hursFile = systemfunc("ls " + path + "hurs_*.nc")

    f_hurs = addfile(hursFile, "r")
    hurs = f_hurs->hurs
    hurs_1d = ndtooned(hurs)
    valid_hurs = ind(ismissing(hurs_1d))
    
    print(hursFile)
    print(valid_hurs)
end