function [excluded_trial_data] = exclude_trials(data)
%exclude trials where speed dips below 10 between 500 mm and 3500 mm
%exclude trials where speed DOES NOT dip below 10 after mouse first hits 4m
%exclude trials that don't even hit 4000
%exclude the first and second trials 
laps = data(:,10);
unik_laps = unique(laps);
trials_bad = [0 1];
for i = 3:length(unik_laps)
    disp(i)
    this_trial = data(data(:,10)==unik_laps(i),:);
    [this_trial_row, this_trial_col] = size(this_trial);
    where_4000 = find(this_trial(:,8)>=4000);
    if length(where_4000)~=0
    first_4000 = where_4000(1);
    for_500 = abs(this_trial(:,8)-500);
    for_3500 = abs(this_trial(:,8)-3500);
    closest_to_500 = min(for_500);
    closest_to_3500 = min(for_3500);
    closest_to_500_index = find(for_500==closest_to_500);
    closest_to_3500_index = find(for_3500==closest_to_3500);
    middle_speed = this_trial(closest_to_500_index:closest_to_3500_index,12);
    after_4000 = this_trial(first_4000:this_trial_row,12);
    less_than_ten_middle = find(middle_speed<=10);
    after_4000 = find(after_4000<=10);
    if length(less_than_ten_middle)~=0 | length(after_4000)==0
        trials_bad = [trials_bad, unik_laps(i)]
    end
    elseif length(where_4000)==0
        trials_bad = [trials_bad, unik_laps(i)]
    end
end
rows_dont_want = [];
    for i = 1:length(trials_bad)
        bad_rows = find(data(:,10)==trials_bad(i))';
        rows_dont_want = [rows_dont_want, bad_rows];
    end
data(rows_dont_want,:)=[];
excluded_trial_data = data;
end
