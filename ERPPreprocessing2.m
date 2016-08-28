% extract bin-based epochs
EEG = pop_epochbin( EEG , [-200.0  800.0],  'pre');

%these don't seem to be working do manually after running:

eeglab redraw

%synchronize artifact rejections
%EEG = pop_syncroartifacts(EEG, 3);

%doesn't seem to work, do manually
%compute averaged ERPs
%ERP = pop_averager( ALLEEG , 'Criterion', 'good', 'DSindex',  4, 'ExcludeBoundary', 'on', 'SEM', 'on' );

%% ERP DT
%contra-ipsi step 1
ERP = pop_binoperator( ERP, {  'prepareContraIpsi',  'Lch = [ 1 3:5 7 6 8:10 12 11 14:16]',  'Rch = [ 32 30 31 27 29 28 25 26 21 23 22 19 20 18]',...
  'nbin1 = 0.5*bin1@Rch + 0.5*bin2@Lch label Angry Contra',  'nbin2 = 0.5*bin1@Lch + 0.5*bin2@Rch label Angry Ipsi',...
  'nbin3 = 0.5*bin3@Rch + 0.5*bin4@Lch label Happy Contra',  'nbin4 = 0.5*bin3@Lch + 0.5*bin4@Rch label Happy Ipsi',  '# For creating contra-minus-ipsi waveforms from the bins above,',...
  '# run (only) the formulas described here below in a second call',  '# of "ERP binoperator" (remove the # symbol before run them)',...
  '#bin5 = bin1 - bin2 label Angry Contra-Ipsi',  '#bin6 = bin3 - bin4 label Happy Contra-Ipsi'});

%contra-ipsi step 2
ERP = pop_binoperator( ERP, {  'bin5 = bin1 - bin2 label Angry Contra-Ipsi',  'bin6 = bin3 - bin4 label Happy Contra-Ipsi'});

%create averaged sites for DT
ERP = pop_erpchanoperator( ERP, {  'ch35 = (ch14 + ch15 + ch16)/3 label Average Occipital Parietal'} , 'ErrorMsg', 'popup', 'Warning', 'on' );

%save ERPset and EEGset!

%% plot eDT 

%plotting angry
ERP = pop_ploterps( ERP, [ 1 2 5],  35 , 'AutoYlim', 'on', 'Axsize', [ 0.05 0.08], 'BinNum', 'on', 'Blc', 'pre', 'Box', [ 6 6], 'ChLabel',...
 'on', 'FontSizeChan',  10, 'FontSizeLeg',  12, 'FontSizeTicks',  10, 'LegPos', 'bottom', 'Linespec', {'k-' , 'r-' , 'b-' }, 'LineWidth',  3,...
 'Maximize', 'on', 'Position', [ 100.476 29.6429 106.857 31.9286], 'Style', 'Classic', 'Tag', 'ERP_figure', 'Transparency',  0, 'xscale',...
 [ -200.0 798.0   -200:200:600 ], 'YDir', 'normal' );


% plot happy
ERP = pop_ploterps( ERP, [ 3 4 6],  35 , 'AutoYlim', 'on', 'Axsize', [ 0.05 0.08], 'BinNum', 'on', 'Blc', 'pre', 'Box', [ 6 6], 'ChLabel',...
 'on', 'FontSizeChan',  10, 'FontSizeLeg',  12, 'FontSizeTicks',  10, 'LegPos', 'bottom', 'Linespec', {'k-' , 'r-' , 'b-' }, 'LineWidth',  3,...
 'Maximize', 'on', 'Position', [ 100.476 29.6429 106.857 31.9286], 'Style', 'Classic', 'Tag', 'ERP_figure', 'Transparency',  0, 'xscale',...
 [ -200.0 798.0   -200:200:600 ], 'YDir', 'normal' );