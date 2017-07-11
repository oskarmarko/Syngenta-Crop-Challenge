function enough_samples = occurrence_thresh(real_yield, threshold)

    number_of_varieties = size(real_yield,3);
    enough_samples = zeros(number_of_varieties,1);
    
    for vr=1:number_of_varieties
        number_of_samples = sum(~isnan(real_yield(:,:,vr)),1);
        number_of_samples = squeeze(sum(number_of_samples,2));

        if (number_of_samples > threshold)
            enough_samples(vr) = 1;
        else
            enough_samples(vr) = 0;
        end
    end
end