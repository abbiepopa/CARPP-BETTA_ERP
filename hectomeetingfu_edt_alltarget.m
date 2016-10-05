%% For Angry Target ERPs
ERP = pop_binoperator( ERP, {  'BIN7 = BIN5 label Target Contra-Ipsi'});
eeglab redraw

%% For Happy Target ERPs
ERP = pop_binoperator( ERP, {  'BIN7 = BIN6 label Target Contra-Ipsi'});
eeglab redraw

%% For Calm Target ERPs
ERP = pop_binoperator( ERP, {  'BIN7 = ((BIN2 - BIN1) + (BIN4 - BIN3))/2 label Target Contra-Ipsi'});
eeglab redraw