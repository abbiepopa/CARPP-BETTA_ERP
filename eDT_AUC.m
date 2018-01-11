%% File info

file_in = strcat(pwd, '/eDT_happy_TD_180111.txt');

%% PD

file_out = strcat(pwd, '/eDT_happy_TD_Pd_180111.txt');

ALLERP = pop_geterpvalues( file_in ,...
 [ 200 500],  [5 6],  35 , 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', file_out ,...
 'Fracreplace', 'NaN', 'InterpFactor',  1, 'Measure', 'areap', 'PeakOnset',  1, 'Resolution',  3 );


%% N2PC

file_out = strcat(pwd,'/eDT_happy_TD_N2PC_180111.txt');

ALLERP = pop_geterpvalues( file_in,...
 [ 150 450],  [5 6],  35 , 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', file_out,...
 'Fracreplace', 'NaN', 'InterpFactor',  1, 'Measure', 'arean', 'PeakOnset',  1, 'Resolution',  3 );