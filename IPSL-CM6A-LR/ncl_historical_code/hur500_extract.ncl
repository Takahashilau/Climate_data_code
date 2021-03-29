function get_normalise_par()
begin
    mainPath = "/mnt/e/CMIP6/IPSL-CM6A-LR"
    hurFiles = systemfunc("ls " + mainPath + "/historical/hur_*.nc")

    hur_list1_500 = new((/1/),double)
    hur_list2_500 = new((/1/),double)
    hur_list3_500 = new((/1/),double)
    hur_list4_500 = new((/1/),double)
    hur_list5_500 = new((/1/),double)
    hur_list6_500 = new((/1/),double)
    hur_list7_500 = new((/1/),double)
    hur_list8_500 = new((/1/),double)

    i = 0
    f = addfile(hurFiles(i), "r")
    hurT42 := flt2dble(f->hur(:,3,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
    hurT42 := f2gsh_Wrap(hurT42, (/64, 128/), 0)
    print((/i/)) ;;signal

    hurGrid1_500 := hurT42(:,43,34)
    hurGrid2_500 := hurT42(:,40,35)
    hurGrid3_500 := hurT42(:,41,35)
    hurGrid4_500 := hurT42(:,42,35)
    hurGrid5_500 := hurT42(:,43,35)
    hurGrid6_500 := hurT42(:,39,36)
    hurGrid7_500 := hurT42(:,40,36) 
    hurGrid8_500 := hurT42(:,41,36)

    hur_list1_500 := array_append_record(hur_list1_500, hurGrid1_500, 0)
    hur_list2_500 := array_append_record(hur_list2_500, hurGrid2_500, 0)
    hur_list3_500 := array_append_record(hur_list3_500, hurGrid3_500, 0)
    hur_list4_500 := array_append_record(hur_list4_500, hurGrid4_500, 0)
    hur_list5_500 := array_append_record(hur_list5_500, hurGrid5_500, 0)
    hur_list6_500 := array_append_record(hur_list6_500, hurGrid6_500, 0)
    hur_list7_500 := array_append_record(hur_list7_500, hurGrid7_500, 0)
    hur_list8_500 := array_append_record(hur_list8_500, hurGrid8_500, 0)


    ;; 1950:1:1-1970:12:31 共365*21+5=7670天。加 1 成为序列头
    ;; 1971:1:1-2000:12:31 共10958天，8个闰年。7671+10958-1=18628
    nor_par = new((/16/), double)
    nor_par(0) = avg(hur_list1_500(7671:18628))
    nor_par(1) = sqrt(variance(hur_list1_500(7671:18628)))
    nor_par(2) = avg(hur_list2_500(7671:18628))
    nor_par(3) = sqrt(variance(hur_list2_500(7671:18628)))
    nor_par(4) = avg(hur_list3_500(7671:18628))
    nor_par(5) = sqrt(variance(hur_list3_500(7671:18628)))
    nor_par(6) = avg(hur_list4_500(7671:18628))
    nor_par(7) = sqrt(variance(hur_list4_500(7671:18628)))
    nor_par(8) = avg(hur_list5_500(7671:18628))
    nor_par(9) = sqrt(variance(hur_list5_500(7671:18628)))
    nor_par(10) = avg(hur_list6_500(7671:18628))
    nor_par(11) = sqrt(variance(hur_list6_500(7671:18628)))
    nor_par(12) = avg(hur_list7_500(7671:18628))
    nor_par(13) = sqrt(variance(hur_list7_500(7671:18628)))
    nor_par(14) = avg(hur_list8_500(7671:18628))
    nor_par(15) = sqrt(variance(hur_list8_500(7671:18628)))

    return nor_par
end

begin
    mainPath = "/mnt/e/CMIP6/IPSL-CM6A-LR"
    hurFiles = systemfunc("ls " + mainPath + "/historical/hur_*.nc")

    hur_list1_500 = new((/1/), double, 0)
    hur_list2_500 = new((/1/), double, 0)
    hur_list3_500 = new((/1/), double, 0)
    hur_list4_500 = new((/1/), double, 0)
    hur_list5_500 = new((/1/), double, 0)
    hur_list6_500 = new((/1/), double, 0)
    hur_list7_500 = new((/1/), double, 0)
    hur_list8_500 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    i = 0
    f = addfile(hurFiles(i), "r")
    hurT42 := flt2dble(f->hur(:,3,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
    hurT42 := f2gsh_Wrap(hurT42, (/64, 128/), 0)
    print((/i/)) ;;signal

    mean1 := nor_par(0)
    std1 := nor_par(1)
    Grid1 := hurT42(:,43,34)
    hurGrid1_500 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
    mean2 := nor_par(2)
    std2 := nor_par(3)
    Grid2 := hurT42(:,40,35)
    hurGrid2_500 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
    mean3 := nor_par(4)
    std3 := nor_par(5)
    Grid3 := hurT42(:,41,35)
    hurGrid3_500 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
    mean4 := nor_par(6)
    std4 := nor_par(7)
    Grid4 := hurT42(:,42,35)
    hurGrid4_500 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
    mean5 := nor_par(8)
    std5 := nor_par(9)
    Grid5 := hurT42(:,43,35)
    hurGrid5_500 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
    mean6 := nor_par(10)
    std6 := nor_par(11)
    Grid6 := hurT42(:,39,36)
    hurGrid6_500 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
    mean7 := nor_par(12)
    std7 := nor_par(13)
    Grid7 := hurT42(:,40,36)
    hurGrid7_500 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
    mean8 := nor_par(14)
    std8 := nor_par(15)
    Grid8 := hurT42(:,41,36)
    hurGrid8_500 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

    hur_list1_500 := array_append_record(hur_list1_500, hurGrid1_500, 0)
    hur_list2_500 := array_append_record(hur_list2_500, hurGrid2_500, 0)
    hur_list3_500 := array_append_record(hur_list3_500, hurGrid3_500, 0)
    hur_list4_500 := array_append_record(hur_list4_500, hurGrid4_500, 0)
    hur_list5_500 := array_append_record(hur_list5_500, hurGrid5_500, 0)
    hur_list6_500 := array_append_record(hur_list6_500, hurGrid6_500, 0)
    hur_list7_500 := array_append_record(hur_list7_500, hurGrid7_500, 0)
    hur_list8_500 := array_append_record(hur_list8_500, hurGrid8_500, 0)


    ;; 1950:1:1-1960:12:31 共365*11+3=4018天。加 1 成为序列头
    ;; 1961:1:1-2005:12:31 共16436天，4019+16436-1=20454
    outPath = "/mnt/e/Climate_data_code/IPSL-CM6A-LR/sdsm_historical_file/hur500_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/ipshr500g1.dat"
    write_matrix(transpose(hur_list1_500(4019:20454)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/ipshr500g2.dat"
    write_matrix(transpose(hur_list2_500(4019:20454)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/ipshr500g3.dat"
    write_matrix(transpose(hur_list3_500(4019:20454)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/ipshr500g4.dat"
    write_matrix(transpose(hur_list4_500(4019:20454)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/ipshr500g5.dat"
    write_matrix(transpose(hur_list5_500(4019:20454)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/ipshr500g6.dat"
    write_matrix(transpose(hur_list6_500(4019:20454)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/ipshr500g7.dat"
    write_matrix(transpose(hur_list7_500(4019:20454)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/ipshr500g8.dat"
    write_matrix(transpose(hur_list8_500(4019:20454)), "f9.3", opt8)

end