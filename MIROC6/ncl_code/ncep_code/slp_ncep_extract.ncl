function get_normalise_par()
begin
    mainPath = "/mnt/d/CMIP6/NCEP_RAW_NC"
    slpFiles = systemfunc("ls " + mainPath + "/slp/slp*.nc")
    slpFiles := slpFiles(10:40)

    slp_list1 = new((/1/),double)
    slp_list2 = new((/1/),double)
    slp_list3 = new((/1/),double)
    slp_list4 = new((/1/),double)
    slp_list5 = new((/1/),double)
    slp_list6 = new((/1/),double)
    slp_list7 = new((/1/),double)
    slp_list8 = new((/1/),double)

    do i = 0, 29
        f = addfile(slpFiles(i), "r")
        slp := flt2dble(f->slp) ;; todouble()不能保存metadata，flt2dble()可以。
        slpT42 := f2gsh_Wrap(slp, (/64, 128/), 0)
        print((/i/)) ;;signal

        slpGrid1 := slpT42(:,43,34)
        slpGrid2 := slpT42(:,40,35)
        slpGrid3 := slpT42(:,41,35)
        slpGrid4 := slpT42(:,42,35)
        slpGrid5 := slpT42(:,43,35)
        slpGrid6 := slpT42(:,39,36)
        slpGrid7 := slpT42(:,40,36) 
        slpGrid8 := slpT42(:,41,36)

        slp_list1 := array_append_record(slp_list1, slpGrid1, 0)
        slp_list2 := array_append_record(slp_list2, slpGrid2, 0)
        slp_list3 := array_append_record(slp_list3, slpGrid3, 0)
        slp_list4 := array_append_record(slp_list4, slpGrid4, 0)
        slp_list5 := array_append_record(slp_list5, slpGrid5, 0)
        slp_list6 := array_append_record(slp_list6, slpGrid6, 0)
        slp_list7 := array_append_record(slp_list7, slpGrid7, 0)
        slp_list8 := array_append_record(slp_list8, slpGrid8, 0)
    end do

    nor_par = new((/16/), double)
    nor_par(0) = avg(slp_list1(1:))
    nor_par(1) = sqrt(variance(slp_list1(1:)))
    nor_par(2) = avg(slp_list2(1:))
    nor_par(3) = sqrt(variance(slp_list2(1:)))
    nor_par(4) = avg(slp_list3(1:))
    nor_par(5) = sqrt(variance(slp_list3(1:)))
    nor_par(6) = avg(slp_list4(1:))
    nor_par(7) = sqrt(variance(slp_list4(1:)))
    nor_par(8) = avg(slp_list5(1:))
    nor_par(9) = sqrt(variance(slp_list5(1:)))
    nor_par(10) = avg(slp_list6(1:))
    nor_par(11) = sqrt(variance(slp_list6(1:)))
    nor_par(12) = avg(slp_list7(1:))
    nor_par(13) = sqrt(variance(slp_list7(1:)))
    nor_par(14) = avg(slp_list8(1:))
    nor_par(15) = sqrt(variance(slp_list8(1:)))

    return nor_par
end

begin
    mainPath = "/mnt/d/CMIP6/NCEP_RAW_NC"
    slpFiles = systemfunc("ls " + mainPath + "/slp/slp*.nc")

    slp_list1 = new((/1/), double, 0)
    slp_list2 = new((/1/), double, 0)
    slp_list3 = new((/1/), double, 0)
    slp_list4 = new((/1/), double, 0)
    slp_list5 = new((/1/), double, 0)
    slp_list6 = new((/1/), double, 0)
    slp_list7 = new((/1/), double, 0)
    slp_list8 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    do i = 0, 44
        f = addfile(slpFiles(i), "r")
        slp := flt2dble(f->slp) ;; todouble()不能保存metadata，flt2dble()可以。
        slpT42 := f2gsh_Wrap(slp, (/64, 128/), 0)
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := slpT42(:,43,34)
        slpGrid1 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := slpT42(:,40,35)
        slpGrid2 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := slpT42(:,41,35)
        slpGrid3 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := slpT42(:,42,35)
        slpGrid4 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := slpT42(:,43,35)
        slpGrid5 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := slpT42(:,39,36)
        slpGrid6 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := slpT42(:,40,36)
        slpGrid7 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := slpT42(:,41,36)
        slpGrid8 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        slp_list1 := array_append_record(slp_list1, slpGrid1, 0)
        slp_list2 := array_append_record(slp_list2, slpGrid2, 0)
        slp_list3 := array_append_record(slp_list3, slpGrid3, 0)
        slp_list4 := array_append_record(slp_list4, slpGrid4, 0)
        slp_list5 := array_append_record(slp_list5, slpGrid5, 0)
        slp_list6 := array_append_record(slp_list6, slpGrid6, 0)
        slp_list7 := array_append_record(slp_list7, slpGrid7, 0)
        slp_list8 := array_append_record(slp_list8, slpGrid8, 0)
    end do

    outPath = "/mnt/d/Climate_data_code/sdsm_ncep_file/slp_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/ncepmslpg1.dat"
    write_matrix(transpose(slp_list1(1:)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/ncepmslpg2.dat"
    write_matrix(transpose(slp_list2(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/ncepmslpg3.dat"
    write_matrix(transpose(slp_list3(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/ncepmslpg4.dat"
    write_matrix(transpose(slp_list4(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/ncepmslpg5.dat"
    write_matrix(transpose(slp_list5(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/ncepmslpg6.dat"
    write_matrix(transpose(slp_list6(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/ncepmslpg7.dat"
    write_matrix(transpose(slp_list7(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/ncepmslpg8.dat"
    write_matrix(transpose(slp_list8(1:)), "f9.3", opt8)

end