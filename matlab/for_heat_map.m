function [data_new] = for_heat_map(data_old)
%data old is trial, pos, activity
    [row, col] = size(data_old);
    spatial_bin = data_old(:,2);
    activity_and_pos = horzcat(spatial_bin, data_old(:,3:col));
    ncells = length(3:col);

    n_bins = unique(spatial_bin);
    num_bins = length(n_bins);
    aMean = ones(ncells, num_bins);
    for j = 1:ncells
        ind = j+1;
        this_cell = horzcat(activity_and_pos(:,1), activity_and_pos(:,ind));
    for i = 1:length(n_bins)
        this_bin = this_cell(this_cell(:,1)==n_bins(i), :);
        aMean(j,i) = mean(this_bin(:,2));
    end
    end
data_new=aMean;
end

