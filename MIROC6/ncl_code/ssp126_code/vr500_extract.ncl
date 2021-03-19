function get_normalise_par()
begin
    mainPath = "/mnt/d/CMIP6/MIROC6"
    uaFiles = systemfunc("ls " + mainPath + "/historical/ua_*.nc")
    vaFiles = systemfunc("ls " + mainPath + "/historical/va_*.nc")
    uaFiles := uaFiles(10:40)
    vaFiles := vaFiles(10:40)

    vr_list1_500 = new((/1/), double, 0)
    vr_list2_500 = new((/1/), double, 0)
    vr_list3_500 = new((/1/), double, 0)
    vr_list4_500 = new((/1/), double, 0)
    vr_list5_500 = new((/1/), double, 0)
    vr_list6_500 = new((/1/), double, 0)
    vr_list7_500 = new((/1/), double, 0)
    vr_list8_500 = new((/1/), double, 0)

    do i = 0, 29
        f1 = addfile(uaFiles(i), "r")
        f2 = addfile(vaFiles(i), "r")
        ua := flt2dble(f1->ua(:,3,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
        va := flt2dble(f2->va(:,3,:,:))
        uaT42 := f2gsh_Wrap(ua, (/64, 128/), 0)
        vaT42 := f2gsh_Wrap(va, (/64, 128/), 0)
        vrT42 := uv2vrG_Wrap(uaT42, vaT42)
        print((/i/)) ;;signal

        vrGrid1_500 := vrT42(:,43,34)
        vrGrid2_500 := vrT42(:,40,35)
        vrGrid3_500 := vrT42(:,41,35)
        vrGrid4_500 := vrT42(:,42,35)
        vrGrid5_500 := vrT42(:,43,35)
        vrGrid6_500 := vrT42(:,39,36)
        vrGrid7_500 := vrT42(:,40,36) 
        vrGrid8_500 := vrT42(:,41,36)

        vr_list1_500 := array_append_record(vr_list1_500, vrGrid1_500, 0)
        vr_list2_500 := array_append_record(vr_list2_500, vrGrid2_500, 0)
        vr_list3_500 := array_append_record(vr_list3_500, vrGrid3_500, 0)
        vr_list4_500 := array_append_record(vr_list4_500, vrGrid4_500, 0)
        vr_list5_500 := array_append_record(vr_list5_500, vrGrid5_500, 0)
        vr_list6_500 := array_append_record(vr_list6_500, vrGrid6_500, 0)
        vr_list7_500 := array_append_record(vr_list7_500, vrGrid7_500, 0)
        vr_list8_500 := array_append_record(vr_list8_500, vrGrid8_500, 0)
    end do

    nor_par = new((/16/), double)
    nor_par(0) = avg(vr_list1_500(1:))
    nor_par(1) = sqrt(variance(vr_list1_500(1:)))
    nor_par(2) = avg(vr_list2_500(1:))
    nor_par(3) = sqrt(variance(vr_list2_500(1:)))
    nor_par(4) = avg(vr_list3_500(1:))
    nor_par(5) = sqrt(variance(vr_list3_500(1:)))
    nor_par(6) = avg(vr_list4_500(1:))
    nor_par(7) = sqrt(variance(vr_list4_500(1:)))
    nor_par(8) = avg(vr_list5_500(1:))
    nor_par(9) = sqrt(variance(vr_list5_500(1:)))
    nor_par(10) = avg(vr_list6_500(1:))
    nor_par(11) = sqrt(variance(vr_list6_500(1:)))
    nor_par(12) = avg(vr_list7_500(1:))
    nor_par(13) = sqrt(variance(vr_list7_500(1:)))
    nor_par(14) = avg(vr_list8_500(1:))
    nor_par(15) = sqrt(variance(vr_list8_500(1:)))

    return nor_par
end

begin
    mainPath = "/mnt/d/CMIP6/MIROC6"
    uaFiles = systemfunc("ls " + mainPath + "/ssp126/ua_*.nc")
    vaFiles = systemfunc("ls " + mainPath + "/ssp126/va_*.nc")

    vr_list1_500 = new((/1/), double, 0)
    vr_list2_500 = new((/1/), double, 0)
    vr_list3_500 = new((/1/), double, 0)
    vr_list4_500 = new((/1/), double, 0)
    vr_list5_500 = new((/1/), double, 0)
    vr_list6_500 = new((/1/), double, 0)
    vr_list7_500 = new((/1/), double, 0)
    vr_list8_500 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    do i = 0, dimsizes(uaFiles)-1
        f1 = addfile(uaFiles(i), "r")
        f2 = addfile(vaFiles(i), "r")
        ua := flt2dble(f1->ua(:,3,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
        va := flt2dble(f2->va(:,3,:,:))
        uaT42 := f2gsh_Wrap(ua, (/64, 128/), 0)
        vaT42 := f2gsh_Wrap(va, (/64, 128/), 0)
        vrT42 := uv2vrG_Wrap(uaT42, vaT42)
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := vrT42(:,43,34)
        vrGrid1_500 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := vrT42(:,40,35)
        vrGrid2_500 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := vrT42(:,41,35)
        vrGrid3_500 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := vrT42(:,42,35)
        vrGrid4_500 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := vrT42(:,43,35)
        vrGrid5_500 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := vrT42(:,39,36)
        vrGrid6_500 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := vrT42(:,40,36)
        vrGrid7_500 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := vrT42(:,41,36)
        vrGrid8_500 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        vr_list1_500 := array_append_record(vr_list1_500, vrGrid1_500, 0)
        vr_list2_500 := array_append_record(vr_list2_500, vrGrid2_500, 0)
        vr_list3_500 := array_append_record(vr_list3_500, vrGrid3_500, 0)
        vr_list4_500 := array_append_record(vr_list4_500, vrGrid4_500, 0)
        vr_list5_500 := array_append_record(vr_list5_500, vrGrid5_500, 0)
        vr_list6_500 := array_append_record(vr_list6_500, vrGrid6_500, 0)
        vr_list7_500 := array_append_record(vr_list7_500, vrGrid7_500, 0)
        vr_list8_500 := array_append_record(vr_list8_500, vrGrid8_500, 0)
    end do

    outPath = "/mnt/d/Climate_data_code/sdsm_ssp126_file/vr500_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/mir1p5_zg1.dat"
    write_matrix(transpose(vr_list1_500(1:)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/mir1p5_zg2.dat"
    write_matrix(transpose(vr_list2_500(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/mir1p5_zg3.dat"
    write_matrix(transpose(vr_list3_500(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/mir1p5_zg4.dat"
    write_matrix(transpose(vr_list4_500(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/mir1p5_zg5.dat"
    write_matrix(transpose(vr_list5_500(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/mir1p5_zg6.dat"
    write_matrix(transpose(vr_list6_500(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/mir1p5_zg7.dat"
    write_matrix(transpose(vr_list7_500(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/mir1p5_zg8.dat"
    write_matrix(transpose(vr_list8_500(1:)), "f9.3", opt8)

end