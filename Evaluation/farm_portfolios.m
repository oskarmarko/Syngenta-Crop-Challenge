function improvement = farm_portfolios(data, predicted_yield, covariance_matrix,...
    real_yield, VOT, YDT, PT)

    number_of_years = size(predicted_yield,1);
    number_of_varieties = size(predicted_yield, 3);
    improvement_year = zeros(number_of_years, 1);
    
    [number_of_occurrences, mean_yield_diff] = get_occurr_and_yield_diff(data);
    mask_thresh = (number_of_occurrences > VOT) & (mean_yield_diff > YDT);
    
    for yr=1:number_of_years
        test_data = data(data(:,4) == (yr+2008),:);
        real_yield_year = squeeze(real_yield(yr,:,:));
        farms = unique(test_data(:,5));
        number_of_farms = length(farms);
        portfolios = zeros(number_of_farms, number_of_varieties);
        
        for fm=1:number_of_farms
            farm_yields = squeeze(predicted_yield(yr,farms(fm),:));
            mask_not_nan = ~isnan(farm_yields);
            mask = mask_not_nan & mask_thresh;
            
            if (sum(mask) > 1)
                [varieties, percentage] = optimise_portfolio(farm_yields', ...
                    covariance_matrix, PT, mask, 'dont-plot');
            elseif (sum(mask) == 1)
                [~,varieties] = max(mask);
                percentage = 1;
            else
                varieties = [];
                percentage = [];
            end

            if ~isempty(varieties)
                portfolios(fm,varieties) = portfolios(fm,varieties) + percentage';
            end            
        end
        
        variety_yield = zeros(number_of_varieties, 1);
        for vr=1:number_of_varieties
            variety_yields_all = squeeze(real_yield(yr,:,vr));
            variety_yield(vr) = mean(variety_yields_all(~isnan(variety_yields_all)));
        end
        
        variety_percentages = sum(portfolios,1);
        [M,I] = sort(variety_percentages,'descend');
        final_portfolio = zeros(number_of_varieties,1);
        final_portfolio(I(1:5)) = M(1:5) / sum(M(1:5));
        mean_real_yield_year = mean(real_yield_year(~isnan(real_yield_year)));
        improvement_year(yr) = sum(variety_yield(final_portfolio ~= 0) .*...
            final_portfolio(final_portfolio ~= 0)) / mean(variety_yield(~isnan(variety_yield)));
    end
    
    improvement = mean(improvement_year);
end