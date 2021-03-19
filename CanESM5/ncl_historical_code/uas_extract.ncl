function get_normalise_par()
begin
    mainPath = "/mnt/e/CMIP6/CanESM5"
    uasFiles = systemfunc("ls " + mainPath + "/historical/uas*.nc")

    uas_list1 = new((/1/),double)
    uas_list2 = new((/1/),double)
    uas_list3 = new((/1/),double)
    uas_list4 = new((/1/),double)
    uas_list5 = new((/1/),double)
    uas_list6 = new((/1/),double)
    uas_list7 = new((/1/),double)
    uas_list8 = new((/1/),double)

    do i = 0, 0
        f = addfile(uasFiles(i), "r")
        uasT42 := flt2dble(f->uas) ;; todouble()不能保存metadata，flt2dble()可以。
        print((/i/)) ;;signal

        uasGrid1 := uasT42(:,43,34)
        uasGrid2 := uasT42(:,40,35)
        uasGrid3 := uasT42(:,41,35)
        uasGrid4 := uasT42(:,42,35)
        uasGrid5 := uasT42(:,43,35)
        uasGrid6 := uasT42(:,39,36)
        uasGrid7 := uasT42(:,40,36) 
        uasGrid8 := uasT42(:,41,36)

        uas_list1 := array_append_record(uas_list1, uasGrid1, 0)
        uas_list2 := array_append_record(uas_list2, uasGrid2, 0)
        uas_list3 := array_append_record(uas_list3, uasGrid3, 0)
        uas_list4 := array_append_record(uas_list4, uasGrid4, 0)
        uas_list5 := array_append_record(uas_list5, uasGrid5, 0)
        uas_list6 := array_append_record(uas_list6, uasGrid6, 0)
        uas_list7 := array_append_record(uas_list7, uasGrid7, 0)
        uas_list8 := array_append_record(uas_list8, uasGrid8, 0)
    end do

    nor_par = new((/16/), double)
    nor_par(0) = avg(uas_list1(44166:55115)) ;; 44166->1971:00:00, 55115->44166+10950-1->2000:12:31
    nor_par(1) = sqrt(variance(uas_list1(44166:55115))) ;; 循环外前一段代码，创建列表时有一个初始值0，故序列数字加1
    nor_par(2) = avg(uas_list2(44166:55115))
    nor_par(3) = sqrt(variance(uas_list2(44166:55115)))
    nor_par(4) = avg(uas_list3(44166:55115))
    nor_par(5) = sqrt(variance(uas_list3(44166:55115)))
    nor_par(6) = avg(uas_list4(44166:55115))
    nor_par(7) = sqrt(variance(uas_list4(44166:55115)))
    nor_par(8) = avg(uas_list5(44166:55115))
    nor_par(9) = sqrt(variance(uas_list5(44166:55115)))
    nor_par(10) = avg(uas_list6(44166:55115))
    nor_par(11) = sqrt(variance(uas_list6(44166:55115)))
    nor_par(12) = avg(uas_list7(44166:55115))
    nor_par(13) = sqrt(variance(uas_list7(44166:55115)))
    nor_par(14) = avg(uas_list8(44166:55115))
    nor_par(15) = sqrt(variance(uas_list8(44166:55115)))

    return nor_par
end

begin
    mainPath = "/mnt/e/CMIP6/CanESM5"
    uasFiles = systemfunc("ls " + mainPath + "/historical/uas*.nc")

    uas_list1 = new((/1/), double, 0)
    uas_list2 = new((/1/), double, 0)
    uas_list3 = new((/1/), double, 0)
    uas_list4 = new((/1/), double, 0)
    uas_list5 = new((/1/), double, 0)
    uas_list6 = new((/1/), double, 0)
    uas_list7 = new((/1/), double, 0)
    uas_list8 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    do i = 0, 0
        f = addfile(uasFiles(i), "r")
        uasT42 := flt2dble(f->uas) ;; todouble()不能保存metadata，flt2dble()可以。
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := uasT42(:,43,34)
        uasGrid1 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := uasT42(:,40,35)
        uasGrid2 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := uasT42(:,41,35)
        uasGrid3 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := uasT42(:,42,35)
        uasGrid4 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := uasT42(:,43,35)
        uasGrid5 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := uasT42(:,39,36)
        uasGrid6 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := uasT42(:,40,36)
        uasGrid7 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := uasT42(:,41,36)
        uasGrid8 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        uas_list1 := array_append_record(uas_list1, uasGrid1, 0)
        uas_list2 := array_append_record(uas_list2, uasGrid2, 0)
        uas_list3 := array_append_record(uas_list3, uasGrid3, 0)
        uas_list4 := array_append_record(uas_list4, uasGrid4, 0)
        uas_list5 := array_append_record(uas_list5, uasGrid5, 0)
        uas_list6 := array_append_record(uas_list6, uasGrid6, 0)
        uas_list7 := array_append_record(uas_list7, uasGrid7, 0)
        uas_list8 := array_append_record(uas_list8, uasGrid8, 0)
    end do

    outPath = "/mnt/e/Climate_data_code/CanESM5/sdsm_historical_file/uas_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/canhp__ug1.dat"
    write_matrix(transpose(uas_list1(40516:56940)), "f9.3", opt1) ;; 40516->1961, 56940->40516+16425-1->2005
    opt2 = True ;; 循环外前一段代码，创建列表时有一个初始值0，故序列数字加1
    opt2@fout = outPath + "/canhp__ug2.dat"
    write_matrix(transpose(uas_list2(40516:56940)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/canhp__ug3.dat"
    write_matrix(transpose(uas_list3(40516:56940)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/canhp__ug4.dat"
    write_matrix(transpose(uas_list4(40516:56940)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/canhp__ug5.dat"
    write_matrix(transpose(uas_list5(40516:56940)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/canhp__ug6.dat"
    write_matrix(transpose(uas_list6(40516:56940)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/canhp__ug7.dat"
    write_matrix(transpose(uas_list7(40516:56940)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/canhp__ug8.dat"
    write_matrix(transpose(uas_list8(40516:56940)), "f9.3", opt8)

end