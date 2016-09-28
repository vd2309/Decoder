%%have the raw_data which is the traces file and the events file loaded into workspace
cell_start = 13;
num_trial_type = length(unique(raw_data(:,11)));
if num_trial_type == 1
    [svm_all_data, nb_all_data, error_pb_pt_mat_nb, error_pb_pt_mat_svm, ho] = svm_nb_final(events, raw_data, cell_start);
    csvwrite('/Users/virginiadevi-chou/Desktop/svm_err_bin_trial.csv', error_pb_pt_mat_svm)
    csvwrite('/Users/virginiadevi-chou/Desktop/nb_err_bin_trial.csv', error_pb_pt_mat_nb)
    csvwrite('/Users/virginiadevi-chou/Desktop/svm_all_data.csv', svm_all_data)
    csvwrite('/Users/virginiadevi-chou/Desktop/nb_all_data.csv', nb_all_data)
    savefig(ho, '/Users/virginiadevi-chou/Desktop/svm_nb_figs.fig')
    lick_plots
    savefig(h, '/Users/virginiadevi-chou/Desktop/lick_trial.fig')
    heat_map
    savefig(hi, '/Users/virginiadevi-chou/Desktop/trial_heatmap.fig')
elseif num_trial_type == 2
    a1_raw_data = raw_data(raw_data(:,11)==1,:);
    a2_raw_data = raw_data(raw_data(:,11)==2,:);
    a1_events = events(events(:,11)==1,:);
    a2_events = events(events(:,11)==2,:);
    %% a1 %%%%
    [svm_all_data_a1, nb_all_data_a1, error_pb_pt_mat_nb_a1, error_pb_pt_mat_svm_a1,ho] = svm_nb_final(a1_events, a1_raw_data, cell_start);
    savefig(ho, '/Users/virginiadevi-chou/Desktop/svm_nb_figs_a1.fig')
    csvwrite('/Users/virginiadevi-chou/Desktop/svm_err_bin_trial_a1.csv', error_pb_pt_mat_svm_a1)
    csvwrite('/Users/virginiadevi-chou/Desktop/nb_err_bin_trial_a1.csv', error_pb_pt_mat_nb_a1)
    csvwrite('/Users/virginiadevi-chou/Desktop/svm_all_data_a1.csv', svm_all_data_a1)
    csvwrite('/Users/virginiadevi-chou/Desktop/nb_all_data_a1.csv', nb_all_data_a1)
    lick_plots
    savefig(h, '/Users/virginiadevi-chou/Desktop/lick_trial_a1.fig')
    heat_map
    savefig(hi, '/Users/virginiadevi-chou/Desktop/trial_heatmap_a1.fig')
    %%%%%%%%
    
    %%%%%a2%%%%%%%
    [svm_all_data_a2, nb_all_data_a2, error_pb_pt_mat_nb_a2, error_pb_pt_mat_svm_a2, ho] = svm_nb_final(a2_events, a2_raw_data, cell_start);
    savefig(ho, '/Users/virginiadevi-chou/Desktop/svm_nb_figs_a2.fig')
    csvwrite('/Users/virginiadevi-chou/Desktop/svm_err_bin_trial_a2.csv', error_pb_pt_mat_svm_a2)
    csvwrite('/Users/virginiadevi-chou/Desktop/nb_err_bin_trial_a2.csv', error_pb_pt_mat_nb_a2)
    csvwrite('/Users/virginiadevi-chou/Desktop/svm_all_data_a2.csv', svm_all_data_a2)
    csvwrite('/Users/virginiadevi-chou/Desktop/nb_all_data_a2.csv', nb_all_data_a2)
    lick_plots
    savefig(h, '/Users/virginiadevi-chou/Desktop/lick_trial_a2.fig')
    heat_map
    savefig(hi, '/Users/virginiadevi-chou/Desktop/trial_heatmap_a2.fig')
    %%%%%%%%%%%%%%
end
