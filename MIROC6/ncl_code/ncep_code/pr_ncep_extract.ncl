function get_normalise_par()
begin
    mainPath = "/mnt/e/CMIP6/NCEP_RAW_NC"
    pr_wtrFiles = systemfunc("ls " + mainPath + "/pr/pr_wtr*.nc")
    pr_wtrFiles := pr_wtrFiles(10:40)

    pr_wtr_list1 = new((/1/),double)
    pr_wtr_list2 = new((/1/),double)
    pr_wtr_list3 = new((/1/),double)
    pr_wtr_list4 = new((/1/),double)
    pr_wtr_list5 = new((/1/),double)
    pr_wtr_list6 = new((/1/),double)
    pr_wtr_list7 = new((/1/),double)
    pr_wtr_list8 = new((/1/),double)

    do i = 0, 29
        f = addfile(pr_wtrFiles(i), "r")
        pr_wtr := flt2dble(f->pr_wtr) ;; todouble()不能保存metadata，flt2dble()可以。
        pr_wtr := pr_wtr(:,::-1,:)
        pr_wtrT42 := f2gsh_Wrap(pr_wtr, (/64, 128/), 0)
        print((/i/)) ;;signal

        pr_wtrGrid1 := pr_wtrT42(:,43,34)
        pr_wtrGrid2 := pr_wtrT42(:,40,35)
        pr_wtrGrid3 := pr_wtrT42(:,41,35)
        pr_wtrGrid4 := pr_wtrT42(:,42,35)
        pr_wtrGrid5 := pr_wtrT42(:,43,35)
        pr_wtrGrid6 := pr_wtrT42(:,39,36)
        pr_wtrGrid7 := pr_wtrT42(:,40,36) 
        pr_wtrGrid8 := pr_wtrT42(:,41,36)

        pr_wtr_list1 := array_append_record(pr_wtr_list1, pr_wtrGrid1, 0)
        pr_wtr_list2 := array_append_record(pr_wtr_list2, pr_wtrGrid2, 0)
        pr_wtr_list3 := array_append_record(pr_wtr_list3, pr_wtrGrid3, 0)
        pr_wtr_list4 := array_append_record(pr_wtr_list4, pr_wtrGrid4, 0)
        pr_wtr_list5 := array_append_record(pr_wtr_list5, pr_wtrGrid5, 0)
        pr_wtr_list6 := array_append_record(pr_wtr_list6, pr_wtrGrid6, 0)
        pr_wtr_list7 := array_append_record(pr_wtr_list7, pr_wtrGrid7, 0)
        pr_wtr_list8 := array_append_record(pr_wtr_list8, pr_wtrGrid8, 0)
    end do

    nor_par = new((/16/), double)
    nor_par(0) = avg(pr_wtr_list1(1:))
    nor_par(1) = sqrt(variance(pr_wtr_list1(1:)))
    nor_par(2) = avg(pr_wtr_list2(1:))
    nor_par(3) = sqrt(variance(pr_wtr_list2(1:)))
    nor_par(4) = avg(pr_wtr_list3(1:))
    nor_par(5) = sqrt(variance(pr_wtr_list3(1:)))
    nor_par(6) = avg(pr_wtr_list4(1:))
    nor_par(7) = sqrt(variance(pr_wtr_list4(1:)))
    nor_par(8) = avg(pr_wtr_list5(1:))
    nor_par(9) = sqrt(variance(pr_wtr_list5(1:)))
    nor_par(10) = avg(pr_wtr_list6(1:))
    nor_par(11) = sqrt(variance(pr_wtr_list6(1:)))
    nor_par(12) = avg(pr_wtr_list7(1:))
    nor_par(13) = sqrt(variance(pr_wtr_list7(1:)))
    nor_par(14) = avg(pr_wtr_list8(1:))
    nor_par(15) = sqrt(variance(pr_wtr_list8(1:)))

    return nor_par
end

begin
    mainPath = "/mnt/e/CMIP6/NCEP_RAW_NC"
    pr_wtrFiles = systemfunc("ls " + mainPath + "/pr/pr_wtr*.nc")

    pr_wtr_list1 = new((/1/), double, 0)
    pr_wtr_list2 = new((/1/), double, 0)
    pr_wtr_list3 = new((/1/), double, 0)
    pr_wtr_list4 = new((/1/), double, 0)
    pr_wtr_list5 = new((/1/), double, 0)
    pr_wtr_list6 = new((/1/), double, 0)
    pr_wtr_list7 = new((/1/), double, 0)
    pr_wtr_list8 = new((/1/), double, 0)

    nor_par = get_normalise_par()

    do i = 0, 44
        f = addfile(pr_wtrFiles(i), "r")
        pr_wtr := flt2dble(f->pr_wtr) ;; todouble()不能保存metadata，flt2dble()可以。
        pr_wtr := pr_wtr(:,::-1,:)
        pr_wtrT42 := f2gsh_Wrap(pr_wtr, (/64, 128/), 0)
        print((/i/)) ;;signal

        mean1 := nor_par(0)
        std1 := nor_par(1)
        Grid1 := pr_wtrT42(:,43,34)
        pr_wtrGrid1 := where(Grid1.ne.Grid1@_FillValue, (Grid1-mean1)/std1, Grid1@_FillValue)
        mean2 := nor_par(2)
        std2 := nor_par(3)
        Grid2 := pr_wtrT42(:,40,35)
        pr_wtrGrid2 := where(Grid2.ne.Grid2@_FillValue, (Grid2-mean2)/std2, Grid2@_FillValue) 
        mean3 := nor_par(4)
        std3 := nor_par(5)
        Grid3 := pr_wtrT42(:,41,35)
        pr_wtrGrid3 := where(Grid3.ne.Grid3@_FillValue, (Grid3-mean3)/std3, Grid3@_FillValue)
        mean4 := nor_par(6)
        std4 := nor_par(7)
        Grid4 := pr_wtrT42(:,42,35)
        pr_wtrGrid4 := where(Grid4.ne.Grid4@_FillValue, (Grid4-mean4)/std4, Grid4@_FillValue)
        mean5 := nor_par(8)
        std5 := nor_par(9)
        Grid5 := pr_wtrT42(:,43,35)
        pr_wtrGrid5 := where(Grid5.ne.Grid5@_FillValue, (Grid5-mean5)/std5, Grid5@_FillValue)
        mean6 := nor_par(10)
        std6 := nor_par(11)
        Grid6 := pr_wtrT42(:,39,36)
        pr_wtrGrid6 := where(Grid6.ne.Grid6@_FillValue, (Grid6-mean6)/std6, Grid6@_FillValue) 
        mean7 := nor_par(12)
        std7 := nor_par(13)
        Grid7 := pr_wtrT42(:,40,36)
        pr_wtrGrid7 := where(Grid7.ne.Grid7@_FillValue, (Grid7-mean7)/std7, Grid7@_FillValue)
        mean8 := nor_par(14)
        std8 := nor_par(15)
        Grid8 := pr_wtrT42(:,41,36)
        pr_wtrGrid8 := where(Grid8.ne.Grid8@_FillValue, (Grid8-mean8)/std8, Grid8@_FillValue) 

        pr_wtr_list1 := array_append_record(pr_wtr_list1, pr_wtrGrid1, 0)
        pr_wtr_list2 := array_append_record(pr_wtr_list2, pr_wtrGrid2, 0)
        pr_wtr_list3 := array_append_record(pr_wtr_list3, pr_wtrGrid3, 0)
        pr_wtr_list4 := array_append_record(pr_wtr_list4, pr_wtrGrid4, 0)
        pr_wtr_list5 := array_append_record(pr_wtr_list5, pr_wtrGrid5, 0)
        pr_wtr_list6 := array_append_record(pr_wtr_list6, pr_wtrGrid6, 0)
        pr_wtr_list7 := array_append_record(pr_wtr_list7, pr_wtrGrid7, 0)
        pr_wtr_list8 := array_append_record(pr_wtr_list8, pr_wtrGrid8, 0)
    end do

    outPath = "/mnt/e/Climate_data_code/MIROC6/sdsm_ncep_file/pr_sdsm_file"
    opt1 = True
    opt1@fout = outPath + "/ncepprcpg1.dat"
    write_matrix(transpose(pr_wtr_list1(1:)), "f9.3", opt1)
    opt2 = True
    opt2@fout = outPath + "/ncepprcpg2.dat"
    write_matrix(transpose(pr_wtr_list2(1:)), "f9.3", opt2)
    opt3 = True
    opt3@fout = outPath + "/ncepprcpg3.dat"
    write_matrix(transpose(pr_wtr_list3(1:)), "f9.3", opt3)
    opt4 = True
    opt4@fout = outPath + "/ncepprcpg4.dat"
    write_matrix(transpose(pr_wtr_list4(1:)), "f9.3", opt4)
    opt5 = True
    opt5@fout = outPath + "/ncepprcpg5.dat"
    write_matrix(transpose(pr_wtr_list5(1:)), "f9.3", opt5)
    opt6 = True
    opt6@fout = outPath + "/ncepprcpg6.dat"
    write_matrix(transpose(pr_wtr_list6(1:)), "f9.3", opt6)
    opt7 = True
    opt7@fout = outPath + "/ncepprcpg7.dat"
    write_matrix(transpose(pr_wtr_list7(1:)), "f9.3", opt7)
    opt8 = True
    opt8@fout = outPath + "/ncepprcpg8.dat"
    write_matrix(transpose(pr_wtr_list8(1:)), "f9.3", opt8)

end