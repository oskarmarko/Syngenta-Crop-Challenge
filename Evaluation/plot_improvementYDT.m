function plot_improvementYDT(YDT,improvement)

    figure
    plot([min(YDT)-0.01, YDT, max(YDT)+0.01],ones(length(YDT)+2,1),'--k')
    %plot(YDT,ones(length(YDT),1),'--k')
    xlabel('Yield difference threshold')
    ylabel('Improvement comparing to mean yield')
    axis([min(YDT)-0.01,max(YDT)+0.01,0.96,1.08])
    hold on 
    plot(YDT,improvement,'LineWidth',2)
    
end