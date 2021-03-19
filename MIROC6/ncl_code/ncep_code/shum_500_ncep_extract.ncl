function get_normalise_par()
begin
    mainPath = "/mnt/d/CMIP6/NCEP_RAW_NC"
    shumFiles = systemfunc("ls " + mainPath + "/shum/shum*.nc")
    shumFiles := shumFiles(10:40)

    shum_list1_500 = new((/1/),double)
    shum_list2_500 = new((/1/),double)
    shum_list3_500 = new((/1/),double)
    shum_list4_500 = new((/1/),double)
    shum_list5_500 = new((/1/),double)
    shum_list6_500 = new((/1/),double)
    shum_list7_500 = new((/1/),double)
    shum_list8_500 = new((/1/),double)

    do i = 0, 29
        f = addfile(shumFiles(i), "r")
        shum := flt2dble(f->shum(:,5,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
        shumT42 := f2gsh_Wrap(shum, (/64, 128/), 0)
        print((/i/)) ;;signal

        shumGrid1_500 := shumT42(:,43,34)
        shumGrid2_500 := shumT42(:,40,35)
        shumGrid3_500 := shumT42(:,41,35)
        shumGrid4_500 := shumT42(:,42,35)
        shumGrid5_500 := shumT42(:,43,35)
        shumGrid6_500 := shumT42(:,39,36)
        shumGrid7_500 := shumT42(:,40,36) 
        shumGrid8_500 := shumT42(:,41,36)

        shum_list1_500 := array_append_record(shum_list1_500, shumGrid1_500, 0)
        shum_list2_500 := array_append_record(shum_list2_500, shumGrid2_500, 0)
        shum_list3_500 := array_append_record(shum_list3_500, shumGrid3_500, 0)
        shum_list4_500 := array_append_record(shum_list4_500, shumGrid4_500, 0)
        shum_list5_500 := array_append_record(shum_list5_500, shumGrid5_500, 0)
        shum_list6_500 := array_append_record(shum_list6_500, shumGrid6_500, 0)
        shum_list7_500 := array_append_record(shum_list7_500, shumGrid7_500, 0)
        shum_list8_500 := array_append_record(shum_list8_500, shumGrid8_500, 0)
    end do

    nor_par = new((/16/), double)
    nor_par(0) = avg(shum_list1_500(1:))
    nor_par(1) = sqrt(variance(shum_list1_500(1:)))
    nor_par(2) = avg(shum_list2_500(1:))
    nor_par(3) = sqrt(variance(shum_list2_500(1:)))
    nor_par(4) = avg(shum_list3_500(1:))
    nor_par(5) = sqrt(variance(shum_list3_500(1:)))
    nor_par(6) = avg(shum_list4_500(1:))
    nor_par(7) = sqrt(variance(shum_list4_500(1:)))
    nor_par(8) = avg(shum_list5_500(1:))
    nor_par(9) = sqrt(variance(shum_list5_500(1:)))
    nor_par(10) = avg(shum_list6_500(1:))
    nor_par(11) = sqrt(variance(shum_list6_500(1:)))
    nor_par(12) = avg(shum_list7_500(1:))
    nor_par(13) = sqrt(variance(shum_list7_500(1:)))
    nor_par(14) = avg(shum_list8_500(1:))
    nor_par(15) = sqrt(variance(shum_list8_500(1:)))

    return nor_par
end

begin
    mainPath = "/mnt/d/CMIP6/NCEP_RAW_NC"
    shumFiles = systemfunc("ls " + mainPath + "/shum/shum*.nc")

    shum_list1_500 = new((/1/), double, 0)
    shum_list2_500 = new((/1/), double, 0)
    shum_list3_500 = new((/1/), double, 0)
    shum_list4_500 = new((/1/), double, 0)
    shum_list5_500 = new((/1/), double, 0)
    shum_list6_500 = new((/1/), double, 0)
    shum_list7_500 = new((/1/), double, 0)
    shum_list8_500 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    do i = 0, 44
        f = addfile(shumFiles(i), "r")
        shum := flt2dble(f->shum(:,5,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
        shumT42 := f2gsh_Wrap(shum, (/64, 128/), 0)
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := shumT42(:,43,34)
        shumGrid1_500 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := shumT42(:,40,35)
        shumGrid2_500 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := shumT42(:,41,35)
        shumGrid3_500 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := shumT42(:,42,35)
        shumGrid4_500 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := shumT42(:,43,35)
        shumGrid5_500 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := shumT42(:,39,36)
        shumGrid6_500 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := shumT42(:,40,36)
        shumGrid7_500 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := shumT42(:,41,36)
        shumGrid8_500 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        shum_list1_500 := array_append_record(shum_list1_500, shumGrid1_500, 0)
        shum_list2_500 := array_append_record(shum_list2_500, shumGrid2_500, 0)
        shum_list3_500 := array_append_record(shum_list3_500, shumGrid3_500, 0)
        shum_list4_500 := array_append_record(shum_list4_500, shumGrid4_500, 0)
        shum_list5_500 := array_append_record(shum_list5_500, shumGrid5_500, 0)
        shum_list6_500 := array_append_record(shum_list6_500, shumGrid6_500, 0)
        shum_list7_500 := array_append_record(shum_list7_500, shumGrid7_500, 0)
        shum_list8_500 := array_append_record(shum_list8_500, shumGrid8_500, 0)
    end do

    outPath = "/mnt/d/Climate_data_code/sdsm_ncep_file/shum500_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/nceps500g1.dat"
    write_matrix(transpose(shum_list1_500(1:)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/nceps500g2.dat"
    write_matrix(transpose(shum_list2_500(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/nceps500g3.dat"
    write_matrix(transpose(shum_list3_500(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/nceps500g4.dat"
    write_matrix(transpose(shum_list4_500(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/nceps500g5.dat"
    write_matrix(transpose(shum_list5_500(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/nceps500g6.dat"
    write_matrix(transpose(shum_list6_500(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/nceps500g7.dat"
    write_matrix(transpose(shum_list7_500(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/nceps500g8.dat"
    write_matrix(transpose(shum_list8_500(1:)), "f9.3", opt8)

end