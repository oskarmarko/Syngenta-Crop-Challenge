function [yy mean_yield_diff] = yield_in_years(data_preprocessed)

    number_of_varieties = length(unique(data_preprocessed(:,6)));
    number_of_years = length(unique(data_preprocessed(:,4)));
    
    yy = nan(number_of_years, number_of_varieties);
    
    for yr=1:number_of_years
        for vr=1:number_of_varieties
            mask = (data_preprocessed(:,4) == (yr+2008)) & (data_preprocessed(:,6) == vr);
            if sum(mask) > 0
                yy(yr,vr) = mean(data_preprocessed(mask,3));
            end
        end
    end
    
    
    mean_yield_diff = zeros(length(yy),1);
    for i=1:length(yy)
        mask = ~isnan(yy(:,i));
        mean_yield_diff(i) = mean(yy(mask,i));
    end
end