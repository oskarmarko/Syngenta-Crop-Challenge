function prediction_matrix = make_prediction_matrix(test_data,...
            test_predictions, number_of_farms, number_of_varietes)

    variety_index = 6;
    farm_index = 5;
    
    number_of_samples = length(test_data);
    prediction_matrix = nan(number_of_farms, number_of_varietes);
    
    for sm=1:number_of_samples
        prediction_matrix(test_data(sm, farm_index),test_data(sm, variety_index)) =...
            test_predictions(sm);
    end
end