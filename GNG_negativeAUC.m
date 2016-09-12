%generage nogo minus go ERP
ERP = pop_binoperator( ERP, {  'BIN3 = BIN1 - BIN2 label NoGo_Minus_Go'});

%% measure negative AUC
%measure negative AUC, do on all sets once subtraction has been made,
%saving here for settings not to run
ALLERP = pop_geterpvalues( ERP, [ 150 450],  3,  35 , 'Baseline', 'pre', 'FileFormat', 'wide', 'Filename', '/Users/abbiepopa/Documents/MATLAB/GNG_measure_test.txt',...
 'Fracreplace', 'NaN', 'InterpFactor',  1, 'Measure', 'arean', 'Resolution',  3 );