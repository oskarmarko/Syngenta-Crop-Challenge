function mask = yield_diff_thresh(data, threshold)
    
    number_of_varieties = length(unique(data(:,6)));
    mean_yield_diff = zeros(number_of_varieties,1);
    
    for i=1:number_of_varieties
        check_yields = data(data(:,6) == i, 3);
        mean_yield_diff(i) = mean(check_yields);
    end
    
    mask = mean_yield_diff > threshold;
end