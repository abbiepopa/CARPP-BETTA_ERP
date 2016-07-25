%Downsample to 500 Hz
EEG = pop_resample(EEG, 500);

%Add channel location
EEG=pop_chanedit(EEG,'lookup', '/Users/abbiepopa/Documents/MATLAB/eeglab13_4_4b/plugins/dipfit2.3/standard_BESA/standard-10-5-cap385.elp');

%Filter, High pass 0.1, Low pass 30
EEG  = pop_basicfilter( EEG,  1:34 , 'Boundary', 'boundary', 'Cutoff', [ 0.1 30], 'Design', 'butter', 'Filter', 'bandpass', 'Order',  2,...
 'RemoveDC', 'on' ); 

%Notch Filter
EEG  = pop_basicfilter( EEG,  1:34 , 'Boundary', 'boundary', 'Cutoff',  60, 'Design', 'notch', 'Filter', 'PMnotch', 'Order',  180, 'RemoveDC',...
 'on' ); 