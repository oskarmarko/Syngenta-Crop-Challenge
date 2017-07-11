function predicted_yield = predict_rf(training_data,test_data)
%napraviti rf model na trening skupu
%odraditi rf na test skupu
    
    Mdl = TreeBagger(100,training_data(:,6:end),training_data(:,1),'Method','regression','CategoricalPredictors',1);
    predicted_yield = predict(Mdl,test_data(:,6:end));
end