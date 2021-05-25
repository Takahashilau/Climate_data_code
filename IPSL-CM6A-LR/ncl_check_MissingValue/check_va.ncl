begin
    path = "/mnt/e/CMIP6/IPSL-CM6A-LR/historical/"
    vaFile = systemfunc("ls " + path + "va_*.nc")

    f_va = addfile(vaFile, "r")
    va = f_va->va
    va_1d = ndtooned(va)
    valid_va = ind(ismissing(va_1d))
    
    print(vaFile)
    print(valid_va)
end