function [VOT_optimal, YDT_optimal, PI_optimal, improvement] = ...
    get_optimal_thresh_farms(data, predicted_yield, covariance_matrix, real_yield)
    %variety occurrence, yield difference, portfolio threshold
    %with area and PI
    
    VOT_step = 20;
    YDT_step = 0.01;
    PI_step = .25;

    VOT = 0;%[0,10,20, 200:VOT_step:300];
    YDT = 1.03;%0.98:YDT_step:1.07; %
    PI = 0:PI_step:19; %[0.994:PT_step:1]; %19; %
    
    improvement = zeros(length(VOT),length(YDT),length(PI));
    
    for i = 1:length(VOT)
        for j = 1:length(YDT)
            for k = 1:length(PI)
                tic
                improvement(i,j,k) = farm_portfolios_area(data, predicted_yield, covariance_matrix,...
                                        real_yield, VOT(i), YDT(j), PI(k));
                disp(['VOT = ',num2str(VOT(i)), ' YDT = ',num2str(YDT(j)),' PI = ',num2str(PI(k)),' I = ',num2str(improvement(i,j,k))]);
                toc
            end
        end
    end
    
    [~,ind] = max(improvement(:));
    [optimal_VOT_index,optimal_YDT_index,optimal_PI_index] = ind2sub(size(improvement),ind);
    
    VOT_optimal = VOT(optimal_VOT_index);
    YDT_optimal = YDT(optimal_YDT_index);
    PI_optimal = PI(optimal_PI_index);
end



% fajl improvement0995
% VOT_step = 10;
%     YDT_step = 0.01;
%     PT_step = 0.003;
% 
%     VOT = [0, 100:VOT_step:300];
%     YDT = [0, 0.94:YDT_step:1.06]; 
%     PT = 0.995; 