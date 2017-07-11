function [cc improvement] = rank_stat(real_yield, predicted_yield)
    
    number_of_years = size(real_yield,1);
    number_of_farms = size(real_yield,2);
    number_of_varieties = size(real_yield,3);
    
    ccs = [];
    improvements = [];
    count = 0;
    
    for yr=1:number_of_years
        for fm=1:number_of_farms
            %disp(['Godina ',num2str(yr),' ',num2str(fm)])
            if count == 579
                disp('1');
            end
            real_list = squeeze(real_yield(yr,fm,:));
            predicted_list = squeeze(predicted_yield(yr,fm,:));
            
            mask = (~isnan(real_list)) & (~isnan(predicted_list));
            
            if (sum(mask) > 5)
                count = count + 1;
                real_list = real_list(mask);
                predicted_list = predicted_list(mask);
                
                new_cc = corr(real_list, predicted_list,'type','Spearman');
                ccs = [ccs new_cc];
                
                [~,I] = sort(predicted_list,'descend');
                chosen5_yield = mean(real_list(I(1:5)));
                avg_yield = mean(real_list);
                new_impr = chosen5_yield / avg_yield;                
                improvements = [improvements new_impr];
            end
        end
    end

    cc = mean(ccs);
    improvement = mean(improvements);
            
end