function [MI, pvals] = MI_skaggs_shuffle(trace, position, nshuf)
%trace is ncells by nframes
%position is nframes by 1
MI = MI_skaggs(trace, position);
ncells = size(trace, 1);
nframes = size(trace, 2);
mat = zeros(ncells, nshuf);
for i = 1:nshuf
    disp(i)
    rand_ind = randperm(nframes);
    trace = trace(:,rand_ind);
    mat(:,i) = MI_skaggs(trace, position);
end
pvalues = [];
for i = 1:ncells
    how_many = find(mat(i,:)>=MI(i));
    add = length(how_many)/nshuf;
    pvalues = [pvalues add];
end
pvals = pvalues;
end


