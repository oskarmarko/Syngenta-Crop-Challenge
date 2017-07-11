function predicted_yield = get_prediction(data, classifier, class_par0, class_par1, class_par2)
% Treba realizovati posebno klasifikatore
% Izlaz je matrica prinosa po godinama, njivama i kulturama
    folderName = fullfile(pwd,'Classifiers');
    addpath(folderName);
    
    year = data(:,4);
    farm = data(:,5);
    variety = data(:,6);
    
    number_of_years = length(unique(year));
    number_of_farms = length(unique(farm));
    number_of_varietes = max(variety);
    number_of_features = size(data,2) - 5;
    
    predicted_yield = zeros(number_of_years,number_of_farms,number_of_varietes);
    
    if strcmp(classifier,'whr')
        folderName = fullfile(pwd,'WHR');
        addpath(folderName);
        categorical = zeros(size(data,2),1);
        categorical(6) = 1;
        
        if (nargin == 3)
            number_of_bins = 120; %default bin number
            weights = ones(number_of_years,number_of_features) / number_of_features; %equ
        elseif (nargin == 4)
            number_of_bins = class_par1; %specific bin number
            weights = ones(number_of_years,number_of_features) / number_of_features; %equ
        elseif (nargin == 5)
            number_of_bins = class_par1; %specific bin number
            weights = class_par2; %cvx weights
        end
    end
    
    tic
    for i=1:number_of_years
        test_data = data(year == (i+2008),:);
        training_data = data(year ~= (i+2008),:);
        
        switch classifier
            case 'rf'
                if strcmp(class_par0,'ws')
                    test_predictions = predict_rf_ws(training_data, test_data);
                elseif strcmp(class_par0,'noisy')
                    test_predictions = predict_rf_noisy(training_data, test_data);
                else
                    test_predictions = predict_rf(training_data, test_data);
                end        
            case 'whr'
                if strcmp(class_par0,'ws')
                    test_predictions = predict_whr_ws(training_data, test_data, categorical, number_of_bins, weights(i,:));
                elseif strcmp(class_par0,'non-ws')
                    test_predictions = predict_whr(training_data, test_data, categorical, number_of_bins, weights(i,:));
                elseif strcmp(class_par0,'non-ws_var')
                    test_predictions = predict_whr_var(training_data, test_data, categorical, number_of_bins, weights(i,:));
                elseif strcmp(class_par0,'noisy')
                    test_predictions = predict_whr_noisy(training_data, test_data, categorical, number_of_bins, weights(i,:),.9);
                end
            case 'knn'
                if strcmp(class_par0,'ws')
%                     test_predictions = predict_svm_ws(training_data, test_data);
                else
                    test_predictions = predict_knn(training_data, test_data, class_par1);
                end 
            case 'mlr'
                if strcmp(class_par0,'ws')
                    test_predictions = predict_mlr_ws(training_data, test_data);
                else
                    test_predictions = predict_mlr(training_data, test_data);
                end 
            case 'ann'
                test_predictions = predict_ann(training_data,test_data, class_par1);
            case 'svm'
                test_predictions = predict_svm(training_data,test_data);
        end
        
        predicted_yield(i,:,:) = make_prediction_matrix(test_data, test_predictions, number_of_farms, number_of_varietes);
        
        disp(['Godina ',num2str(2008+i)])
    end 
    toc
end
    
        
        
        
        
        
        