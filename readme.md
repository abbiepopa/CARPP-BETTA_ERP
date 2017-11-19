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