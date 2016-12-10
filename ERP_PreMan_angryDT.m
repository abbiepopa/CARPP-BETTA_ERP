%% angry event list 

%create EEG eventlist, run on non-pruned version
EEG  = pop_editeventlist( EEG , 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99}, 'BoundaryString', { 'boundary' }, 'ExportEL',...
 'elist_angryDT.txt', 'List', '/Users/abbiepopa/Documents/ERP Analyses/elist_advanced_lister_angry_150820.txt', 'SendEL2', 'EEG&Text', 'UpdateEEG',...
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
eeglab redraw