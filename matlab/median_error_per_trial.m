function [svm_med_err_per_trial] = median_error_per_trial(trial, error)
unik_trials = unique(trial);
med_error = [];
for i = 1:length(unik_trials)
    which_rows = find(trial==unik_trials(i));
    these_errors = error(which_rows);
    median_e = median(these_errors)
    med_error = [med_error median_e];
end
svm_med_err_per_trial = med_error;
end 
