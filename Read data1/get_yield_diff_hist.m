function mean_yield_diff = get_yield_diff_hist(data)
    
    number_of_varieties = length(unique(data(:,6)));
    mean_yield_diff = zeros(number_of_varieties,1);
    occurence = zeros(number_of_varieties,1);
    
    for i=1:number_of_varieties
        check_yields = data(data(:,6) == i, 3);
        mean_yield_diff(i) = mean(check_yields);
        occurence(i) = length(check_yields);
    end
    
    figure
    hist(mean_yield_diff)
    xlabel('Yield difference')
    ylabel('Number of samples')
end