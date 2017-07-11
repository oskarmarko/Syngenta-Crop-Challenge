function [VOT_optimal, YDT_optimal, improvement] = get_one_best(data, predicted_yield, real_yield, covariance_matrix)
    %variety occurrence, yield difference
    
    VOT_step = 10;
    YDT_step = 0.01;

    VOT = 0;%:VOT_step:300;
    YDT = [0.8:YDT_step:1.05];
    
    improvement = zeros(length(VOT),length(YDT));
    
    for i = 1:length(VOT)
        for j = 1:length(YDT)
            [improvement(i,j),~,~] = one_best(data, predicted_yield, real_yield, covariance_matrix, VOT(i), YDT(j));
            disp(['VOT = ',num2str(VOT(i)),'YDT = ',num2str(YDT(j)),', I = ',num2str(improvement(i,j))]);
        end
    end
    
    [~,ind] = max(improvement(:));
    [optimal_VOT_index,optimal_YDT_index] = ind2sub(size(improvement),ind);
    
    VOT_optimal = VOT(optimal_VOT_index);
    YDT_optimal = YDT(optimal_YDT_index);
end