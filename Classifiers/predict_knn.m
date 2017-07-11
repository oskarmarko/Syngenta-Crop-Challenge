function predicted_yield = predict_knn(training_data, test_data, number_of_neighbours)
%napraviti rf model na trening skupu
%odraditi rf na test skupu

    Mdl = fitcknn(training_data(:,6:end),training_data(:,1),'NumNeighbors',number_of_neighbours,'Standardize',1);
    predicted_yield = predict(Mdl,test_data(:,6:end));
end