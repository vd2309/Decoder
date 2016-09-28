%Create heat map from data we feed into decoder, i.e. cleaned data
%data must be svm_all_data, NOT nb_all_data because that activity is events
%only, need auxiliary function for_heat_map

%%%%exclude trials and clean%%%%
data = exclude_trials(raw_data);
[data, binned_pos, nfbt, activity] = get_rid_of_get_nfbt_lick(data, 13);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%now must run predictions first AND have to do separately for a1 and a2

[row,col] = size(data);
ncells = length(13:col);
colorMaxAve = 0.6;
colorMax = 1.2;
%odorBin = 10;

if length(unique(data(:,11)))>1
    a1 = data(data(:,11)==1, :);
    a2 = data(data(:,11)==2, :);
    
    %%%a1%%%%%
    [row_a1, col_a1] = size(a1);
    spatial_bin_a1 = a1(:,8);
    activity_and_pos_a1 = horzcat(spatial_bin_a1, a1(:,13:col_a1));

    n_bins_a1 = unique(spatial_bin_a1);
    num_bins_a1 = length(n_bins_a1);
    a1Mean = ones(ncells, num_bins_a1);
    for j = 1:ncells
        ind = j+1;
        this_cell = horzcat(activity_and_pos_a1(:,1), activity_and_pos_a1(:,ind));
    for i = 1:length(n_bins_a1)
        this_bin = this_cell(this_cell(:,1)==n_bins_a1(i), :);
        a1Mean(j,i) = mean(this_bin(:,2));
    end
    end
    
    %%%%%%a2%%%%%%%%%
    [row_a2, col_a2] = size(a2);
    spatial_bin_a2 = a2(:,8);
    activity_and_pos_a2 = horzcat(spatial_bin_a2, a2(:,13:col_a2));

    n_bins_a2 = unique(spatial_bin_a2);
    num_bins_a2 = length(n_bins_a2);
    a2Mean = ones(ncells, num_bins_a2);
    for j = 1:ncells
        ind = j+1;
        this_cell = horzcat(activity_and_pos_a2(:,1), activity_and_pos_a2(:,ind));
    for i = 1:length(n_bins_a2)
        this_bin = this_cell(this_cell(:,1)==n_bins_a2(i), :);
        a2Mean(j,i) = mean(this_bin(:,2));
    end
    end
[~, a1MeanPeak] = max(a1Mean');
[~, a2MeanPeak] = max(a2Mean');

 %plot mean acticity of all cells for each odor, ordered by max
[~, iPlot] = sort(a1MeanPeak); %odor A sort A
a1Plot = a1Mean(iPlot, :);
a1Plot = [a1Plot ones(size(a1Plot,1),1); ones(1,size(a1Plot,2)+1)]; 

[~, iPlot] = sort(a2MeanPeak); %odor B sort B
a2Plot = a2Mean(iPlot, :);
a2Plot = [a2Plot ones(size(a2Plot,1),1); ones(1,size(a2Plot,2)+1)]; 

%figure(1)
hi(1) = figure
%odor A sort A
pcolor(a1Plot);
%colormap(lines)
caxis([0 colorMaxAve]);
hold on;
%plot([1 size(a1Plot, 1)], 'w');
%plot([1 size(a1Plot, 1)]);
plot(size(a1Plot, 1))
hold off;
title('A1');
xlabel('Bin');
ylabel('cell');


%figure(2) % odor B sort B
hi(2) = figure
pcolor(a2Plot);
%colormap(lines)
caxis([0 colorMaxAve]);
hold on;
%plot([odorBin odorBin], [1 size(a2Plot, 1)], 'w');
%plot([1 size(a2Plot, 1)]);
plot([size(a2Plot, 1)]);
hold off;
title('A2');
xlabel('Bin');
ylabel('cell');

%%%%% all a1 trials %%%%%%%%
mat = horzcat(a1(:,10), a1(:,8), a1(:,13:col_a1));
trials_unik = unique(mat(:,1));
number_trials = length(trials_unik);
bins_unik = unique(mat(:,2));
num_bins_unik = length(bins_unik);
aMean_indtrial = ones(ncells, num_bins_unik);
num_figures = ceil(number_trials/8);
%num_figures_ind = 1:num_figures;
extraj = number_trials:-8:1

%for i = 1:length(trials_unik)
for j = number_trials:-8:1
    ind = find(extraj==j);
    %figure(2 + ind);
    hi(2+ind) = figure
    hold on;
    if j - 8 >= 0
        for i = j:-1:j-7
            %disp(i)
            trial_num = trials_unik(i);
            this_trial = mat(mat(:,1)==trial_num,:);
            [row_t, col_t] = size(this_trial);
            aMean_trial = for_heat_map(this_trial);
            %aMean_trial = this_trial(:,3:col_t)';
            [~, aMeanPeak_trial] = max(aMean_trial');
            [~, iPlot] = sort(a1MeanPeak);
            aPlot_trial = aMean_trial(iPlot, :);
            aPlot_trial = [aPlot_trial ones(size(aPlot_trial,1),1); ones(1,size(aPlot_trial,2)+1)];
            ind_i = j:-1:j-7;
            subplot_ind = find(ind_i == i);
            subplot(2,4,subplot_ind)
            pcolor(aPlot_trial);
            %caxis([0 colorMax])
            caxis([0 colorMaxAve]);
            hold on;
            plot(size(aPlot_trial, 1));
            hold off;
            title([' A1 Trial ' num2str(trial_num) ' individual']);
            xlabel('Bin');
            ylabel('cell');
        end
    elseif j - 8 < 0
        for i = j:-1:1
            this_trial = mat(mat(:,1)==trials_unik(i),:);
            trial_num = trials_unik(i);
            [row_t, col_t] = size(this_trial);
            aMean_trial = for_heat_map(this_trial);
            %aMean_trial = this_trial(:,3:col_t)';
            [~, aMeanPeak_trial] = max(aMean_trial');
            [~, iPlot] = sort(a1MeanPeak);
            aPlot_trial = aMean_trial(iPlot, :);
            aPlot_trial = [aPlot_trial ones(size(aPlot_trial,1),1); ones(1,size(aPlot_trial,2)+1)];
            ind_i = j:-1:1;
            subplot_ind = find(ind_i == i);
            subplot(2,4,subplot_ind)
            pcolor(aPlot_trial);
            %caxis([0 colorMax])
            caxis([0 colorMaxAve]);
            hold on;
            plot(size(aPlot_trial, 1));
            hold off;
            title(['A1 Trial ' num2str(trial_num) ' individual']);
            xlabel('Bin');
            ylabel('cell');
        end
    end
end

%%%%% a2 %%%%trials
add_on = num_figures + 2;
mat = horzcat(a2(:,10), a2(:,8), a2(:,13:col_a1));
trials_unik = unique(mat(:,1));
number_trials = length(trials_unik);
bins_unik = unique(mat(:,2));
num_bins_unik = length(bins_unik);
aMean_indtrial = ones(ncells, num_bins_unik);
%num_figures = ceil(number_trials/8);
%num_figures_ind = 1:num_figures;
extraj = number_trials:-8:1

%for i = 1:length(trials_unik)
for j = number_trials:-8:1
    ind = find(extraj==j);
    %figure(add_on + ind);
    hi(add_on + ind) = figure
    hold on;
    if j - 8 >= 0
        for i = j:-1:j-7
            disp(i)
            trial_num = trials_unik(i);
            this_trial = mat(mat(:,1)==trial_num,:);
            [row_t, col_t] = size(this_trial);
            aMean_trial = for_heat_map(this_trial);
            %aMean_trial = this_trial(:,3:col_t)';
            [~, aMeanPeak_trial] = max(aMean_trial');
            [~, iPlot] = sort(a2MeanPeak);
            aPlot_trial = aMean_trial(iPlot, :);
     
            aPlot_trial = [aPlot_trial ones(size(aPlot_trial,1),1); ones(1,size(aPlot_trial,2)+1)];
            ind_i = j:-1:j-7;
            subplot_ind = find(ind_i == i);
            subplot(2,4,subplot_ind)
            pcolor(aPlot_trial);
            %caxis([0 colorMax])
            caxis([0 colorMaxAve]);
            hold on;
            plot(size(aPlot_trial, 1));
            hold off;
            title([' A2 Trial ' num2str(trial_num) ' individual']);
            xlabel('Bin');
            ylabel('cell');
        end
    elseif j - 8 < 0
        for i = j:-1:1
            this_trial = mat(mat(:,1)==trials_unik(i),:);
            trial_num = trials_unik(i);
            [row_t, col_t] = size(this_trial);
            aMean_trial = for_heat_map(this_trial);
            %aMean_trial = this_trial(:,3:col_t)';
            [~, aMeanPeak_trial] = max(aMean_trial');
            [~, iPlot] = sort(a2MeanPeak);
            aPlot_trial = aMean_trial(iPlot, :);
             %
            check_me = size(aPlot_trial);
            %
            disp(check_me)
            aPlot_trial = [aPlot_trial ones(size(aPlot_trial,1),1); ones(1,size(aPlot_trial,2)+1)];
            ind_i = j:-1:1;
            subplot_ind = find(ind_i == i);
            subplot(2,4,subplot_ind)
            pcolor(aPlot_trial);
            %caxis([0 colorMax])
            caxis([0 colorMaxAve]);
            hold on;
            plot(size(aPlot_trial, 1));
            hold off;
            title(['A2 Trial ' num2str(trial_num) ' individual']);
            xlabel('Bin');
            ylabel('cell');
        end
    end
    savefig(hi, '/Users/virginiadevi-chou/Desktop/trial_heatmap.fig')
end

elseif length(unique(data(:,11)))==1
    [row, col] = size(data);
    spatial_bin = data(:,8);
    activity_and_pos = horzcat(spatial_bin, data(:,13:col));

    n_bins = unique(spatial_bin);
    num_bins = length(n_bins);
    aMean = zeros(ncells, num_bins);
    for j = 1:ncells
        ind = j+1;
        this_cell = horzcat(activity_and_pos(:,1), activity_and_pos(:,ind));
    for i = 1:length(n_bins)
        this_bin = this_cell(this_cell(:,1)==n_bins(i), :);
        aMean(j,i) = mean(this_bin(:,2));
    end
    end
    
    [~, aMeanPeak] = max(aMean');
    %figure(1) %plot mean activity of all cells for each odor, ordered by max
    hi(1) = figure
    [~, iPlot] = sort(aMeanPeak); %odor A sort A
    aPlot = aMean(iPlot, :);
    aPlot = [aPlot ones(size(aPlot,1),1); ones(1,size(aPlot,2)+1)]; 
    
   %odor A sort A
    pcolor(aPlot);
    caxis([0 colorMaxAve]);
    hold on;
    plot(size(aPlot, 1));
    hold off;
    title('A');
    xlabel('Bin');
    ylabel('cell');
    
    %%%all trials%%%
mat = horzcat(data(:,10), data(:,8), data(:,13:col));
trials_unik = unique(mat(:,1));
number_trials = length(trials_unik);
bins_unik = unique(mat(:,2));
num_bins_unik = length(bins_unik);
aMean_indtrial = ones(ncells, num_bins_unik);
%num_figures = ceil(number_trials/8);
%num_figures_ind = 1:num_figures;
extraj = number_trials:-8:1

%for i = 1:length(trials_unik)
for j = number_trials:-8:1
    ind = find(extraj==j);
    %figure(1 + ind);
    hi(1 +ind) = figure
    hold on;
    if j - 8 >= 0
        for i = j:-1:j-7
            disp(i)
            trial_num = trials_unik(i);
            this_trial = mat(mat(:,1)==trial_num,:);
            [row_t, col_t] = size(this_trial);
            aMean_trial = for_heat_map(this_trial);
            %aMean_trial = this_trial(:,3:col_t)';
            [~, aMeanPeak_trial] = max(aMean_trial');
            [~, iPlot] = sort(aMeanPeak);
            aPlot_trial = aMean_trial(iPlot, :);
            aPlot_trial = [aPlot_trial ones(size(aPlot_trial,1),1); ones(1,size(aPlot_trial,2)+1)];
            ind_i = j:-1:j-7;
            subplot_ind = find(ind_i == i);
            subplot(2,4,subplot_ind)
            pcolor(aPlot_trial);
            caxis([0 colorMaxAve]);
            hold on;
            plot(size(aPlot_trial, 1));
            hold off;
            title(['Trial ' num2str(trial_num) ' individual']);
            xlabel('Bin');
            ylabel('cell');
        end
    elseif j - 8 < 0
        for i = j:-1:1
            this_trial = mat(mat(:,1)==trials_unik(i),:);
            trial_num = trials_unik(i);
            [row_t, col_t] = size(this_trial);
            aMean_trial = for_heat_map(this_trial);
            %aMean_trial = this_trial(:,3:col_t)';
            [~, aMeanPeak_trial] = max(aMean_trial');
            [~, iPlot] = sort(aMeanPeak);
            aPlot_trial = aMean_trial(iPlot, :);
            aPlot_trial = [aPlot_trial ones(size(aPlot_trial,1),1); ones(1,size(aPlot_trial,2)+1)];
            ind_i = j:-1:1;
            subplot_ind = find(ind_i == i);
            subplot(2,4,subplot_ind)
            pcolor(aPlot_trial);
            caxis([0 colorMaxAve]);
            hold on;
            plot(size(aPlot_trial, 1));
            hold off;
            title(['Trial ' num2str(trial_num) ' individual']);
            xlabel('Bin');
            ylabel('cell');
        end
    end
end
savefig(hi, '/Users/virginiadevi-chou/Desktop/trial_heatmap.fig')
end

