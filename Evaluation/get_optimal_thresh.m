function [VOT_optimal, YDT_optimal, PT_optimal, improvement] = ...
    get_optimal_thresh(data, predicted_yield, covariance_matrix, real_yield)
    %variety occurrence, yield difference, portfolio threshold
    %without area and PI 
    
    VOT_step = 10;
    YDT_step = 0.01;
    PT_step = 0.002;

    VOT = 0:VOT_step:300;
    YDT = [0, 0.9:YDT_step:1.07]; 
    PT = 0.95:PT_step:1; 
    
    improvement = zeros(length(VOT),length(YDT),length(PT));
    [number_of_occurrences, mean_yield_diff] = get_occurr_and_yield_diff(data);
    predicted_yield_years = average_accross_farms(predicted_yield);
    real_yield_years = average_accross_farms(real_yield);
    
    for i = 1:length(VOT)
        disp(['VOT = ',num2str(VOT(i))]);
        tic
        for j = 1:length(YDT)
            for k = 1:length(PT)
                mask_thresh = (number_of_occurrences > VOT(i)) & (mean_yield_diff > YDT(j));
                improvement(i,j,k) = get_portfolio_improvement(predicted_yield_years,...
                    covariance_matrix, mask_thresh, PT(k), real_yield_years);
            end
        end
        toc
    end
    
    [~,ind] = max(improvement(:));
    [optimal_VOT_index,optimal_YDT_index,optimal_PT_index] = ind2sub(size(improvement),ind);
    
    VOT_optimal = VOT(optimal_VOT_index);
    YDT_optimal = YDT(optimal_YDT_index);
    PT_optimal = PT(optimal_PT_index);
end