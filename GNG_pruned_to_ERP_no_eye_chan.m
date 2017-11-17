%% GNG event list
%cfold = pwd;
pid = '1010';
%current_folder = strcat(cfold, '/',pid);
current_folder = pwd;
task = 'GNG';

filename_in_1 = strcat(task, '_',pid,'_AR.set');

EEG = pop_loadset('filename', filename_in_1, 'filepath', current_folder);

%create EEG eventlist, run on non-pruned version
EEG  = pop_editeventlist( EEG , 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99}, 'BoundaryString', { 'boundary' }, 'ExportEL',...
 'elist_GNG.txt', 'List', '/Users/abbiepopa/Documents/CARPP-BETTA_ERP/elist_adv_GNG.txt', 'SendEL2', 'EEG&Text', 'UpdateEEG', 'on', 'Warning',...
 'on' ); % GUI: 30-Aug-2016 15:46:44
%% all ERPs
%extract bin based epochs
EEG = pop_epochbin( EEG , [-200.0  800.0],  'pre');

EEG = pop_exporteegeventlist( EEG , 'Filename',...
 'elist_art.txt' );


filename0 = strcat(task, '_', pid, '_preman', '.set');
EEG = pop_saveset(EEG, 'filename', filename0, 'filepath', current_folder);

%open ICA pruned file
%eeglab redraw

%open ICA pruned file

%current_folder = pwd;
%pid = '957';
%task = 'eGNG_angry';


filename_in_2 = strcat(task, '_',pid,'_AR pruned with ICA.set');

EEG = pop_loadset('filename', filename_in_2, 'filepath', current_folder);

% import elist
EEG = pop_importeegeventlist( EEG, 'elist_art.txt' , 'ReplaceEventList',...
 'on' );

% extract bin-based epochs
EEG = pop_epochbin( EEG , [-200.0  800.0],  'pre');

%these don't seem to be working do manually after running:

%eeglab redraw

%synchronize artifact rejections
%EEG = pop_syncroartifacts(EEG, 3);
EEG = pop_syncroartifacts(EEG,'Direction', 'bidirectional')

filename0 = strcat(task, '_', pid, '_syncrej', '.set');
EEG = pop_saveset(EEG, 'filename', filename0, 'filepath', current_folder);
%%
%doesn't seem to work, do manually
%compute averaged ERPs
filename1 = strcat(task, '_',pid,'.erp'); 
erpname1 = strcat(task, '_', pid);
ERP = pop_averager( EEG , 'Criterion', 'good', 'ExcludeBoundary', 'on', 'SEM', 'on' );
ERP = pop_savemyerp(ERP, 'erpname', erpname1, 'filename', filename1, 'filepath', current_folder, 'warning', 'on');  
ALLERP = ERP;
%add dummy channels for missing eye channels
ERP = pop_erpchanoperator( ERP, {  'ch33 = ch6 - ch5 label HEOV',  'ch34 = ch5 - ch6 label VEOG'} , 'ErrorMsg', 'popup', 'KeepLocations',  0,...
 'Warning', 'on' );

%avg anterior lateral sites
ERP = pop_erpchanoperator( ERP, {  'ch35 = (ch3 + ch2 + ch30 + ch8 + ch24 + ch25 + ch14 + ch13 + ch19) / 9 label Average Anterior Sites'} ,...
 'ErrorMsg', 'popup', 'Warning', 'on' );

%generage nogo minus go ERP
ERP = pop_binoperator( ERP, {  'BIN4 = BIN1 - BIN2 label NoGo_Minus_Go'});

%eeglab redraw

%don't forget to save chop bop

filename2 = strcat(task, '_',pid,'_cb','.erp'); 
erpname2 = strcat(task, '_', pid, '_cb');
P = pop_savemyerp(ERP, 'erpname', erpname2, 'filename', filename2, 'filepath', current_folder, 'warning', 'on');  
ALLERP = ERP;
%eeglab redraw

%% Plot GNG

%difference wave
ERP = pop_ploterps( ERP,  [1 2 4],  35 , 'AutoYlim', 'on', 'Axsize', [ 0.05 0.08], 'BinNum', 'on', 'Blc', 'pre', 'Box', [ 1 1], 'ChLabel', 'on',...
 'FontSizeChan',  10, 'FontSizeLeg',  12, 'FontSizeTicks',  10, 'LegPos', 'bottom', 'Linespec', {'k-' , 'r-' , 'b-' }, 'LineWidth',  3,...
 'Maximize', 'on', 'Position', [ 100.476 25.456 106.857 31.9286], 'Style', 'Classic', 'Tag', 'ERP_figure', 'Transparency',  0, 'xscale',...
 [ -200.0 798.0   -200:200:600 ], 'YDir', 'normal' );

%no difference wave
ERP = pop_ploterps( ERP,  1:2,  35 , 'AutoYlim', 'on', 'Axsize', [ 0.05 0.08], 'BinNum', 'on', 'Blc', 'pre', 'Box', [ 1 1], 'ChLabel', 'on',...
 'FontSizeChan',  10, 'FontSizeLeg',  12, 'FontSizeTicks',  10, 'LegPos', 'bottom', 'Linespec', {'r-' , 'g-' , 'b-' }, 'LineWidth',  3,...
 'Maximize', 'on', 'Position', [ 100.476 25.456 106.857 31.9286], 'Style', 'Classic', 'Tag', 'ERP_figure', 'Transparency',  0, 'xscale',...
 [ -200.0 798.0   -200:200:600 ], 'YDir', 'normal' );
pop_exporterplabfigure(ERP, 'Filepath', current_folder, 'Format', 'pdf', 'tag', {'ERP_figure'});