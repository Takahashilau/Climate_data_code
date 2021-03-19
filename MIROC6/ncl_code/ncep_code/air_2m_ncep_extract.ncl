function get_normalise_par()
begin
    mainPath = "/mnt/d/CMIP6/NCEP_RAW_NC"
    airFiles = systemfunc("ls " + mainPath + "/air_2m/air.2m*.nc")
    airFiles := airFiles(10:40)

    air_list1_995 = new((/1/),double)
    air_list2_995 = new((/1/),double)
    air_list3_995 = new((/1/),double)
    air_list4_995 = new((/1/),double)
    air_list5_995 = new((/1/),double)
    air_list6_995 = new((/1/),double)
    air_list7_995 = new((/1/),double)
    air_list8_995 = new((/1/),double)

    do i = 0, 29
        f = addfile(airFiles(i), "r")
        air := flt2dble(f->air) ;; todouble()不能保存metadata，flt2dble()可以。
        airT42 := f2gsh_Wrap(air, (/64, 128/), 0)
        print((/i/)) ;;signal

        airGrid1_995 := airT42(:,43,34)
        airGrid2_995 := airT42(:,40,35)
        airGrid3_995 := airT42(:,41,35)
        airGrid4_995 := airT42(:,42,35)
        airGrid5_995 := airT42(:,43,35)
        airGrid6_995 := airT42(:,39,36)
        airGrid7_995 := airT42(:,40,36) 
        airGrid8_995 := airT42(:,41,36)

        air_list1_995 := array_append_record(air_list1_995, airGrid1_995, 0)
        air_list2_995 := array_append_record(air_list2_995, airGrid2_995, 0)
        air_list3_995 := array_append_record(air_list3_995, airGrid3_995, 0)
        air_list4_995 := array_append_record(air_list4_995, airGrid4_995, 0)
        air_list5_995 := array_append_record(air_list5_995, airGrid5_995, 0)
        air_list6_995 := array_append_record(air_list6_995, airGrid6_995, 0)
        air_list7_995 := array_append_record(air_list7_995, airGrid7_995, 0)
        air_list8_995 := array_append_record(air_list8_995, airGrid8_995, 0)
    end do

    nor_par = new((/16/), double)
    nor_par(0) = avg(air_list1_995(1:))
    nor_par(1) = sqrt(variance(air_list1_995(1:)))
    nor_par(2) = avg(air_list2_995(1:))
    nor_par(3) = sqrt(variance(air_list2_995(1:)))
    nor_par(4) = avg(air_list3_995(1:))
    nor_par(5) = sqrt(variance(air_list3_995(1:)))
    nor_par(6) = avg(air_list4_995(1:))
    nor_par(7) = sqrt(variance(air_list4_995(1:)))
    nor_par(8) = avg(air_list5_995(1:))
    nor_par(9) = sqrt(variance(air_list5_995(1:)))
    nor_par(10) = avg(air_list6_995(1:))
    nor_par(11) = sqrt(variance(air_list6_995(1:)))
    nor_par(12) = avg(air_list7_995(1:))
    nor_par(13) = sqrt(variance(air_list7_995(1:)))
    nor_par(14) = avg(air_list8_995(1:))
    nor_par(15) = sqrt(variance(air_list8_995(1:)))

    return nor_par
end

begin
    mainPath = "/mnt/d/CMIP6/NCEP_RAW_NC"
    airFiles = systemfunc("ls " + mainPath + "/air_2m/air.2m*.nc")

    air_list1_995 = new((/1/), double, 0)
    air_list2_995 = new((/1/), double, 0)
    air_list3_995 = new((/1/), double, 0)
    air_list4_995 = new((/1/), double, 0)
    air_list5_995 = new((/1/), double, 0)
    air_list6_995 = new((/1/), double, 0)
    air_list7_995 = new((/1/), double, 0)
    air_list8_995 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    do i = 0, 44
        f = addfile(airFiles(i), "r")
        air := flt2dble(f->air) ;; todouble()不能保存metadata，flt2dble()可以。
        airT42 := f2gsh_Wrap(air, (/64, 128/), 0)
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := airT42(:,43,34)
        airGrid1_995 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := airT42(:,40,35)
        airGrid2_995 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := airT42(:,41,35)
        airGrid3_995 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := airT42(:,42,35)
        airGrid4_995 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := airT42(:,43,35)
        airGrid5_995 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := airT42(:,39,36)
        airGrid6_995 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := airT42(:,40,36)
        airGrid7_995 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := airT42(:,41,36)
        airGrid8_995 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        air_list1_995 := array_append_record(air_list1_995, airGrid1_995, 0)
        air_list2_995 := array_append_record(air_list2_995, airGrid2_995, 0)
        air_list3_995 := array_append_record(air_list3_995, airGrid3_995, 0)
        air_list4_995 := array_append_record(air_list4_995, airGrid4_995, 0)
        air_list5_995 := array_append_record(air_list5_995, airGrid5_995, 0)
        air_list6_995 := array_append_record(air_list6_995, airGrid6_995, 0)
        air_list7_995 := array_append_record(air_list7_995, airGrid7_995, 0)
        air_list8_995 := array_append_record(air_list8_995, airGrid8_995, 0)
    end do

    outPath = "/mnt/d/Climate_data_code/sdsm_ncep_file/air2m_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/nceptempg1.dat"
    write_matrix(transpose(air_list1_995(1:)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/nceptempg2.dat"
    write_matrix(transpose(air_list2_995(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/nceptempg3.dat"
    write_matrix(transpose(air_list3_995(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/nceptempg4.dat"
    write_matrix(transpose(air_list4_995(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/nceptempg5.dat"
    write_matrix(transpose(air_list5_995(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/nceptempg6.dat"
    write_matrix(transpose(air_list6_995(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/nceptempg7.dat"
    write_matrix(transpose(air_list7_995(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/nceptempg8.dat"
    write_matrix(transpose(air_list8_995(1:)), "f9.3", opt8)

end