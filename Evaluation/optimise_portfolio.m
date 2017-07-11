function [varieties, percentage] = optimise_portfolio(... 
    predicted_yield, covariance_matrix, portfolio_thresh, mask, plot)

    number_of_varieties = length(predicted_yield);
    t=1:number_of_varieties;
    varieties_potential = t(mask);
    
    predicted_yield_masked = predicted_yield(mask)';
    covariance_matrix_masked = covariance_matrix(mask,mask);
    
    p = Portfolio('AssetList', cellstr(num2str(varieties_potential'))');
    p = setInitPort(p, 1/p.NumAssets);
    p = setAssetMoments(p, predicted_yield_masked, covariance_matrix_masked);
    
    p = setDefaultConstraints(p);
    number_of_portfolios = 100;
    pwgt = estimateFrontier(p, number_of_portfolios);
    pwgt = pwgt(:,~sum(pwgt<0));
    [prsk, pret] = estimatePortMoments(p, pwgt);
    
    portfolio_yields = sum(pwgt.*repmat(predicted_yield_masked,[1 size(pwgt,2)]));
    risk_threshold = min(pret) + portfolio_thresh / 19 * (max(pret) - min(pret));
    [~,I] = max((size(pwgt,2):-1:1) .* (portfolio_yields > yield_threshold));
    wgt_optimal = pwgt(:,I);
    [rsk_optimal, ret_optimal] = estimatePortMoments(p, wgt_optimal);
    
    varieties = varieties_potential(wgt_optimal ~= 0)';
    percentage = nonzeros(wgt_optimal);
    
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