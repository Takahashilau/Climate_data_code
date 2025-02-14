function get_normalise_par()
begin
    mainPath = "/mnt/e/CMIP6/CanESM5"
    vasFiles = systemfunc("ls " + mainPath + "/historical/vas_*.nc")

    vas_list1 = new((/1/),double)
    vas_list2 = new((/1/),double)
    vas_list3 = new((/1/),double)
    vas_list4 = new((/1/),double)
    vas_list5 = new((/1/),double)
    vas_list6 = new((/1/),double)
    vas_list7 = new((/1/),double)
    vas_list8 = new((/1/),double)

    do i = 0, 0
        f = addfile(vasFiles(i), "r")
        vasT42 := flt2dble(f->vas) ;; todouble()不能保存metadata，flt2dble()可以。
        print((/i/)) ;;signal

        vasGrid1 := vasT42(:,43,34)
        vasGrid2 := vasT42(:,40,35)
        vasGrid3 := vasT42(:,41,35)
        vasGrid4 := vasT42(:,42,35)
        vasGrid5 := vasT42(:,43,35)
        vasGrid6 := vasT42(:,39,36)
        vasGrid7 := vasT42(:,40,36) 
        vasGrid8 := vasT42(:,41,36)

        vas_list1 := array_append_record(vas_list1, vasGrid1, 0)
        vas_list2 := array_append_record(vas_list2, vasGrid2, 0)
        vas_list3 := array_append_record(vas_list3, vasGrid3, 0)
        vas_list4 := array_append_record(vas_list4, vasGrid4, 0)
        vas_list5 := array_append_record(vas_list5, vasGrid5, 0)
        vas_list6 := array_append_record(vas_list6, vasGrid6, 0)
        vas_list7 := array_append_record(vas_list7, vasGrid7, 0)
        vas_list8 := array_append_record(vas_list8, vasGrid8, 0)
    end do

    nor_par = new((/16/), double)
    nor_par(0) = avg(vas_list1(44166:55115)) ;; 44166->1971:00:00, 55115->44166+10950-1->2000:12:31
    nor_par(1) = sqrt(variance(vas_list1(44166:55115))) ;; 循环外前一段代码，创建列表时有一个初始值0，故序列数字加1
    nor_par(2) = avg(vas_list2(44166:55115))
    nor_par(3) = sqrt(variance(vas_list2(44166:55115)))
    nor_par(4) = avg(vas_list3(44166:55115))
    nor_par(5) = sqrt(variance(vas_list3(44166:55115)))
    nor_par(6) = avg(vas_list4(44166:55115))
    nor_par(7) = sqrt(variance(vas_list4(44166:55115)))
    nor_par(8) = avg(vas_list5(44166:55115))
    nor_par(9) = sqrt(variance(vas_list5(44166:55115)))
    nor_par(10) = avg(vas_list6(44166:55115))
    nor_par(11) = sqrt(variance(vas_list6(44166:55115)))
    nor_par(12) = avg(vas_list7(44166:55115))
    nor_par(13) = sqrt(variance(vas_list7(44166:55115)))
    nor_par(14) = avg(vas_list8(44166:55115))
    nor_par(15) = sqrt(variance(vas_list8(44166:55115)))

    return nor_par
end

begin
    mainPath = "/mnt/e/CMIP6/CanESM5"
    vasFiles = systemfunc("ls " + mainPath + "/ssp126/vas_*.nc")

    vas_list1 = new((/1/), double, 0)
    vas_list2 = new((/1/), double, 0)
    vas_list3 = new((/1/), double, 0)
    vas_list4 = new((/1/), double, 0)
    vas_list5 = new((/1/), double, 0)
    vas_list6 = new((/1/), double, 0)
    vas_list7 = new((/1/), double, 0)
    vas_list8 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    do i = 0, dimsizes(vasFiles)-1
        f = addfile(vasFiles(i), "r")
        vasT42 := flt2dble(f->vas) ;; todouble()不能保存metadata，flt2dble()可以。
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := vasT42(:,43,34)
        vasGrid1 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := vasT42(:,40,35)
        vasGrid2 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := vasT42(:,41,35)
        vasGrid3 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := vasT42(:,42,35)
        vasGrid4 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := vasT42(:,43,35)
        vasGrid5 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := vasT42(:,39,36)
        vasGrid6 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := vasT42(:,40,36)
        vasGrid7 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := vasT42(:,41,36)
        vasGrid8 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        vas_list1 := array_append_record(vas_list1, vasGrid1, 0)
        vas_list2 := array_append_record(vas_list2, vasGrid2, 0)
        vas_list3 := array_append_record(vas_list3, vasGrid3, 0)
        vas_list4 := array_append_record(vas_list4, vasGrid4, 0)
        vas_list5 := array_append_record(vas_list5, vasGrid5, 0)
        vas_list6 := array_append_record(vas_list6, vasGrid6, 0)
        vas_list7 := array_append_record(vas_list7, vasGrid7, 0)
        vas_list8 := array_append_record(vas_list8, vasGrid8, 0)
    end do

    outPath = "/mnt/e/Climate_data_code/CanESM5/sdsm_ssp126_file/vas_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/can1p__vg1.dat"
    write_matrix(transpose(vas_list1(1:)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/can1p__vg2.dat"
    write_matrix(transpose(vas_list2(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/can1p__vg3.dat"
    write_matrix(transpose(vas_list3(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/can1p__vg4.dat"
    write_matrix(transpose(vas_list4(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/can1p__vg5.dat"
    write_matrix(transpose(vas_list5(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/can1p__vg6.dat"
    write_matrix(transpose(vas_list6(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/can1p__vg7.dat"
    write_matrix(transpose(vas_list7(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/can1p__vg8.dat"
    write_matrix(transpose(vas_list8(1:)), "f9.3", opt8)

end