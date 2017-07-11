function [out_varieties, out_percentage] = optimise_portfolio_PI(... 
    predicted_yield_masked, covariance_matrix_masked, PI, in_varieties, plot)

    number_of_varieties = length(predicted_yield_masked);
    varieties_ordered=1:number_of_varieties;
    
    p = Portfolio('AssetList', cellstr(num2str(in_varieties))');
    p = setInitPort(p, 1/p.NumAssets);
    p = setAssetMoments(p, predicted_yield_masked, covariance_matrix_masked);
    
    p = setDefaultConstraints(p);
    number_of_portfolios = 100;
    pwgt = estimateFrontier(p, number_of_portfolios);
    pwgt = pwgt(:,~sum(pwgt<0));
    [prsk, pret] = estimatePortMoments(p, pwgt);
    
    risk_threshold = min(pret) + PI / 19 * (max(pret) - min(pret));
    [~,I] = max((size(pwgt,2):-1:1) .* (pret' >= risk_threshold));
    wgt_optimal = pwgt(:,I);
    [rsk_optimal, ret_optimal] = estimatePortMoments(p, wgt_optimal);
    
    out_varieties = varieties_ordered(wgt_optimal ~= 0)';
    out_percentage = nonzeros(wgt_optimal);
    
    if strcmp(plot,'plot')
        %right values on axis, but labels are too far away
%         figure;
%         portfolioexamples_plot('Efficient Frontier with Maximum Sharpe Ratio Portfolio', ...
%             {'line', prsk/12, pret/12}, ...
%             {'scatter', rsk_optimal/12, ret_optimal/12, {'optimal'}, '.g'}, ...
%             {'scatter', sqrt(diag(p.AssetCovar))/12, p.AssetMean/12, p.AssetList, '.r'});
%         hold on;
        
        figure;
        portfolioexamples_plot('Efficient Frontier with Maximum Sharpe Ratio Portfolio', ...
            {'line', prsk, pret}, ...
            {'scatter', rsk_optimal, ret_optimal, {'optimal'}, '.g'}, ...
            {'scatter', sqrt(diag(p.AssetCovar)), p.AssetMean, p.AssetList, '.r'});
        hold on;
    end
    
    
end