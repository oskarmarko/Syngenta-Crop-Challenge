function [improvement, risk] = farm_portfolios_area(data, predicted_yield, covariance_matrix,...
    real_yield, VOT, YDT, PI)
    %with global PI

    number_of_years = size(predicted_yield,1);
    number_of_farms = size(predicted_yield,2);
    number_of_varieties = size(predicted_yield, 3);
    improvement_year = zeros(number_of_years, 1);
    risk_year = zeros(number_of_years, 1);
    
    [number_of_occurrences, mean_yield_diff] = get_occurr_and_yield_diff(data);
    mask_thresh = (number_of_occurrences > VOT) & (mean_yield_diff > YDT);
    
    zero_years = 0;
    
    for yr=1:number_of_years
        test_data = data(data(:,4) == (yr+2008),:);
        real_yield_year = squeeze(real_yield(yr,:,:));
        farms = unique(test_data(:,5));
        number_of_farms_year = length(farms);
        portfolios = zeros(number_of_farms_year, number_of_varieties);
        area = zeros(number_of_farms,1);
        
        for fm=1:number_of_farms_year
            area(farms(fm)) = mean(data((data(:,4) == (yr+2008)) & (data(:,5) == farms(fm)),19));
            farm_yields = squeeze(predicted_yield(yr,farms(fm),:));
            mask_not_nan = ~isnan(farm_yields);
            mask = mask_not_nan & mask_thresh;
            
            if (sum(mask) > 1)
                [varieties, percentage] = optimise_portfolio_PI(farm_yields', ...
                    covariance_matrix, PI, mask, 'dont-plot');
            elseif (sum(mask) == 1)
                [~,varieties] = max(mask);
                percentage = 1;
            else
                varieties = [];
                percentage = [];
            end

            if ~isempty(varieties)
                portfolios(fm,varieties) = (portfolios(fm,varieties) + percentage') * area(farms(fm));
            end            
        end
        
        variety_yield = zeros(number_of_varieties, 1);
        for vr=1:number_of_varieties
            variety_yields_all = squeeze(real_yield(yr,:,vr));
            variety_yield(vr) = sum(variety_yields_all(~isnan(variety_yields_all))...
                .* area(~isnan(variety_yields_all))') / sum(area(~isnan(variety_yields_all)));
        end
        
        variety_percentages = sum(portfolios,1);
        
        if (sum(variety_percentages) > 0)
            [M,I] = sort(variety_percentages,'descend');
            final_portfolio = zeros(number_of_varieties,1);
            final_portfolio(I(1:5)) = M(1:5) / sum(M(1:5));
            final_portfolio(final_portfolio < 0.1) = 0;
            final_portfolio = final_portfolio / sum(final_portfolio);
            mean_real_yield_year = mean(real_yield_year(~isnan(real_yield_year)));
            improvement_year(yr) = sum(variety_yield(final_portfolio ~= 0) .*...
                final_portfolio(final_portfolio ~= 0)) / mean(variety_yield(~isnan(variety_yield)));
            risk_year(yr) = get_risk(final_portfolio, variety_yield, covariance_matrix);
        else
            improvement_year(yr) = -1;
            risk_year(yr) = -1;
            zero_years = zero_years +1;
        end
    end
    
    improvement = mean(improvement_year(improvement_year>0));
    risk = mean(risk_year(risk_year>0));
    disp(['number of years without validation: ',num2str(zero_years)])
end