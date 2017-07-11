function predicted_yield = predict_rf_ws(training_data,test_data)
    
    number_of_test_samples = length(test_data);
    predicted_yield = zeros(number_of_test_samples,1);
    
    Mdl = TreeBagger(100,training_data(:,6:end),training_data(:,1),'Method','regression','CategoricalPredictors',1);
    
    h = waitbar(0,'Initializing waitbar...');
    
    for sm=1:number_of_test_samples
        waitbar(sm/number_of_test_samples,h,'Calculating...')
        
        farm_mask = training_data(:,5) == test_data(sm,5);
        weather = training_data(farm_mask,15:17);
        weather_scenarios = unique(round(weather*10000),'rows')/10000;             
        
        if (~isempty(weather_scenarios))
            scenario_yield = zeros(size(weather_scenarios,1),1);
            
            for i = 1:size(weather_scenarios,1)
                test_data(sm,15:17) = weather_scenarios(i,:);
                scenario_yield(i) = predict(Mdl,test_data(sm,6:end));
            end
        else
            test_data(sm,15:17) = mean(training_data((training_data(:,4) == test_data(sm,4)),15:17));
            scenario_yield = predict(Mdl,test_data(sm,6:end));
        end
        
        predicted_yield(sm) = mean(scenario_yield);
    end
    close(h)
end