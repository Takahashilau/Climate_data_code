begin
    path = "/mnt/e/CMIP6/IPSL-CM6A-LR/historical/"
    pslFile = systemfunc("ls " + path + "psl_*.nc")

    f_psl = addfile(pslFile, "r")
    psl = f_psl->psl
    psl_1d = ndtooned(psl)
    valid_psl = ind(ismissing(psl_1d))
    
    print(pslFile)
    print(valid_psl)
end