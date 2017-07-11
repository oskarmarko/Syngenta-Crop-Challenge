function [RMSE, MAE, r_spearman, r_pearson] = get_stat_classifier(...
    data, real_yield, classifier, class_par0, class_par1, class_par2)
    
    %[RMSE, MAE, r_spearman, r_pearson] = get_stat_classifier(data_norm, real_yield, 'whr', 'non-ws')

    if (nargin == 4)
        predicted_yield = get_prediction(data, classifier, class_par0);
    elseif (nargin == 5)
        predicted_yield = get_prediction(data, classifier, class_par0, class_par1);
    elseif (nargin == 6)
        predicted_yield = get_prediction(data, classifier, class_par0, class_par1, class_par2);
    end
        
    [RMSE, MAE, r_spearman, r_pearson] =  get_stat(predicted_yield, real_yield);
    
    disp(['RMSE: ',num2str(RMSE),', MAE: ',num2str(MAE),', Spearman: ',num2str(r_spearman),', Pearson: ',num2str(r_pearson)])
    
end