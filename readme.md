# ERP Processing Pipeline for CARPP and BETTA
	
## Scripts for processing individual's files

* **ERPPrepocessing1.m**
	* To run, some manual steps are needed:
		1. Run eeglab (through matlab)
		2. Import your Brain Products files
		3. Append all sessions
		4. Run the script!
	* This script will label electrode locations, filter, and rereference your eeg data!
* **ERPPreprocessing1_rerefed_files.m**
	* This file works the same as the ERPPreprocessing1 file but is for running on participants
	where recording inadvertently rereferenced online
* **ERPPreprocessing1_32chan_no_eyes.m**
	* This file works the same as the ERPPreprocessing1 file but is for running on participants
	where recording inadvertently did not include eye channels
* **DT_pruned_to_ERP.m**
	* Requires that the DT EEG file that has had artifacts removed (But not ICA components) and the file that has had
	ICA pruning be in the present working directory.
	* Processes the file to add event list, remove trials where blinks or eye movements occluded stimulus presentation,
	average across trials, calculate contra-ipsi wavefroms and output erpset and graph
* **DT_pruned_to_ERP_no_eye_channels.m**
	* As DT_pruned_to_ERP, but for files where the eye channels inadvertently were not recorded.
* **eDT_Angry_pruned_to_ERP.m**
	* Requires that the eDT_Angry EEG file that has had artifacts removed (but not ICA components) and the file that has had
	ICA pruning be in the present working directory.
	* Processes the file to add event list, remove trials where blinks or eye movements occluded stimulus presentation,
	average across trials, calculate contra-ipsi wavefroms and output erpset and graphs for happy and angry lateral faces
* **eDT_Calm_pruned_to_ERP.m**
	* Requires that the eDT_Calm EEG file that has had artifacts removed (but not ICA components) and the file that has had
	ICA pruning be in the present working directory.
	* Processes the file to add event list, remove trials where blinks or eye movements occluded stimulus presentation,
	average across trials, calculate contra-ipsi wavefroms and output erpset and graphs for happy and angry lateral faces
* **eDT_Calm_pruned_to_ERP_no_eye_channels.m**
	* As eDT_Calm_pruned_to_ERP, but for files where the eye channels inadvertently were not recorded.
* **eDT_Happy_pruned_to_ERP.m**
	* Requires that the eDT_Happy EEG file that has had artifacts removed (but not ICA components) and the file that has had
	ICA pruning be in the present working directory.
	* Processes the file to add event list, remove trials where blinks or eye movements occluded stimulus presentation,
	average across trials, calculate contra-ipsi wavefroms and output erpset and graphs for happy and angry lateral faces
* **eDT_Happy_pruned_to_ERP_no_eye_channels.m**
	* As eDT_Happy_pruned_to_ERP, but for files where the eye channels inadvertently were not recorded.
* **GNG_pruned_to_ERP.m**
	* Requires that the GNG EEG file that has had artifacts removed (But not ICA components) and the file that has had
	ICA pruning be in the present working directory.
	* Processes the file to add event list, remove trials where blinks or eye movements occluded stimulus presentation,
	average across trials, calculate average anterior channel, and plot graphs with and without difference waves
* **GNG_pruned_to_ERP_no_eye_channels.m**
	* As GNG_pruned_to_ERP, but for files where the eye channels inadvertently were not recorded.

## Channel Lists
Necessary for some scripts to run when channels need to be adjusted or assigned
* **dummy_eye_channels.txt**
	* allows scripts to run when the participants eye channels accidentally were not recorded
* **fix_recording_refed_files.txt**
	* allows scripts to run when electrodes were accidentally re-referenced during recording

## Event Lists
These are necessary for the individual processing scripts to run
* **DT_quickanddirty_advancedelist.txt**
	* event list for DT task
* **elist_adv_GNG.txt**
	* event list for GNG task, all versions
* **elist_advanced_lister_angry_150820.txt**
	* event list for the angry eDT blocks
* **elist_advanced_lister_calm_150821.txt**
	* event list for the calm eDT blocks
* **elist_advanced_lister_happy_150820.txt**
	* event list for the happy eDT blocks

## Scripts for Generating Group Files
* **DT_AUC.m**
	* This must be run after the list of all ERPs to be included has been generated
	* Currently, this script will output negative and positive area under the curve measures for N2PC
	and Pd (respectively). The windows are 150-450 and 200-500 (respectively)
	* One file is output for N2PC and one is output for PD, TD and clinical participants are run separately
	* _Outdated!!_
* **eDT_AUC.m**
	* This must be run after the list of all ERPs to be included has been generated
	* Currently, this script will output negative and positive area under the curve measures for N2PC
	and Pd (respectively). The windows are 150-450 and 200-500 (respectively), for happy and angry distractors.
	* One file is output for N2PC and one is output for PD, TD and clinical participants are run separately
	* Each target emotion (angry, calm, happy) is also run separately
	* _Outdated!!_
* **GNG_negativeAUC.m**
	* This must be run after the list of all ERPs to be included has been generated	
	* Outputs one file with negative area under the curve from 150-450 ms for each file
	
	
## Scripts for comparing ERP Outcome measures
* **artifacts.R**
	* compares number of artifacts in each group and for each task based on a summary table
	
## Other
* **example_vhdr_load.m**
	* I made this file to show how to load a vhdr from the command line (rather than the gui)
* **hectomeetingfu_edt_alltarget.m**
	* Analyzing the eDT without regard for which emotion is expressed
* **JustPlotting.m**
	* Useful if you have an ERPset (any task) and need to plot the standard graphs


