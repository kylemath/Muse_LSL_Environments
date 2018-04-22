clear all
% close all

%% load the data
sub = '010';
rawdata = importfile_lsl(['/Users/kyle/Dropbox/experiments/MuseLSL/baselineAssay/data/' sub '_mac_muse_lsl_baseline.csv']);

%% get the time information
period = median(diff(rawdata(:,1))); %first derivative of the time
srate = 1/period; %how many per second
timepoints = period:period:length(rawdata)*period; %seconds
timepointm = timepoints/60; %minutes

%% subtract the mean
% find the mean over time and subtract it from each channel

data = rawdata(:,2:5)';
mean_data = mean(data,2);

data(1,:) = data(1,:) / mean_data(1);
data(2,:) = data(2,:) / mean_data(2);
data(3,:) = data(3,:) / mean_data(3);
data(4,:) = data(4,:) / mean_data(4);

%% plot EEG
% all four channels
figure; subplot(3,1,1); plot(timepoints,data);
        xlabel('Time (sec)');
        ylabel('Voltage (uV)'); 
        title(sub);
        axis tight

%% wavelet
% estimate the oscillations in the data with a wavelet analysis 
% output is a matrix of frequencies by time (power at each frequency)

F = 1:.2:30; %output frequencies
wavenum = 10; %how many cycles of the oscillations to correlate with data
[B1] = log(BOSC_tf(data(1,:),F,srate,wavenum)); %just do the two ear channels
[B4] = log(BOSC_tf(data(4,:),F,srate,wavenum));

%% plot spectrogram

subplot(3,1,2);
    imagesc(timepointm,F,B1);
        set(gca,'Ydir','normal');
        xlabel('Time (min)');
        ylabel('Frequency (Hz)');
        colormap(hot)
        title('Left Ear');

subplot(3,1,3);
     imagesc(timepointm,F,B4);
        set(gca,'Ydir','normal');
        xlabel('Time (min)');
        ylabel('Frequency (Hz)');
        title('Right Ear');

        
%% Find markers
% 11 and 12 = eyes open 1st and 2nd block
% 21 and 22 = eyes closed 1st and 2nd block
% 1 and 2 = eyes open 1st or eyes closed 1st


mrk_ids = find(rawdata(:,7)>0); % find the indices where markers are
mrk_vals = rawdata(rawdata(:,7)>0,7); % what are the marker values
block_length = 10; % seconds, length of each eyes open/closed block
block_length_ids = round(block_length/period); % turn into sampling points

%set the time limits (in sampling points) for each chunk of data
closed_win_1 = [mrk_ids(mrk_vals == 21) mrk_ids(mrk_vals == 21) + block_length_ids];
open_win_1 =   [mrk_ids(mrk_vals == 11) mrk_ids(mrk_vals == 11) + block_length_ids];
closed_win_2 = [mrk_ids(mrk_vals == 22) mrk_ids(mrk_vals == 22) + block_length_ids];
open_win_2 =   [mrk_ids(mrk_vals == 12) mrk_ids(mrk_vals == 12) + block_length_ids];



     
     
%% Spectra
% compute the average spectra in each condition by averageing over time 
% separately for each condition (eyes open vs. eyes closed)

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

%% Average Spectra
% average over all the blocks and both electrodes 
% stack them all up and take the average at each time point

closed_spectras = [closed_spectra_1_B1,closed_spectra_1_B4,closed_spectra_2_B1,closed_spectra_2_B4];
closed_spectra = mean(closed_spectras,2);
open_spectras = [open_spectra_1_B1,open_spectra_1_B4,open_spectra_2_B1,open_spectra_2_B4];
open_spectra = mean(open_spectras,2);



%% plot spectra
% this is what you have in the spreadsheet for each participant (columns),
% for each condition (sheets)
% frequencies are in different rows

figure; 
    plot(F,closed_spectra,F,open_spectra);
    legend('closed','open');
    ylabel('Power (uV^2)');
    xlabel('Frequency (Hz)');
    title(num2str(sub));

    
    
 
