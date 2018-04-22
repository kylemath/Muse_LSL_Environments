clear all
close all

pathpre = '/Volumes/Lab_Files/Data/Muse_&_Smith/375_W2018/';

folders = {'Jon','Alysha','Joanna','Daniel'};
numsubs = [15,15,8,13];
subs = {'001'; '002'; '003'; '004';'005';'006';'007';'008';'009';'010';'011';'012';'013';'014';'015'};

overall_count = 0;
for i_fold = 1:length(folders)
    path = [pathpre folders{i_fold} '/'];
    fprintf(['Current folder: ' folders{i_fold} '. \n']);
    for i_sub = 1:numsubs(i_fold)
        overall_count = overall_count +1;
        folder_list(overall_count) = i_fold;
        sub = subs{i_sub};
        fprintf(['Current subject: ' sub '. \n']);
        [closed_spectra(:,overall_count), open_spectra(:,overall_count), F] = Psych375_Winter2018_ComputeSpectra(path, sub);
    end
end
%%
figure; 
    plot(F,mean(closed_spectra,2),F,mean(open_spectra,2));
    legend('closed','open');
    ylabel('Power (uV^2)');
    xlabel('Frequency (Hz)');
    title('GrandAverage');
    
%%

    figure;
    boundedline(F,mean(closed_spectra,2),std(closed_spectra-open_spectra,[],2)/sqrt(totalsubs), 'b', ...
                F,mean(open_spectra  ,2),std(closed_spectra-open_spectra,[],2)/sqrt(totalsubs), 'r');
 
    legend('closed','open');
    ylabel('Power (uV^2)');
    xlabel('Frequency (Hz)');
    title('GrandAverage');
    axis tight
    
    
%%
totalsubs = sum(numsubs);
figure;
for i_sub = 1:totalsubs
    subplot(6,9,i_sub)
    plot(F,closed_spectra(:,i_sub),F,open_spectra(:,i_sub));
    axis off
end

