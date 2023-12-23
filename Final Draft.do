** The authors uses two seperate datasets for making the summary stats and the tables and to make the graphs. ///
We are first importing the dataset relevant for the summary stats and the tables. ///
And we will import the other dataset for the graphs later. 

** Importing the dataset for the tables, correlation and regression

clear 

use "$labor_supply_data_for_bs.dta";
** Describe (with relevant variables only) (Q. 11) ///

bys village wage: egen avg_labor=mean(labor)

describe male tinroof rooms acres married educ hh_adults hh_kids b06 b07 avg_labor wage lnwage lnavgwage lnvilwage accepted_wage avg_accepted_wage avg_vil_wage

** Summarise (Table 1: Summary Statsitics of Selected Variables) (Q. 12) ///

sum male tinroof rooms acres married educ hh_adults hh_kids b06 b07 avg_labor wage lnwage lnavgwage lnvilwage accepted_wage avg_accepted_wage avg_vil_wage

** Baseline and descriptive statstics (Table 2: Baseline Characteristics) (Q. 12) ///

tabstat male hhsize twowomen twomen educ hh_adults hh_kids tinroof rooms acres b06 b07 b08 married no_prev_work if week==2 & wage!=. & village!="", stat(mean sd n p10 p50 p90) col(stat)

** (Table 3: Correlation between Employment and Observable Characteristics (excluding Fixed Effects)) (Q. 12) ///

gen insamp = 1
replace insamp = 0 if male==. | hhsize==. | educ==. | a01==. | rooms==. | acres==. | tinroof==. | no_prev_work==. | wage==.

keep if insamp==1

egen idtag=tag(id)

reg total_labor male hhsize educ married a01 rooms acres tinroof no_prev_work  if idtag==1, cluster(village)

** (Table 4: Correlation between Employment and Observable Characteristics (including Fixed Effects)) (Q. 12) ///

xi: reg total_labor male hhsize educ married a01 rooms acres tinroof no_prev_work i.village  if idtag==1, cluster(village)

** Baseline correlation between the labor, wages and accepted wages (Table 5: Correlation between Average Labor, Wage and Accepted Wages) (Q. 12) ///

cor avg_labor wage accepted_wage

** Understanding the summary statistics of the wage and the accepted wage ///

sum wage accepted_wage

**************************************************************************************************************************************************************************************************************************************************************

** Change Datasets**

clear 

use "$collapsed.dta"

** Generating the Linear Regression estimates to calculate the elasticity (Table 6: Linear Regression of Labor against ln(wage)) (Q. 14) ///


reg vil_labor lnwage

** Generating the Linear Regression estimates with clustering by villages (Table 7: Linear Regression of Labor against ln(wage) (clustered by village)) (Q. 14) ///

reg vil_labor lnwage, cluster(village)
xi: reg vil_labor lnwage i.village, cluster(village)
xi: reg vil_labor lnwage i.week, cluster(village)
xi: reg vil_labor lnwage i.village i.week, cluster(village)



**************************************************************************************************************************************************************************************************************************************************************

** Importing the dataset relevant for making the graphs. ///

clear

use "$labor_supply_data_for_bs.dta"

bys village wage: egen avg_labor=mean(labor)

** Code for Figure 1: Fraction Working at Each Wage (Wages in MK) ///

graph twoway (lfit avg_labor wage) (scatter avg_labor wage), xlab(30(10)140) ytitle("Fraction Working") xtitle("Wages (in Kwacha)") title("Fraction Of People Working At A Given Wage") legend(off) note("Data: Replication package: Goldberg, J. (2016)") name(graph_1, replace)

** Potential code for Figure 2. Self-Reported Reasons for Working And Not Working ///

** Generating additional variables
bys wage: egen mean_work_wage=mean(work_wage) if work_accurate & wage_accurate
bys wage: egen mean_work_spend=mean(work_spend) if work_accurate & wage_accurate
bys wage: egen mean_work_save=mean(work_save) if work_accurate & wage_accurate
bys wage: egen mean_work_social=mean(work_social) if work_accurate & wage_accurate
bys wage: egen mean_nowork_wage=mean(nowork_wage) if work_accurate & wage_accurate
bys wage: egen mean_nowork_oppcost=mean(nowork_oppcost) if work_accurate & wage_accurate
bys wage: egen mean_nowork_funeral=mean(nowork_funeral) if work_accurate & wage_accurate
bys wage: egen mean_nowork_sick=mean(nowork_sick) if work_accurate & wage_accurate
bys wage: egen mean_nowork_social=mean(nowork_social) if work_accurate & wage_accurate
bys wage: egen mean_nowork_noneed=mean(nowork_noneed) if work_accurate & wage_accurate
label variable mean_work_wage "Worked"
label variable mean_nowork_wage "Did not work"


graph bar mean_work_wage mean_work_spend mean_work_save mean_work_social, over(wage) bar(2, bc("51 51 179")) bar(1, bc("119 128 128")) bar(4, bc("151 151 217")) bar(3, bc("19 28 28")) graphr(fc(white) lc(black)) legend(region(lc(white))) xsize(3.8) ysize(2) legend( label(1 "Wage") label(2 "Spend immediately") label(3 "Save") label(4 "Social pressure")) ylabel(0(0.2)1) title("Self-Reported Reasons for Working") note("Data: Replication package: Goldberg, J. (2016)") name(graph_2, replace)

graph bar mean_nowork_wage mean_nowork_oppcost mean_nowork_noneed mean_nowork_funeral mean_nowork_sick mean_nowork_social, over(wage) bar(2, bc("51 51 179")) bar(1, bc("119 128 128")) bar(4, bc("151 151 217")) bar(3, bc("19 28 28")) bar(5, bc("101 101 199")) bar(6, bc("60 80 80")) graphr(fc(white) lc(black)) legend(region(lc(white))) legend( label(1 "Wage") label(2 "Other work") label(3 "No need") label(4 "Funeral") label(5 "Illness") label(6 "Social pressure") cols(3) ) ylabel(0(0.2)1) title("Self-Reported Reasons for Not Working") note("Data: Replication package: Goldberg, J. (2016)") name(graph_3, replace)


