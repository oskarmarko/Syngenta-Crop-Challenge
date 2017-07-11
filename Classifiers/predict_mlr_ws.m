function predicted_yield = predict_mlr_ws(training_data,test_data)
%napraviti rf model na trening skupu
%odraditi rf na test skupu

    training_data = training_data(:,1:(end-1)); %without PI
    test_data = test_data(:,1:(end-1)); %without PI
    
    number_of_test_samples = length(test_data);
    predicted_yield = zeros(number_of_test_samples,1);
    
    Mdl = fitlm(training_data(:,5:end),training_data(:,1));
    
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
                scenario_yield(i) = predict(Mdl,test_data(sm,5:end));
            end
        else
            test_data(sm,16:18) = mean(training_data((training_data(:,4) == test_data(sm,4)),16:18));
            scenario_yield = predict(Mdl,test_data(sm,5:end));
        end
        
        predicted_yield(sm) = mean(scenario_yield);
    end
    close(h)
end