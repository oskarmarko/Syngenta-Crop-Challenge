function ordered_data = read_experimental()

    [raw_num, raw_txt] = xlsread('Experiment dataset.xlsx');
    variety = raw_txt(2:end,3);
    varieties = unique(variety);
    variety_ordered = zeros(length(variety),1);
    
    for i=1:length(varieties)
        variety_ordered(strcmp(variety,varieties(i))) = i;
    end
    
    farm = raw_num(:,1);
    farms = unique(farm);
    farms_ordered = zeros(length(farm),1);
    
    for i=1:length(farms)
        farms_ordered(farm == farms(i)) = i;
    end
    
    planting_date = raw_txt(2:end,4);
    planting_DOY = nan(length(planting_date),1);
    for i=1:length(planting_date)
        if (isstrprop(planting_date{i}(1),'digit'))
            %date_vec = datevec(planting_date(i),'dd.mm.yyyy'); %kod mene na lapsi topsiju
            date_vec = datevec(planting_date(i),'mm/dd/yyyy');
            planting_DOY(i) = datenum(date_vec) - datenum(date_vec(1), 1, 0);
        end
    end
    
    yield_diff = raw_num(:,4) ./ raw_num(:,5);
    
    ordered_data = zeros(size(raw_num));
    ordered_data(:,1) = raw_num(:,4); %yield
    ordered_data(:,2) = raw_num(:,5); %check yield
    ordered_data(:,3) = yield_diff; %yield diff in %
    ordered_data(:,4) = raw_num(:,7); %year
    ordered_data(:,5) = farms_ordered; %farm
    ordered_data(:,6) = variety_ordered; %variety
    ordered_data(:,7) = raw_num(:,8); %GPS lat
    ordered_data(:,8) = raw_num(:,9); %GPS long
    ordered_data(:,9:14) = raw_num(:,14:19); %soil properties
    ordered_data(:,15) = raw_num(:,13); %soil class
    ordered_data(:,16:18) = raw_num(:,10:12); %weather
    ordered_data(:,19) = raw_num(:,21); %area
    ordered_data(:,20) = raw_num(:,7); %year as feature
    ordered_data(:,21) = planting_DOY; %planting date
    ordered_data(:,22) = raw_num(:,20); %pi 
    
end