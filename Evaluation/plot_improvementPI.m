function plot_improvementPI(improvement)

    figure
    %plot(-1:21,ones(21+2,1),'--k')
    xlabel('PI')
    ylabel('Improvement comparing to mean yield')
    axis([-1,20,1.06,1.1])
    hold on 
    plot(0:19,improvement,'LineWidth',2)
    
end