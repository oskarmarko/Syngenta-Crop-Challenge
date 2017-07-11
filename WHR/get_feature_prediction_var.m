function  feature_prediction = get_feature_prediction_var(training_data,...
        test_data, categorical, sample_index, feature_index, number_of_bins)

    yield_index = 1;
    variety_index = 6;

    %sample_variety = test_data(sample_index,variety_index);
    sample_value = test_data(sample_index,feature_index);
        
    training_yields = training_data(:,yield_index);
    training_values = training_data(:,feature_index);

    if (categorical == 0)
        distances = double(abs(training_values-sample_value));
        weights = 1./(distances+1);
        weights = weights ./ sum(weights);
    elseif (categorical == 1)
        weights = double(training_values == sample_value);
        weights = weights ./ sum(weights);
    end

    weighted_histogram = zeros(number_of_bins,1);    
    min_yield = 0;
    max_yield = 120;
    bin_width = (max_yield - min_yield) / number_of_bins;

    for i=1:number_of_bins
        weighted_histogram(i) = sum(weights(...
                logical(training_yields > (min_yield + (i-1)*bin_width))...
                &  logical(training_yields <= (min_yield + i*bin_width))...
                ));
    end

    bin_centres = linspace(0.5, 119.5, number_of_bins);

    feature_prediction = sum(bin_centres .* weighted_histogram');
    
end