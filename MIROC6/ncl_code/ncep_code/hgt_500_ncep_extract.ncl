function get_normalise_par()
begin
    mainPath = "/mnt/e/CMIP6/NCEP_RAW_NC"
    hgtFiles = systemfunc("ls " + mainPath + "/hgt/hgt*.nc")
    hgtFiles := hgtFiles(10:40)

    hgt_list1_500 = new((/1/),double)
    hgt_list2_500 = new((/1/),double)
    hgt_list3_500 = new((/1/),double)
    hgt_list4_500 = new((/1/),double)
    hgt_list5_500 = new((/1/),double)
    hgt_list6_500 = new((/1/),double)
    hgt_list7_500 = new((/1/),double)
    hgt_list8_500 = new((/1/),double)

    do i = 0, 29
        f = addfile(hgtFiles(i), "r")
        hgt := flt2dble(f->hgt(:,5,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
        hgt := hgt(:,::-1,:)
        hgtT42 := f2gsh_Wrap(hgt, (/64, 128/), 0)
        print((/i/)) ;;signal

        hgtGrid1_500 := hgtT42(:,43,34)
        hgtGrid2_500 := hgtT42(:,40,35)
        hgtGrid3_500 := hgtT42(:,41,35)
        hgtGrid4_500 := hgtT42(:,42,35)
        hgtGrid5_500 := hgtT42(:,43,35)
        hgtGrid6_500 := hgtT42(:,39,36)
        hgtGrid7_500 := hgtT42(:,40,36) 
        hgtGrid8_500 := hgtT42(:,41,36)

        hgt_list1_500 := array_append_record(hgt_list1_500, hgtGrid1_500, 0)
        hgt_list2_500 := array_append_record(hgt_list2_500, hgtGrid2_500, 0)
        hgt_list3_500 := array_append_record(hgt_list3_500, hgtGrid3_500, 0)
        hgt_list4_500 := array_append_record(hgt_list4_500, hgtGrid4_500, 0)
        hgt_list5_500 := array_append_record(hgt_list5_500, hgtGrid5_500, 0)
        hgt_list6_500 := array_append_record(hgt_list6_500, hgtGrid6_500, 0)
        hgt_list7_500 := array_append_record(hgt_list7_500, hgtGrid7_500, 0)
        hgt_list8_500 := array_append_record(hgt_list8_500, hgtGrid8_500, 0)
    end do

    nor_par = new((/16/), double)
    nor_par(0) = avg(hgt_list1_500(1:))
    nor_par(1) = sqrt(variance(hgt_list1_500(1:)))
    nor_par(2) = avg(hgt_list2_500(1:))
    nor_par(3) = sqrt(variance(hgt_list2_500(1:)))
    nor_par(4) = avg(hgt_list3_500(1:))
    nor_par(5) = sqrt(variance(hgt_list3_500(1:)))
    nor_par(6) = avg(hgt_list4_500(1:))
    nor_par(7) = sqrt(variance(hgt_list4_500(1:)))
    nor_par(8) = avg(hgt_list5_500(1:))
    nor_par(9) = sqrt(variance(hgt_list5_500(1:)))
    nor_par(10) = avg(hgt_list6_500(1:))
    nor_par(11) = sqrt(variance(hgt_list6_500(1:)))
    nor_par(12) = avg(hgt_list7_500(1:))
    nor_par(13) = sqrt(variance(hgt_list7_500(1:)))
    nor_par(14) = avg(hgt_list8_500(1:))
    nor_par(15) = sqrt(variance(hgt_list8_500(1:)))

    return nor_par
end

begin
    mainPath = "/mnt/e/CMIP6/NCEP_RAW_NC"
    hgtFiles = systemfunc("ls " + mainPath + "/hgt/hgt*.nc")

    hgt_list1_500 = new((/1/), double, 0)
    hgt_list2_500 = new((/1/), double, 0)
    hgt_list3_500 = new((/1/), double, 0)
    hgt_list4_500 = new((/1/), double, 0)
    hgt_list5_500 = new((/1/), double, 0)
    hgt_list6_500 = new((/1/), double, 0)
    hgt_list7_500 = new((/1/), double, 0)
    hgt_list8_500 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    do i = 0, 44
        f = addfile(hgtFiles(i), "r")
        hgt := flt2dble(f->hgt(:,5,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
        hgt := hgt(:,::-1,:)
        hgtT42 := f2gsh_Wrap(hgt, (/64, 128/), 0)
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := hgtT42(:,43,34)
        hgtGrid1_500 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := hgtT42(:,40,35)
        hgtGrid2_500 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := hgtT42(:,41,35)
        hgtGrid3_500 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := hgtT42(:,42,35)
        hgtGrid4_500 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := hgtT42(:,43,35)
        hgtGrid5_500 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := hgtT42(:,39,36)
        hgtGrid6_500 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := hgtT42(:,40,36)
        hgtGrid7_500 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := hgtT42(:,41,36)
        hgtGrid8_500 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        hgt_list1_500 := array_append_record(hgt_list1_500, hgtGrid1_500, 0)
        hgt_list2_500 := array_append_record(hgt_list2_500, hgtGrid2_500, 0)
        hgt_list3_500 := array_append_record(hgt_list3_500, hgtGrid3_500, 0)
        hgt_list4_500 := array_append_record(hgt_list4_500, hgtGrid4_500, 0)
        hgt_list5_500 := array_append_record(hgt_list5_500, hgtGrid5_500, 0)
        hgt_list6_500 := array_append_record(hgt_list6_500, hgtGrid6_500, 0)
        hgt_list7_500 := array_append_record(hgt_list7_500, hgtGrid7_500, 0)
        hgt_list8_500 := array_append_record(hgt_list8_500, hgtGrid8_500, 0)
    end do

    outPath = "/mnt/e/Climate_data_code/MIROC6/sdsm_ncep_file/hgt500_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/ncepp500g1.dat"
    write_matrix(transpose(hgt_list1_500(1:)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/ncepp500g2.dat"
    write_matrix(transpose(hgt_list2_500(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/ncepp500g3.dat"
    write_matrix(transpose(hgt_list3_500(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/ncepp500g4.dat"
    write_matrix(transpose(hgt_list4_500(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/ncepp500g5.dat"
    write_matrix(transpose(hgt_list5_500(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/ncepp500g6.dat"
    write_matrix(transpose(hgt_list6_500(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/ncepp500g7.dat"
    write_matrix(transpose(hgt_list7_500(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/ncepp500g8.dat"
    write_matrix(transpose(hgt_list8_500(1:)), "f9.3", opt8)

end