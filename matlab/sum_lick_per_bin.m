function [avg_lick_bin] = sum_lick_per_bin(lick, bin)
unik_bin = unique(bin);
avg_lick = [];
for i = 1:length(unik_bin)
    which_rows=find(bin==unik_bin(i));
    these_licks = lick(which_rows);
    mn = sum(these_licks);
    avg_lick = [avg_lick mn];
end
avg_lick_bin = avg_lick;
end


