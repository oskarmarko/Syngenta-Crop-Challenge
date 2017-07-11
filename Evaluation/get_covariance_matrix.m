function covariance_matrix = get_covariance_matrix(full_prediction)

    number_of_varieties = size(full_prediction,3);
    covariance_matrix = zeros(number_of_varieties);

    for i=1:number_of_varieties
        first_var_yields = squeeze(full_prediction(:,:,i));
        first_var_yields = first_var_yields(:);
        first_mask = ~isnan(first_var_yields);
        for j=1:number_of_varieties
            second_var_yields = squeeze(full_prediction(:,:,j));
            second_var_yields = second_var_yields(:);
            second_mask = ~isnan(second_var_yields);
            mask = first_mask & second_mask;
            cov_mat = cov(first_var_yields(mask),second_var_yields(mask));
            covariance_matrix(i,j) = cov_mat(2);
        end
    end
end