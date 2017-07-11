function [better_than_mean, varieties, risk] = one_best(data, predicted_yield, real_yield, covariance_matrix, VOT, YDT)
    %variety occurrence threshold 0-300
%     %check yield threshold 0.90-1.00
%     folderName = fullfile(pwd,'Read data');
%     addpath(folderName);
    
    n_first = 1;

    number_of_years = size(real_yield,1);
    number_of_varieties = size(real_yield,3);
        
    mean_pred_year = zeros(number_of_years, number_of_varieties);
    mean_real_year = zeros(number_of_years, number_of_varieties);
    
    better_than_mean_years = zeros(number_of_years,n_first);
    varieties = zeros(number_of_years,1);
    
    %prefiltering      
    enough_samples = variety_occurrence_thresh(data, VOT);
    good_yield_diff = yield_diff_thresh(data, YDT);
    mask = enough_samples & good_yield_diff;
    
    risk_year = zeros(number_of_years,1);
    
    for yr = 1:number_of_years
        for vr=1:number_of_varieties
            pred_mat = squeeze(predicted_yield(yr,:,vr));
            real_mat = squeeze(real_yield(yr,:,vr));
            pred_mat = pred_mat(~isnan(pred_mat));
            real_mat = real_mat(~isnan(real_mat));

            mean_pred_year(yr, vr) = mean(pred_mat);
            mean_real_year(yr, vr) = mean(real_mat);
        end
        mean_pred = mean_pred_year(yr,:);
        mean_pred(isnan(mean_pred)) = 0;
        mean_pred(~mask) = 0;
        [B1,I1] = sort(mean_pred,'descend');
        varieties(yr) = I1(1);
        our_portfolio = mean_real_year(yr,I1(1:n_first));
        mean_real = mean_real_year(yr,:);
        mean_real = mean_real(~isnan(mean_real));
        mean_yield = mean(mean_real);
        better_than_mean_years(yr,:) = our_portfolio./mean_yield;
        risk_year(yr) = sqrt(covariance_matrix(I1(1),I1(1)));
    end
    
    better_than_mean = mean(better_than_mean_years,1);
    risk = mean(risk_year);
end