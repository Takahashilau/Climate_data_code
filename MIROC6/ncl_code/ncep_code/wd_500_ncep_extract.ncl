begin
    mainPath = "/mnt/d/CMIP6/NCEP_RAW_NC"
    uwndFiles = systemfunc("ls " + mainPath + "/u-wind/uwnd*.nc")
    vwndFiles = systemfunc("ls " + mainPath + "/v-wind/vwnd*.nc")

    wd_list1_500 = new((/1/),double)
    wd_list2_500 = new((/1/),double)
    wd_list3_500 = new((/1/),double)
    wd_list4_500 = new((/1/),double)
    wd_list5_500 = new((/1/),double)
    wd_list6_500 = new((/1/),double)
    wd_list7_500 = new((/1/),double)
    wd_list8_500 = new((/1/),double)

    do i = 0, 44
        f1 = addfile(uwndFiles(i), "r")
        f2 = addfile(vwndFiles(i), "r")
        uwnd := flt2dble(f1->uwnd(:,5,:,:))
        vwnd := flt2dble(f2->vwnd(:,5,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
        uwndT42 := f2gsh_Wrap(uwnd, (/64, 128/), 0)
        vwndT42 := f2gsh_Wrap(vwnd, (/64, 128/), 0)
        wdT42 := wind_direction(uwndT42, vwndT42, 0)
        print((/i/)) ;;signal

        wdGrid1_500 := wdT42(:,43,34)
        wdGrid2_500 := wdT42(:,40,35)
        wdGrid3_500 := wdT42(:,41,35)
        wdGrid4_500 := wdT42(:,42,35)
        wdGrid5_500 := wdT42(:,43,35)
        wdGrid6_500 := wdT42(:,39,36)
        wdGrid7_500 := wdT42(:,40,36)
        wdGrid8_500 := wdT42(:,41,36)

        wd_list1_500 := array_append_record(wd_list1_500, wdGrid1_500, 0)
        wd_list2_500 := array_append_record(wd_list2_500, wdGrid2_500, 0)
        wd_list3_500 := array_append_record(wd_list3_500, wdGrid3_500, 0)
        wd_list4_500 := array_append_record(wd_list4_500, wdGrid4_500, 0)
        wd_list5_500 := array_append_record(wd_list5_500, wdGrid5_500, 0)
        wd_list6_500 := array_append_record(wd_list6_500, wdGrid6_500, 0)
        wd_list7_500 := array_append_record(wd_list7_500, wdGrid7_500, 0)
        wd_list8_500 := array_append_record(wd_list8_500, wdGrid8_500, 0)
    end do

    outPath = "/mnt/d/Climate_data_code/sdsm_ncep_file/wd500_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/ncepp5thg1.dat"
    write_matrix(transpose(wd_list1_500(1:)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/ncepp5thg2.dat"
    write_matrix(transpose(wd_list2_500(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/ncepp5thg3.dat"
    write_matrix(transpose(wd_list3_500(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/ncepp5thg4.dat"
    write_matrix(transpose(wd_list4_500(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/ncepp5thg5.dat"
    write_matrix(transpose(wd_list5_500(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/ncepp5thg6.dat"
    write_matrix(transpose(wd_list6_500(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/ncepp5thg7.dat"
    write_matrix(transpose(wd_list7_500(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/ncepp5thg8.dat"
    write_matrix(transpose(wd_list8_500(1:)), "f9.3", opt8)

end