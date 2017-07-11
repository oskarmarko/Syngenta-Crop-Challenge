function weights_importance = feature_importance(data, real_yield)
%how important prediction coming from a feature is

    number_of_perm = 1;
    number_of_features = size(data,2) - 5;
    data_len = length(data);
    err_permutation = zeros(number_of_perm,1);
    weights_importance = zeros(number_of_features,1);
    [~, mae_original, ~, ~] = get_stat_classifier(data, real_yield, 'whr', 'non-ws',20); 
    
    for ft=1:number_of_features  
        
        for permutation=1:number_of_perm
            random_order = randperm(data_len);
            data_permuted = data;
            data_permuted(:,ft+5) = data(random_order,ft+5);

            [~, mae_permuted, ~, ~] = get_stat_classifier(data_permuted, real_yield, 'whr', 'non-ws',20);
            err_permutation(permutation) = mae_permuted - mae_original;
        end
        
        weights_importance(ft) = mean(err_permutation);
        disp(['Obelezje ',num2str(ft),'Povecanje greske ',num2str(weights_importance(ft))])
    end            
end
                