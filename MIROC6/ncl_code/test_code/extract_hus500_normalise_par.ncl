begin
    mainPath = "/mnt/d/CMIP6/MIROC6"
    husFiles = systemfunc("ls " + mainPath + "/historical/hus*.nc")
    husFiles := husFiles(10:40)

    hus_list1_500 = new((/1/),double)
    hus_list2_500 = new((/1/),double)
    hus_list3_500 = new((/1/),double)
    hus_list4_500 = new((/1/),double)
    hus_list5_500 = new((/1/),double)
    hus_list6_500 = new((/1/),double)
    hus_list7_500 = new((/1/),double)
    hus_list8_500 = new((/1/),double)

    do i = 0, 29
        f = addfile(husFiles(i), "r")
        hus := flt2dble(f->hus) ;; todouble()不能保存metadata，flt2dble()可以。
        husT42 := f2gsh_Wrap(hus, (/64, 128/), 0)
        print((/i/)) ;;signal

        husGrid1_500 := husT42(:,3,43,34)
        husGrid2_500 := husT42(:,3,40,35)
        husGrid3_500 := husT42(:,3,41,35)
        husGrid4_500 := husT42(:,3,42,35)
        husGrid5_500 := husT42(:,3,43,35)
        husGrid6_500 := husT42(:,3,39,36)
        husGrid7_500 := husT42(:,3,40,36) 
        husGrid8_500 := husT42(:,3,41,36)

        hus_list1_500 := array_append_record(hus_list1_500, husGrid1_500, 0)
        hus_list2_500 := array_append_record(hus_list2_500, husGrid2_500, 0)
        hus_list3_500 := array_append_record(hus_list3_500, husGrid3_500, 0)
        hus_list4_500 := array_append_record(hus_list4_500, husGrid4_500, 0)
        hus_list5_500 := array_append_record(hus_list5_500, husGrid5_500, 0)
        hus_list6_500 := array_append_record(hus_list6_500, husGrid6_500, 0)
        hus_list7_500 := array_append_record(hus_list7_500, husGrid7_500, 0)
        hus_list8_500 := array_append_record(hus_list8_500, husGrid8_500, 0)
    end do

    outPath = "/mnt/d/Climate_data_code/normalise_par/hus500_normalise_par"
    opt1 = True
    opt1@fout = outPath + "/hus_Grid1_500_19710101-20001231.txt"
    write_matrix(transpose(hus_list1_500(1:)), "f12.10", opt1)
    opt2 = True
    opt2@fout = outPath + "/hus_Grid2_500_19710101-20001231.txt"
    write_matrix(transpose(hus_list2_500(1:)), "f12.10", opt2)
    opt3 = True
    opt3@fout = outPath + "/hus_Grid3_500_19710101-20001231.txt"
    write_matrix(transpose(hus_list3_500(1:)), "f12.10", opt3)
    opt4 = True
    opt4@fout = outPath + "/hus_Grid4_500_19710101-20001231.txt"
    write_matrix(transpose(hus_list4_500(1:)), "f12.10", opt4)
    opt5 = True
    opt5@fout = outPath + "/hus_Grid5_500_19710101-20001231.txt"
    write_matrix(transpose(hus_list5_500(1:)), "f12.10", opt5)
    opt6 = True
    opt6@fout = outPath + "/hus_Grid6_500_19710101-20001231.txt"
    write_matrix(transpose(hus_list6_500(1:)), "f12.10", opt6)
    opt7 = True
    opt7@fout = outPath + "/hus_Grid7_500_19710101-20001231.txt"
    write_matrix(transpose(hus_list7_500(1:)), "f12.10", opt7)
    opt8 = True
    opt8@fout = outPath + "/hus_Grid8_500_19710101-20001231.txt"
    write_matrix(transpose(hus_list8_500(1:)), "f12.10", opt8)

end