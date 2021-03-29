;; 本代码将多年nc文件分割为多个一年nc文件，以解决运行内存不够问题。
;; 使用时根据需要，替换（1）模式名；（2）情景名；（3）变量名；（4）时间区间。
;; hur, hus, ua, va, zg 文件较大，仅对这几个文件作分割处理。
begin
    inPath = "/mnt/e/CMIP6/IPSL-CM6A-LR/ssp585_raw/zg_day_IPSL-CM6A-LR_ssp585_r1i1p1f1_gr_20150101-21001231.nc"
    fin = addfile(inPath, "r")
    zg = fin->zg
    
    leapYearCount = 0
    do year = 2015, 2100, 1
        if (((year % 4 .eq. 0) .and. (year % 100 .ne. 0)) .or. (year % 400 .eq. 0)) then
            startIndex := (year - 2015) * 365 + leapYearCount
            endIndex := startIndex + 366 - 1 ;; -1:index syntax
            zgYearlyFile := zg(startIndex:endIndex, :, :, :) ;; 4 dimensions, change when needed.
            ;zgYearlyFile := zg(startIndex:endIndex, :, :)

            outPath := "/mnt/e/CMIP6/IPSL-CM6A-LR/ssp585/zg_day_IPSL-CM6A-LR_ssp585_r1i1p1f1_gr_" + tostring(year) + "0101-" + tostring(year) + "1231.nc"
            fout := addfile(outPath, "c")
            fout->zg = zgYearlyFile

            leapYearCount := leapYearCount + 1
        else
            startIndex := (year - 2015) * 365 + leapYearCount
            endIndex := startIndex + 365 - 1 ;; -1:index syntax
            zgYearlyFile := zg(startIndex:endIndex, :, :, :) ;; 4 dimensions, change when needed.
            ;zgYearlyFile := zg(startIndex:endIndex, :, :)

            outPath := "/mnt/e/CMIP6/IPSL-CM6A-LR/ssp585/zg_day_IPSL-CM6A-LR_ssp585_r1i1p1f1_gr_" + tostring(year) + "0101-" + tostring(year) + "1231.nc"
            fout := addfile(outPath, "c")
            fout->zg = zgYearlyFile
        end if
    end do
end