function [RMSE, MAE, r_spearman, r_pearson] = get_stat_bH(H, b)
    %matrice sadrze vrednost prinosa i imaju tri dimenzije: 
    %godina, njiva, seme
    
    predicted_yield = mean(H,2);
    real_yield = b;
    
    RMSE = sqrt(mean((predicted_yield - real_yield).^2));
    MAE = mean(abs(predicted_yield - real_yield));
    r_spearman = corr(predicted_yield,real_yield,'type','Spearman');
    r_pearson = corr(predicted_yield,real_yield,'type','Pearson');
    
    disp(['RMSE: ',num2str(RMSE),', MAE: ',num2str(MAE),', Spearman: ',num2str(r_spearman),', Pearson: ',num2str(r_pearson)])
    
end