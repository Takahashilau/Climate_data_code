function get_normalise_par()
begin
    mainPath = "/mnt/d/CMIP6/MIROC6"
    uaFiles = systemfunc("ls " + mainPath + "/historical/ua_*.nc")
    vaFiles = systemfunc("ls " + mainPath + "/historical/va_*.nc")
    uaFiles := uaFiles(10:40)
    vaFiles := vaFiles(10:40)

    ws_list1_500 = new((/1/), double, 0)
    ws_list2_500 = new((/1/), double, 0)
    ws_list3_500 = new((/1/), double, 0)
    ws_list4_500 = new((/1/), double, 0)
    ws_list5_500 = new((/1/), double, 0)
    ws_list6_500 = new((/1/), double, 0)
    ws_list7_500 = new((/1/), double, 0)
    ws_list8_500 = new((/1/), double, 0)

    do i = 0, 29
        f1 = addfile(uaFiles(i), "r")
        f2 = addfile(vaFiles(i), "r")
        ua := flt2dble(f1->ua(:,3,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
        va := flt2dble(f2->va(:,3,:,:))
        uaT42 := f2gsh_Wrap(ua, (/64, 128/), 0)
        vaT42 := f2gsh_Wrap(va, (/64, 128/), 0)
        wsT42 := wind_speed(uaT42, vaT42)
        print((/i/)) ;;signal

        wsGrid1_500 := wsT42(:,43,34)
        wsGrid2_500 := wsT42(:,40,35)
        wsGrid3_500 := wsT42(:,41,35)
        wsGrid4_500 := wsT42(:,42,35)
        wsGrid5_500 := wsT42(:,43,35)
        wsGrid6_500 := wsT42(:,39,36)
        wsGrid7_500 := wsT42(:,40,36) 
        wsGrid8_500 := wsT42(:,41,36)

        ws_list1_500 := array_append_record(ws_list1_500, wsGrid1_500, 0)
        ws_list2_500 := array_append_record(ws_list2_500, wsGrid2_500, 0)
        ws_list3_500 := array_append_record(ws_list3_500, wsGrid3_500, 0)
        ws_list4_500 := array_append_record(ws_list4_500, wsGrid4_500, 0)
        ws_list5_500 := array_append_record(ws_list5_500, wsGrid5_500, 0)
        ws_list6_500 := array_append_record(ws_list6_500, wsGrid6_500, 0)
        ws_list7_500 := array_append_record(ws_list7_500, wsGrid7_500, 0)
        ws_list8_500 := array_append_record(ws_list8_500, wsGrid8_500, 0)
    end do

    nor_par = new((/16/), double)
    nor_par(0) = avg(ws_list1_500(1:))
    nor_par(1) = sqrt(variance(ws_list1_500(1:)))
    nor_par(2) = avg(ws_list2_500(1:))
    nor_par(3) = sqrt(variance(ws_list2_500(1:)))
    nor_par(4) = avg(ws_list3_500(1:))
    nor_par(5) = sqrt(variance(ws_list3_500(1:)))
    nor_par(6) = avg(ws_list4_500(1:))
    nor_par(7) = sqrt(variance(ws_list4_500(1:)))
    nor_par(8) = avg(ws_list5_500(1:))
    nor_par(9) = sqrt(variance(ws_list5_500(1:)))
    nor_par(10) = avg(ws_list6_500(1:))
    nor_par(11) = sqrt(variance(ws_list6_500(1:)))
    nor_par(12) = avg(ws_list7_500(1:))
    nor_par(13) = sqrt(variance(ws_list7_500(1:)))
    nor_par(14) = avg(ws_list8_500(1:))
    nor_par(15) = sqrt(variance(ws_list8_500(1:)))

    return nor_par
end

begin
    mainPath = "/mnt/d/CMIP6/MIROC6"
    uaFiles = systemfunc("ls " + mainPath + "/ssp585/ua_*.nc")
    vaFiles = systemfunc("ls " + mainPath + "/ssp585/va_*.nc")

    ws_list1_500 = new((/1/), double, 0)
    ws_list2_500 = new((/1/), double, 0)
    ws_list3_500 = new((/1/), double, 0)
    ws_list4_500 = new((/1/), double, 0)
    ws_list5_500 = new((/1/), double, 0)
    ws_list6_500 = new((/1/), double, 0)
    ws_list7_500 = new((/1/), double, 0)
    ws_list8_500 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    do i = 0, dimsizes(uaFiles)-1
        f1 = addfile(uaFiles(i), "r")
        f2 = addfile(vaFiles(i), "r")
        ua := flt2dble(f1->ua(:,3,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
        va := flt2dble(f2->va(:,3,:,:))
        uaT42 := f2gsh_Wrap(ua, (/64, 128/), 0)
        vaT42 := f2gsh_Wrap(va, (/64, 128/), 0)
        wsT42 := wind_speed(uaT42, vaT42)
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := wsT42(:,43,34)
        wsGrid1_500 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := wsT42(:,40,35)
        wsGrid2_500 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := wsT42(:,41,35)
        wsGrid3_500 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := wsT42(:,42,35)
        wsGrid4_500 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := wsT42(:,43,35)
        wsGrid5_500 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := wsT42(:,39,36)
        wsGrid6_500 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := wsT42(:,40,36)
        wsGrid7_500 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := wsT42(:,41,36)
        wsGrid8_500 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        ws_list1_500 := array_append_record(ws_list1_500, wsGrid1_500, 0)
        ws_list2_500 := array_append_record(ws_list2_500, wsGrid2_500, 0)
        ws_list3_500 := array_append_record(ws_list3_500, wsGrid3_500, 0)
        ws_list4_500 := array_append_record(ws_list4_500, wsGrid4_500, 0)
        ws_list5_500 := array_append_record(ws_list5_500, wsGrid5_500, 0)
        ws_list6_500 := array_append_record(ws_list6_500, wsGrid6_500, 0)
        ws_list7_500 := array_append_record(ws_list7_500, wsGrid7_500, 0)
        ws_list8_500 := array_append_record(ws_list8_500, wsGrid8_500, 0)
    end do

    outPath = "/mnt/d/Climate_data_code/sdsm_ssp585_file/ws500_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/mir5p5_fg1.dat"
    write_matrix(transpose(ws_list1_500(1:)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/mir5p5_fg2.dat"
    write_matrix(transpose(ws_list2_500(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/mir5p5_fg3.dat"
    write_matrix(transpose(ws_list3_500(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/mir5p5_fg4.dat"
    write_matrix(transpose(ws_list4_500(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/mir5p5_fg5.dat"
    write_matrix(transpose(ws_list5_500(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/mir5p5_fg6.dat"
    write_matrix(transpose(ws_list6_500(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/mir5p5_fg7.dat"
    write_matrix(transpose(ws_list7_500(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/mir5p5_fg8.dat"
    write_matrix(transpose(ws_list8_500(1:)), "f9.3", opt8)

end