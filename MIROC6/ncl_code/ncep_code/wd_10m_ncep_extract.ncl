begin
    mainPath = "/mnt/e/CMIP6/NCEP_RAW_NC"
    uwndFiles = systemfunc("ls " + mainPath + "/u-wind_10m/uwnd.10m*.nc")
    vwndFiles = systemfunc("ls " + mainPath + "/v-wind_10m/vwnd.10m*.nc")

    wd_list1_10m = new((/1/),double)
    wd_list2_10m = new((/1/),double)
    wd_list3_10m = new((/1/),double)
    wd_list4_10m = new((/1/),double)
    wd_list5_10m = new((/1/),double)
    wd_list6_10m = new((/1/),double)
    wd_list7_10m = new((/1/),double)
    wd_list8_10m = new((/1/),double)

    do i = 0, 44
        f1 = addfile(uwndFiles(i), "r")
        f2 = addfile(vwndFiles(i), "r")
        uwnd := flt2dble(f1->uwnd)
        vwnd := flt2dble(f2->vwnd) ;; todouble()不能保存metadata，flt2dble()可以。
        uwnd := uwnd(:,::-1,:)
        vwnd := vwnd(:,::-1,:)
        uwndT42 := f2gsh_Wrap(uwnd, (/64, 128/), 0)
        vwndT42 := f2gsh_Wrap(vwnd, (/64, 128/), 0)
        wdT42 := wind_direction(uwndT42, vwndT42, 0)
        print((/i/)) ;;signal

        wdGrid1_10m := wdT42(:,43,34)
        wdGrid2_10m := wdT42(:,40,35)
        wdGrid3_10m := wdT42(:,41,35)
        wdGrid4_10m := wdT42(:,42,35)
        wdGrid5_10m := wdT42(:,43,35)
        wdGrid6_10m := wdT42(:,39,36)
        wdGrid7_10m := wdT42(:,40,36)
        wdGrid8_10m := wdT42(:,41,36)

        wd_list1_10m := array_append_record(wd_list1_10m, wdGrid1_10m, 0)
        wd_list2_10m := array_append_record(wd_list2_10m, wdGrid2_10m, 0)
        wd_list3_10m := array_append_record(wd_list3_10m, wdGrid3_10m, 0)
        wd_list4_10m := array_append_record(wd_list4_10m, wdGrid4_10m, 0)
        wd_list5_10m := array_append_record(wd_list5_10m, wdGrid5_10m, 0)
        wd_list6_10m := array_append_record(wd_list6_10m, wdGrid6_10m, 0)
        wd_list7_10m := array_append_record(wd_list7_10m, wdGrid7_10m, 0)
        wd_list8_10m := array_append_record(wd_list8_10m, wdGrid8_10m, 0)
    end do

    outPath = "/mnt/e/Climate_data_code/MIROC6/sdsm_ncep_file/wd10m_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/ncepp_thg1.dat"
    write_matrix(transpose(wd_list1_10m(1:)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/ncepp_thg2.dat"
    write_matrix(transpose(wd_list2_10m(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/ncepp_thg3.dat"
    write_matrix(transpose(wd_list3_10m(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/ncepp_thg4.dat"
    write_matrix(transpose(wd_list4_10m(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/ncepp_thg5.dat"
    write_matrix(transpose(wd_list5_10m(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/ncepp_thg6.dat"
    write_matrix(transpose(wd_list6_10m(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/ncepp_thg7.dat"
    write_matrix(transpose(wd_list7_10m(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/ncepp_thg8.dat"
    write_matrix(transpose(wd_list8_10m(1:)), "f9.3", opt8)

end