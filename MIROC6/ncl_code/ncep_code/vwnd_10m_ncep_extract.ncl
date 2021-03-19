function get_normalise_par()
begin
    mainPath = "/mnt/d/CMIP6/NCEP_RAW_NC"
    vwndFiles = systemfunc("ls " + mainPath + "/v-wind_10m/vwnd.10m*.nc")
    vwndFiles := vwndFiles(10:40)

    vwnd_list1_10m = new((/1/),double)
    vwnd_list2_10m = new((/1/),double)
    vwnd_list3_10m = new((/1/),double)
    vwnd_list4_10m = new((/1/),double)
    vwnd_list5_10m = new((/1/),double)
    vwnd_list6_10m = new((/1/),double)
    vwnd_list7_10m = new((/1/),double)
    vwnd_list8_10m = new((/1/),double)

    do i = 0, 29
        f = addfile(vwndFiles(i), "r")
        vwnd := flt2dble(f->vwnd) ;; todouble()不能保存metadata，flt2dble()可以。
        vwndT42 := f2gsh_Wrap(vwnd, (/64, 128/), 0)
        print((/i/)) ;;signal

        vwndGrid1_10m := vwndT42(:,43,34)
        vwndGrid2_10m := vwndT42(:,40,35)
        vwndGrid3_10m := vwndT42(:,41,35)
        vwndGrid4_10m := vwndT42(:,42,35)
        vwndGrid5_10m := vwndT42(:,43,35)
        vwndGrid6_10m := vwndT42(:,39,36)
        vwndGrid7_10m := vwndT42(:,40,36) 
        vwndGrid8_10m := vwndT42(:,41,36)

        vwnd_list1_10m := array_append_record(vwnd_list1_10m, vwndGrid1_10m, 0)
        vwnd_list2_10m := array_append_record(vwnd_list2_10m, vwndGrid2_10m, 0)
        vwnd_list3_10m := array_append_record(vwnd_list3_10m, vwndGrid3_10m, 0)
        vwnd_list4_10m := array_append_record(vwnd_list4_10m, vwndGrid4_10m, 0)
        vwnd_list5_10m := array_append_record(vwnd_list5_10m, vwndGrid5_10m, 0)
        vwnd_list6_10m := array_append_record(vwnd_list6_10m, vwndGrid6_10m, 0)
        vwnd_list7_10m := array_append_record(vwnd_list7_10m, vwndGrid7_10m, 0)
        vwnd_list8_10m := array_append_record(vwnd_list8_10m, vwndGrid8_10m, 0)
    end do

    nor_par = new((/16/), double)
    nor_par(0) = avg(vwnd_list1_10m(1:))
    nor_par(1) = sqrt(variance(vwnd_list1_10m(1:)))
    nor_par(2) = avg(vwnd_list2_10m(1:))
    nor_par(3) = sqrt(variance(vwnd_list2_10m(1:)))
    nor_par(4) = avg(vwnd_list3_10m(1:))
    nor_par(5) = sqrt(variance(vwnd_list3_10m(1:)))
    nor_par(6) = avg(vwnd_list4_10m(1:))
    nor_par(7) = sqrt(variance(vwnd_list4_10m(1:)))
    nor_par(8) = avg(vwnd_list5_10m(1:))
    nor_par(9) = sqrt(variance(vwnd_list5_10m(1:)))
    nor_par(10) = avg(vwnd_list6_10m(1:))
    nor_par(11) = sqrt(variance(vwnd_list6_10m(1:)))
    nor_par(12) = avg(vwnd_list7_10m(1:))
    nor_par(13) = sqrt(variance(vwnd_list7_10m(1:)))
    nor_par(14) = avg(vwnd_list8_10m(1:))
    nor_par(15) = sqrt(variance(vwnd_list8_10m(1:)))

    return nor_par
end

begin
    mainPath = "/mnt/d/CMIP6/NCEP_RAW_NC"
    vwndFiles = systemfunc("ls " + mainPath + "/v-wind_10m/vwnd.10m*.nc")

    vwnd_list1_10m = new((/1/), double, 0)
    vwnd_list2_10m = new((/1/), double, 0)
    vwnd_list3_10m = new((/1/), double, 0)
    vwnd_list4_10m = new((/1/), double, 0)
    vwnd_list5_10m = new((/1/), double, 0)
    vwnd_list6_10m = new((/1/), double, 0)
    vwnd_list7_10m = new((/1/), double, 0)
    vwnd_list8_10m = new((/1/), double, 0)

    nor_par = get_normalise_par()

    do i = 0, 44
        f = addfile(vwndFiles(i), "r")
        vwnd := flt2dble(f->vwnd) ;; todouble()不能保存metadata，flt2dble()可以。
        vwndT42 := f2gsh_Wrap(vwnd, (/64, 128/), 0)
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := vwndT42(:,43,34)
        vwndGrid1_10m := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := vwndT42(:,40,35)
        vwndGrid2_10m := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := vwndT42(:,41,35)
        vwndGrid3_10m := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := vwndT42(:,42,35)
        vwndGrid4_10m := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := vwndT42(:,43,35)
        vwndGrid5_10m := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := vwndT42(:,39,36)
        vwndGrid6_10m := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := vwndT42(:,40,36)
        vwndGrid7_10m := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := vwndT42(:,41,36)
        vwndGrid8_10m := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        vwnd_list1_10m := array_append_record(vwnd_list1_10m, vwndGrid1_10m, 0)
        vwnd_list2_10m := array_append_record(vwnd_list2_10m, vwndGrid2_10m, 0)
        vwnd_list3_10m := array_append_record(vwnd_list3_10m, vwndGrid3_10m, 0)
        vwnd_list4_10m := array_append_record(vwnd_list4_10m, vwndGrid4_10m, 0)
        vwnd_list5_10m := array_append_record(vwnd_list5_10m, vwndGrid5_10m, 0)
        vwnd_list6_10m := array_append_record(vwnd_list6_10m, vwndGrid6_10m, 0)
        vwnd_list7_10m := array_append_record(vwnd_list7_10m, vwndGrid7_10m, 0)
        vwnd_list8_10m := array_append_record(vwnd_list8_10m, vwndGrid8_10m, 0)
    end do

    outPath = "/mnt/d/Climate_data_code/sdsm_ncep_file/vwnd10m_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/ncepp__vg1.dat"
    write_matrix(transpose(vwnd_list1_10m(1:)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/ncepp__vg2.dat"
    write_matrix(transpose(vwnd_list2_10m(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/ncepp__vg3.dat"
    write_matrix(transpose(vwnd_list3_10m(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/ncepp__vg4.dat"
    write_matrix(transpose(vwnd_list4_10m(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/ncepp__vg5.dat"
    write_matrix(transpose(vwnd_list5_10m(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/ncepp__vg6.dat"
    write_matrix(transpose(vwnd_list6_10m(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/ncepp__vg7.dat"
    write_matrix(transpose(vwnd_list7_10m(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/ncepp__vg8.dat"
    write_matrix(transpose(vwnd_list8_10m(1:)), "f9.3", opt8)

end