function [new_data_all, nfbt, binned_pos, activity_alone] = get_rid_of_get_nfbt_lick(data, cell_start)
% data input is nframes by ncells + behavior info 
% this function gives the data set with no frames beyond the reward
% it also gives all inputs for cvdecoder
% and it also gives the nfbt
% also gives binned lick rate
% and it bins position
% this is the all encompassing function
num_laps = unique(data(:,10));
lick_rate = [];
empty = [];
%check = [];
for i = 1 : length(num_laps)
    sub_data = data(data(:,10) == num_laps(i),:);
    indices = find(sub_data(:,8) >= 4000);
    if (isempty(indices)==0)
    % if you want to change how many back from drop @ 4000 change the
    % number that is subtracted from indices(1)
    start_dontwant = indices(1)-2;
    sub_data = sub_data(1:start_dontwant,:);
    sub_data_lick = sub_data(:,4);
    sub_data_lickrate = [0;diff(sub_data_lick)];
    lick_rate = [lick_rate sub_data_lickrate'];
    %nfbt = [nfbt size(sub_data,1)];
    empty = vertcat(empty,sub_data);
    elseif (isempty(indices)==1)
    sub_data_lick = sub_data(:,4);
    sub_data_lickrate = [0;diff(sub_data_lick)];
    lick_rate = [lick_rate sub_data_lickrate'];
    %nfbt = [nfbt size(sub_data,1)];
    empty = vertcat(empty,sub_data);
    end
end
%x = sum(check);
%disp(x)
temp_data = empty;
temp_data(:,4) = lick_rate;
temp_data(:,8) = bin_me(temp_data(:,8));
temp_data = get_rid_bin1_bin80(temp_data);
binned_pos = temp_data(:,8);
nfbt = get_nfbt(temp_data);
% put back nfbt for naive bayes as a functin output 
new_data_all = temp_data;
% row col is frames by stuff plus ncells
[row,col] = size(temp_data);
activity_alone = new_data_all(:, cell_start:col)';
end