%% GNG event list
current_folder = pwd;
pid = '915';
task = 'eGNG_Faces_Happy';

filename_in_1 = strcat(task, '_',pid,'_AR.set');

EEG = pop_loadset('filename', filename_in_1, 'filepath', current_folder);

%create EEG eventlist, run on non-pruned version
EEG  = pop_editeventlist( EEG , 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99}, 'BoundaryString', { 'boundary' }, 'ExportEL',...
 'elist_GNG.txt', 'List', '/Users/abbiepopa/Documents/CARPP-BETTA_ERP/elist_adv_GNG.txt', 'SendEL2', 'EEG&Text', 'UpdateEEG', 'on', 'Warning',...
 'on' ); % GUI: 30-Aug-2016 15:46:44
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


filename0 = strcat(task, '_', pid, '_preman', '.set');
EEG = pop_saveset(EEG, 'filename', filename0, 'filepath', current_folder);

%open ICA pruned file
%eeglab redraw