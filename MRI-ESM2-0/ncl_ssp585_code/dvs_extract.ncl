function get_normalise_par()
begin
    mainPath = "/mnt/e/CMIP6/MRI-ESM2-0"
    uasFiles = systemfunc("ls " + mainPath + "/historical/uas_*.nc")
    vasFiles = systemfunc("ls " + mainPath + "/historical/vas_*.nc")

    dvs_list1 = new((/1/), double, 0)
    dvs_list2 = new((/1/), double, 0)
    dvs_list3 = new((/1/), double, 0)
    dvs_list4 = new((/1/), double, 0)
    dvs_list5 = new((/1/), double, 0)
    dvs_list6 = new((/1/), double, 0)
    dvs_list7 = new((/1/), double, 0)
    dvs_list8 = new((/1/), double, 0)

    do i = 0, 1
        f1 = addfile(uasFiles(i), "r")
        f2 = addfile(vasFiles(i), "r")
        uasT42 := flt2dble(f1->uas) ;; todouble()不能保存metadata，flt2dble()可以。
        vasT42 := flt2dble(f2->vas)
        uasT42 := f2gsh_Wrap(uasT42, (/64, 128/), 0)
        vasT42 := f2gsh_Wrap(vasT42, (/64, 128/), 0)
        dvsT42 := uv2dvG_Wrap(uasT42, vasT42)
        print((/i/)) ;;signal

        dvsGrid1 := dvsT42(:,43,34)
        dvsGrid2 := dvsT42(:,40,35)
        dvsGrid3 := dvsT42(:,41,35)
        dvsGrid4 := dvsT42(:,42,35)
        dvsGrid5 := dvsT42(:,43,35)
        dvsGrid6 := dvsT42(:,39,36)
        dvsGrid7 := dvsT42(:,40,36) 
        dvsGrid8 := dvsT42(:,41,36)

        dvs_list1 := array_append_record(dvs_list1, dvsGrid1, 0)
        dvs_list2 := array_append_record(dvs_list2, dvsGrid2, 0)
        dvs_list3 := array_append_record(dvs_list3, dvsGrid3, 0)
        dvs_list4 := array_append_record(dvs_list4, dvsGrid4, 0)
        dvs_list5 := array_append_record(dvs_list5, dvsGrid5, 0)
        dvs_list6 := array_append_record(dvs_list6, dvsGrid6, 0)
        dvs_list7 := array_append_record(dvs_list7, dvsGrid7, 0)
        dvs_list8 := array_append_record(dvs_list8, dvsGrid8, 0)
    end do

    ;; 1950:1:1-1960:12:31 共7670天，5个闰年，+1作为序列头
    ;; 1971:1:1-2000:12:31 共10958天，8个闰年。7671+10958-1=18628
    nor_par = new((/16/), double)
    nor_par(0) = avg(dvs_list1(7671:18628)) 
    nor_par(1) = sqrt(variance(dvs_list1(7671:18628))) ;; 循环外前一段代码，创建列表时有一个初始值0，故序列数字加1
    nor_par(2) = avg(dvs_list2(7671:18628))
    nor_par(3) = sqrt(variance(dvs_list2(7671:18628)))
    nor_par(4) = avg(dvs_list3(7671:18628))
    nor_par(5) = sqrt(variance(dvs_list3(7671:18628)))
    nor_par(6) = avg(dvs_list4(7671:18628))
    nor_par(7) = sqrt(variance(dvs_list4(7671:18628)))
    nor_par(8) = avg(dvs_list5(7671:18628))
    nor_par(9) = sqrt(variance(dvs_list5(7671:18628)))
    nor_par(10) = avg(dvs_list6(7671:18628))
    nor_par(11) = sqrt(variance(dvs_list6(7671:18628)))
    nor_par(12) = avg(dvs_list7(7671:18628))
    nor_par(13) = sqrt(variance(dvs_list7(7671:18628)))
    nor_par(14) = avg(dvs_list8(7671:18628))
    nor_par(15) = sqrt(variance(dvs_list8(7671:18628)))

    return nor_par
end

begin
    mainPath = "/mnt/e/CMIP6/MRI-ESM2-0"
    uasFiles = systemfunc("ls " + mainPath + "/ssp585/uas_*.nc")
    vasFiles = systemfunc("ls " + mainPath + "/ssp585/vas_*.nc")

    dvs_list1 = new((/1/), double, 0)
    dvs_list2 = new((/1/), double, 0)
    dvs_list3 = new((/1/), double, 0)
    dvs_list4 = new((/1/), double, 0)
    dvs_list5 = new((/1/), double, 0)
    dvs_list6 = new((/1/), double, 0)
    dvs_list7 = new((/1/), double, 0)
    dvs_list8 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    do i = 0, dimsizes(uasFiles)-1
        f1 = addfile(uasFiles(i), "r")
        f2 = addfile(vasFiles(i), "r")
        uasT42 := flt2dble(f1->uas) ;; todouble()不能保存metadata，flt2dble()可以。
        vasT42 := flt2dble(f2->vas)
        uasT42 := f2gsh_Wrap(uasT42, (/64, 128/), 0)
        vasT42 := f2gsh_Wrap(vasT42, (/64, 128/), 0)
        dvsT42 := uv2dvG_Wrap(uasT42, vasT42)
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := dvsT42(:,43,34)
        dvsGrid1 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := dvsT42(:,40,35)
        dvsGrid2 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := dvsT42(:,41,35)
        dvsGrid3 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := dvsT42(:,42,35)
        dvsGrid4 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := dvsT42(:,43,35)
        dvsGrid5 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := dvsT42(:,39,36)
        dvsGrid6 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := dvsT42(:,40,36)
        dvsGrid7 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := dvsT42(:,41,36)
        dvsGrid8 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        dvs_list1 := array_append_record(dvs_list1, dvsGrid1, 0)
        dvs_list2 := array_append_record(dvs_list2, dvsGrid2, 0)
        dvs_list3 := array_append_record(dvs_list3, dvsGrid3, 0)
        dvs_list4 := array_append_record(dvs_list4, dvsGrid4, 0)
        dvs_list5 := array_append_record(dvs_list5, dvsGrid5, 0)
        dvs_list6 := array_append_record(dvs_list6, dvsGrid6, 0)
        dvs_list7 := array_append_record(dvs_list7, dvsGrid7, 0)
        dvs_list8 := array_append_record(dvs_list8, dvsGrid8, 0)
    end do

    outPath = "/mnt/e/Climate_data_code/MRI-ESM2-0/sdsm_ssp585_file/dvs_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/mri5p_zhg1.dat"
    write_matrix(transpose(dvs_list1(1:)), "f9.3", opt1)
    opt2 = True ;; 循环外前一段代码，创建列表时有一个初始值0，故序列数字加1
    opt2@fout = outPath + "/mri5p_zhg2.dat"
    write_matrix(transpose(dvs_list2(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/mri5p_zhg3.dat"
    write_matrix(transpose(dvs_list3(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/mri5p_zhg4.dat"
    write_matrix(transpose(dvs_list4(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/mri5p_zhg5.dat"
    write_matrix(transpose(dvs_list5(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/mri5p_zhg6.dat"
    write_matrix(transpose(dvs_list6(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/mri5p_zhg7.dat"
    write_matrix(transpose(dvs_list7(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/mri5p_zhg8.dat"
    write_matrix(transpose(dvs_list8(1:)), "f9.3", opt8)

end