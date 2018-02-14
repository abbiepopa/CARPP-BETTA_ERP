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

## Scripts for Generating Group Files
* **DT_AUC.m**
	* This must be run after the list of all ERPs to be included has been generated
	* Currently, this script will output negative and positive area under the curve measures for N2PC
	and Pd (respectively). The windows are 150-450 and 200-500 (respectively)
	* One file is output for N2PC and one is output for PD, TD and clinical participants are run separately
* **eDT_AUC.m**
	* This must be run after the list of all ERPs to be included has been generated
	* Currently, this script will output negative and positive area under the curve measures for N2PC
	and Pd (respectively). The windows are 150-450 and 200-500 (respectively), for happy and angry distractors.
	* One file is output for N2PC and one is output for PD, TD and clinical participants are run separately
	* Each target emotion (angry, calm, happy) is also run separately
		
## Scripts for comparing ERP Outcome measures

* **ComparativeStats_DT.R** 
	* takes as input 4 files that are output from the Matlab analysis of DT ERPS
		* Long format N2PC file for participants with 22q
		* Long format N2PC file for participants who are TD
		* Long format Pd file for participants with 22q
		* Long format Pd file for participants who are 22q
	* Analyses between and within group measures for DT only!
	* outputs three files with DT as the qualifier
		* Long format where both diagnoses are components are included
		* Wide format where both diagnoses and components are included
		* Summary sheet with means, sems, and n's for both groups
* **ComparativeStats_eDT_angry.R**
	* takes as input 4 files that are output from the Matlab analysis of eDT angry ERPS
		* Long format N2PC file for participants with 22q
		* Long format N2PC file for participants who are TD
		* Long format Pd file for participants with 22q
		* Long format Pd file for participants who are 22q
	* Analyzes between and within group measures for eDT only! Additionally note, the analyses
	are only performed for when angry is the target AND the distractor. The task irrelevant distractors
	are not analyzed.
	* outputs three files with eDT_angry as the qualifier
		* Long format where both diagnoses are components are included
		* Wide format where both diagnoses and components are included
		* Summary sheet with means, sems, and n's for both groups
* **ComparativeStats_eDT_happy.R**
	* takes as input 4 files that are output from the Matlab analysis of eDT happy ERPS
		* Long format N2PC file for participants with 22q
		* Long format N2PC file for participants who are TD
		* Long format Pd file for participants with 22q
		* Long format Pd file for participants who are 22q
	* Analyzes between and within group measures for eDT only! Additionally note, the analyses
	are only performed for when happy is the target AND the distractor. The task irrelevant distractors
	are not analyzed.
	* outputs three files with eDT_happy as the qualifier
		* Long format where both diagnoses are components are included
		* Wide format where both diagnoses and components are included
		* Summary sheet with means, sems, and n's for both groups
* **ComparativeStats_GNG_eGNG.R**
	* takes as input 6 files, all long format N2 output from Matlab, 3 emotions (including cold) and two diagnostic groups
	* Analyzes by comparing diagnostic groups and emotional condtions
	* Outputs one summary sheet for each emotion (including cold)

## Outdated Files
* Completion Checklist.xlsx
* ERPPreprocessing2.m
* ERPPre_Manual.m
* ERPProcessing.m
* DT_eDT_difference measures.R
* DT_eDT_difference_within.R
* ERP_PreMan_angryDT.m
* ERP_PreMan_calmDT.m
* ERP_PreMan_DT.m
* ERP_PreMan_GNG.m
* ERP_PreMan_happyDT.m