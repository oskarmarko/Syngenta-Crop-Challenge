function [b, H, bH_year] = predict_whr_matrix(data, number_of_bins)
    
    %data = data(:,1:(end-1)); %without PI
    
    yield_index = 1;
    year = data(:,4);
    
    number_of_years = length(unique(year));
    number_of_features = size(data,2) - 5; %first 3 are yield
    categorical = zeros(size(data,2),1);
    %categorical(15) = 1;
    categorical(6) = 1;
    
    H = zeros(length(data),number_of_features);
    bH_year = zeros(length(data),1);
    b = zeros(length(data),1);
        
    year_offset = 0;
    
    for i=1:number_of_years
        tic
        current_year = i+2008;
        test_data = data(year == current_year,:);
        training_data = data(year ~= current_year,:);
        number_of_test_samples = length(test_data);
        
        for sm=1:number_of_test_samples
            feature_predictions = zeros(number_of_features,1);
            for ft=6:(number_of_features+6-1)
                feature_predictions(ft-5) = get_feature_prediction(training_data,...
                    test_data, categorical(ft), sm, ft, number_of_bins);
            end
            
            feature_predictions(isnan(feature_predictions)) = mean(feature_predictions(~isnan(feature_predictions)));
            
            H(year_offset+sm,:) = feature_predictions;
            b(year_offset+sm) = test_data(sm,yield_index);
        end
        
        bH_year((year_offset+1):(year_offset+number_of_test_samples)) = current_year;
        year_offset = year_offset + number_of_test_samples;  
        
        disp(['Godina ',num2str(2008+i)])
        toc
    end   
    
    bH_year = bH_year(~isnan(H(:,1)));
    b = b(~isnan(H(:,1)));
    H = H(~isnan(H(:,1)),:);
end

