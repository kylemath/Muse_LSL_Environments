

prenum = '002';
postnum = '004';
block_length = 20;
F = .1:.1:30;
wavenum = 10;
path = '/Users/kyle/Dropbox/experiments/MuseLSL/Muse_LSL_Environments/Muse_LSL_Baseline/data/';

%%
[closed_pre, open_pre, F] = MuseLSL_ComputeSpectra(path,prenum,block_length,F,wavenum);
[closed_post, open_post, F] = MuseLSL_ComputeSpectra(path,postnum,block_length,F,wavenum);

%%
figure; 
    subplot(2,1,1);
    plot(F,closed_pre,'r',F,open_pre,'b',F,closed_post,'-.r',F,open_post,'-.b');
    legend('Pre-closed','Pre-open','Post-closed','Post-open');
    ylabel('Power (uV^2)');
    xlabel('Frequency (Hz)');
    title([prenum ' ' postnum]);

    subplot(2,1,2);
    plot(F,closed_pre-closed_post,'r',F,open_pre-open_post,'b');
    legend('Closed Pre-Post','Open Pre-Post');
    ylabel('Power (uV^2)');
    xlabel('Frequency (Hz)');
    title([prenum ' - ' postnum]);