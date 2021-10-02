*******************************************************************************
* South Sudan Pilot Household Survey
* Sean Kelly
* May 28, 2021
*******************************************************************************
* File uses: mesp_household_baseline_survey_combined_hh_flag_dqc_23May_15June.dta
* File saves: 
* This file takes examines administration times of the questionnaire
********************************************************************************

*Create file paths
local inpath "W:\Shared\Projects\6073.04 SSD MESP\Tech\Deliverables\Household Survey\Baseline\data\02_flag\"
local outpath1 "W:\Shared\Projects\6073.04 SSD MESP\Tech\Deliverables\Household Survey\Baseline\results\excel\"
local outpath2 "W:\Shared\Projects\6073.04 SSD MESP\Tech\Deliverables\Household Survey\Baseline\results\histograms\"
local outpath3 "W:\Shared\Projects\6073.04 SSD MESP\Tech\Deliverables\Household Survey\Baseline\results\boxplots\"

use "`inpath'mesp_household_baseline_survey_combined_hh_flag_dqc_23May_15June.dta", replace

drop if county=="."

**********************
* Summary Statistics *
**********************
putexcel set "`outpath1'county_admin_times.xlsx", sheet("Summary") replace
putexcel A1 = ("County") B1=("Observations") C1=("Mean") D1=("Median") E1=("Std. Dev.") F1=("Min. Val.") G1=("Max. Val.")
putexcel A2 = ("Akobo")
putexcel A3 = ("Budi")
putexcel A4 = ("Duk")
putexcel A5 = ("Leer")
putexcel A6 = ("Pibor")
putexcel A7 = ("Uror")
putexcel A8 = ("Total")

estpost tabstat survey_minutes2, by(county) s(n mean median sd min max)
matrix A = e(count)'
putexcel B2 = matrix(A)
matrix B = e(mean)'
putexcel C2 = matrix(B)
matrix C = e(p50)'
putexcel D2 = matrix(C)
matrix D = e(sd)'
putexcel E2 = matrix(D)
matrix E = e(min)'
putexcel F2 = matrix(E)
matrix F = e(max)'
putexcel G2 = matrix(F)


gen outlier = 0
replace outlier = 1 if county=="Akobo" & survey_minutes2<48.03223-(3*20.85648) | survey_minutes2>48.03223+(3*20.85648)
replace outlier = 1 if county=="Budi" & survey_minutes2<36.4635-(3*10.81471) | survey_minutes2>36.4635+(3*10.81471)
replace outlier = 1 if county=="Duk" & survey_minutes2<55.33502-(3*24.93511) | survey_minutes2>55.33502+(3*24.93511)
replace outlier = 1 if county=="Leer" & survey_minutes2<51.65586-(3*24.93511) | survey_minutes2>51.65586+(3*24.93511)
replace outlier = 1 if county=="Pibor" & survey_minutes2<34.10109-(3*15.91399) | survey_minutes2>34.10109+(3*15.91399)
replace outlier = 1 if county=="Uror" & survey_minutes2<40.00229-(3*19.13464) | survey_minutes2>40.00229+(3*19.13464)

local brisco Akobo Budi Duk Leer Pibor Uror
foreach bcjr of local brisco {
putexcel set "`outpath1'county_admin_times.xlsx", sheet("`bcjr'_outliers") modify 
putexcel A1=("Outlier Times") B1=("Observations") C1=("Percent") D1=("Cumulative Percent")
levelsof survey_minutes2 if outlier==1 & county=="`bcjr'", local(`bcjr'_outs)
local row=2
foreach itm of local `bcjr'_outs {
putexcel A`row' = `itm'
local ++row
}

estpost tab survey_minutes2 if outlier==1 & county=="`bcjr'"
matrix A = e(b)'
putexcel B2 = matrix(A)

matrix B = e(pct)'
putexcel C2 = matrix(B)

matrix C = e(cumpct)'
putexcel D2 = matrix(C)

}
*

**************
* Histograms *
**************

foreach bcjr of local brisco {
histogram survey_minutes2 if county=="`bcjr'", start(0) width(10) percent fcolor(none) bcolor(midblue) title("Admin Times in `bcjr' County")
graph save "`outpath2'\`bcjr'_admin_times.gph", replace
graph export "`outpath2'\`bcjr'_admin_times.png", replace 
}
*

graph combine "`outpath2'Akobo_admin_times" "`outpath2'Budi_admin_times" "`outpath2'Duk_admin_times" "`outpath2'Leer_admin_times" "`outpath2'Pibor_admin_times" "`outpath2'Uror_admin_times", xcommon
graph export "`outpath2'combined_admin_times.png", replace 

graph hbox survey_minutes2, over(county)
graph save "`outpath3'\combine_box_admin_times.gph", replace
graph export "`outpath3'\combine_box_admin_times.png", replace 
