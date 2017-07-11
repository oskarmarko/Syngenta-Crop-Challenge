function full_prediction = predict_rf_full(data)

    year = data(:,4);
    farm = data(:,5);
    variety = data(:,6);
    
    number_of_years = length(unique(year));
    number_of_farms = length(unique(farm));
    number_of_varieties = max(variety);
    
    full_prediction = nan(number_of_years,number_of_farms,number_of_varieties);
    
    for yr=1:number_of_years
        test_data_original = data(year == yr+2008,:);
        test_data = nan(number_of_farms*number_of_varieties,size(data,2));
        for fm=1:number_of_farms
            farm_parameters = test_data_original(test_data_original(:, 5) == fm, :);
                if (~isempty(farm_parameters))
                    farm_parameters = farm_parameters(1, :);
                    for vr=1:number_of_varieties
                        farm_parameters(1, 6) = vr;
                        test_data((fm-1) * number_of_varieties + vr, :) = farm_parameters;
                    end
                end
        end
        test_data = test_data(~isnan(test_data(:,1)),:);
        %training_data = data(year ~= yr+2008,:);
        Mdl = TreeBagger(100,data(:,6:end),data(:,1),'Method','regression','CategoricalPredictors',1);
        test_predictions = predict(Mdl,test_data(:,6:end));
        
        full_prediction(yr,:,:) = make_prediction_matrix(test_data, test_predictions, number_of_farms, number_of_varieties);
        
        disp(['Godina ',num2str(2008+yr)])
    end 

end