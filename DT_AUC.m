%% File info

file_in = strcat(pwd, '/DT_TD_180111.txt');

%% N2PC
file_out = strcat(pwd, '/DT_TD_N2PC_180111.txt');

ALLERP = pop_geterpvalues( file_in, [ 150 450],  3,...
  35 , 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', file_out,...
 'Fracreplace', 'NaN', 'InterpFactor',  1, 'Measure', 'arean', 'PeakOnset',  1, 'Resolution',  3 );

%% Pd
file_out = strcat(pwd, '/DT_TD_Pd_180111.txt');

ALLERP = pop_geterpvalues( file_in, [ 200 500],  3,...
  35 , 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename', file_out,...
 'Fracreplace', 'NaN', 'InterpFactor',  1, 'Measure', 'areap', 'PeakOnset',  1, 'Resolution',  3 );
