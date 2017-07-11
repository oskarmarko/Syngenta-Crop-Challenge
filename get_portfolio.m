function percentage = get_portfolio(predicted_yield, cov_mat, portfolio_thresh)

    varieties = 1:length(predicted_yield);
    
    p = Portfolio('AssetList', cellstr(num2str(varieties'))');
    p = setInitPort(p, 1/p.NumAssets);
    p = setAssetMoments(p, predicted_yield, cov_mat);
    
    p = setDefaultConstraints(p);
    portfoliosNo = 100; %200 lasts for 13min
    pwgt = estimateFrontier(p, portfoliosNo);
    pwgt = pwgt(:,~sum(pwgt<0));
    [prsk, pret] = estimatePortMoments(p, pwgt);

    p = setInitPort(p, 0);
    
end