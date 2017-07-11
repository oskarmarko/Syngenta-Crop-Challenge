figure;
plot(prsk,pret,'LineWidth',2);
hold on

%Grid
min_risk = min(prsk);
max_risk = max(prsk);
PI_step = (max_risk - min_risk) / 19;

for i=0:19
    if sum(i == [0,5,10,15,19])
        point = min_risk + i*PI_step;
        line([point point],[0 60],'color',[0,0,0]+0.8);
    end
    
    scatter
    text(dx+sqrt(diag(p.AssetCovar)), dy+p.AssetMean, p.AssetList)
end

scatter (sqrt(diag(p.AssetCovar)), p.AssetMean,'filled')
dx = ones(16,1)*0.05;
dy = [-0.2; zeros(15,1)];
text(dx+sqrt(diag(p.AssetCovar)), dy+p.AssetMean, p.AssetList)
xlabel('Risk');
ylabel('Yield');


axis([5,8,42,56])