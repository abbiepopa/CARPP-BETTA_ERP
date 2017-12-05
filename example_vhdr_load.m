filepath = 'Volumes/REDWOOD/Blackbird/Big Data/CARPP/160907-/989/EEG'
filename = 'DT_Blue_Session2_989.vhdr'

EEG = pop_loadbv(filepath, filename, [], [1:34])

eeglab redraw