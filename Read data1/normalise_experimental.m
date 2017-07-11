function data_norm = normalise_experimental(data)

    data_norm = data;
    
    for i=7:20
       m = mean(data(~isnan(data(:,i)),i));
       stdev = std(data(~isnan(data(:,i)),i));
       data_norm(:,i) = (data(:,i) - m) / stdev;
    end
end