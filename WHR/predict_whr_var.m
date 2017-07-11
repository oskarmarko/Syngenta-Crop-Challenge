function predicted_yield = predict_whr_var(training_data,test_data,...
    categorical, number_of_bins, cvx_weights)
            
    number_of_features = size(training_data,2) - 5; %first 3 are yield, then year, farm and variety
    number_of_test_samples = length(test_data);
    predicted_yield = zeros(number_of_test_samples,1);
    
    h = waitbar(0,'Initializing waitbar...');
    
    for sm=1:number_of_test_samples
        waitbar(sm/number_of_test_samples,h,'Calculating...')
        feature_predictions = zeros(number_of_features,1);
        for ft=6:(number_of_features+6-1)
            feature_predictions(ft-5) = get_feature_prediction_var(training_data,...
                test_data, categorical(ft), sm, ft, number_of_bins);
        end
        
        nonNan = ~isnan(feature_predictions);
        predicted_yield(sm) = sum(feature_predictions(nonNan) .* cvx_weights(nonNan)')...
            / sum(cvx_weights(nonNan));
    end
end