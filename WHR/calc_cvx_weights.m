function [weights_unc, weights_con] = calc_cvx_weights(b, H, bH_year)
    
    number_of_years = length(unique(bH_year));
    number_of_features = size(H,2);
    
    weights_unc = zeros(number_of_years, number_of_features);
    weights_con = zeros(number_of_years, number_of_features);
    
    for i=1:number_of_years
        current_year = i+2008;
        
        cvx_begin quiet
            variable w(number_of_features)
            minimize( norm(H(bH_year ~= current_year,:) * w - b(bH_year ~= current_year)) )
        cvx_end
        
        weights_unc(i,:) = w;
        
        cvx_begin quiet
            variable w(number_of_features)
            minimize(norm(H(bH_year ~= current_year,:) * w - b(bH_year ~= current_year)))
            subject to
                0 <= w
        cvx_end
        
        weights_con(i,:) = w;
        
        disp(['Godina ',num2str(2008+i)])
    end
end