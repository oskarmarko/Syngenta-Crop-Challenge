function [winners, percentage] = get_winners(predicted_yield, data_varieties)

    varieties = unique(data_varieties(:,1));
    number_of_varieties = length(varieties);
    number_of_years = 15;
    number_of_farms = length(data_varieties) / number_of_years / number_of_varieties;
    covariance_matrix = zeros(number_of_varieties, number_of_varieties);
    vr_yield = zeros(number_of_varieties,number_of_years);
    portfolio_percentages = zeros(number_of_farms, number_of_varieties);
    
    tic
    for fm = 1:number_of_farms 
        offset = (fm-1) * number_of_years * number_of_varieties;
        for vr = 1:number_of_varieties 
            first_index = offset + number_of_years * (vr-1) + 1;
            last_index = offset + number_of_years * vr;
            vr_yield(vr, :) = predicted_yield(first_index : last_index);
        end
        
        for vr1 = 1:number_of_varieties
            for vr2 = vr1:number_of_varieties
                R = corr(vr_yield(vr1, :)',vr_yield(vr2, :)');
                covariance_matrix(vr1,vr2) = R;
                covariance_matrix(vr2,vr1) = R;
            end
        end
        
        mean_yields = mean(vr_yield,2);
        
        [which_varieties, what_percentage] = optimise_portfolio_PI(mean_yields, ...
            covariance_matrix, data_varieties(offset+1,14), varieties, 'dont-plot');
        
        portfolio_percentages(fm, which_varieties) = what_percentage;
        
        if (mod(fm,50) == 0)
            toc
            disp([num2str(fm),'/6490']);
            tic
        end
    end
    
    final_percentages = sum(portfolio_percentages);
    [B,I] = sort(final_percentages,'descend');
        
    winners = varieties(I(1:5));
    percentage = B(1:5);
    percentage = percentage / sum(percentage);
    winners = winners(percentage > 0.1); %at least 10%
    percentage = percentage(percentage > 0.1);
    
end
    