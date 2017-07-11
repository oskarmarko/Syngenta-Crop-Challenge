function [filtered_data, number_of_discarded] = filter_data_YDT(data, data_cube, thresh)
    
    mask = yield_diff_thresh(data, thresh);
    filtered_data = data_cube;
    filtered_data(:,:,~mask) = nan;
    number_of_discarded = sum(~mask);
end