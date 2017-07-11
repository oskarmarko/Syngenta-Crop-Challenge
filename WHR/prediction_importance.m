function [weights_importance, mae_without_ft] = prediction_importance(b,H,bH_year)
%how important prediction coming from a feature is

        number_of_perm = 500;
        years = unique(bH_year);
        number_of_years = length(years);
        number_of_features = size(H,2);
        weights_importance = zeros(number_of_years,number_of_features);
        mae_without_ft = zeros(number_of_features,1);
        err_permutation = zeros(number_of_perm,1);
        
        for yr=1:number_of_years
            H_year_out = H(bH_year ~= years(yr),:);
            b_year_out = b(bH_year ~= years(yr));
            
            mae_original = mean(abs((mean(H_year_out,2) - b_year_out)));
            
            for ft=1:number_of_features 
                for permutation=1:number_of_perm
                    random_order = randperm(length(H_year_out));
                    H_permuted = H_year_out;
                    H_permuted(:,ft) = H_year_out(random_order,ft);
                    
                    mae_permuted = mean(abs((mean(H_permuted,2) - b_year_out)));
                    err_permutation(permutation) = mae_permuted - mae_original;
                end
                t = 1:number_of_features;
                t(ft) = [];
                mae_without_ft(ft) = mean(abs((mean(H_year_out(:,t),2) - b_year_out)));
                weights_importance(yr,ft) = mean(err_permutation);
            end            
            
%             weights_importance(yr,:) = weights_importance(yr,:) ./ sum(weights_importance(yr,:));
            
            disp(['Godina ',num2str(years(yr))])
            %weights_corr(yr,:) = weights_corr(yr,:) / sum(weights_corr(yr,:));
        end        
end
                