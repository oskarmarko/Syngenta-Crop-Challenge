function data = preprocess(ordered_data)
   
    data = zeros(size(ordered_data));
    count = 1;
    
    min_year = min(ordered_data(:,4));
    max_year = max(ordered_data(:,4));
    max_variety = max(ordered_data(:,6));
    max_farms = max(ordered_data(:,5));
    for yr=min_year:max_year
        for fm=1:max_farms
            for vr=1:max_variety
                mask = (ordered_data(:,4) == yr) & (ordered_data(:,5) == fm)...
                    & (ordered_data(:,6) == vr);
                if (sum(mask) == 1)
                    data(count,:) = ordered_data(mask,:);
                    count = count + 1;
                elseif (sum(mask) > 1)
                    data(count,:) = mean(ordered_data(mask,:),1);
                    count = count + 1;
                end
            end
        end
        disp(['Godina ',num2str(yr)])
    end
    
    data = data(1:(count-1),:);
    data(isnan(data(:,20)),20)) = mean(data(~isnan(data(:,20)),20));
end