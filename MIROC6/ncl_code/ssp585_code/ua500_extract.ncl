function get_normalise_par()
begin
    mainPath = "/mnt/d/CMIP6/MIROC6"
    uaFiles = systemfunc("ls " + mainPath + "/historical/ua_*.nc")
    uaFiles := uaFiles(10:40)

    ua_list1_500 = new((/1/),double)
    ua_list2_500 = new((/1/),double)
    ua_list3_500 = new((/1/),double)
    ua_list4_500 = new((/1/),double)
    ua_list5_500 = new((/1/),double)
    ua_list6_500 = new((/1/),double)
    ua_list7_500 = new((/1/),double)
    ua_list8_500 = new((/1/),double)

    do i = 0, 29
        f = addfile(uaFiles(i), "r")
        ua := flt2dble(f->ua(:,3,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
        uaT42 := f2gsh_Wrap(ua, (/64, 128/), 0)
        print((/i/)) ;;signal

        uaGrid1_500 := uaT42(:,43,34)
        uaGrid2_500 := uaT42(:,40,35)
        uaGrid3_500 := uaT42(:,41,35)
        uaGrid4_500 := uaT42(:,42,35)
        uaGrid5_500 := uaT42(:,43,35)
        uaGrid6_500 := uaT42(:,39,36)
        uaGrid7_500 := uaT42(:,40,36) 
        uaGrid8_500 := uaT42(:,41,36)

        ua_list1_500 := array_append_record(ua_list1_500, uaGrid1_500, 0)
        ua_list2_500 := array_append_record(ua_list2_500, uaGrid2_500, 0)
        ua_list3_500 := array_append_record(ua_list3_500, uaGrid3_500, 0)
        ua_list4_500 := array_append_record(ua_list4_500, uaGrid4_500, 0)
        ua_list5_500 := array_append_record(ua_list5_500, uaGrid5_500, 0)
        ua_list6_500 := array_append_record(ua_list6_500, uaGrid6_500, 0)
        ua_list7_500 := array_append_record(ua_list7_500, uaGrid7_500, 0)
        ua_list8_500 := array_append_record(ua_list8_500, uaGrid8_500, 0)
    end do

    nor_par = new((/16/), double)
    nor_par(0) = avg(ua_list1_500(1:))
    nor_par(1) = sqrt(variance(ua_list1_500(1:)))
    nor_par(2) = avg(ua_list2_500(1:))
    nor_par(3) = sqrt(variance(ua_list2_500(1:)))
    nor_par(4) = avg(ua_list3_500(1:))
    nor_par(5) = sqrt(variance(ua_list3_500(1:)))
    nor_par(6) = avg(ua_list4_500(1:))
    nor_par(7) = sqrt(variance(ua_list4_500(1:)))
    nor_par(8) = avg(ua_list5_500(1:))
    nor_par(9) = sqrt(variance(ua_list5_500(1:)))
    nor_par(10) = avg(ua_list6_500(1:))
    nor_par(11) = sqrt(variance(ua_list6_500(1:)))
    nor_par(12) = avg(ua_list7_500(1:))
    nor_par(13) = sqrt(variance(ua_list7_500(1:)))
    nor_par(14) = avg(ua_list8_500(1:))
    nor_par(15) = sqrt(variance(ua_list8_500(1:)))

    return nor_par
end

begin
    mainPath = "/mnt/d/CMIP6/MIROC6"
    uaFiles = systemfunc("ls " + mainPath + "/ssp585/ua_*.nc")

    ua_list1_500 = new((/1/), double, 0)
    ua_list2_500 = new((/1/), double, 0)
    ua_list3_500 = new((/1/), double, 0)
    ua_list4_500 = new((/1/), double, 0)
    ua_list5_500 = new((/1/), double, 0)
    ua_list6_500 = new((/1/), double, 0)
    ua_list7_500 = new((/1/), double, 0)
    ua_list8_500 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    do i = 0, dimsizes(uaFiles)-1
        f = addfile(uaFiles(i), "r")
        ua := flt2dble(f->ua(:,3,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
        uaT42 := f2gsh_Wrap(ua, (/64, 128/), 0)
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := uaT42(:,43,34)
        uaGrid1_500 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := uaT42(:,40,35)
        uaGrid2_500 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := uaT42(:,41,35)
        uaGrid3_500 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := uaT42(:,42,35)
        uaGrid4_500 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := uaT42(:,43,35)
        uaGrid5_500 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := uaT42(:,39,36)
        uaGrid6_500 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := uaT42(:,40,36)
        uaGrid7_500 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := uaT42(:,41,36)
        uaGrid8_500 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        ua_list1_500 := array_append_record(ua_list1_500, uaGrid1_500, 0)
        ua_list2_500 := array_append_record(ua_list2_500, uaGrid2_500, 0)
        ua_list3_500 := array_append_record(ua_list3_500, uaGrid3_500, 0)
        ua_list4_500 := array_append_record(ua_list4_500, uaGrid4_500, 0)
        ua_list5_500 := array_append_record(ua_list5_500, uaGrid5_500, 0)
        ua_list6_500 := array_append_record(ua_list6_500, uaGrid6_500, 0)
        ua_list7_500 := array_append_record(ua_list7_500, uaGrid7_500, 0)
        ua_list8_500 := array_append_record(ua_list8_500, uaGrid8_500, 0)
    end do

    outPath = "/mnt/d/Climate_data_code/sdsm_ssp585_file/ua500_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/mir5p5_ug1.dat"
    write_matrix(transpose(ua_list1_500(1:)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/mir5p5_ug2.dat"
    write_matrix(transpose(ua_list2_500(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/mir5p5_ug3.dat"
    write_matrix(transpose(ua_list3_500(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/mir5p5_ug4.dat"
    write_matrix(transpose(ua_list4_500(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/mir5p5_ug5.dat"
    write_matrix(transpose(ua_list5_500(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/mir5p5_ug6.dat"
    write_matrix(transpose(ua_list6_500(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/mir5p5_ug7.dat"
    write_matrix(transpose(ua_list7_500(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/mir5p5_ug8.dat"
    write_matrix(transpose(ua_list8_500(1:)), "f9.3", opt8)

end