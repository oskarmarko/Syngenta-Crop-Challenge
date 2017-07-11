function data_varieties = add_varieties_to_data(data_regional, varieties)
    
    number_of_varieties = length(varieties);
    number_of_farms = length(data_regional) / 15;
    number_of_years = 15;
    
    data_varieties = zeros(size(data_regional,1) * number_of_varieties,...
        size(data_regional,2) + 1);
    
    for i=1:number_of_farms
        first_index = (i-1) * number_of_years * number_of_varieties + 1;
        last_index = i * number_of_years * number_of_varieties;
        first_index_regional = (i-1) * number_of_years+1;
        last_index_regional = i * number_of_years;
        
        varieties_repeated = repmat(varieties,15,1);
        
        data_varieties(first_index:last_index,1) = varieties_repeated(:);
        data_varieties(first_index:last_index,2:end) = repmat(...
            data_regional(first_index_regional:last_index_regional,1:end),...
            number_of_varieties,1);
        
        if (mod(i,1000) == 0)
            disp(i);
        end
    end
end