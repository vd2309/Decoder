function [err_per_bin]= error_perbin(cv_nb_error, real_pos)
unik_bin = unique(real_pos);
err_bin = [];
for i = 1:length(unik_bin)
    which_rows = find(real_pos==unik_bin(i));
    these_errors = cv_nb_error(which_rows);
    med = median(these_errors);
    err_bin = [err_bin med];
end
err_per_bin = err_bin;
end 

