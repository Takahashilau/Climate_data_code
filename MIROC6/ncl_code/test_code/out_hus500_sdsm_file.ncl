begin
    mainPath = "/mnt/d/CMIP6/MIROC6"
    husFiles = systemfunc("ls " + mainPath + "/historical/hus*.nc")

    hus_list1_500 = new((/1/), double, 0)
    hus_list2_500 = new((/1/), double, 0)
    hus_list3_500 = new((/1/), double, 0)
    hus_list4_500 = new((/1/), double, 0)
    hus_list5_500 = new((/1/), double, 0)
    hus_list6_500 = new((/1/), double, 0)
    hus_list7_500 = new((/1/), double, 0)
    hus_list8_500 = new((/1/), double, 0)

    do i = 0, 0
        f = addfile(husFiles(i), "r")
        hus := flt2dble(f->hus) ;; todouble()不能保存metadata，flt2dble()可以。
        husT42 := f2gsh_Wrap(hus, (/64, 128/), 0)
        print((/i/)) ;;signal

        mean1 := 0.00285199588139259
        std1 := 0.0020619190108070104
        Grid1 := husT42(:,3,43,34)
        husGrid1_500 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := 0.00232542371617996
        std2 := 0.0019504704490360227
        Grid2 := husT42(:,3,40,35)
        husGrid2_500 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := 0.0024133158748585507
        std3 := 0.0019327503103839317
        Grid3 := husT42(:,3,41,35)
        husGrid3_500 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := 0.0028667864520076657
        std4 := 0.0019974713856638006
        Grid4 := husT42(:,3,42,35)
        husGrid4_500 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := 0.002884185021682789
        std5 := 0.0020570798221256886
        Grid5 := husT42(:,3,43,35)
        husGrid5_500 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := 0.002209685435745574
        std6 := 0.0018399209841959887
        Grid6 := husT42(:,3,39,36)
        husGrid6_500 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := 0.0023220193084960757
        std7 := 0.001890229770876244
        Grid7 := husT42(:,3,40,36)
        husGrid7_500 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := 0.0024178672307355355
        std8 := 0.0018731633835945619
        Grid8 := husT42(:,3,41,36)
        husGrid8_500 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        hus_list1_500 := array_append_record(hus_list1_500, husGrid1_500, 0)
        hus_list2_500 := array_append_record(hus_list2_500, husGrid2_500, 0)
        hus_list3_500 := array_append_record(hus_list3_500, husGrid3_500, 0)
        hus_list4_500 := array_append_record(hus_list4_500, husGrid4_500, 0)
        hus_list5_500 := array_append_record(hus_list5_500, husGrid5_500, 0)
        hus_list6_500 := array_append_record(hus_list6_500, husGrid6_500, 0)
        hus_list7_500 := array_append_record(hus_list7_500, husGrid7_500, 0)
        hus_list8_500 := array_append_record(hus_list8_500, husGrid8_500, 0)
    end do

    outPath = "/mnt/d/Climate_data_code/sdsm_input_file/hus500_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/mirhs500g1.dat"
    write_matrix(transpose(hus_list1_500(1:)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/mirhs500g2.dat"
    write_matrix(transpose(hus_list2_500(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/mirhs500g3.dat"
    write_matrix(transpose(hus_list3_500(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/mirhs500g4.dat"
    write_matrix(transpose(hus_list4_500(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/mirhs500g5.dat"
    write_matrix(transpose(hus_list5_500(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/mirhs500g6.dat"
    write_matrix(transpose(hus_list6_500(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/mirhs500g7.dat"
    write_matrix(transpose(hus_list7_500(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/mirhs500g8.dat"
    write_matrix(transpose(hus_list8_500(1:)), "f9.3", opt8)

end