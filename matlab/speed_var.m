function [speedvariance_trial] = speed_var(trial, speed)
big_mat = horzcat(trial, speed);
unik_trials = unique(trial);
n_rows = length(unik_trials);
mat = zeros(n_rows,2);
for i = 1:n_rows
    this_trial = big_mat(big_mat(:,1)==unik_trials(i),:);
    var_speed = var(this_trial(:,2));
    vectah = [unik_trials(i), var_speed];
    mat(i,:) = vectah;
end
speedvariance_trial = mat;
end


