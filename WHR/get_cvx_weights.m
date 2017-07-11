function [weights_unc, weights_con] = get_cvx_weights(data, number_of_bins)
    
    [b, H, bH_year] = predict_whr_matrix(data, number_of_bins);
    [weights_unc, weights_con] = calc_cvx_weights(b, H, bH_year);
    
end