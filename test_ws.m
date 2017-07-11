RMSE = zeros(12,1);
MAE = zeros(12,1);
r_spearman = zeros(12,1);
r_pearson = zeros(12,1);

[RMSE(1), MAE(1), r_spearman(1), r_pearson(1)] = get_stat_classifier(data_norm, 'rf', 'ws')
[RMSE(2), MAE(2), r_spearman(2), r_pearson(2)] = get_stat_classifier(data_norm, 'mlr', 'ws')
[RMSE(3), MAE(3), r_spearman(3), r_pearson(3)] = get_stat_classifier(data_norm, 'whr', 'ws')
[RMSE(4), MAE(4), r_spearman(4), r_pearson(4)] = get_stat_classifier(data_norm, 'whr', 'ws',120,weights_con_n)
[RMSE(5), MAE(5), r_spearman(5), r_pearson(5)] = get_stat_classifier(data_norm, 'whr', 'ws',120,weights_unc_n)
[RMSE(6), MAE(6), r_spearman(6), r_pearson(6)] = get_stat_classifier(data_norm, 'whr', 'ws',120,weights_corr)

[RMSE(7), MAE(7), r_spearman(7), r_pearson(7)] = get_stat_classifier(data_preprocessed, 'rf', 'ws')
[RMSE(8), MAE(8), r_spearman(8), r_pearson(8)] = get_stat_classifier(data_preprocessed, 'mlr', 'ws')
[RMSE(9), MAE(9), r_spearman(9), r_pearson(9)] = get_stat_classifier(data_preprocessed, 'whr', 'ws')
[RMSE(10), MAE(10), r_spearman(10), r_pearson(10)] = get_stat_classifier(data_preprocessed, 'whr', 'ws',120,weights_con_p)
[RMSE(11), MAE(11), r_spearman(11), r_pearson(11)] = get_stat_classifier(data_preprocessed, 'whr', 'ws',120,weights_unc_p)
[RMSE(12), MAE(12), r_spearman(12), r_pearson(12)] = get_stat_classifier(data_preprocessed, 'whr', 'ws',120,weights_corr)
