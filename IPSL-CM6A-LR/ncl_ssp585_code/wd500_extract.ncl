begin
    mainPath = "/mnt/e/CMIP6/IPSL-CM6A-LR"
    uaFiles = systemfunc("ls " + mainPath + "/ssp585/ua_*.nc")
    vaFiles = systemfunc("ls " + mainPath + "/ssp585/va_*.nc")

    wd_list1_500 = new((/1/), double, 0)
    wd_list2_500 = new((/1/), double, 0)
    wd_list3_500 = new((/1/), double, 0)
    wd_list4_500 = new((/1/), double, 0)
    wd_list5_500 = new((/1/), double, 0)
    wd_list6_500 = new((/1/), double, 0)
    wd_list7_500 = new((/1/), double, 0)
    wd_list8_500 = new((/1/), double, 0)

    do i = 0, dimsizes(uaFiles)-1
        f1 = addfile(uaFiles(i), "r")
        f2 = addfile(vaFiles(i), "r")
        uaT42 := flt2dble(f1->ua(:,3,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
        vaT42 := flt2dble(f2->va(:,3,:,:))
        uaT42 := f2gsh_Wrap(uaT42, (/64, 128/), 0)
        vaT42 := f2gsh_Wrap(vaT42, (/64, 128/), 0)
        wdT42 := wind_direction(uaT42, vaT42, 0)
        print((/i/)) ;;signal

        Grid1_500 := wdT42(:,43,34)
        Grid2_500 := wdT42(:,40,35)
        Grid3_500 := wdT42(:,41,35)
        Grid4_500 := wdT42(:,42,35)
        Grid5_500 := wdT42(:,43,35)
        Grid6_500 := wdT42(:,39,36)
        Grid7_500 := wdT42(:,40,36)
        Grid8_500 := wdT42(:,41,36)

        wd_list1_500 := array_append_record(wd_list1_500, Grid1_500, 0)
        wd_list2_500 := array_append_record(wd_list2_500, Grid2_500, 0)
        wd_list3_500 := array_append_record(wd_list3_500, Grid3_500, 0)
        wd_list4_500 := array_append_record(wd_list4_500, Grid4_500, 0)
        wd_list5_500 := array_append_record(wd_list5_500, Grid5_500, 0)
        wd_list6_500 := array_append_record(wd_list6_500, Grid6_500, 0)
        wd_list7_500 := array_append_record(wd_list7_500, Grid7_500, 0)
        wd_list8_500 := array_append_record(wd_list8_500, Grid8_500, 0)
    end do
    
    outPath = "/mnt/e/Climate_data_code/IPSL-CM6A-LR/sdsm_ssp585_file/wd500_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/ips5p5thg1.dat"
    write_matrix(transpose(wd_list1_500(1:)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/ips5p5thg2.dat"
    write_matrix(transpose(wd_list2_500(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/ips5p5thg3.dat"
    write_matrix(transpose(wd_list3_500(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/ips5p5thg4.dat"
    write_matrix(transpose(wd_list4_500(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/ips5p5thg5.dat"
    write_matrix(transpose(wd_list5_500(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/ips5p5thg6.dat"
    write_matrix(transpose(wd_list6_500(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/ips5p5thg7.dat"
    write_matrix(transpose(wd_list7_500(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/ips5p5thg8.dat"
    write_matrix(transpose(wd_list8_500(1:)), "f9.3", opt8)

end