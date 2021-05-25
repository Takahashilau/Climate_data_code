begin
    path = "/mnt/e/CMIP6/IPSL-CM6A-LR/historical/"
    vasFile = systemfunc("ls " + path + "vas_*.nc")

    f_vas = addfile(vasFile, "r")
    vas = f_vas->vas
    vas_1d = ndtooned(vas)
    valid_vas = ind(ismissing(vas_1d))
    
    print(vasFile)
    print(valid_vas)
end