function [varieties, percentage] = optimisePortfolio(ydPredicted, covCoef, portfolioThresh)

mask = zeros(210,1);
for i=1:length(covCoef)
    mask(i) = prod(isnan(covCoef(i,:)));
end
ydPredicted(logical(mask)) = 0;
ydPredicted(isnan(ydPredicted)) = 0;
varieties = 1:210;
varieties(ydPredicted == 0) = [];

smallCovCoef = covCoef(varieties, varieties);

p = Portfolio('AssetList', cellstr(num2str(varieties'))');
p = setInitPort(p, 1/p.NumAssets);
p = setAssetMoments(p, ydPredicted(varieties), smallCovCoef); %mean, covariance

p = setDefaultConstraints(p);
portfoliosNo = 100; %200 lasts for 13min
pwgt = estimateFrontier(p, portfoliosNo);
pwgt = pwgt(:,~sum(pwgt<0));
[prsk, pret] = estimatePortMoments(p, pwgt);

p = setInitPort(p, 0);

%allowing yield to drop by no more than 5%
portfoliosYields = sum(pwgt.*repmat(ydPredicted(varieties),[1 size(pwgt,2)]));
yieldThreshold = portfolioThresh * max(ydPredicted(varieties));
[Y,I] = max((size(pwgt,2):-1:1) .* (portfoliosYields > yieldThreshold));

wgt95 = pwgt(:,I);
[orsk95, oret95] = estimatePortMoments(p, wgt95);

% Plot efficient frontier with portfolio that attains maximum Sharpe ratio

% figure;
% portfolioexamples_plot('Efficient Frontier with Maximum Sharpe Ratio Portfolio', ...
% 	{'line', prsk/12, pret/12}, ...
%     {'scatter', orsk95/12, oret95/12, {'original 95%'}}, ...
% 	{'scatter', sqrt(diag(p.AssetCovar))/12, p.AssetMean/12, p.AssetList, '.r'});
% hold on;

% Set up a dataset object that contains the portfolio that maximizes the Sharpe ratio

%Blotter = dataset({100*wgt95(wgt95 > 0),'Weight'}, 'obsnames', p.AssetList(wgt95 > 0));

%fprintf('Portfolio with Maximum Sharpe Ratio\n');
%disp(Blotter);

varieties = str2num(char(p.AssetList(wgt95 > 0)));
percentage = wgt95(wgt95 > 0);
percentage = percentage / sum(percentage);

while (any(percentage < 0.1) || (length(varieties) > 5))
    [Y,I] = min(percentage);
    varieties(I) = [];
    smallCovCoef = covCoef(varieties, varieties);

    p = Portfolio('AssetList', cellstr(num2str(varieties))');
    p = setInitPort(p, 1/p.NumAssets);
    p = setAssetMoments(p, ydPredicted(varieties), smallCovCoef); %mean, covariance
    p = setDefaultConstraints(p);
    pwgt = estimateFrontier(p, portfoliosNo);
    q=pwgt(:,~sum(pwgt<0)); %gives negative percentages
    %[prsk, pret] = estimatePortMoments(p, pwgt);
    portfoliosYields = sum(q.*repmat(ydPredicted(varieties),[1 size(q,2)]));
    [Y,I] = max((size(q,2):-1:1) .* (portfoliosYields > yieldThreshold));
    wgt95 = q(:,I);
    [rsk95, ret95] = estimatePortMoments(p, wgt95);
    varieties = str2num(char(p.AssetList(wgt95 > 0)));
    percentage = wgt95(wgt95 > 0);
    percentage = percentage / sum(percentage);

end


% portfolioexamples_plot('Efficient Frontier with Maximum Sharpe Ratio Portfolio', ...
%     {'scatter', rsk95/12, ret95/12, {'final 95%'}});

%[Y,I] = sort(percentage,1,'descend');

end