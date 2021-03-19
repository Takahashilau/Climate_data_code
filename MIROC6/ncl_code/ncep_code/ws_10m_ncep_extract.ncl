function get_normalise_par()
begin
    mainPath = "/mnt/d/CMIP6/NCEP_RAW_NC"
    uwndFiles = systemfunc("ls " + mainPath + "/u-wind_10m/uwnd.10m*.nc")
    vwndFiles = systemfunc("ls " + mainPath + "/v-wind_10m/vwnd.10m*.nc")
    uwndFiles := uwndFiles(10:40)
    vwndFiles := vwndFiles(10:40)

    ws_list1_10m = new((/1/),double)
    ws_list2_10m = new((/1/),double)
    ws_list3_10m = new((/1/),double)
    ws_list4_10m = new((/1/),double)
    ws_list5_10m = new((/1/),double)
    ws_list6_10m = new((/1/),double)
    ws_list7_10m = new((/1/),double)
    ws_list8_10m = new((/1/),double)

    do i = 0, 29
        f1 = addfile(uwndFiles(i), "r")
        f2 = addfile(vwndFiles(i), "r")
        uwnd := flt2dble(f1->uwnd)
        vwnd := flt2dble(f2->vwnd) ;; todouble()不能保存metadata，flt2dble()可以。
        uwndT42 := f2gsh_Wrap(uwnd, (/64, 128/), 0)
        vwndT42 := f2gsh_Wrap(vwnd, (/64, 128/), 0)
        wsT42 := wind_speed(uwndT42, vwndT42)
        print((/i/)) ;;signal

        wsGrid1_10m := wsT42(:,43,34)
        wsGrid2_10m := wsT42(:,40,35)
        wsGrid3_10m := wsT42(:,41,35)
        wsGrid4_10m := wsT42(:,42,35)
        wsGrid5_10m := wsT42(:,43,35)
        wsGrid6_10m := wsT42(:,39,36)
        wsGrid7_10m := wsT42(:,40,36) 
        wsGrid8_10m := wsT42(:,41,36)

        ws_list1_10m := array_append_record(ws_list1_10m, wsGrid1_10m, 0)
        ws_list2_10m := array_append_record(ws_list2_10m, wsGrid2_10m, 0)
        ws_list3_10m := array_append_record(ws_list3_10m, wsGrid3_10m, 0)
        ws_list4_10m := array_append_record(ws_list4_10m, wsGrid4_10m, 0)
        ws_list5_10m := array_append_record(ws_list5_10m, wsGrid5_10m, 0)
        ws_list6_10m := array_append_record(ws_list6_10m, wsGrid6_10m, 0)
        ws_list7_10m := array_append_record(ws_list7_10m, wsGrid7_10m, 0)
        ws_list8_10m := array_append_record(ws_list8_10m, wsGrid8_10m, 0)
    end do

    nor_par = new((/16/), double)
    nor_par(0) = avg(ws_list1_10m(1:))
    nor_par(1) = sqrt(variance(ws_list1_10m(1:)))
    nor_par(2) = avg(ws_list2_10m(1:))
    nor_par(3) = sqrt(variance(ws_list2_10m(1:)))
    nor_par(4) = avg(ws_list3_10m(1:))
    nor_par(5) = sqrt(variance(ws_list3_10m(1:)))
    nor_par(6) = avg(ws_list4_10m(1:))
    nor_par(7) = sqrt(variance(ws_list4_10m(1:)))
    nor_par(8) = avg(ws_list5_10m(1:))
    nor_par(9) = sqrt(variance(ws_list5_10m(1:)))
    nor_par(10) = avg(ws_list6_10m(1:))
    nor_par(11) = sqrt(variance(ws_list6_10m(1:)))
    nor_par(12) = avg(ws_list7_10m(1:))
    nor_par(13) = sqrt(variance(ws_list7_10m(1:)))
    nor_par(14) = avg(ws_list8_10m(1:))
    nor_par(15) = sqrt(variance(ws_list8_10m(1:)))

    return nor_par
end

begin
    mainPath = "/mnt/d/CMIP6/NCEP_RAW_NC"
    uwndFiles = systemfunc("ls " + mainPath + "/u-wind_10m/uwnd.10m*.nc")
    vwndFiles = systemfunc("ls " + mainPath + "/v-wind_10m/vwnd.10m*.nc")

    ws_list1_10m = new((/1/),double)
    ws_list2_10m = new((/1/),double)
    ws_list3_10m = new((/1/),double)
    ws_list4_10m = new((/1/),double)
    ws_list5_10m = new((/1/),double)
    ws_list6_10m = new((/1/),double)
    ws_list7_10m = new((/1/),double)
    ws_list8_10m = new((/1/),double)

    nor_par = get_normalise_par()

    do i = 0, 44
        f1 = addfile(uwndFiles(i), "r")
        f2 = addfile(vwndFiles(i), "r")
        uwnd := flt2dble(f1->uwnd)
        vwnd := flt2dble(f2->vwnd) ;; todouble()不能保存metadata，flt2dble()可以。
        uwndT42 := f2gsh_Wrap(uwnd, (/64, 128/), 0)
        vwndT42 := f2gsh_Wrap(vwnd, (/64, 128/), 0)
        wsT42 := wind_speed(uwndT42, vwndT42)
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := wsT42(:,43,34)
        wsGrid1_10m := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := wsT42(:,40,35)
        wsGrid2_10m := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := wsT42(:,41,35)
        wsGrid3_10m := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := wsT42(:,42,35)
        wsGrid4_10m := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := wsT42(:,43,35)
        wsGrid5_10m := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := wsT42(:,39,36)
        wsGrid6_10m := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := wsT42(:,40,36)
        wsGrid7_10m := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := wsT42(:,41,36)
        wsGrid8_10m := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        ws_list1_10m := array_append_record(ws_list1_10m, wsGrid1_10m, 0)
        ws_list2_10m := array_append_record(ws_list2_10m, wsGrid2_10m, 0)
        ws_list3_10m := array_append_record(ws_list3_10m, wsGrid3_10m, 0)
        ws_list4_10m := array_append_record(ws_list4_10m, wsGrid4_10m, 0)
        ws_list5_10m := array_append_record(ws_list5_10m, wsGrid5_10m, 0)
        ws_list6_10m := array_append_record(ws_list6_10m, wsGrid6_10m, 0)
        ws_list7_10m := array_append_record(ws_list7_10m, wsGrid7_10m, 0)
        ws_list8_10m := array_append_record(ws_list8_10m, wsGrid8_10m, 0)
    end do

    outPath = "/mnt/d/Climate_data_code/sdsm_ncep_file/ws10m_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/ncepp__fg1.dat"
    write_matrix(transpose(ws_list1_10m(1:)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/ncepp__fg2.dat"
    write_matrix(transpose(ws_list2_10m(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/ncepp__fg3.dat"
    write_matrix(transpose(ws_list3_10m(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/ncepp__fg4.dat"
    write_matrix(transpose(ws_list4_10m(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/ncepp__fg5.dat"
    write_matrix(transpose(ws_list5_10m(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/ncepp__fg6.dat"
    write_matrix(transpose(ws_list6_10m(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/ncepp__fg7.dat"
    write_matrix(transpose(ws_list7_10m(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/ncepp__fg8.dat"
    write_matrix(transpose(ws_list8_10m(1:)), "f9.3", opt8)

end