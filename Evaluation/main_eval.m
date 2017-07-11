
full_prediction = predict_rf_full(data);
covariance_matrix = get_covariance_matrix(full_prediction);
[VOT_optimal, YDT_optimal, PT_optimal, improvement] = ...
    get_optimal_thresh(data, predicted_yield, covariance_matrix, real_yield)

mask_VOT = variety_occurrence_thresh(data, optimal_VOT);
mask_YDT = yield_diff_thresh(data, optimal_YDT);
mask = mask_VOT & mask_YDT;


occurrence = zeros(7,174);
