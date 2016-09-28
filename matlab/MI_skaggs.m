function [mi_score] = MI_skaggs(trace, position)
%inputs, trace is ncells by nframes
%inputs, position is nframes by 1 
%unique orders already
ncells = size(trace, 1);
nframes = length(position);
unik_pos = unique(position);
unik_freq = hist(position, unique(position));
position_probs = unik_freq/nframes;
MI = [];
for i = 1:ncells
    this_cell = trace(i,:)';
    this_cell = (this_cell-min(this_cell))/(max(this_cell) - min(this_cell));
    this_matrix = horzcat(this_cell, position);
    cell_total_mean = mean(this_cell);
    %disp(cell_total_mean)
    info_per_bin_one_cell = [];
    for j = 1:length(unik_pos)
        current_pos = unik_pos(j);
        which_rows = find(this_matrix(:,2)==current_pos);
        this_matrix_pos = this_matrix(which_rows, :);
        mean_cell_pos= mean(this_matrix_pos(:,1));
        information_bin = (position_probs(j)*(mean_cell_pos/cell_total_mean)*log(mean_cell_pos/cell_total_mean));
        info_per_bin_one_cell = [info_per_bin_one_cell information_bin];
    end
    summ = sum(info_per_bin_one_cell);
    MI = [MI summ];
end
mi_score = MI;
end

