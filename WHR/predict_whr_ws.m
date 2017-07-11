function predicted_yield = predict_whr_ws(training_data,test_data,...
    categorical, number_of_bins, cvx_weights)
    %+ weather scenarios
    
%     training_data = training_data(:,1:(end-1)); %without PI
%     test_data = test_data(:,1:(end-1)); %without PI
        
    number_of_features = size(training_data,2) - 6; %first 3 are yield, then year, farm and variety
    number_of_test_samples = length(test_data);
    predicted_yield = zeros(number_of_test_samples,1);
    
    h = waitbar(0,'Initializing waitbar...');
    
    for sm=1:number_of_test_samples
        waitbar(sm/number_of_test_samples,h,'Calculating...')
        
        farm_mask = training_data(:,5) == test_data(sm,5);
        weather = training_data(farm_mask,16:18);
        weather_scenarios = unique(round(weather*10000),'rows')/10000;             
        
        if (~isempty(weather_scenarios))
            scenario_yield = zeros(size(weather_scenarios,1),1);
            
            for i = 1:size(weather_scenarios,1)
                test_data(sm,16:18) = weather_scenarios(i,:);
                feature_predictions = zeros(number_of_features,1);
                for ft=7:(number_of_features+7-1)
                    feature_predictions(ft-6) = get_feature_prediction(training_data,...
                        test_data, categorical(ft), sm, ft, number_of_bins);
                end

                nonNan = ~isnan(feature_predictions);
                scenario_yield(i) = sum(feature_predictions(nonNan) .* cvx_weights(nonNan)')...
                    / sum(cvx_weights(nonNan));
            end
        else
            test_data(sm,16:18) = mean(training_data((training_data(:,4) == test_data(sm,4)),16:18));
            feature_predictions = zeros(number_of_features,1);
            for ft=7:(number_of_features+7-1)
                feature_predictions(ft-6) = get_feature_prediction(training_data,...
                    test_data, categorical(ft), sm, ft, number_of_bins);
            end
            
            nonNan = ~isnan(feature_predictions);
            scenario_yield = sum(feature_predictions(nonNan) .* cvx_weights(nonNan)')...
                / sum(cvx_weights(nonNan));
        end
        
        predicted_yield(sm) = mean(scenario_yield);
    end
    close(h)
end