function data_regional = read_regional()
    [raw_data, ~] = xlsread('Region dataset.xlsx');
    
    data_regional = zeros(size(raw_data,1),size(raw_data,2));
    data_regional(:,1) = raw_data(:,3); %GPS lat
    data_regional(:,2) = raw_data(:,2); %GPS long
    data_regional(:,3:8) = raw_data(:,7:12); %soil
    data_regional(:,9:11) = raw_data(:,4:6); %weather
    data_regional(:,12) = raw_data(:,1); %year
    data_regional(:,13) = raw_data(:,14); %area
    data_regional(:,14) = raw_data(:,13); %PI
end