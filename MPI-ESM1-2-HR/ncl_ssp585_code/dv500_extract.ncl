function get_normalise_par()
begin
    mainPath = "/mnt/e/CMIP6/MPI-ESM1-2-HR"
    uaFiles = systemfunc("ls " + mainPath + "/historical/ua_*.nc")
    vaFiles = systemfunc("ls " + mainPath + "/historical/va_*.nc")
    ;; 不在此处选取时间，直接在循环处选择

    dv_list1_500 = new((/1/), double, 0)
    dv_list2_500 = new((/1/), double, 0)
    dv_list3_500 = new((/1/), double, 0)
    dv_list4_500 = new((/1/), double, 0)
    dv_list5_500 = new((/1/), double, 0)
    dv_list6_500 = new((/1/), double, 0)
    dv_list7_500 = new((/1/), double, 0)
    dv_list8_500 = new((/1/), double, 0)

    do i = 24, 30 ;;1970-2004
        f1 = addfile(uaFiles(i), "r")
        f2 = addfile(vaFiles(i), "r")
        uaT42 := flt2dble(f1->ua(:,3,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
        vaT42 := flt2dble(f2->va(:,3,:,:))
        uaT42 := f2gsh_Wrap(uaT42, (/64, 128/), 0)
        vaT42 := f2gsh_Wrap(vaT42, (/64, 128/), 0)
        dvT42 := uv2dvG_Wrap(uaT42, vaT42)
        print((/i/)) ;;signal

        dvGrid1_500 := dvT42(:,43,34)
        dvGrid2_500 := dvT42(:,40,35)
        dvGrid3_500 := dvT42(:,41,35)
        dvGrid4_500 := dvT42(:,42,35)
        dvGrid5_500 := dvT42(:,43,35)
        dvGrid6_500 := dvT42(:,39,36)
        dvGrid7_500 := dvT42(:,40,36) 
        dvGrid8_500 := dvT42(:,41,36)

        dv_list1_500 := array_append_record(dv_list1_500, dvGrid1_500, 0)
        dv_list2_500 := array_append_record(dv_list2_500, dvGrid2_500, 0)
        dv_list3_500 := array_append_record(dv_list3_500, dvGrid3_500, 0)
        dv_list4_500 := array_append_record(dv_list4_500, dvGrid4_500, 0)
        dv_list5_500 := array_append_record(dv_list5_500, dvGrid5_500, 0)
        dv_list6_500 := array_append_record(dv_list6_500, dvGrid6_500, 0)
        dv_list7_500 := array_append_record(dv_list7_500, dvGrid7_500, 0)
        dv_list8_500 := array_append_record(dv_list8_500, dvGrid8_500, 0)
    end do

    ;; 1971:1:1-2000:12:31 共10958天，8个闰年。366+10958-1=11323
    nor_par = new((/16/), double)
    nor_par(0) = avg(dv_list1_500(366:11323))
    nor_par(1) = sqrt(variance(dv_list1_500(366:11323)))
    nor_par(2) = avg(dv_list2_500(366:11323))
    nor_par(3) = sqrt(variance(dv_list2_500(366:11323)))
    nor_par(4) = avg(dv_list3_500(366:11323))
    nor_par(5) = sqrt(variance(dv_list3_500(366:11323)))
    nor_par(6) = avg(dv_list4_500(366:11323))
    nor_par(7) = sqrt(variance(dv_list4_500(366:11323)))
    nor_par(8) = avg(dv_list5_500(366:11323))
    nor_par(9) = sqrt(variance(dv_list5_500(366:11323)))
    nor_par(10) = avg(dv_list6_500(366:11323))
    nor_par(11) = sqrt(variance(dv_list6_500(366:11323)))
    nor_par(12) = avg(dv_list7_500(366:11323))
    nor_par(13) = sqrt(variance(dv_list7_500(366:11323)))
    nor_par(14) = avg(dv_list8_500(366:11323))
    nor_par(15) = sqrt(variance(dv_list8_500(366:11323)))

    return nor_par
end

begin
    mainPath = "/mnt/e/CMIP6/MPI-ESM1-2-HR"
    uaFiles = systemfunc("ls " + mainPath + "/ssp585/ua_*.nc")
    vaFiles = systemfunc("ls " + mainPath + "/ssp585/va_*.nc")
    ;; 不在此处选取时间，直接在循环处选择

    dv_list1_500 = new((/1/), double, 0)
    dv_list2_500 = new((/1/), double, 0)
    dv_list3_500 = new((/1/), double, 0)
    dv_list4_500 = new((/1/), double, 0)
    dv_list5_500 = new((/1/), double, 0)
    dv_list6_500 = new((/1/), double, 0)
    dv_list7_500 = new((/1/), double, 0)
    dv_list8_500 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    do i = 0, dimsizes(uaFiles)-1
        f1 = addfile(uaFiles(i), "r")
        f2 = addfile(vaFiles(i), "r")
        uaT42 := flt2dble(f1->ua(:,3,:,:)) ;; todouble()不能保存metadata，flt2dble()可以。
        vaT42 := flt2dble(f2->va(:,3,:,:))
        uaT42 := f2gsh_Wrap(uaT42, (/64, 128/), 0)
        vaT42 := f2gsh_Wrap(vaT42, (/64, 128/), 0)
        dvT42 := uv2dvG_Wrap(uaT42, vaT42)
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := dvT42(:,43,34)
        dvGrid1_500 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := dvT42(:,40,35)
        dvGrid2_500 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := dvT42(:,41,35)
        dvGrid3_500 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := dvT42(:,42,35)
        dvGrid4_500 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := dvT42(:,43,35)
        dvGrid5_500 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := dvT42(:,39,36)
        dvGrid6_500 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := dvT42(:,40,36)
        dvGrid7_500 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := dvT42(:,41,36)
        dvGrid8_500 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        dv_list1_500 := array_append_record(dv_list1_500, dvGrid1_500, 0)
        dv_list2_500 := array_append_record(dv_list2_500, dvGrid2_500, 0)
        dv_list3_500 := array_append_record(dv_list3_500, dvGrid3_500, 0)
        dv_list4_500 := array_append_record(dv_list4_500, dvGrid4_500, 0)
        dv_list5_500 := array_append_record(dv_list5_500, dvGrid5_500, 0)
        dv_list6_500 := array_append_record(dv_list6_500, dvGrid6_500, 0)
        dv_list7_500 := array_append_record(dv_list7_500, dvGrid7_500, 0)
        dv_list8_500 := array_append_record(dv_list8_500, dvGrid8_500, 0)
    end do

    outPath = "/mnt/e/Climate_data_code/MPI-ESM1-2-HR/sdsm_ssp585_file/dv500_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/mpi5p5zhg1.dat"
    write_matrix(transpose(dv_list1_500(1:)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/mpi5p5zhg2.dat"
    write_matrix(transpose(dv_list2_500(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/mpi5p5zhg3.dat"
    write_matrix(transpose(dv_list3_500(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/mpi5p5zhg4.dat"
    write_matrix(transpose(dv_list4_500(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/mpi5p5zhg5.dat"
    write_matrix(transpose(dv_list5_500(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/mpi5p5zhg6.dat"
    write_matrix(transpose(dv_list6_500(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/mpi5p5zhg7.dat"
    write_matrix(transpose(dv_list7_500(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/mpi5p5zhg8.dat"
    write_matrix(transpose(dv_list8_500(1:)), "f9.3", opt8)
end