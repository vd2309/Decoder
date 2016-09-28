function [svm_predictions] = loocv(cleaned_data,cell_start)
%[cleaned_data, binned_pos, events] = get_rid_of_get_nfbt_lick(data, cell_start);
laps = unique(cleaned_data(:,10));
all_laps = cleaned_data(:,10);
%cleaned data is nframes by ncells
predictions = [];
%below line is for transforming events from ncells by nframes to nframes by
%ncells
[row, col] = size(cleaned_data);
activity = cleaned_data(:,cell_start:col);
%[rowt, colt] = size(activity);
%for i = 1:colt
 %   activity(:,i) = scale(activity(:,i));
%end
n = length(laps);
% above line is to make events nframes by ncells, not ncells by nframes
for i = 1:n
    disp(i)
    current_lap = laps(i);
    indices_test = find(all_laps==current_lap);
    indices_train = find(all_laps~=current_lap);
    test_data = activity(indices_test,:);
    test_labels = cleaned_data(indices_test,8);
    train_data = activity(indices_train,:);
    train_labels = cleaned_data(indices_train,8);
    %size_trainlabels = size(train_labels)
    %size_traindata = size(train_data')
    %size_testlabels = size(test_labels)
    %size_testdata = size(test_data')
    model = svmtrain(train_labels, train_data, '-t 0 -d 3 -c 1 -g .0026');
    %model = svmtrain(train_labels, train_data);
    pred_labels = svmpredict(test_labels, test_data, model);
    disp(predictions)
    predictions = [predictions pred_labels']
end
svm_predictions = predictions;
end

