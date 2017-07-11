function predicted_yield_years = average_accross_farms(predicted_yield)

    
    number_of_years = size(predicted_yield,1);
    number_of_varieties = size(predicted_yield,3);
    
    predicted_yield_years = zeros(number_of_years, number_of_varieties);
    
    for yr=1:number_of_years
        for vr=1:number_of_varieties
            year_variety = predicted_yield(yr,:,vr);
            predicted_yield_years(yr,vr) = mean(year_variety(~isnan(year_variety)));
        end
    end
end