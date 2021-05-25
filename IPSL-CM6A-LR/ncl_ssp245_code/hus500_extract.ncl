function get_normalise_par()
begin
    mainPath = "/mnt/e/CMIP6/IPSL-CM6A-LR"
    husFiles = systemfunc("ls " + mainPath + "/historical/hus_*.nc")

    hus_list1_500 = new((/1/),double)
    hus_list2_500 = new((/1/),double)
    hus_list3_500 = new((/1/),double)
    hus_list4_500 = new((/1/),double)
    hus_list5_500 = new((/1/),double)
    hus_list6_500 = new((/1/),double)
    hus_list7_500 = new((/1/),double)
    hus_list8_500 = new((/1/),double)

    i = 0
    f = addfile(husFiles(i), "r")
    husT42 := flt2dble(f->hus(:,3,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
    husT42 := f2gsh_Wrap(husT42, (/64, 128/), 0)
    print((/i/)) ;;signal

    husGrid1_500 := husT42(:,43,34)
    husGrid2_500 := husT42(:,40,35)
    husGrid3_500 := husT42(:,41,35)
    husGrid4_500 := husT42(:,42,35)
    husGrid5_500 := husT42(:,43,35)
    husGrid6_500 := husT42(:,39,36)
    husGrid7_500 := husT42(:,40,36) 
    husGrid8_500 := husT42(:,41,36)

    hus_list1_500 := array_append_record(hus_list1_500, husGrid1_500, 0)
    hus_list2_500 := array_append_record(hus_list2_500, husGrid2_500, 0)
    hus_list3_500 := array_append_record(hus_list3_500, husGrid3_500, 0)
    hus_list4_500 := array_append_record(hus_list4_500, husGrid4_500, 0)
    hus_list5_500 := array_append_record(hus_list5_500, husGrid5_500, 0)
    hus_list6_500 := array_append_record(hus_list6_500, husGrid6_500, 0)
    hus_list7_500 := array_append_record(hus_list7_500, husGrid7_500, 0)
    hus_list8_500 := array_append_record(hus_list8_500, husGrid8_500, 0)


    ;; 1950:1:1-1970:12:31 共365*21+5=7670天。加 1 成为序列头
    ;; 1971:1:1-2000:12:31 共10958天，8个闰年。7671+10958-1=18628
    nor_par = new((/16/), double)
    nor_par(0) = avg(hus_list1_500(7671:18628))
    nor_par(1) = sqrt(variance(hus_list1_500(7671:18628)))
    nor_par(2) = avg(hus_list2_500(7671:18628))
    nor_par(3) = sqrt(variance(hus_list2_500(7671:18628)))
    nor_par(4) = avg(hus_list3_500(7671:18628))
    nor_par(5) = sqrt(variance(hus_list3_500(7671:18628)))
    nor_par(6) = avg(hus_list4_500(7671:18628))
    nor_par(7) = sqrt(variance(hus_list4_500(7671:18628)))
    nor_par(8) = avg(hus_list5_500(7671:18628))
    nor_par(9) = sqrt(variance(hus_list5_500(7671:18628)))
    nor_par(10) = avg(hus_list6_500(7671:18628))
    nor_par(11) = sqrt(variance(hus_list6_500(7671:18628)))
    nor_par(12) = avg(hus_list7_500(7671:18628))
    nor_par(13) = sqrt(variance(hus_list7_500(7671:18628)))
    nor_par(14) = avg(hus_list8_500(7671:18628))
    nor_par(15) = sqrt(variance(hus_list8_500(7671:18628)))

    return nor_par
end

begin
    mainPath = "/mnt/e/CMIP6/IPSL-CM6A-LR"
    husFiles = systemfunc("ls " + mainPath + "/ssp245/hus*.nc")

    hus_list1_500 = new((/1/), double, 0)
    hus_list2_500 = new((/1/), double, 0)
    hus_list3_500 = new((/1/), double, 0)
    hus_list4_500 = new((/1/), double, 0)
    hus_list5_500 = new((/1/), double, 0)
    hus_list6_500 = new((/1/), double, 0)
    hus_list7_500 = new((/1/), double, 0)
    hus_list8_500 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    do i = 0, dimsizes(husFiles)-1
        f = addfile(husFiles(i), "r")
        husT42 := flt2dble(f->hus(:,3,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
        husT42 := f2gsh_Wrap(husT42, (/64, 128/), 0)
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := husT42(:,43,34)
        husGrid1_500 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := husT42(:,40,35)
        husGrid2_500 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := husT42(:,41,35)
        husGrid3_500 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := husT42(:,42,35)
        husGrid4_500 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := husT42(:,43,35)
        husGrid5_500 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := husT42(:,39,36)
        husGrid6_500 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := husT42(:,40,36)
        husGrid7_500 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := husT42(:,41,36)
        husGrid8_500 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        hus_list1_500 := array_append_record(hus_list1_500, husGrid1_500, 0)
        hus_list2_500 := array_append_record(hus_list2_500, husGrid2_500, 0)
        hus_list3_500 := array_append_record(hus_list3_500, husGrid3_500, 0)
        hus_list4_500 := array_append_record(hus_list4_500, husGrid4_500, 0)
        hus_list5_500 := array_append_record(hus_list5_500, husGrid5_500, 0)
        hus_list6_500 := array_append_record(hus_list6_500, husGrid6_500, 0)
        hus_list7_500 := array_append_record(hus_list7_500, husGrid7_500, 0)
        hus_list8_500 := array_append_record(hus_list8_500, husGrid8_500, 0)
    end do

    outPath = "/mnt/e/Climate_data_code/IPSL-CM6A-LR/sdsm_ssp245_file/hus500_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/ips2s500g1.dat"
    write_matrix(transpose(hus_list1_500(1:)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/ips2s500g2.dat"
    write_matrix(transpose(hus_list2_500(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/ips2s500g3.dat"
    write_matrix(transpose(hus_list3_500(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/ips2s500g4.dat"
    write_matrix(transpose(hus_list4_500(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/ips2s500g5.dat"
    write_matrix(transpose(hus_list5_500(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/ips2s500g6.dat"
    write_matrix(transpose(hus_list6_500(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/ips2s500g7.dat"
    write_matrix(transpose(hus_list7_500(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/ips2s500g8.dat"
    write_matrix(transpose(hus_list8_500(1:)), "f9.3", opt8)

end