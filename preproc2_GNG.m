%open ICA pruned file
% import elist
EEG = pop_importeegeventlist( EEG, 'elist_art.txt' , 'ReplaceEventList',...
 'on' );

% extract bin-based epochs
EEG = pop_epochbin( EEG , [-200.0  800.0],  'pre');

%these don't seem to be working do manually after running:

eeglab redraw

%synchronize artifact rejections
%EEG = pop_syncroartifacts(EEG, 3);

%doesn't seem to work, do manually
%compute averaged ERPs
%ERP = pop_averager( ALLEEG , 'Criterion', 'good', 'DSindex',  4, 'ExcludeBoundary', 'on', 'SEM', 'on' );

%% GNG
%avg anterior lateral sites
ERP = pop_erpchanoperator( ERP, {  'ch35 = (ch3 + ch2 + ch30 + ch8 + ch24 + ch25 + ch14 + ch13 + ch19) / 9 label Average Anterior Sites'} ,...
 'ErrorMsg', 'popup', 'Warning', 'on' );

%generage nogo minus go ERP
ERP = pop_binoperator( ERP, {  'BIN3 = BIN1 - BIN2 label NoGo_Minus_Go'});

eeglab redraw

%don't forget to save chop bop

%% Plot GNG

%difference wave
ERP = pop_ploterps( ERP,  1:3,  35 , 'AutoYlim', 'on', 'Axsize', [ 0.05 0.08], 'BinNum', 'on', 'Blc', 'pre', 'Box', [ 1 1], 'ChLabel', 'on',...
 'FontSizeChan',  10, 'FontSizeLeg',  12, 'FontSizeTicks',  10, 'LegPos', 'bottom', 'Linespec', {'k-' , 'r-' , 'b-' }, 'LineWidth',  3,...
 'Maximize', 'on', 'Position', [ 100.476 25.456 106.857 31.9286], 'Style', 'Classic', 'Tag', 'ERP_figure', 'Transparency',  0, 'xscale',...
 [ -200.0 798.0   -200:200:600 ], 'YDir', 'normal' );

%no difference wave
ERP = pop_ploterps( ERP,  1:2,  35 , 'AutoYlim', 'on', 'Axsize', [ 0.05 0.08], 'BinNum', 'on', 'Blc', 'pre', 'Box', [ 1 1], 'ChLabel', 'on',...
 'FontSizeChan',  10, 'FontSizeLeg',  12, 'FontSizeTicks',  10, 'LegPos', 'bottom', 'Linespec', {'r-' , 'g-' , 'b-' }, 'LineWidth',  3,...
 'Maximize', 'on', 'Position', [ 100.476 25.456 106.857 31.9286], 'Style', 'Classic', 'Tag', 'ERP_figure', 'Transparency',  0, 'xscale',...
 [ -200.0 798.0   -200:200:600 ], 'YDir', 'normal' );
