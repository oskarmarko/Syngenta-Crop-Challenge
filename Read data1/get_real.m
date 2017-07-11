function real_yield = get_real(data)

    yield_index = 1;

    year = data(:,4);
    farm = data(:,5);
    variety = data(:,6);
    
    number_of_years = length(unique(year));
    number_of_farms = length(unique(farm));
    number_of_varieties = length(unique(variety));
    
    real_yield = nan(number_of_years,number_of_farms,number_of_varieties);
    
    for yr = 1:number_of_years
        for fm = 1:number_of_farms
            for vr = 1:number_of_varieties
                mask = (year == (2008 + yr)) & (farm == fm) & (variety == vr);
                if (sum(mask) > 0)
                    real_yield(yr,fm,vr) = data(mask,yield_index);
                end
            end
        end
    end   
    
    %save(real_yield)
end