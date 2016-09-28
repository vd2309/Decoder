function [lick_rates] = bin_lick(lick_diff_vec)
% lick_diff_vec is the vector of licks where the difference has already
% been taken ie a vector of a bunch of zeros and ones, not a cumulatively
% summed vector 
n = length(lick_diff_vec);
remainder = rem(n,5);
index = n:-5:remainder;
empty = ones(n,1);
for i = index
    if i~=remainder
        inds = i:-1:i-4;
        val = sum(lick_diff_vec(inds));
        empty(inds) = val;
    else
        inds = i:-1:1;
        %empty(inds) = 0;
        empty(inds) = lick_diff_vec(inds);
end
end
lick_rates = empty;
end