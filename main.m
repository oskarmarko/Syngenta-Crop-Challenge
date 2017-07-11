%iz foldera Read data
load('data_final.mat')
load('real_yield.mat')

%iz root-a
[RMSE, MAE, r_spearman, r_pearson] = get_stat_classifier(data, real_yield, 'rf', 'non-ws');
% 10.5324    8.2605    0.3589    0.3665

%Evaluation
full_prediction = predict_rf_full(data);
covariance_matrix = get_covariance_matrix(full_prediction);
predicted_yield = get_prediction(data, 'rf', 'non-ws');
[VOT_optimal, YDT_optimal, PT_optimal, improvement] = ...
    get_optimal_thresh(data, predicted_yield, covariance_matrix, real_yield);