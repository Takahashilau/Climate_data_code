function get_normalise_par()
begin
    mainPath = "/mnt/e/CMIP6/IPSL-CM6A-LR"
    vaFiles = systemfunc("ls " + mainPath + "/historical/va_*.nc")

    va_list1_500 = new((/1/),double)
    va_list2_500 = new((/1/),double)
    va_list3_500 = new((/1/),double)
    va_list4_500 = new((/1/),double)
    va_list5_500 = new((/1/),double)
    va_list6_500 = new((/1/),double)
    va_list7_500 = new((/1/),double)
    va_list8_500 = new((/1/),double)

    i = 0
    f = addfile(vaFiles(i), "r")
    vaT42 := flt2dble(f->va(:,3,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
    vaT42 := f2gsh_Wrap(vaT42, (/64, 128/), 0)
    print((/i/)) ;;signal

    vaGrid1_500 := vaT42(:,43,34)
    vaGrid2_500 := vaT42(:,40,35)
    vaGrid3_500 := vaT42(:,41,35)
    vaGrid4_500 := vaT42(:,42,35)
    vaGrid5_500 := vaT42(:,43,35)
    vaGrid6_500 := vaT42(:,39,36)
    vaGrid7_500 := vaT42(:,40,36) 
    vaGrid8_500 := vaT42(:,41,36)

    va_list1_500 := array_append_record(va_list1_500, vaGrid1_500, 0)
    va_list2_500 := array_append_record(va_list2_500, vaGrid2_500, 0)
    va_list3_500 := array_append_record(va_list3_500, vaGrid3_500, 0)
    va_list4_500 := array_append_record(va_list4_500, vaGrid4_500, 0)
    va_list5_500 := array_append_record(va_list5_500, vaGrid5_500, 0)
    va_list6_500 := array_append_record(va_list6_500, vaGrid6_500, 0)
    va_list7_500 := array_append_record(va_list7_500, vaGrid7_500, 0)
    va_list8_500 := array_append_record(va_list8_500, vaGrid8_500, 0)


    ;; 1950:1:1-1970:12:31 共365*21+5=7670天。加 1 成为序列头
    ;; 1971:1:1-2000:12:31 共10958天，8个闰年。7671+10958-1=18628
    nor_par = new((/16/), double)
    nor_par(0) = avg(va_list1_500(7671:18628))
    nor_par(1) = sqrt(variance(va_list1_500(7671:18628)))
    nor_par(2) = avg(va_list2_500(7671:18628))
    nor_par(3) = sqrt(variance(va_list2_500(7671:18628)))
    nor_par(4) = avg(va_list3_500(7671:18628))
    nor_par(5) = sqrt(variance(va_list3_500(7671:18628)))
    nor_par(6) = avg(va_list4_500(7671:18628))
    nor_par(7) = sqrt(variance(va_list4_500(7671:18628)))
    nor_par(8) = avg(va_list5_500(7671:18628))
    nor_par(9) = sqrt(variance(va_list5_500(7671:18628)))
    nor_par(10) = avg(va_list6_500(7671:18628))
    nor_par(11) = sqrt(variance(va_list6_500(7671:18628)))
    nor_par(12) = avg(va_list7_500(7671:18628))
    nor_par(13) = sqrt(variance(va_list7_500(7671:18628)))
    nor_par(14) = avg(va_list8_500(7671:18628))
    nor_par(15) = sqrt(variance(va_list8_500(7671:18628)))

    return nor_par
end

begin
    mainPath = "/mnt/e/CMIP6/IPSL-CM6A-LR"
    vaFiles = systemfunc("ls " + mainPath + "/historical/va_*.nc")

    va_list1_500 = new((/1/), double, 0)
    va_list2_500 = new((/1/), double, 0)
    va_list3_500 = new((/1/), double, 0)
    va_list4_500 = new((/1/), double, 0)
    va_list5_500 = new((/1/), double, 0)
    va_list6_500 = new((/1/), double, 0)
    va_list7_500 = new((/1/), double, 0)
    va_list8_500 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    i = 0
    f = addfile(vaFiles(i), "r")
    vaT42 := flt2dble(f->va(:,3,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
    vaT42 := f2gsh_Wrap(vaT42, (/64, 128/), 0)
    print((/i/)) ;;signal

    mean1 := nor_par(0)
    std1 := nor_par(1)
    Grid1 := vaT42(:,43,34)
    vaGrid1_500 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
    mean2 := nor_par(2)
    std2 := nor_par(3)
    Grid2 := vaT42(:,40,35)
    vaGrid2_500 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
    mean3 := nor_par(4)
    std3 := nor_par(5)
    Grid3 := vaT42(:,41,35)
    vaGrid3_500 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
    mean4 := nor_par(6)
    std4 := nor_par(7)
    Grid4 := vaT42(:,42,35)
    vaGrid4_500 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
    mean5 := nor_par(8)
    std5 := nor_par(9)
    Grid5 := vaT42(:,43,35)
    vaGrid5_500 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
    mean6 := nor_par(10)
    std6 := nor_par(11)
    Grid6 := vaT42(:,39,36)
    vaGrid6_500 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
    mean7 := nor_par(12)
    std7 := nor_par(13)
    Grid7 := vaT42(:,40,36)
    vaGrid7_500 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
    mean8 := nor_par(14)
    std8 := nor_par(15)
    Grid8 := vaT42(:,41,36)
    vaGrid8_500 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

    va_list1_500 := array_append_record(va_list1_500, vaGrid1_500, 0)
    va_list2_500 := array_append_record(va_list2_500, vaGrid2_500, 0)
    va_list3_500 := array_append_record(va_list3_500, vaGrid3_500, 0)
    va_list4_500 := array_append_record(va_list4_500, vaGrid4_500, 0)
    va_list5_500 := array_append_record(va_list5_500, vaGrid5_500, 0)
    va_list6_500 := array_append_record(va_list6_500, vaGrid6_500, 0)
    va_list7_500 := array_append_record(va_list7_500, vaGrid7_500, 0)
    va_list8_500 := array_append_record(va_list8_500, vaGrid8_500, 0)


    ;; 1950:1:1-1960:12:31 共365*11+3=4018天。加 1 成为序列头
    ;; 1961:1:1-2005:12:31 共16436天，4019+16436-1=20454
    outPath = "/mnt/e/Climate_data_code/IPSL-CM6A-LR/sdsm_historical_file/va500_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/ipshp5_vg1.dat"
    write_matrix(transpose(va_list1_500(4019:20454)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/ipshp5_vg2.dat"
    write_matrix(transpose(va_list2_500(4019:20454)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/ipshp5_vg3.dat"
    write_matrix(transpose(va_list3_500(4019:20454)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/ipshp5_vg4.dat"
    write_matrix(transpose(va_list4_500(4019:20454)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/ipshp5_vg5.dat"
    write_matrix(transpose(va_list5_500(4019:20454)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/ipshp5_vg6.dat"
    write_matrix(transpose(va_list6_500(4019:20454)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/ipshp5_vg7.dat"
    write_matrix(transpose(va_list7_500(4019:20454)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/ipshp5_vg8.dat"
    write_matrix(transpose(va_list8_500(4019:20454)), "f9.3", opt8)

end