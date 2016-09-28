function [matrix] = make_plots(data, position, nfbt, size, smooth_lengths, past_futures)
    empty = ones(length(nfbt), length(smooth_lengths));
    for i = 1:length(smooth_lengths)
        [mean, med, all]=crossValidateDecoder(data, position, nfbt, size, smooth_lengths(i), past_futures);
        empty(:,i) = med;
    end
    matrix = empty;
end


