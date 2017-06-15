%Downsample to 500 Hz
EEG = pop_resample(EEG, 500);

%Add channel location
EEG=pop_chanedit(EEG,'lookup', '/Users/abbiepopa/Documents/MATLAB/eeglab14_1_0b/plugins/dipfit2.3/standard_BESA/standard-10-5-cap385.elp');
%EEG=pop_chanedit(EEG,'lookup', '/Users/minderplab/Desktop/EEGlab/eeglab13_5_4b/plugins/dipfit2.3/standard_BESA/standard-10-5-cap385.elp');
%EEG=pop_chanedit(EEG,'lookup', 'C:\Users\MIND\Documents\MATLAB\eeglab13_4_4b\plugins\dipfit2.3\standard_BESA\standard-10-5-cap385.elp');
%EEG=pop_chanedit(EEG,'lookup', '/Users/MIND/Documents/MATLAB/eeglab13_4_4b/plugins/dipfit2.3/standard_BESA/standard-10-5-cap385.elp');
%EEG=pop_chanedit(EEG,'lookup', '/Users/cabil/Documents/MATLAB/eeglab13_4_4b/plugins/dipfit2.3/standard_BESA/standard-10-5-cap385.elp');

%Filter, High pass 0.1, Low pass 30
EEG  = pop_basicfilter( EEG,  1:32 , 'Boundary', 'boundary', 'Cutoff', [ 0.1 30], 'Design', 'butter', 'Filter', 'bandpass', 'Order',  2,...
 'RemoveDC', 'on' ); 

%Notch Filter
EEG  = pop_basicfilter( EEG,  1:32 , 'Boundary', 'boundary', 'Cutoff',  60, 'Design', 'notch', 'Filter', 'PMnotch', 'Order',  180, 'RemoveDC',...
 'on' );

EEG = pop_eegchanoperator( EEG, {  'nch1 = ch1 label Fp1',  'nch2 = ch2 label Fz',  'nch3 = ch3 label F3',  'nch4 = ch4 label F7',...
  'nch5 = ch5 label FT9',  'nch6 = ch6 label FC5',  'nch7 = ch7 label FC1',  'nch8 = ch8 label C3',  'nch9 = ch9 label T7',  'nch10 = (ch9 + ch14)/2 label TP9',...
  'nch11 = ch10 label CP5',  'nch12 = ch11 label CP1',  'nch13 = ch12 label Pz',  'nch14 = ch13 label P3',  'nch15 = ch14 label P7',...
  'nch16 = ch15 label O1',  'nch17 = ch16 label Oz',  'nch18 = ch17 label O2',  'nch19 = ch18 label P4',  'nch20 = ch19 label P8',...
  'nch21 = (ch19 + ch24)/2 label TP10',  'nch22 = ch20 label Cp6',  'nch23 = ch21 label Cp2',  'nch24 = ch22 label Cz',  'nch25 = ch23 label C4',...
  'nch26 = ch24 label T8',  'nch27 = ch25 label FT10',  'nch28 = ch26 label FC6',  'nch29 = ch27 label FC2',  'nch30 = ch28 label F4',...
  'nch31 = ch29 label F8',  'nch32 = ch30 label FP2',  'nch33 = ch31 label HEOV',  'nch34 = ch32 label VEOG'} , 'ErrorMsg', 'popup', 'Warning',...
 'on' ); % GUI: 15-Jun-2017 13:12:05

EEG=pop_chanedit(EEG,'lookup', '/Users/abbiepopa/Documents/MATLAB/eeglab14_1_0b/plugins/dipfit2.3/standard_BESA/standard-10-5-cap385.elp');

eeglab redraw
