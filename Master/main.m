load('data_regional.mat')
varieties = yield_diff_thresh(data, 1.03);
data_varieties = add_varieties_to_data(data_regional, varieties);
model_rf = TreeBagger(100,data(:,6:end),data(:,1),'Method','regression','CategoricalPredictors',1);

predicted_yield = zeros(length(data_varieties),1);

tic
for i=1:34
    predicted_yield(((i-1)*100000 + 1):(i*100000)) = predict(model_rf,...
        data_varieties(((i-1)*100000 + 1):(i*100000),:));
    disp([num2str(i),'/35']);
end
predicted_yield(3400000:length(data_varieties)) = predict(model_rf,...
    data_varieties(3400000:length(data_varieties),:));
toc


[winners, percentage] = get_winners(predicted_yield, data_varieties);