function [closed_spectra, open_spectra, F] = Psych375_Winter2018_ComputeSpectra(path, sub)

%%
rawdata = importfile_lsl([path sub '_mac_muse_lsl_baseline.csv']);
period = median(diff(rawdata(:,1)));
srate = 1/period;
timepoints = period:period:length(rawdata)*period;
timepointm = timepoints/60;

%% subtract the mean

data = rawdata(:,2:5)';
mean_data = mean(data,2);

data(1,:) = data(1,:) / mean_data(1);
data(2,:) = data(2,:) / mean_data(2);
data(3,:) = data(3,:) / mean_data(3);
data(4,:) = data(4,:) / mean_data(4);

%% plot EEG

% figure; subplot(3,1,1); plot(timepoints,data);
% axis tight


%% wavelet

F = 1:.5:30;
wavenum = 10;
[B1] = log(BOSC_tf(data(1,:),F,srate,wavenum));
[B4] = log(BOSC_tf(data(4,:),F,srate,wavenum));

%% plot spectrogram

% subplot(3,1,2);
%     imagesc(timepointm,F,B1);
%         set(gca,'Ydir','normal');
%         xlabel('Time (min)');
%         ylabel('Frequency (Hz)');
%         colormap(hot)
% 
% subplot(3,1,3);
%      imagesc(timepointm,F,B4);
%         set(gca,'Ydir','normal');
%         xlabel('Time (min)');
%         ylabel('Frequency (Hz)');   

        
%% Find markers
% 11 and 12 = eyes open 1st and 2nd block
% 21 and 22 = eyes closed 1st and 2nd block
% 1 and 2 = eyes open 1st or eyes closed 1st


mrk_ids = find(rawdata(:,7)>0);
mrk_vals = rawdata(rawdata(:,7)>0,7);
block_length = 90; %seconds
block_length_ids = round(block_length/period);


closed_win_1 = [mrk_ids(mrk_vals == 21) mrk_ids(mrk_vals == 21) + block_length_ids];
open_win_1 =   [mrk_ids(mrk_vals == 11) mrk_ids(mrk_vals == 11) + block_length_ids];
closed_win_2 = [mrk_ids(mrk_vals == 22) mrk_ids(mrk_vals == 22) + block_length_ids];
open_win_2 =   [mrk_ids(mrk_vals == 12) mrk_ids(mrk_vals == 12) + block_length_ids];



     
     
%% Spectra

%first blocks
closed_spectra_1_B1 = mean(B1(:,closed_win_1(1):closed_win_1(2)),2);
closed_spectra_1_B4 = mean(B4(:,closed_win_1(1):closed_win_1(2)),2);
open_spectra_1_B1 = mean(B1(:,open_win_1(1):open_win_1(2)),2);
open_spectra_1_B4 = mean(B4(:,open_win_1(1):open_win_1(2)),2);
%second blocks
closed_spectra_2_B1 = mean(B1(:,closed_win_2(1):closed_win_2(2)),2);
closed_spectra_2_B4 = mean(B4(:,closed_win_2(1):closed_win_2(2)),2);
open_spectra_2_B1 = mean(B1(:,open_win_2(1):open_win_2(2)),2);
open_spectra_2_B4 = mean(B4(:,open_win_2(1):open_win_2(2)),2);

%%Average Spectra

closed_spectras = [closed_spectra_1_B1,closed_spectra_1_B4,closed_spectra_2_B1,closed_spectra_2_B4];
closed_spectra = mean(closed_spectras,2);
open_spectras = [open_spectra_1_B1,open_spectra_1_B4,open_spectra_2_B1,open_spectra_2_B4];
open_spectra = mean(open_spectras,2);



%% plot spectra
figure; 
    plot(F,closed_spectra,F,open_spectra);
    legend('closed','open');
    ylabel('Power (uV^2)');
    xlabel('Frequency (Hz)');
    title(num2str(sub));

    
    
 
