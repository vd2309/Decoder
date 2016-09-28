function [a1_mat, a2_mat] = create_matrix(a1, a2, cell_start)
% a1 and a2 just have to be a1 and a2 no other modifications 
% sl then pf
[a1_clean, nfbt_a1, pos_a1, events_a1] = get_rid_of_get_nfbt_lick(a1, cell_start);
[a2_clean, nfbt_a2, pos_a2, events_a2] = get_rid_of_get_nfbt_lick(a2, cell_start);
[a1_mean, a1_med, a1_all, a1_decoded, a1_real] = crossValidateDecoder(events_a1, pos_a1, nfbt_a1, 5, 6, 16);
[a2_mean, a2_med, a2_all, a2_decoded, a2_real] = crossValidateDecoder(events_a2, pos_a2, nfbt_a2, 5, 6, 16);
a1_matrix = horzcat(a1_clean, a1_all', a1_decoded', a1_real');
a2_matrix = horzcat(a2_clean, a2_all', a2_decoded', a2_real');
csvwrite('/Users/axel/Desktop/a1_19.csv', a1_matrix)
csvwrite('/Users/axel/Desktop/a2_19.csv', a2_matrix)
a1_mat = a1_matrix;
a2_mat = a2_matrix;
end

