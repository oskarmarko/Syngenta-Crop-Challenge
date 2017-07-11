function improvement = get_portfolio_improvement(predicted_yield_years,...
    covariance_matrix, mask_thresh, portfolio_thresh, real_yield_years)
    %without area and PI 
    
    number_of_years = size(predicted_yield_years,1);
    
    improvement_year = zeros(number_of_years,1);
    
    for i=1:number_of_years
        mask_not_nan = ~isnan(predicted_yield_years(i,:));
        mask = mask_not_nan' & mask_thresh;
        
        if (sum(mask) > 1)
            [varieties, percentage] = optimise_portfolio(predicted_yield_years(i,:),...
                covariance_matrix, portfolio_thresh, mask,'dont_plot');
        elseif (sum(mask) == 1)
            [~,varieties] = max(mask);
            percentage = 1;
        else
            varieties = [];
            percentage = [];
        end
        
        if isempty(varieties)
            improvement_year(i) = nan;
        else
            mean_real_yield_year = mean(real_yield_years(i,~isnan(real_yield_years(i,:))));
            mean_portfolio_yield_year = sum(real_yield_years(i,varieties)' .* percentage);

            improvement_year(i) = mean_portfolio_yield_year / mean_real_yield_year;
        end
    end
    
    improvement = mean(improvement_year(~isnan(improvement_year)));
end