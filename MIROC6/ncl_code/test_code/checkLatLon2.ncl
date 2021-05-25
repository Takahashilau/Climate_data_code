begin
    f1 = addfile("/media/taka/Passport/CMIP6/NCEP_RAW_NC/air_2m/air.2m.gauss.1961.nc", "r")
    v1 = flt2dble(f1->air)
    v1T42 := f2gsh_Wrap(v1, (/64, 128/), 0)

    f2 = addfile("/media/taka/Passport/CMIP6/MIROC6/ssp126/hur_day_MIROC6_ssp126_r1i1p1f1_gn_20150101-20151231.nc", "r")
    v2 = flt2dble(f2->hur(:,3,:,:))
    v2T42 := f2gsh_Wrap(v2, (/64, 128/), 0)

    print(v1T42(0,43,34))
    print(v2T42(0,43,34))    
end