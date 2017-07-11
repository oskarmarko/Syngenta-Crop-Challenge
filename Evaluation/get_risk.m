function risk_year = get_risk(final_portfolio, real_yield, covariance_matrix)

    number_of_varieties = length(real_yield);
    t=1:number_of_varieties;
    
    varieties = t(final_portfolio ~= 0);
    covariance_matrix_masked = covariance_matrix(varieties,varieties);
    predicted_yield_masked = real_yield(varieties);
    
    p = Portfolio('AssetList', cellstr(num2str(varieties'))');
    p = setInitPort(p, 1/p.NumAssets);
    p = setAssetMoments(p, predicted_yield_masked, covariance_matrix_masked);
    
    p = setDefaultConstraints(p);
    pwgt = final_portfolio(varieties);
    [risk_year, pret] = estimatePortMoments(p, pwgt);
    
end