%% set variable
% eeglab

pid = '847';
task = 'eDT_angry';
current_folder = pwd;

%% filter it
EEG  = pop_basicfilter( EEG,  1 , 'Boundary', 'boundary', 'Cutoff',  1, 'Design', 'butter', 'Filter', 'highpass', 'Order',  2, 'RemoveDC',...
 'on' );
EEG  = pop_basicfilter( EEG,  1 , 'Boundary', 'boundary', 'Cutoff',  60, 'Design', 'notch', 'Filter', 'PMnotch', 'Order',  180, 'RemoveDC',...
 'on' );

filename_filt = strcat(task, '_', pid, '_HR_filt_1hz.set')

EEG = pop_saveset(EEG, 'filename', filename_filt, 'filepath', current_folder);


%% it's been filtered


filename0 = strcat(task, '_', pid, '_HR_filt_1hz.set')

EEG = pop_loadset('filename', filename0, 'filepath', current_folder);
eeglab redraw
%% optional, remove continuous artifacts

EEG = pop_continuousartdet( EEG , 'ampth', [ -810 810], 'chanArray',  1, 'colorseg', [ 1 0.9765 0.5294], 'forder',  100, 'stepms',  250,...
 'winms',  500 );
eeglab redraw

%% add event codes
thresh = 350

EEG = pop_insertcodeatTTL( EEG,1, 'NewCode',  88, 'RelationalOperation', '>=', 'Threshold',  thresh );

filename1 = strcat(task, '_', pid, '_HR_inscottl.set')

EEG = pop_saveset(EEG, 'filename', filename1, 'filepath', current_folder);

eeglab redraw
%% producebeatlist

filename3 = strcat(current_folder, '/', task, '_', pid, '_beatlist.txt');

EEG  = pop_creabasiceventlist( EEG , 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99 }, 'BoundaryString', { 'boundary' }, 'Eventlist',...
 filename3 ); 

filename2 = strcat(task, '_', pid, '_HR_elist.set')

EEG = pop_saveset(EEG, 'filename', filename2, 'filepath', current_folder);
