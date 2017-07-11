function [VOT_optimal, YDT_optimal, improvement] = ...
    get_optimal_thresh_farms_PI(data, predicted_yield, covariance_matrix, real_yield)
    %variety occurrence, yield difference, portfolio threshold
    %with area and PI
    
    VOT_step = 20;
    YDT_step = 0.01;

    VOT = 0;%[0,10,20, 200:VOT_step:300];
    YDT = 0.80:YDT_step:1.05; %1.03;
    
    improvement = zeros(length(VOT),length(YDT));
    
    for i = 1:length(VOT)
        for j = 1:length(YDT)
                tic
                improvement(i,j) = farm_portfolios_area_PI(data, predicted_yield, covariance_matrix,...
                                        real_yield, VOT(i), YDT(j));
                disp(['VOT = ',num2str(VOT(i)), ' YDT = ',num2str(YDT(j)),' I = ',num2str(improvement(i,j))]);
                toc
        end
    end
    
    [~,ind] = max(improvement(:));
    [optimal_VOT_index,optimal_YDT_index] = ind2sub(size(improvement),ind);
    
    VOT_optimal = VOT(optimal_VOT_index);
    YDT_optimal = YDT(optimal_YDT_index);
end