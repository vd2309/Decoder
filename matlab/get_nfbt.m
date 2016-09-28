function [n_frames_by_trial] = get_nfbt(data)
lap_count = data(:,10)';
unique_laps = unique(lap_count);
empty = [];
for iLap = unique_laps
    frames = find(lap_count == iLap);
    empty = [empty length(frames)];
end
n_frames_by_trial = empty;
end


