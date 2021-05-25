function get_normalise_par()
begin
    mainPath = "/mnt/e/CMIP6/NCEP_RAW_NC"
    uwndFiles = systemfunc("ls " + mainPath + "/u-wind/uwnd*.nc")
    uwndFiles := uwndFiles(10:40)

    uwnd_list1_500 = new((/1/),double)
    uwnd_list2_500 = new((/1/),double)
    uwnd_list3_500 = new((/1/),double)
    uwnd_list4_500 = new((/1/),double)
    uwnd_list5_500 = new((/1/),double)
    uwnd_list6_500 = new((/1/),double)
    uwnd_list7_500 = new((/1/),double)
    uwnd_list8_500 = new((/1/),double)

    do i = 0, 29
        f = addfile(uwndFiles(i), "r")
        uwnd := flt2dble(f->uwnd(:,5,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
        uwnd := uwnd(:,::-1,:)
        uwndT42 := f2gsh_Wrap(uwnd, (/64, 128/), 0)
        print((/i/)) ;;signal

        uwndGrid1_500 := uwndT42(:,43,34)
        uwndGrid2_500 := uwndT42(:,40,35)
        uwndGrid3_500 := uwndT42(:,41,35)
        uwndGrid4_500 := uwndT42(:,42,35)
        uwndGrid5_500 := uwndT42(:,43,35)
        uwndGrid6_500 := uwndT42(:,39,36)
        uwndGrid7_500 := uwndT42(:,40,36) 
        uwndGrid8_500 := uwndT42(:,41,36)

        uwnd_list1_500 := array_append_record(uwnd_list1_500, uwndGrid1_500, 0)
        uwnd_list2_500 := array_append_record(uwnd_list2_500, uwndGrid2_500, 0)
        uwnd_list3_500 := array_append_record(uwnd_list3_500, uwndGrid3_500, 0)
        uwnd_list4_500 := array_append_record(uwnd_list4_500, uwndGrid4_500, 0)
        uwnd_list5_500 := array_append_record(uwnd_list5_500, uwndGrid5_500, 0)
        uwnd_list6_500 := array_append_record(uwnd_list6_500, uwndGrid6_500, 0)
        uwnd_list7_500 := array_append_record(uwnd_list7_500, uwndGrid7_500, 0)
        uwnd_list8_500 := array_append_record(uwnd_list8_500, uwndGrid8_500, 0)
    end do

    nor_par = new((/16/), double)
    nor_par(0) = avg(uwnd_list1_500(1:))
    nor_par(1) = sqrt(variance(uwnd_list1_500(1:)))
    nor_par(2) = avg(uwnd_list2_500(1:))
    nor_par(3) = sqrt(variance(uwnd_list2_500(1:)))
    nor_par(4) = avg(uwnd_list3_500(1:))
    nor_par(5) = sqrt(variance(uwnd_list3_500(1:)))
    nor_par(6) = avg(uwnd_list4_500(1:))
    nor_par(7) = sqrt(variance(uwnd_list4_500(1:)))
    nor_par(8) = avg(uwnd_list5_500(1:))
    nor_par(9) = sqrt(variance(uwnd_list5_500(1:)))
    nor_par(10) = avg(uwnd_list6_500(1:))
    nor_par(11) = sqrt(variance(uwnd_list6_500(1:)))
    nor_par(12) = avg(uwnd_list7_500(1:))
    nor_par(13) = sqrt(variance(uwnd_list7_500(1:)))
    nor_par(14) = avg(uwnd_list8_500(1:))
    nor_par(15) = sqrt(variance(uwnd_list8_500(1:)))

    return nor_par
end

begin
    mainPath = "/mnt/e/CMIP6/NCEP_RAW_NC"
    uwndFiles = systemfunc("ls " + mainPath + "/u-wind/uwnd*.nc")

    uwnd_list1_500 = new((/1/), double, 0)
    uwnd_list2_500 = new((/1/), double, 0)
    uwnd_list3_500 = new((/1/), double, 0)
    uwnd_list4_500 = new((/1/), double, 0)
    uwnd_list5_500 = new((/1/), double, 0)
    uwnd_list6_500 = new((/1/), double, 0)
    uwnd_list7_500 = new((/1/), double, 0)
    uwnd_list8_500 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    do i = 0, 44
        f = addfile(uwndFiles(i), "r")
        uwnd := flt2dble(f->uwnd(:,5,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
        uwnd := uwnd(:,::-1,:)
        uwndT42 := f2gsh_Wrap(uwnd, (/64, 128/), 0)
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := uwndT42(:,43,34)
        uwndGrid1_500 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := uwndT42(:,40,35)
        uwndGrid2_500 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := uwndT42(:,41,35)
        uwndGrid3_500 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := uwndT42(:,42,35)
        uwndGrid4_500 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := uwndT42(:,43,35)
        uwndGrid5_500 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := uwndT42(:,39,36)
        uwndGrid6_500 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := uwndT42(:,40,36)
        uwndGrid7_500 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := uwndT42(:,41,36)
        uwndGrid8_500 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        uwnd_list1_500 := array_append_record(uwnd_list1_500, uwndGrid1_500, 0)
        uwnd_list2_500 := array_append_record(uwnd_list2_500, uwndGrid2_500, 0)
        uwnd_list3_500 := array_append_record(uwnd_list3_500, uwndGrid3_500, 0)
        uwnd_list4_500 := array_append_record(uwnd_list4_500, uwndGrid4_500, 0)
        uwnd_list5_500 := array_append_record(uwnd_list5_500, uwndGrid5_500, 0)
        uwnd_list6_500 := array_append_record(uwnd_list6_500, uwndGrid6_500, 0)
        uwnd_list7_500 := array_append_record(uwnd_list7_500, uwndGrid7_500, 0)
        uwnd_list8_500 := array_append_record(uwnd_list8_500, uwndGrid8_500, 0)
    end do

    outPath = "/mnt/e/Climate_data_code/MIROC6/sdsm_ncep_file/uwnd500_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/ncepp5_ug1.dat"
    write_matrix(transpose(uwnd_list1_500(1:)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/ncepp5_ug2.dat"
    write_matrix(transpose(uwnd_list2_500(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/ncepp5_ug3.dat"
    write_matrix(transpose(uwnd_list3_500(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/ncepp5_ug4.dat"
    write_matrix(transpose(uwnd_list4_500(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/ncepp5_ug5.dat"
    write_matrix(transpose(uwnd_list5_500(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/ncepp5_ug6.dat"
    write_matrix(transpose(uwnd_list6_500(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/ncepp5_ug7.dat"
    write_matrix(transpose(uwnd_list7_500(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/ncepp5_ug8.dat"
    write_matrix(transpose(uwnd_list8_500(1:)), "f9.3", opt8)

end