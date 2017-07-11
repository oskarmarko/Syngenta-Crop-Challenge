function weights_rand = random_weights()

    weights_rand = zeros(7,15);
    
    for i=1:7
        for j=1:15
            weights_rand(i,j) = abs(randn(1));
        end
        
        weights_rand(i,:) = weights_rand(i,:) ./ sum(weights_rand(i,:));
    end
    
    
end