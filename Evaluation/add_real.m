function full_prediction_with_real = add_real(full_prediction, real_yield)

    full_prediction_with_real = full_prediction;
    
    for i=1:size(full_prediction,1)
        for j=1:size(full_prediction,2)
            for k=1:size(full_prediction,3)
                if (~isnan(real_yield(i,j,k)))
                    full_prediction_with_real(i,j,k) = real_yield(i,j,k);
                end
            end
        end
        disp(num2str(i));
    end
end