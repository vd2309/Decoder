function [mat] = error_per_bin_per_trial(trial, error, real)
big_mat = horzcat(trial, error, real);
laps = unique(trial);
n_laps = length(laps);
bins = unique(real);
empty_mat = ones(n_laps,bins);
for i = 1:n_laps
    this_lap = big_mat(big_mat(:,1)==laps(i),:);
    empty_mat(i,:) = errorper_bin(this_lap(:,2), this_lap(:,3));
end
mat = empty_mat;
csvwrite('/Users/virginiadevi-chou/Desktop/mat.csv', mat);
end