function [svm_med_err_per_trial] = mean_error_per_trial(trial, error)
unik_trials = unique(trial);
mean_error = [];
for i = 1:length(unik_trials)
    which_rows = find(trial==unik_trials(i));
    these_errors = error(which_rows);
    mean_e = mean(these_errors)
    mean_error = [mean_error mean_e];
end
svm_med_err_per_trial = mean_error;
end 
