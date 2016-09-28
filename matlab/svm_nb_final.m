function [svm_all_data, nb_all_data, error_pb_pt_mat_nb, error_pb_pt_mat_svm,ho] = svm_nb_final(events, traces, cell_start)
    %%%%%GET NB AND SVM DATA CLEANED AND READY FOR DECODING%%%%%%%%%
    events = exclude_trials(events);
    traces = exclude_trials(traces);
    [cleaned_data_nb, nfbt_e, bin_pos_e, events] = get_rid_of_get_nfbt_lick(events, cell_start);
    [cleaned_data_svm, nfbt_t, bin_pos_t, traces] = get_rid_of_get_nfbt_lick(traces, cell_start);
    lap = cleaned_data_nb(:,10);
    %lick = cleaned_data_nb(:,4);
    lap_svm = cleaned_data_svm(:,10);
    %lick_svm = cleaned_data_svm(:,4);
    
    %%%%%NB DECODE%%%%%%%%%
    [mean_err_pt_nb, med_err_pt_nb, all_err_nb, dec_pos_nb] = crossValidateDecoder(events, bin_pos_e, nfbt_e, 5, 6, 11);
    %error_per_bin = error_perbin(all_err_nb, bin_pos_e);
    %avg_lick_per_real_bin_nb = avg_lick_per_bin(lick,bin_pos_e);
    %avg_lick_per_dec_bin_nb = avg_lick_per_bin(lick, dec_pos_nb);
    [error_pb_pt_mat_nb, med_err_pb_pt_nb] = error_per_bin_per_trial(lap, all_err_nb', bin_pos_e);
  
    
    %%%%%%%%NB PLOT%%%%%%%%%%%%
    ho(1) = figure
    subplot(2,2,1)
    plot(mean_err_pt_nb) 
    title('Mean Error Per Trial Naive Bayes')
    %subplot(2,3,2)
    %plot(error_per_bin)
    %title('Error Per Bin Naive Bayes')
    %subplot(2,3,3)
    %plot(avg_lick_per_real_bin_nb);
    %title('Average Lick Per Real Bin Naive Bayes')
    %subplot(2,3,4)
    %plot(avg_lick_per_dec_bin_nb);
    %title('Average Lick Per Decoded Bin Naive Bayes')
    subplot(2,2,2)
    plot(med_err_pb_pt_nb)
    title('Median Error Per Bin Over all Trials: Naive Bayes')
    xlabel('Bin')
    ylabel('Median Error Per Bin Over all Trial - each trial equally weighted')
    
    %%%%%%%%%SVM DECODE%%%%%%%%%%%%%%%
    [dec_pos_svm] = loocv(cleaned_data_svm, 13);
    all_err_svm = abs(bin_pos_t - dec_pos_svm');
    %error_per_bin_svm = error_perbin(all_err_svm, bin_pos_t);
    %avg_lick_per_real_bin_svm = avg_lick_per_bin(lick_svm,bin_pos_t);
    %avg_lick_per_dec_bin_svm = avg_lick_per_bin(lick_svm, dec_pos_svm);
    mean_err_pt_svm = mean_error_per_trial(lap_svm, all_err_svm);
    [error_pb_pt_mat_svm, med_err_pb_pt_svm] = error_per_bin_per_trial(lap_svm, all_err_svm, bin_pos_t);
    
    %%%%%%%%%%%%SVM PLOT%%%%%%%%%%%%%%
    ho(2) = figure
    subplot(2,2,1)
    plot(mean_err_pt_svm) 
    title('Mean Error Per Trial SVM')
    %subplot(2,3,2)
    %plot(error_per_bin_svm)
    %title('Error Per Bin SVM')
    %subplot(2,3,3)
    %plot(avg_lick_per_real_bin_svm);
    %title('Average Lick Per Real SVM')
    %subplot(2,3,4)
    %plot(avg_lick_per_dec_bin_svm);
    %title('Average Lick Per Decoded Bin SVM')
    subplot(2,2,2)
    plot(med_err_pb_pt_svm)
    title('Median Error Per Bin Over all Trials: SVM')
    xlabel('Bin')
    ylabel('Median Error Per Bin Over all Trial - each trial equally weighted')
    %savefig(ho, '/Users/virginiadevi-chou/Desktop/figures_svm_nb.fig')
    
    %%%%%%FINAL CLEANED DATA%%%%%%%%%%
    svm_all_data = horzcat(cleaned_data_svm, dec_pos_svm');
    nb_all_data = horzcat(cleaned_data_nb,dec_pos_nb');
    
    %%%%%%%WRITE FILES%%%%%%%%
    %csvwrite('/Users/virginiadevi-chou/Desktop/svm_err_bin_trial.csv', error_pb_pt_mat_svm)
    %csvwrite('/Users/virginiadevi-chou/Desktop/nb_err_bin_trial.csv', error_pb_pt_mat_nb)
    %csvwrite('/Users/virginiadevi-chou/Desktop/svm_all_data.csv', svm_all_data)
    %csvwrite('/Users/virginiadevi-chou/Desktop/nb_all_data.csv', nb_all_data)
end 

