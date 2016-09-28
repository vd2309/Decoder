%Create heat map from data we feed into decoder, i.e. cleaned data
%data must be svm_all_data, NOT nb_all_data because that activity is events
%only, need auxiliary function for_heat_map

% lets see if this appears in GITHUB!!!!!! YAHOOOOOOO!!!

%%%%exclude trials and clean%%%%
%data = exclude_trials(raw_data);
%[data, binned_pos, nfbt, activity] = get_rid_of_get_nfbt_lick(data, 13);
% must run predictions before we get the 
[num_row, num_col] = size(data);

if length(unique(data(:,11)))>1
    a1 = data(data(:,11)==1, :);
    a1_lick = a1(:,4);
    a1_bin = a1(:,8);
    %a1_decbin = a1(:,num_col)
    a1_numtrials = length(unique(a1(:,10)));
    a1_all_sum_lick_per_bin = sum_lick_per_bin(a1_lick, a1_bin)/a1_numtrials;
    %a1_all_sum_lick_per_decbin = sum_lick_per_bin(a1_lick, a1_decbin)/a1_numtrials;
    %%%%%%%%
    a2 = data(data(:,11)==2, :);
    a2_lick = a2(:,4);
    a2_bin = a2(:,8);
    %a2_decbin = a2(:,num_col)
    a2_numtrials = length(unique(a2(:,10)));
    a2_all_sum_lick_per_bin = sum_lick_per_bin(a2_lick, a2_bin)/a2_numtrials;
    %a2_all_sum_lick_per_decbin = sum_lick_per_bin(a2_lick, a2_decbin)/a2_numtrials;

h(1) = figure
hold on;
plot(a1_all_sum_lick_per_bin, 'g')
ylim([0 20])
hold off;
title('A1 Avg Lick Per Bin');
xlabel('Bin');
ylabel('Avg Lick');

h(2) = figure
hold on;
plot(a2_all_sum_lick_per_bin, 'g');
ylim([0 20])
hold off;
title('A2 Avg Lick Per Bin');
xlabel('Bin');
ylabel('Avg Lick');

%%%%% all a1 trials %%%%%%%%
mat = horzcat(a1(:,10), a1(:,4), a1(:,8));
trials_unik = unique(mat(:,1));
number_trials = length(trials_unik);
num_figures = ceil(number_trials/8);
extraj = number_trials:-8:1

for j = number_trials:-8:1
    ind = find(extraj==j);
    h(2+ind) = figure
    hold on;
    if j - 8 >= 0
        disp(j)
        for i = j:-1:j-7
            trial_num = trials_unik(i);
            this_trial = mat(mat(:,1)==trial_num,:);
            sum_lick_per_bin_trial = sum_lick_per_bin(this_trial(:,2), this_trial(:,3));
            sum_lick_per_dec_bin_trial = sum_lick_per_bin()
            ind_i = j:-1:j-7;
            subplot_ind = find(ind_i == i);
            subplot(2,4,subplot_ind)
            %hold on;
            plot(sum_lick_per_bin_trial, 'b'); hold on; plot(a1_all_sum_lick_per_bin, 'r')
            ylim([0 20])
            %plot(sum_lick_per_bin_trial,a1_all_sum_lick_per_bin,'r');
            hold off;
            title([' A1 Trial ' num2str(trial_num) ' individual']);
            xlabel('Bin');
            ylabel('Avg Lick Per Bin');
        end
    elseif j - 8 < 0
        for i = j:-1:1
            trial_num = trials_unik(i);
            this_trial = mat(mat(:,1)==trial_num,:);
            sum_lick_per_bin_trial = sum_lick_per_bin(this_trial(:,2), this_trial(:,3))
            ind_i = j:-1:1;
            subplot_ind = find(ind_i == i);
            subplot(2,4,subplot_ind)
            %hold on;
            plot(sum_lick_per_bin_trial, 'b'); hold on; plot(a1_all_sum_lick_per_bin,'r');
            ylim([0 20])
            hold off;
            title(['A1 Trial ' num2str(trial_num) ' individual']);
            xlabel('Bin');
            ylabel('Avg Lick Per Bin');
        end
    end
end

%%%%% a2 %%%%trials
mat = horzcat(a2(:,10), a2(:,4), a2(:,8));
trials_unik = unique(mat(:,1));
number_trials = length(trials_unik);
num_figures = ceil(number_trials/8);
extraj = number_trials:-8:1
add_on = num_figures + 2;

%for i = 1:length(trials_unik)
for j = number_trials:-8:1
    ind = find(extraj==j);
    h(add_on+ind) = figure
    hold on;
    if j - 8 >= 0
        for i = j:-1:j-7
            trial_num = trials_unik(i);
            this_trial = mat(mat(:,1)==trial_num,:);
            sum_lick_per_bin_trial = sum_lick_per_bin(this_trial(:,2), this_trial(:,3))
            ind_i = j:-1:j-7;
            subplot_ind = find(ind_i == i);
            subplot(2,4,subplot_ind)
            %hold on;
            plot(sum_lick_per_bin_trial, 'b'); hold on; plot(a2_all_sum_lick_per_bin,'r');
            ylim([0 20])
            hold off;
            title([' A2 Trial ' num2str(trial_num) ' individual']);
            xlabel('Bin');
            ylabel('Avg Lick Per Bin');
        end
    elseif j - 8 < 0
        for i = j:-1:1
            trial_num = trials_unik(i);
            this_trial = mat(mat(:,1)==trial_num,:);
            sum_lick_per_bin_trial = sum_lick_per_bin(this_trial(:,2), this_trial(:,3))
            ind_i = j:-1:1;
            subplot_ind = find(ind_i == i);
            subplot(2,4,subplot_ind)
            %hold on;
            plot(sum_lick_per_bin_trial,'b'); hold on; plot(a2_all_sum_lick_per_bin,'r');
            ylim([0 20])
            hold off;
            title(['A2 Trial ' num2str(trial_num) ' individual']);
            xlabel('Bin');
            ylabel('Avg Lick Per Bin');
        end
    end
    savefig(h, '/Users/virginiadevi-chou/Desktop/lick_trial.fig')
end

elseif length(unique(data(:,11)))==1
    a_lick = data(:,4);
    a_bin = data(:,8);
    a_decbin = data(:,num_col);
    a_numtrials = length(unique(data(:,10)));
    sum_lick_per_bin_all = sum_lick_per_bin(a_lick, a_bin)/a_numtrials;  
    sum_lick_per_decbin_all = sum_lick_per_bin(a_lick, a_decbin)/a_numtrials; 
    
h(1) = figure
hold on;
%plot(sum_lick_per_bin_all, 'g'); hold on; plot(sum_lick_per_decbin_all, 'r');
%scatter(sum_lick_per_bin_all, unique(a_bin)); hold on; scatter(sum_lick_per_decbin_all, unique(a_decbin));
scatter(unique(a_bin), sum_lick_per_bin_all); hold on; scatter(unique(a_decbin), sum_lick_per_decbin_all);
line(unique(a_bin), sum_lick_per_bin_all)
line(unique(a_decbin), sum_lick_per_decbin_all, 'Color', [1 0 0])
ylim([0 20])
hold off;
title('Sum Lick Per Real Bin (in blue) and Decoded Bin (in red)');
xlabel('Bin');
ylabel('Sum Lick');

%%%all trials%%%
mat = horzcat(data(:,10), data(:,4), data(:,8), data(:,num_col));
trials_unik = unique(mat(:,1));
number_trials = length(trials_unik);
num_figures = ceil(number_trials/8);
extraj = number_trials:-8:1


for j = number_trials:-8:1
    ind = find(extraj==j);
    h(1 + ind) = figure
    hold on;
    if j - 8 >= 0
        for i = j:-1:j-7
            trial_num = trials_unik(i);
            this_trial = mat(mat(:,1)==trial_num,:);
            sum_lick_per_bin_trial = sum_lick_per_bin(this_trial(:,2), this_trial(:,3));
            sum_lick_per_decbin_trial = sum_lick_per_bin(this_trial(:,2), this_trial(:,4));
            ind_i = j:-1:j-7;
            subplot_ind = find(ind_i == i);
            subplot(2,4,subplot_ind)
            %hold on;
            %plot(sum_lick_per_bin_trial, 'g'); hold on;  plot(sum_lick_per_decbin_trial,'r');
            %scatter(sum_lick_per_bin_trial, unique(this_trial(:,3))); hold on;  scatter(sum_lick_per_decbin_trial, unique(this_trial(:,4)))
            scatter(unique(this_trial(:,3)), sum_lick_per_bin_trial); hold on;  scatter(unique(this_trial(:,4)), sum_lick_per_decbin_trial)
            line(unique(this_trial(:,3)), sum_lick_per_bin_trial)
            line(unique(this_trial(:,4)), sum_lick_per_decbin_trial, 'Color', [1 0 0])
            ylim([0 20])
            %plot(sum_lick_per_bin_trial, 'b');
            hold off;
            title(['Trial ' num2str(trial_num) ' Real blue Decoded red']);
            xlabel('Bin');
            ylabel('Sum Lick Per Bin');
        end
    elseif j - 8 < 0
        for i = j:-1:1
            trial_num = trials_unik(i);
            this_trial = mat(mat(:,1)==trial_num,:);
            sum_lick_per_bin_trial = sum_lick_per_bin(this_trial(:,2), this_trial(:,3))
            sum_lick_per_decbin_trial = sum_lick_per_bin(this_trial(:,2), this_trial(:,4));
            ind_i = j:-1:j-7;
            subplot_ind = find(ind_i == i);
            subplot(2,4,subplot_ind)
            %hold on;
            %plot(sum_lick_per_bin_trial, 'g'); hold on; plot(sum_lick_per_decbin_trial,'r');
            %scatter(sum_lick_per_bin_trial, unique(this_trial(:,3))); hold on;  scatter(sum_lick_per_decbin_trial,unique(this_trial(:,4)))
            scatter(unique(this_trial(:,3)), sum_lick_per_bin_trial); hold on;  scatter(unique(this_trial(:,4)), sum_lick_per_decbin_trial)
            line(unique(this_trial(:,3)), sum_lick_per_bin_trial)
            line(unique(this_trial(:,4)), sum_lick_per_decbin_trial, 'Color', [1 0 0])
            ylim([0 20])
            hold off;
            title(['Trial ' num2str(trial_num) ' Real blue Decoded red']);
            xlabel('Bin');
            ylabel('Sum Lick Per Bin');
        end
    end
end
savefig(h, '/Users/virginiadevi-chou/Desktop/lick_trial.fig')
end


