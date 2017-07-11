function weights_corr = corr_weights(b,H,bH_year)

        years = unique(bH_year);
        number_of_years = length(years);
        number_of_features = size(H,2);
        weights_corr = zeros(number_of_years,number_of_features);
        
        for yr=1:number_of_years
            H_year_out = H(bH_year ~= years(yr),:);
            b_year_out = b(bH_year ~= years(yr));
            
            for ft=1:number_of_features
                weights_corr(yr,ft) = corr(H_year_out(:,ft),b_year_out,'type','Pearson');                
            end            
            
            disp(['Godina ',num2str(years(yr))])
            weights_corr(yr,:) = weights_corr(yr,:) / sum(weights_corr(yr,:));
        end        
end
                