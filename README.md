Read Me

Overview:
This is a replication project of Goldberg. J. (2016) paper, “Kwacha Gonna Do? Experimental Evidence About Labor Supply In Rural Malawi.”
The files in this repository are:

1.	Data File:
There are two main data files: 
•	“collapsed.dta,” is contains individual level variables from the survey data and constructed variables collapsed to the village-week level, and is used for most of the analysis.  
•	“labor_supply_data_for_bs.dta”, is a legacy of a previous bootstrapping procedure over individual level data

The working directory should be set to the “replication” folder. All file paths are defined relative to the working directory. 

2.	Final Draft.do:
The do-file contains the code for all the relevant tables and graphs.  Additionally, from the first regression, we created a predictor using labor and wage data, yielding predicted labor force participation.  Elasticities at different participation levels were calculated using a new variable in line with the formula presented in the paper.
The paper also presents a counterfactual where all participants work at 140MK.  In order to confirm the counterfactual presented, the observations are restricted to only participants at 30MK and 140MK.  The resultant regression β=0.174, is line with the finding in the paper.

3.	ReadMe:
The document you are reading now.
![image](https://github.com/eesha2712/Stata-files/assets/154126381/1a578cff-c146-49bc-b41a-7f7d687a5329)
