function get_normalise_par()
begin
    mainPath = "/mnt/e/CMIP6/MPI-ESM1-2-HR"
    uasFiles = systemfunc("ls " + mainPath + "/historical/uas_*.nc")
    vasFiles = systemfunc("ls " + mainPath + "/historical/vas_*.nc")

    wss_list1 = new((/1/), double, 0)
    wss_list2 = new((/1/), double, 0)
    wss_list3 = new((/1/), double, 0)
    wss_list4 = new((/1/), double, 0)
    wss_list5 = new((/1/), double, 0)
    wss_list6 = new((/1/), double, 0)
    wss_list7 = new((/1/), double, 0)
    wss_list8 = new((/1/), double, 0)

    do i = 24, 30 ;;1970-2004
        f1 = addfile(uasFiles(i), "r")
        f2 = addfile(vasFiles(i), "r")
        uasT42 := flt2dble(f1->uas) ;; todouble()不能保存metadata，flt2dble()可以。
        vasT42 := flt2dble(f2->vas)
        uasT42 := f2gsh_Wrap(uasT42, (/64, 128/), 0)
        vasT42 := f2gsh_Wrap(vasT42, (/64, 128/), 0)
        wssT42 := wind_speed(uasT42, vasT42)
        print((/i/)) ;;signal

        wssGrid1 := wssT42(:,43,34)
        wssGrid2 := wssT42(:,40,35)
        wssGrid3 := wssT42(:,41,35)
        wssGrid4 := wssT42(:,42,35)
        wssGrid5 := wssT42(:,43,35)
        wssGrid6 := wssT42(:,39,36)
        wssGrid7 := wssT42(:,40,36) 
        wssGrid8 := wssT42(:,41,36)

        wss_list1 := array_append_record(wss_list1, wssGrid1, 0)
        wss_list2 := array_append_record(wss_list2, wssGrid2, 0)
        wss_list3 := array_append_record(wss_list3, wssGrid3, 0)
        wss_list4 := array_append_record(wss_list4, wssGrid4, 0)
        wss_list5 := array_append_record(wss_list5, wssGrid5, 0)
        wss_list6 := array_append_record(wss_list6, wssGrid6, 0)
        wss_list7 := array_append_record(wss_list7, wssGrid7, 0)
        wss_list8 := array_append_record(wss_list8, wssGrid8, 0)
    end do

    ;; 1971:1:1-2000:12:31 共10958天，8个闰年。366+10958-1=11323
    nor_par = new((/16/), double)
    nor_par(0) = avg(wss_list1(366:11323)) 
    nor_par(1) = sqrt(variance(wss_list1(366:11323))) ;; 循环外前一段代码，创建列表时有一个初始值0，故序列数字加1
    nor_par(2) = avg(wss_list2(366:11323))
    nor_par(3) = sqrt(variance(wss_list2(366:11323)))
    nor_par(4) = avg(wss_list3(366:11323))
    nor_par(5) = sqrt(variance(wss_list3(366:11323)))
    nor_par(6) = avg(wss_list4(366:11323))
    nor_par(7) = sqrt(variance(wss_list4(366:11323)))
    nor_par(8) = avg(wss_list5(366:11323))
    nor_par(9) = sqrt(variance(wss_list5(366:11323)))
    nor_par(10) = avg(wss_list6(366:11323))
    nor_par(11) = sqrt(variance(wss_list6(366:11323)))
    nor_par(12) = avg(wss_list7(366:11323))
    nor_par(13) = sqrt(variance(wss_list7(366:11323)))
    nor_par(14) = avg(wss_list8(366:11323))
    nor_par(15) = sqrt(variance(wss_list8(366:11323)))

    return nor_par
end

begin
    mainPath = "/mnt/e/CMIP6/MPI-ESM1-2-HR"
    uasFiles = systemfunc("ls " + mainPath + "/historical/uas_*.nc")
    vasFiles = systemfunc("ls " + mainPath + "/historical/vas_*.nc")

    wss_list1 = new((/1/), double, 0)
    wss_list2 = new((/1/), double, 0)
    wss_list3 = new((/1/), double, 0)
    wss_list4 = new((/1/), double, 0)
    wss_list5 = new((/1/), double, 0)
    wss_list6 = new((/1/), double, 0)
    wss_list7 = new((/1/), double, 0)
    wss_list8 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    do i = 22, 31 ;; 1960-2009 （之后输出再截断至2005）
        f1 = addfile(uasFiles(i), "r")
        f2 = addfile(vasFiles(i), "r")
        uasT42 := flt2dble(f1->uas) ;; todouble()不能保存metadata，flt2dble()可以。
        vasT42 := flt2dble(f2->vas)
        uasT42 := f2gsh_Wrap(uasT42, (/64, 128/), 0)
        vasT42 := f2gsh_Wrap(vasT42, (/64, 128/), 0)
        wssT42 := wind_speed(uasT42, vasT42)
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := wssT42(:,43,34)
        wssGrid1 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := wssT42(:,40,35)
        wssGrid2 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := wssT42(:,41,35)
        wssGrid3 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := wssT42(:,42,35)
        wssGrid4 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := wssT42(:,43,35)
        wssGrid5 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := wssT42(:,39,36)
        wssGrid6 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := wssT42(:,40,36)
        wssGrid7 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := wssT42(:,41,36)
        wssGrid8 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        wss_list1 := array_append_record(wss_list1, wssGrid1, 0)
        wss_list2 := array_append_record(wss_list2, wssGrid2, 0)
        wss_list3 := array_append_record(wss_list3, wssGrid3, 0)
        wss_list4 := array_append_record(wss_list4, wssGrid4, 0)
        wss_list5 := array_append_record(wss_list5, wssGrid5, 0)
        wss_list6 := array_append_record(wss_list6, wssGrid6, 0)
        wss_list7 := array_append_record(wss_list7, wssGrid7, 0)
        wss_list8 := array_append_record(wss_list8, wssGrid8, 0)
    end do

    ;; 1961:1:1-2005:12:31 共16436天，367+16436-1=16802
    outPath = "/mnt/e/Climate_data_code/MPI-ESM1-2-HR/sdsm_historical_file/wss_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/mpihp__fg1.dat"
    write_matrix(transpose(wss_list1(367:16802)), "f9.3", opt1)
    opt2 = True ;; 循环外前一段代码，创建列表时有一个初始值0，故序列数字加1
    opt2@fout = outPath + "/mpihp__fg2.dat"
    write_matrix(transpose(wss_list2(367:16802)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/mpihp__fg3.dat"
    write_matrix(transpose(wss_list3(367:16802)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/mpihp__fg4.dat"
    write_matrix(transpose(wss_list4(367:16802)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/mpihp__fg5.dat"
    write_matrix(transpose(wss_list5(367:16802)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/mpihp__fg6.dat"
    write_matrix(transpose(wss_list6(367:16802)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/mpihp__fg7.dat"
    write_matrix(transpose(wss_list7(367:16802)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/mpihp__fg8.dat"
    write_matrix(transpose(wss_list8(367:16802)), "f9.3", opt8)

end