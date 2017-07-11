function [RMSE, MAE, r_spearman, r_pearson] = get_stat_cascade(H, b, bH_year)
    %matrice sadrze vrednost prinosa i imaju tri dimenzije: 
    %godina, njiva, seme
    b_hat = zeros(length(b),1);
    year_offset = 0;
    
    for i=min(bH_year):max(bH_year)
        tic
        current_year = i;
        test_H = H(bH_year == current_year,:);
        training_H = H(bH_year ~= current_year,:);
        training_b = b(bH_year ~= current_year);
        number_of_test_samples = length(test_H);
        
        Mdl = fitcknn(training_H,training_b,'NumNeighbors',3,'Standardize',1);
        %Mdl = fitlm(training_H,training_b);
        %Mdl = TreeBagger(100,training_H,training_b,'Method','regression');
        predicted_b = predict(Mdl,test_H);
        
        b_hat(bH_year == current_year) = predicted_b;
        
        year_offset = year_offset + number_of_test_samples;  
        
        disp(['Godina ',num2str(i)])
        toc
    end   
    
    predicted_yield = b_hat;
    real_yield = b;
    
    RMSE = sqrt(mean((predicted_yield - real_yield).^2));
    MAE = mean(abs(predicted_yield - real_yield));
    r_spearman = corr(predicted_yield,real_yield,'type','Spearman');
    r_pearson = corr(predicted_yield,real_yield,'type','Pearson');
    
    disp(['RMSE: ',num2str(RMSE),', MAE: ',num2str(MAE),', Spearman: ',num2str(r_spearman),', Pearson: ',num2str(r_pearson)])
    
end