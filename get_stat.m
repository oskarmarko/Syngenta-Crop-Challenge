function [RMSE, MAE, r_spearman, r_pearson] = get_stat(predicted_yield, real_yield)
    %matrice sadrze vrednost prinosa i imaju tri dimenzije: 
    %godina, njiva, seme
    
    predicted_yield = predicted_yield(:);
    real_yield = real_yield(:);
    
    mask = ~(isnan(predicted_yield) | isnan(real_yield));
    
    predicted_masked = predicted_yield(mask);
    real_masked = real_yield(mask);
    
    RMSE = sqrt(mean((predicted_masked - real_masked).^2));
    MAE = mean(abs(predicted_masked - real_masked));
    r_spearman = corr(predicted_masked,real_masked,'type','Spearman');
    r_pearson = corr(predicted_masked,real_masked,'type','Pearson');
end