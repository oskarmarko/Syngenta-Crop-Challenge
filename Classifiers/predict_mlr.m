function predicted_yield = predict_mlr(training_data,test_data)
%napraviti rf model na trening skupu
%odraditi rf na test skupu
    
    Mdl = fitlm(training_data(:,6:end),training_data(:,1));
    predicted_yield = predict(Mdl,test_data(:,6:end));
end