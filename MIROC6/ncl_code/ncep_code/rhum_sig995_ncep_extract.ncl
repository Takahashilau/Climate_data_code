function get_normalise_par()
begin
    mainPath = "/mnt/d/CMIP6/NCEP_RAW_NC"
    rhumFiles = systemfunc("ls " + mainPath + "/rhum_sig995/rhum.sig995*.nc")
    rhumFiles := rhumFiles(10:40)

    rhum_list1_995 = new((/1/),double)
    rhum_list2_995 = new((/1/),double)
    rhum_list3_995 = new((/1/),double)
    rhum_list4_995 = new((/1/),double)
    rhum_list5_995 = new((/1/),double)
    rhum_list6_995 = new((/1/),double)
    rhum_list7_995 = new((/1/),double)
    rhum_list8_995 = new((/1/),double)

    do i = 0, 29
        f = addfile(rhumFiles(i), "r")
        rhum := flt2dble(f->rhum) ;; todouble()不能保存metadata，flt2dble()可以。
        rhumT42 := f2gsh_Wrap(rhum, (/64, 128/), 0)
        print((/i/)) ;;signal

        rhumGrid1_995 := rhumT42(:,43,34)
        rhumGrid2_995 := rhumT42(:,40,35)
        rhumGrid3_995 := rhumT42(:,41,35)
        rhumGrid4_995 := rhumT42(:,42,35)
        rhumGrid5_995 := rhumT42(:,43,35)
        rhumGrid6_995 := rhumT42(:,39,36)
        rhumGrid7_995 := rhumT42(:,40,36) 
        rhumGrid8_995 := rhumT42(:,41,36)

        rhum_list1_995 := array_append_record(rhum_list1_995, rhumGrid1_995, 0)
        rhum_list2_995 := array_append_record(rhum_list2_995, rhumGrid2_995, 0)
        rhum_list3_995 := array_append_record(rhum_list3_995, rhumGrid3_995, 0)
        rhum_list4_995 := array_append_record(rhum_list4_995, rhumGrid4_995, 0)
        rhum_list5_995 := array_append_record(rhum_list5_995, rhumGrid5_995, 0)
        rhum_list6_995 := array_append_record(rhum_list6_995, rhumGrid6_995, 0)
        rhum_list7_995 := array_append_record(rhum_list7_995, rhumGrid7_995, 0)
        rhum_list8_995 := array_append_record(rhum_list8_995, rhumGrid8_995, 0)
    end do

    nor_par = new((/16/), double)
    nor_par(0) = avg(rhum_list1_995(1:))
    nor_par(1) = sqrt(variance(rhum_list1_995(1:)))
    nor_par(2) = avg(rhum_list2_995(1:))
    nor_par(3) = sqrt(variance(rhum_list2_995(1:)))
    nor_par(4) = avg(rhum_list3_995(1:))
    nor_par(5) = sqrt(variance(rhum_list3_995(1:)))
    nor_par(6) = avg(rhum_list4_995(1:))
    nor_par(7) = sqrt(variance(rhum_list4_995(1:)))
    nor_par(8) = avg(rhum_list5_995(1:))
    nor_par(9) = sqrt(variance(rhum_list5_995(1:)))
    nor_par(10) = avg(rhum_list6_995(1:))
    nor_par(11) = sqrt(variance(rhum_list6_995(1:)))
    nor_par(12) = avg(rhum_list7_995(1:))
    nor_par(13) = sqrt(variance(rhum_list7_995(1:)))
    nor_par(14) = avg(rhum_list8_995(1:))
    nor_par(15) = sqrt(variance(rhum_list8_995(1:)))

    return nor_par
end

begin
    mainPath = "/mnt/d/CMIP6/NCEP_RAW_NC"
    rhumFiles = systemfunc("ls " + mainPath + "/rhum_sig995/rhum.sig995*.nc")

    rhum_list1_995 = new((/1/), double, 0)
    rhum_list2_995 = new((/1/), double, 0)
    rhum_list3_995 = new((/1/), double, 0)
    rhum_list4_995 = new((/1/), double, 0)
    rhum_list5_995 = new((/1/), double, 0)
    rhum_list6_995 = new((/1/), double, 0)
    rhum_list7_995 = new((/1/), double, 0)
    rhum_list8_995 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    do i = 0, 44
        f = addfile(rhumFiles(i), "r")
        rhum := flt2dble(f->rhum) ;; todouble()不能保存metadata，flt2dble()可以。
        rhumT42 := f2gsh_Wrap(rhum, (/64, 128/), 0)
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := rhumT42(:,43,34)
        rhumGrid1_995 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := rhumT42(:,40,35)
        rhumGrid2_995 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := rhumT42(:,41,35)
        rhumGrid3_995 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := rhumT42(:,42,35)
        rhumGrid4_995 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := rhumT42(:,43,35)
        rhumGrid5_995 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := rhumT42(:,39,36)
        rhumGrid6_995 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := rhumT42(:,40,36)
        rhumGrid7_995 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := rhumT42(:,41,36)
        rhumGrid8_995 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        rhum_list1_995 := array_append_record(rhum_list1_995, rhumGrid1_995, 0)
        rhum_list2_995 := array_append_record(rhum_list2_995, rhumGrid2_995, 0)
        rhum_list3_995 := array_append_record(rhum_list3_995, rhumGrid3_995, 0)
        rhum_list4_995 := array_append_record(rhum_list4_995, rhumGrid4_995, 0)
        rhum_list5_995 := array_append_record(rhum_list5_995, rhumGrid5_995, 0)
        rhum_list6_995 := array_append_record(rhum_list6_995, rhumGrid6_995, 0)
        rhum_list7_995 := array_append_record(rhum_list7_995, rhumGrid7_995, 0)
        rhum_list8_995 := array_append_record(rhum_list8_995, rhumGrid8_995, 0)
    end do

    outPath = "/mnt/d/Climate_data_code/sdsm_ncep_file/rhum995_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/nceprhumg1.dat"
    write_matrix(transpose(rhum_list1_995(1:)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/nceprhumg2.dat"
    write_matrix(transpose(rhum_list2_995(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/nceprhumg3.dat"
    write_matrix(transpose(rhum_list3_995(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/nceprhumg4.dat"
    write_matrix(transpose(rhum_list4_995(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/nceprhumg5.dat"
    write_matrix(transpose(rhum_list5_995(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/nceprhumg6.dat"
    write_matrix(transpose(rhum_list6_995(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/nceprhumg7.dat"
    write_matrix(transpose(rhum_list7_995(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/nceprhumg8.dat"
    write_matrix(transpose(rhum_list8_995(1:)), "f9.3", opt8)

end