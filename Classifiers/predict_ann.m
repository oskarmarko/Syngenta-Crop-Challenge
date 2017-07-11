function predicted_yield = predict_ann(training_data,test_data, architecture)
%model na osnovu ANN




%net = newgrnn(training_data(:,6:end)',training_data(:,1)',0.1);
net = feedforwardnet(architecture);
net = configure(net,training_data(:,6:end)',training_data(:,1)');
predicted_yield = net(test_data(:,6:end)');
%[net,tr] = train(net,X,T,Xi,Ai,EW)
%predicted_yield = sim(net,test_data(:,6:end)'); 




end