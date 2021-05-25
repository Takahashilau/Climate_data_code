begin
    path = "/mnt/e/CMIP6/IPSL-CM6A-LR/historical/"
    prFile = systemfunc("ls " + path + "pr_*.nc")

    f_pr = addfile(prFile, "r")
    pr = f_pr->pr
    pr_1d = ndtooned(pr)
    valid_pr = ind(ismissing(pr_1d))
    
    print(prFile)
    print(valid_pr)
end