
%cfold = pwd;
pid = '1020';
%current_folder = strcat(cfold, '/',pid);
current_folder = pwd;
task = 'eDT_Happy';

filename_in_1 = strcat(task, '_',pid,'_AR.set');

EEG = pop_loadset('filename', filename_in_1, 'filepath', current_folder);

%% happy event list

%create EEG eventlist, run on non-pruned version
%EEG  = pop_editeventlist( EEG , 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99}, 'BoundaryString', { 'boundary' }, 'ExportEL',...
 %'elist_happyDT.txt', 'List', '/Users/abbiepopa/Documents/CARPP-BETTA_ERP/elist_advanced_lister_happy_150821.txt', 'SendEL2', 'EEG&Text', 'UpdateEEG',...
 %'on', 'Warning', 'on' );

EEG  = pop_editeventlist( EEG , 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99}, 'BoundaryString', { 'boundary' }, 'ExportEL',...
 'elist_happyDT.txt', 'List', '/Volumes/REDWOOD/Blackbird/Intern_Folder/ERP/Scripts/elist_advanced_lister_happy_150821.txt', 'SendEL2', 'EEG&Text', 'UpdateEEG',...
 'on', 'Warning', 'on' );
%% all ERPs
%extract bin based epochs
EEG = pop_epochbin( EEG , [-200.0  800.0],  'pre');

%blink rejections
EEG  = pop_artblink( EEG , 'Blinkwidth',  400, 'Channel',  34, 'Crosscov',  0.7, 'Flag', [ 1 2], 'Twindow',...
 [ -200 200] );

%stepwise rejections
EEG  = pop_artstep( EEG , 'Channel',  33, 'Flag', [ 1 3], 'Threshold',  100, 'Twindow', [ -200 200], 'Windowsize',  200, 'Windowstep',...
  50 );

EEG = pop_exporteegeventlist( EEG , 'Filename',...
 'elist_art.txt' );

%save file manually
%open ICA pruned file
%eeglab redraw


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

%% emotional ERP DT
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

%save ERPset!
%eeglab redraw


filename2 = strcat(task, '_',pid,'_ci','.erp'); 
erpname2 = strcat(task, '_', pid, '_ci');
P = pop_savemyerp(ERP, 'erpname', erpname2, 'filename', filename2, 'filepath', current_folder, 'warning', 'on');  
ALLERP = ERP;

%% plot eDT 

%plotting angry
ERP = pop_ploterps( ERP, [ 1 2 5],  35 , 'AutoYlim', 'on', 'Axsize', [ 0.05 0.08], 'BinNum', 'on', 'Blc', 'pre', 'Box', [ 1 1], 'ChLabel',...
 'on', 'FontSizeChan',  10, 'FontSizeLeg',  12, 'FontSizeTicks',  10, 'LegPos', 'bottom', 'Linespec', {'k-' , 'r-' , 'b-' }, 'LineWidth',  3,...
 'Maximize', 'on', 'Position', [ 100.476 29.6429 106.857 31.9286], 'Style', 'Classic', 'Tag', 'ERP_figure', 'Transparency',  0, 'xscale',...
 [ -200.0 798.0   -200:200:600 ], 'YDir', 'normal' );


% plot happy
ERP = pop_ploterps( ERP, [ 3 4 6],  35 , 'AutoYlim', 'on', 'Axsize', [ 0.05 0.08], 'BinNum', 'on', 'Blc', 'pre', 'Box', [ 1 1], 'ChLabel',...
 'on', 'FontSizeChan',  10, 'FontSizeLeg',  12, 'FontSizeTicks',  10, 'LegPos', 'bottom', 'Linespec', {'k-' , 'r-' , 'b-' }, 'LineWidth',  3,...
 'Maximize', 'on', 'Position', [ 100.476 29.6429 106.857 31.9286], 'Style', 'Classic', 'Tag', 'ERP_figure', 'Transparency',  0, 'xscale',...
 [ -200.0 798.0   -200:200:600 ], 'YDir', 'normal' );

pop_exporterplabfigure(ERP, 'Filepath', current_folder, 'Format', 'pdf', 'tag', {'ERP_figure'});