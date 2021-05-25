;; 无法运行此文件，内存不够，仅作复制粘贴简便使用
begin
    path = "/mnt/e/CMIP6/IPSL-CM6A-LR/historical/"
    hurFile = systemfunc("ls " + path + "hur_*.nc")
    hursFile = systemfunc("ls " + path + "hurs_*.nc")
    husFile = systemfunc("ls " + path + "hus_*.nc")
    prFile = systemfunc("ls " + path + "pr_*.nc")
    pslFile = systemfunc("ls " + path + "psl_*.nc")
    tasFile = systemfunc("ls " + path + "tas_*.nc")
    uaFile = systemfunc("ls " + path + "ua_*.nc")
    uasFile = systemfunc("ls " + path + "uas_*.nc")
    vaFile = systemfunc("ls " + path + "va_*.nc")
    vasFile = systemfunc("ls " + path + "vas_*.nc")
    zgFile = systemfunc("ls " + path + "zg_*.nc")

    f_hur = addfile(hurFile, "r")
    hur = f_hur->hur
    hur_1d = ndtooned(hur)
    valid_hur = ind(ismissing(hur_1d))
    print(valid_hur)

    f_hurs = addfile(hursFile, "r")
    hurs = f_hurs->hurs
    hurs_1d = ndtooned(hurs)
    valid_hurs = ind(ismissing(hurs_1d))
    print(valid_hurs)

    f_hus = addfile(husFile, "r")
    hus = f_hus->hus
    hus_1d = ndtooned(hus)
    valid_hus = ind(ismissing(hus_1d))
    print(valid_hus)

    f_pr = addfile(prFile, "r")
    pr = f_pr->pr
    pr_1d = ndtooned(pr)
    valid_pr = ind(ismissing(pr_1d))
    print(valid_pr)

    f_psl = addfile(pslFile, "r")
    psl = f_psl->psl
    psl_1d = ndtooned(psl)
    valid_psl = ind(ismissing(psl_1d))
    print(valid_psl)

    f_tas = addfile(tasFile, "r")
    tas = f_tas->tas
    tas_1d = ndtooned(tas)
    valid_tas = ind(ismissing(tas_1d))
    print(valid_tas)

    f_ua = addfile(uaFile, "r")
    ua = f_ua->ua
    ua_1d = ndtooned(ua)
    valid_ua = ind(ismissing(ua_1d))
    print(valid_ua)

    f_uas = addfile(uasFile, "r")
    uas = f_uas->uas
    uas_1d = ndtooned(uas)
    valid_uas = ind(ismissing(uas_1d))
    print(valid_uas)

    f_va = addfile(vaFile, "r")
    va = f_va->va
    va_1d = ndtooned(va)
    valid_va = ind(ismissing(va_1d))
    print(valid_va)

    f_vas = addfile(vasFile, "r")
    vas = f_vas->vas
    vas_1d = ndtooned(vas)
    valid_vas = ind(ismissing(vas_1d))
    print(valid_vas)

    f_zg = addfile(zgFile, "r")
    zg = f_zg->zg
    zg_1d = ndtooned(zg)
    valid_zg = ind(ismissing(zg_1d))
    print(valid_zg)
end