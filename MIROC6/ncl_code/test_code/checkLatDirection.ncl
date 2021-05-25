begin
    f = addfile("/mnt/e/CMIP6/NCEP_RAW_NC/air_2m/air.2m.gauss.1961.nc", "r")
    v = f->air
    v := v(:,::-1,:) ;; sytntax (::-1) 用来翻转矩阵某个维度

    ;;f = addfile("/mnt/e/CMIP6/MIROC6/historical/hur_day_MIROC6_historical_r1i1p1f1_gn_19610101-19611231.nc", "r")
    ;;v = f->hur(:,3,:,:)

    ;vT42 = f2gsh_Wrap(v, (/64, 128/), 0)
    ;;print(vT42(0, 0, 0))

    print(v(0, 0, 0))
end