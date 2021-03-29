begin
    path = "/mnt/e/CMIP6/IPSL-CM6A-LR/historical/"
    hurFile = systemfunc("ls " + path + "hur_*.nc")

    f_hur = addfile(hurFile, "r")
    hur = f_hur->hur
    hur_1d = ndtooned(hur)
    valid_hur = ind(ismissing(hur_1d))
    
    print(hurFile)
    print(valid_hur)
end