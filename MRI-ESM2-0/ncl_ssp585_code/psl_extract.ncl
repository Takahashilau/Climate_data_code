function get_normalise_par()
begin
    mainPath = "/mnt/e/CMIP6/MRI-ESM2-0"
    pslFiles = systemfunc("ls " + mainPath + "/historical/psl_*.nc")

    psl_list1 = new((/1/),double)
    psl_list2 = new((/1/),double)
    psl_list3 = new((/1/),double)
    psl_list4 = new((/1/),double)
    psl_list5 = new((/1/),double)
    psl_list6 = new((/1/),double)
    psl_list7 = new((/1/),double)
    psl_list8 = new((/1/),double)

    do i = 0, 1
        f = addfile(pslFiles(i), "r")
        pslT42 := flt2dble(f->psl) ;; todouble()不能保存metadata，flt2dble()可以。
        pslT42 := f2gsh_Wrap(pslT42, (/64, 128/), 0)
        print((/i/)) ;;signal

        pslGrid1 := pslT42(:,43,34)
        pslGrid2 := pslT42(:,40,35)
        pslGrid3 := pslT42(:,41,35)
        pslGrid4 := pslT42(:,42,35)
        pslGrid5 := pslT42(:,43,35)
        pslGrid6 := pslT42(:,39,36)
        pslGrid7 := pslT42(:,40,36) 
        pslGrid8 := pslT42(:,41,36)

        psl_list1 := array_append_record(psl_list1, pslGrid1, 0)
        psl_list2 := array_append_record(psl_list2, pslGrid2, 0)
        psl_list3 := array_append_record(psl_list3, pslGrid3, 0)
        psl_list4 := array_append_record(psl_list4, pslGrid4, 0)
        psl_list5 := array_append_record(psl_list5, pslGrid5, 0)
        psl_list6 := array_append_record(psl_list6, pslGrid6, 0)
        psl_list7 := array_append_record(psl_list7, pslGrid7, 0)
        psl_list8 := array_append_record(psl_list8, pslGrid8, 0)
    end do

    ;; 1950:1:1-1960:12:31 共7670天，5个闰年，+1作为序列头
    ;; 1971:1:1-2000:12:31 共10958天，8个闰年。7671+10958-1=18628
    nor_par = new((/16/), double)
    nor_par(0) = avg(psl_list1(7671:18628))
    nor_par(1) = sqrt(variance(psl_list1(7671:18628))) ;; 循环外前一段代码，创建列表时有一个初始值0，故序列数字加1
    nor_par(2) = avg(psl_list2(7671:18628))
    nor_par(3) = sqrt(variance(psl_list2(7671:18628)))
    nor_par(4) = avg(psl_list3(7671:18628))
    nor_par(5) = sqrt(variance(psl_list3(7671:18628)))
    nor_par(6) = avg(psl_list4(7671:18628))
    nor_par(7) = sqrt(variance(psl_list4(7671:18628)))
    nor_par(8) = avg(psl_list5(7671:18628))
    nor_par(9) = sqrt(variance(psl_list5(7671:18628)))
    nor_par(10) = avg(psl_list6(7671:18628))
    nor_par(11) = sqrt(variance(psl_list6(7671:18628)))
    nor_par(12) = avg(psl_list7(7671:18628))
    nor_par(13) = sqrt(variance(psl_list7(7671:18628)))
    nor_par(14) = avg(psl_list8(7671:18628))
    nor_par(15) = sqrt(variance(psl_list8(7671:18628)))

    return nor_par
end

begin
    mainPath = "/mnt/e/CMIP6/MRI-ESM2-0"
    pslFiles = systemfunc("ls " + mainPath + "/ssp585/psl_*.nc")

    psl_list1 = new((/1/), double, 0)
    psl_list2 = new((/1/), double, 0)
    psl_list3 = new((/1/), double, 0)
    psl_list4 = new((/1/), double, 0)
    psl_list5 = new((/1/), double, 0)
    psl_list6 = new((/1/), double, 0)
    psl_list7 = new((/1/), double, 0)
    psl_list8 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    do i = 0, dimsizes(pslFiles)-1
        f = addfile(pslFiles(i), "r")
        pslT42 := flt2dble(f->psl) ;; todouble()不能保存metadata，flt2dble()可以。
        pslT42 := f2gsh_Wrap(pslT42, (/64, 128/), 0)
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := pslT42(:,43,34)
        pslGrid1 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := pslT42(:,40,35)
        pslGrid2 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := pslT42(:,41,35)
        pslGrid3 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := pslT42(:,42,35)
        pslGrid4 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := pslT42(:,43,35)
        pslGrid5 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := pslT42(:,39,36)
        pslGrid6 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := pslT42(:,40,36)
        pslGrid7 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := pslT42(:,41,36)
        pslGrid8 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        psl_list1 := array_append_record(psl_list1, pslGrid1, 0)
        psl_list2 := array_append_record(psl_list2, pslGrid2, 0)
        psl_list3 := array_append_record(psl_list3, pslGrid3, 0)
        psl_list4 := array_append_record(psl_list4, pslGrid4, 0)
        psl_list5 := array_append_record(psl_list5, pslGrid5, 0)
        psl_list6 := array_append_record(psl_list6, pslGrid6, 0)
        psl_list7 := array_append_record(psl_list7, pslGrid7, 0)
        psl_list8 := array_append_record(psl_list8, pslGrid8, 0)
    end do

    outPath = "/mnt/e/Climate_data_code/MRI-ESM2-0/sdsm_ssp585_file/psl_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/mri5mslpg1.dat"
    write_matrix(transpose(psl_list1(1:)), "f9.3", opt1)
    opt2 = True ;; 循环外前一段代码，创建列表时有一个初始值0，故序列数字加1
    opt2@fout = outPath + "/mri5mslpg2.dat"
    write_matrix(transpose(psl_list2(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/mri5mslpg3.dat"
    write_matrix(transpose(psl_list3(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/mri5mslpg4.dat"
    write_matrix(transpose(psl_list4(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/mri5mslpg5.dat"
    write_matrix(transpose(psl_list5(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/mri5mslpg6.dat"
    write_matrix(transpose(psl_list6(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/mri5mslpg7.dat"
    write_matrix(transpose(psl_list7(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/mri5mslpg8.dat"
    write_matrix(transpose(psl_list8(1:)), "f9.3", opt8)

end