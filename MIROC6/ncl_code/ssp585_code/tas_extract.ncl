function get_normalise_par()
begin
    mainPath = "/mnt/d/CMIP6/MIROC6"
    tasFiles = systemfunc("ls " + mainPath + "/historical/tas_*.nc")
    tasFiles := tasFiles(1:)

    tas_list1 = new((/1/),double)
    tas_list2 = new((/1/),double)
    tas_list3 = new((/1/),double)
    tas_list4 = new((/1/),double)
    tas_list5 = new((/1/),double)
    tas_list6 = new((/1/),double)
    tas_list7 = new((/1/),double)
    tas_list8 = new((/1/),double)

    do i = 0, 3
        f = addfile(tasFiles(i), "r")
        tas := flt2dble(f->tas) ;; todouble()不能保存metadata，flt2dble()可以。
        tasT42 := f2gsh_Wrap(tas, (/64, 128/), 0)
        print((/i/)) ;;signal

        tasGrid1 := tasT42(:,43,34)
        tasGrid1 := where(tasGrid1.ne.tasGrid1@_FillValue, tasGrid1-273.15, tasGrid1@_FillValue)
        tasGrid2 := tasT42(:,40,35)
        tasGrid2 := where(tasGrid2.ne.tasGrid2@_FillValue, tasGrid2-273.15, tasGrid2@_FillValue)
        tasGrid3 := tasT42(:,41,35)
        tasGrid3 := where(tasGrid3.ne.tasGrid3@_FillValue, tasGrid3-273.15, tasGrid3@_FillValue)
        tasGrid4 := tasT42(:,42,35)
        tasGrid4 := where(tasGrid4.ne.tasGrid4@_FillValue, tasGrid4-273.15, tasGrid4@_FillValue)
        tasGrid5 := tasT42(:,43,35)
        tasGrid5 := where(tasGrid5.ne.tasGrid5@_FillValue, tasGrid5-273.15, tasGrid5@_FillValue)
        tasGrid6 := tasT42(:,39,36)
        tasGrid6 := where(tasGrid6.ne.tasGrid6@_FillValue, tasGrid6-273.15, tasGrid6@_FillValue)
        tasGrid7 := tasT42(:,40,36) 
        tasGrid7 := where(tasGrid7.ne.tasGrid7@_FillValue, tasGrid7-273.15, tasGrid7@_FillValue)
        tasGrid8 := tasT42(:,41,36)
        tasGrid8 := where(tasGrid8.ne.tasGrid8@_FillValue, tasGrid8-273.15, tasGrid8@_FillValue)

        tas_list1 := array_append_record(tas_list1, tasGrid1, 0)
        tas_list2 := array_append_record(tas_list2, tasGrid2, 0)
        tas_list3 := array_append_record(tas_list3, tasGrid3, 0)
        tas_list4 := array_append_record(tas_list4, tasGrid4, 0)
        tas_list5 := array_append_record(tas_list5, tasGrid5, 0)
        tas_list6 := array_append_record(tas_list6, tasGrid6, 0)
        tas_list7 := array_append_record(tas_list7, tasGrid7, 0)
        tas_list8 := array_append_record(tas_list8, tasGrid8, 0)
    end do

    nor_par = new((/16/), double)
    nor_par(0) = avg(tas_list1(366:11323)) ;; 366->1971:00:00, 11323->366+10958-1->2000:12:31
    nor_par(1) = sqrt(variance(tas_list1(366:11323)))
    nor_par(2) = avg(tas_list2(366:11323))
    nor_par(3) = sqrt(variance(tas_list2(366:11323)))
    nor_par(4) = avg(tas_list3(366:11323))
    nor_par(5) = sqrt(variance(tas_list3(366:11323)))
    nor_par(6) = avg(tas_list4(366:11323))
    nor_par(7) = sqrt(variance(tas_list4(366:11323)))
    nor_par(8) = avg(tas_list5(366:11323))
    nor_par(9) = sqrt(variance(tas_list5(366:11323)))
    nor_par(10) = avg(tas_list6(366:11323))
    nor_par(11) = sqrt(variance(tas_list6(366:11323)))
    nor_par(12) = avg(tas_list7(366:11323))
    nor_par(13) = sqrt(variance(tas_list7(366:11323)))
    nor_par(14) = avg(tas_list8(366:11323))
    nor_par(15) = sqrt(variance(tas_list8(366:11323)))

    return nor_par
end

begin
    mainPath = "/mnt/d/CMIP6/MIROC6"
    tasFiles = systemfunc("ls " + mainPath + "/ssp585/tas_*.nc")

    tas_list1 = new((/1/), double, 0)
    tas_list2 = new((/1/), double, 0)
    tas_list3 = new((/1/), double, 0)
    tas_list4 = new((/1/), double, 0)
    tas_list5 = new((/1/), double, 0)
    tas_list6 = new((/1/), double, 0)
    tas_list7 = new((/1/), double, 0)
    tas_list8 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    do i = 0, dimsizes(tasFiles)-1
        f = addfile(tasFiles(i), "r")
        tas := flt2dble(f->tas) ;; todouble()不能保存metadata，flt2dble()可以。
        tasT42 := f2gsh_Wrap(tas, (/64, 128/), 0)
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := tasT42(:,43,34)
        Grid1 := where(Grid1.ne.Grid1@_FillValue, Grid1-273.15, Grid1@_FillValue)
        tasGrid1 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := tasT42(:,40,35)
        Grid2 := where(Grid2.ne.Grid2@_FillValue, Grid2-273.15, Grid2@_FillValue)
        tasGrid2 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := tasT42(:,41,35)
        Grid3 := where(Grid3.ne.Grid3@_FillValue, Grid3-273.15, Grid3@_FillValue)
        tasGrid3 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := tasT42(:,42,35)
        Grid4 := where(Grid4.ne.Grid4@_FillValue, Grid4-273.15, Grid4@_FillValue)
        tasGrid4 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := tasT42(:,43,35)
        Grid5 := where(Grid5.ne.Grid5@_FillValue, Grid5-273.15, Grid5@_FillValue)
        tasGrid5 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := tasT42(:,39,36)
        Grid6 := where(Grid6.ne.Grid6@_FillValue, Grid6-273.15, Grid6@_FillValue)
        tasGrid6 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := tasT42(:,40,36)
        Grid7 := where(Grid7.ne.Grid7@_FillValue, Grid7-273.15, Grid7@_FillValue)
        tasGrid7 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := tasT42(:,41,36)
        Grid8 := where(Grid8.ne.Grid8@_FillValue, Grid8-273.15, Grid8@_FillValue)
        tasGrid8 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        tas_list1 := array_append_record(tas_list1, tasGrid1, 0)
        tas_list2 := array_append_record(tas_list2, tasGrid2, 0)
        tas_list3 := array_append_record(tas_list3, tasGrid3, 0)
        tas_list4 := array_append_record(tas_list4, tasGrid4, 0)
        tas_list5 := array_append_record(tas_list5, tasGrid5, 0)
        tas_list6 := array_append_record(tas_list6, tasGrid6, 0)
        tas_list7 := array_append_record(tas_list7, tasGrid7, 0)
        tas_list8 := array_append_record(tas_list8, tasGrid8, 0)
    end do

    outPath = "/mnt/d/Climate_data_code/sdsm_ssp585_file/tas_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/mir5tempg1.dat"
    write_matrix(transpose(tas_list1(1:)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/mir5tempg2.dat"
    write_matrix(transpose(tas_list2(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/mir5tempg3.dat"
    write_matrix(transpose(tas_list3(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/mir5tempg4.dat"
    write_matrix(transpose(tas_list4(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/mir5tempg5.dat"
    write_matrix(transpose(tas_list5(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/mir5tempg6.dat"
    write_matrix(transpose(tas_list6(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/mir5tempg7.dat"
    write_matrix(transpose(tas_list7(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/mir5tempg8.dat"
    write_matrix(transpose(tas_list8(1:)), "f9.3", opt8)

end