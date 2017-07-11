function mask = variety_occurrence_thresh(data, threshold)

    variety = data(:,6);
    
    number_of_varieties = max(variety);
    
    number_of_occurrences = zeros(number_of_varieties, 1);
    mean_yield_diff = zeros(number_of_varieties, 1);
    
    for i=1:max(variety)
        number_of_occurrences(i) = sum(variety == i);
        mean_yield_diff(i) = mean(data(variety == i, 3));
    end
    
    mask = (number_of_occurrences > threshold);
        
end