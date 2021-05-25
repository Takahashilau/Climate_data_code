function get_normalise_par()
begin
    mainPath = "/mnt/e/CMIP6/IPSL-CM6A-LR"
    zgFiles = systemfunc("ls " + mainPath + "/historical/zg_*.nc")

    zg_list1_500 = new((/1/),double)
    zg_list2_500 = new((/1/),double)
    zg_list3_500 = new((/1/),double)
    zg_list4_500 = new((/1/),double)
    zg_list5_500 = new((/1/),double)
    zg_list6_500 = new((/1/),double)
    zg_list7_500 = new((/1/),double)
    zg_list8_500 = new((/1/),double)

    i = 0
    f = addfile(zgFiles(i), "r")
    zgT42 := flt2dble(f->zg(:,3,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
    zgT42 := f2gsh_Wrap(zgT42, (/64, 128/), 0)
    print((/i/)) ;;signal

    zgGrid1_500 := zgT42(:,43,34)
    zgGrid2_500 := zgT42(:,40,35)
    zgGrid3_500 := zgT42(:,41,35)
    zgGrid4_500 := zgT42(:,42,35)
    zgGrid5_500 := zgT42(:,43,35)
    zgGrid6_500 := zgT42(:,39,36)
    zgGrid7_500 := zgT42(:,40,36) 
    zgGrid8_500 := zgT42(:,41,36)

    zg_list1_500 := array_append_record(zg_list1_500, zgGrid1_500, 0)
    zg_list2_500 := array_append_record(zg_list2_500, zgGrid2_500, 0)
    zg_list3_500 := array_append_record(zg_list3_500, zgGrid3_500, 0)
    zg_list4_500 := array_append_record(zg_list4_500, zgGrid4_500, 0)
    zg_list5_500 := array_append_record(zg_list5_500, zgGrid5_500, 0)
    zg_list6_500 := array_append_record(zg_list6_500, zgGrid6_500, 0)
    zg_list7_500 := array_append_record(zg_list7_500, zgGrid7_500, 0)
    zg_list8_500 := array_append_record(zg_list8_500, zgGrid8_500, 0)


    ;; 1950:1:1-1970:12:31 共365*21+5=7670天。加 1 成为序列头
    ;; 1971:1:1-2000:12:31 共10958天，8个闰年。7671+10958-1=18628
    nor_par = new((/16/), double)
    nor_par(0) = avg(zg_list1_500(7671:18628))
    nor_par(1) = sqrt(variance(zg_list1_500(7671:18628)))
    nor_par(2) = avg(zg_list2_500(7671:18628))
    nor_par(3) = sqrt(variance(zg_list2_500(7671:18628)))
    nor_par(4) = avg(zg_list3_500(7671:18628))
    nor_par(5) = sqrt(variance(zg_list3_500(7671:18628)))
    nor_par(6) = avg(zg_list4_500(7671:18628))
    nor_par(7) = sqrt(variance(zg_list4_500(7671:18628)))
    nor_par(8) = avg(zg_list5_500(7671:18628))
    nor_par(9) = sqrt(variance(zg_list5_500(7671:18628)))
    nor_par(10) = avg(zg_list6_500(7671:18628))
    nor_par(11) = sqrt(variance(zg_list6_500(7671:18628)))
    nor_par(12) = avg(zg_list7_500(7671:18628))
    nor_par(13) = sqrt(variance(zg_list7_500(7671:18628)))
    nor_par(14) = avg(zg_list8_500(7671:18628))
    nor_par(15) = sqrt(variance(zg_list8_500(7671:18628)))

    return nor_par
end

begin
    mainPath = "/mnt/e/CMIP6/IPSL-CM6A-LR"
    zgFiles = systemfunc("ls " + mainPath + "/ssp126/zg_*.nc")

    zg_list1_500 = new((/1/), double, 0)
    zg_list2_500 = new((/1/), double, 0)
    zg_list3_500 = new((/1/), double, 0)
    zg_list4_500 = new((/1/), double, 0)
    zg_list5_500 = new((/1/), double, 0)
    zg_list6_500 = new((/1/), double, 0)
    zg_list7_500 = new((/1/), double, 0)
    zg_list8_500 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    do i = 0, dimsizes(zgFiles)-1
        f = addfile(zgFiles(i), "r")
        zgT42 := flt2dble(f->zg(:,3,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
        zgT42 := f2gsh_Wrap(zgT42, (/64, 128/), 0)
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := zgT42(:,43,34)
        zgGrid1_500 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := zgT42(:,40,35)
        zgGrid2_500 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := zgT42(:,41,35)
        zgGrid3_500 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := zgT42(:,42,35)
        zgGrid4_500 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := zgT42(:,43,35)
        zgGrid5_500 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := zgT42(:,39,36)
        zgGrid6_500 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := zgT42(:,40,36)
        zgGrid7_500 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := zgT42(:,41,36)
        zgGrid8_500 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        zg_list1_500 := array_append_record(zg_list1_500, zgGrid1_500, 0)
        zg_list2_500 := array_append_record(zg_list2_500, zgGrid2_500, 0)
        zg_list3_500 := array_append_record(zg_list3_500, zgGrid3_500, 0)
        zg_list4_500 := array_append_record(zg_list4_500, zgGrid4_500, 0)
        zg_list5_500 := array_append_record(zg_list5_500, zgGrid5_500, 0)
        zg_list6_500 := array_append_record(zg_list6_500, zgGrid6_500, 0)
        zg_list7_500 := array_append_record(zg_list7_500, zgGrid7_500, 0)
        zg_list8_500 := array_append_record(zg_list8_500, zgGrid8_500, 0)
    end do

    outPath = "/mnt/e/Climate_data_code/IPSL-CM6A-LR/sdsm_ssp126_file/zg500_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/ips1p500g1.dat"
    write_matrix(transpose(zg_list1_500(1:)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/ips1p500g2.dat"
    write_matrix(transpose(zg_list2_500(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/ips1p500g3.dat"
    write_matrix(transpose(zg_list3_500(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/ips1p500g4.dat"
    write_matrix(transpose(zg_list4_500(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/ips1p500g5.dat"
    write_matrix(transpose(zg_list5_500(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/ips1p500g6.dat"
    write_matrix(transpose(zg_list6_500(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/ips1p500g7.dat"
    write_matrix(transpose(zg_list7_500(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/ips1p500g8.dat"
    write_matrix(transpose(zg_list8_500(1:)), "f9.3", opt8)

end