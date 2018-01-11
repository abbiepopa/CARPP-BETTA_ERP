%generage nogo minus go ERP
ERP = pop_binoperator( ERP, {  'BIN3 = BIN1 - BIN2 label NoGo_Minus_Go'});
eeglab redraw
%% measure negative AUC
file_in = strcat(pwd, '/GNG_TD_180111.txt')
file_out = strcat(pwd, '/GNG_TD_N2_180111.txt')

ALLERP = pop_geterpvalues( file_in,...
 [ 150 450],  4,  35 , 'Baseline', 'pre', 'Binlabel', 'on', 'FileFormat', 'long', 'Filename',...
 file_out, 'Fracreplace', 'NaN', 'InterpFactor',  1, 'Measure', 'arean', 'PeakOnset',...
  1, 'Resolution',  3 );