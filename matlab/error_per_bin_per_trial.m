function [mat, med_empty] = error_per_bin_per_trial(trial, error, real)
% takes those three things give a mat and the thing you wana plot
big_mat = horzcat(trial, error, real);
laps = unique(trial);
n_laps = length(laps);
bins = unique(real);
n_bins = length(bins);
empty_mat = {};
for i = 1:n_bins
    this_lap = big_mat(big_mat(:,3)==bins(i),:);
    errors = [];
    for j = 1:n_laps
        this_lap_trial = this_lap(this_lap(:,1)==laps(j),:);
        error = median(this_lap_trial(:,2));
        errors = [errors, error];
    end
    empty_mat{i} = errors;
end
med_empty = [];
for i = 1:length(empty_mat)
    where_nan = isnan(empty_mat{i});
    where_nan_index = find(where_nan == 1);
    temp = empty_mat{i};
    temp(where_nan_index) = [];
    med_empty = [med_empty, median(temp)];
end
temp1 = empty_mat';
temp1 = vertcat(laps', temp1);
mat = temp1;
%%%% the top row of mat is the trial number do not use it to calculat ethe
%%%% average you will get an incorrect number
%csvwrite('/Users/virginiadevi-chou/Desktop/err_per_bin_per_trial.csv', mat);
end