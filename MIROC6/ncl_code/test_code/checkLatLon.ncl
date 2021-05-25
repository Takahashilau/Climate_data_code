begin
    ;;f = addfile("/media/taka/Passport/CMIP6/NCEP_RAW_NC/air_2m/air.2m.gauss.1961.nc", "r")
    ;;v = f->air

    f = addfile("/media/taka/Passport/CMIP6/MIROC6/ssp126/hur_day_MIROC6_ssp126_r1i1p1f1_gn_20150101-20151231.nc", "r")
    v = f->hur(:,3,:,:)

    wks = gsn_open_wks("X11", "map")
    res =True
    res@cnFillOn = True
    res@cnLinesOn = False

    plot = gsn_csm_contour_map(wks, v(0, :, :), res)
end