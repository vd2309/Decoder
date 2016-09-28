function [binned_position] = bin_me(position)
position = position/10;
bins = 0:10:400;
%bins = 0:5:400;
binned_position = discretize(position, bins, 'IncludedEdge', 'left');
end



