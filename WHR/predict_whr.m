function predicted_yield = predict_whr(training_data,test_data,...
    categorical, number_of_bins, feature_weights)
        
    number_of_features = size(training_data,2) - 5; %first 3 are yield, then year, farm and variety
    number_of_test_samples = length(test_data);
    predicted_yield = zeros(number_of_test_samples,1);

    for sm=1:number_of_test_samples
        feature_predictions = zeros(number_of_features,1);
        for ft=6:(number_of_features+6-1)
            feature_predictions(ft-5) = get_feature_prediction(training_data,...
                test_data, categorical(ft), sm, ft, number_of_bins);
        end
        
        nonNan = ~isnan(feature_predictions);
        predicted_yield(sm) = sum(feature_predictions(nonNan) .* feature_weights(nonNan)')...
            / sum(feature_weights(nonNan));
        %predicted_yield(sm) = nthroot(prod(feature_predictions(nonNan)), sum(nonNan));
%         predicted_yield(sm) = sqrt(mean(feature_predictions(nonNan).^2));
            
    end
end