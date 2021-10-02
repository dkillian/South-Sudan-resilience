*******************************************************************************
* South Sudan Baseline Household Survey
* Sean Kelly
* September 3, 2021
* File uses: mesp_household_baseline_hh_survey_weighted.dta
* mesp_household_pilot_survey_hh_schedule_clean.dta
* File saves: mesp_household_baseline_hh_survey_indicators_weighted.xlsx
* This file runs unweighted indicator analysis of HH survey data
*******************************************************************************

* Datasets of interest and variables within each file - macro names match filename infixes *
local inpath "W:\Shared\Projects\6073.04 SSD MESP\Tech\Deliverables\Household Survey\Baseline\data\05_sample_weights\"
*local inpath2 "W:\Shared\Projects\6073.04 SSD MESP\Tech\Deliverables\Household Survey\Baseline\data\03_clean\" 
local outpath "W:\Shared\Projects\6073.04 SSD MESP\Tech\Deliverables\Household Survey\Baseline\results\excel\"

use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear

local bvars q_504 grp_participate trauma q_601 q_812_bin q_802_bin q_803_bin q_814_bin q_829_bin q_830_bin q_831_bin q_832_bin q_824_bin q_825_bin q_827_bin ews_participate

local ovars q_706 q_603_clean q_612 q_513 q_510 q_519 q_606 q_520

local ivars aspirations_index hdds bonding_capital_score bridging_capital_score fies_raw arssi social_capital_score resil_c

local inravars q_402_a_quart q_402_b_quart q_402_c_quart q_402_d_quart q_402_e_quart q_402_f_quart q_402_g_quart q_402_h_quart q_402_i_quart q_402_j_quart q_402_k_quart q_402_l_quart q_402_m_quart q_402_n_quart q_402_o_quart q_402_p_quart q_402_q_quart q_402_r_quart q_402_s_quart q_402_t_quart q_402_u_quart

local brisco Akobo Budi Duk Leer Pibor Uror

*Vax var q_315 --> part of HH schedule dataset

*********************
* Binary Indicators *
*********************

*Overall
foreach survey in bvars  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_bin_overall.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear


			foreach var in ``survey''{
			qui levelsof `var', local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui svy: proportion `var'
			if _rc!=2000 {
			matrix pctmatrix= e(b)	
			local k=colsof(pctmatrix)
			forvalues j=1/`k' { /* J = Position in matrix of k choice variables */
				local choice=choicevector[1,`j']
				local freqpct=(pctmatrix[1,`j'])
				qui summ `var' if `var'==`choice'
				local n=r(N)
				* Label Nomenclature: varname_value_calculation_grade
				file write myfile _newline  "`var'_`choice'_freqpct,`freqpct'"
				file write myfile _newline  "`var'_`choice'_n,`n'"
				}
				}
			}
						
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_bin_overall.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_b_overall") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_bin_overall.csv"
	di "Complete!"
}
*

*By County
foreach bcj of local brisco {
foreach survey in bvars  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_bin_county.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear


			foreach var in ``survey''{
			qui levelsof `var' if county=="`bcj'", local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui svy: proportion `var' if county=="`bcj'"
			if _rc!=2000 {
			matrix pctmatrix= e(b)	
			local k=colsof(pctmatrix)
			forvalues j=1/`k' { /* J = Position in matrix of k choice variables */
				local choice=choicevector[1,`j']
				local freqpct=(pctmatrix[1,`j'])
				qui summ `var' if `var'==`choice' & county=="`bcj'"
				local n=r(N)
				* Label Nomenclature: varname_value_calculation_grade
				file write myfile _newline  "`var'_`choice'_`bcj'_freqpct,`freqpct'"
				file write myfile _newline  "`var'_`choice'_`bcj'_n,`n'"
				}
				}
			}
			}
			
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_bin_county.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_b_county_`bcj'") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_bin_county.csv"
	di "Complete!"
}
*

*Urban/Rural
foreach survey in bvars  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_bin_location.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear

			foreach ur in 1 2 {
			foreach var in ``survey''{
			qui levelsof `var' if q_206==`ur', local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui svy: proportion `var' if q_206==`ur'
			if _rc!=2000 {
			matrix pctmatrix= e(b)	
			local k=colsof(pctmatrix)
			forvalues j=1/`k' { /* J = Position in matrix of k choice variables */
				local choice=choicevector[1,`j']
				local freqpct=(pctmatrix[1,`j'])
				qui summ `var' if `var'==`choice' & q_206==`ur'
				local n=r(N)
				* Label Nomenclature: varname_value_calculation_grade
				file write myfile _newline  "`var'_`choice'_`ur'_freqpct,`freqpct'"
				file write myfile _newline  "`var'_`choice'_`ur'_n,`n'"
				}
				}
			}
			}	
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_bin_location.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_bin_location") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_bin_location.csv"
	di "Complete!"
}
* 

*Male/Female Respondent
foreach survey in bvars  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_bin_sex.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear

			foreach sx in 1 2 {
			foreach var in ``survey''{
			qui levelsof `var' if q_302==`sx', local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui svy: proportion `var' if q_302==`sx'
			if _rc!=2000 {
			matrix pctmatrix= e(b)	
			local k=colsof(pctmatrix)
			forvalues j=1/`k' { /* J = Position in matrix of k choice variables */
				local choice=choicevector[1,`j']
				local freqpct=(pctmatrix[1,`j'])
				qui summ `var' if `var'==`choice' & q_302==`sx'
				local n=r(N)
				* Label Nomenclature: varname_value_calculation_grade
				file write myfile _newline  "`var'_`choice'_`sx'_freqpct,`freqpct'"
				file write myfile _newline  "`var'_`choice'_`sx'_n,`n'"
				}
				}
			}
			}	
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_bin_sex.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_bin_sex") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_bin_sex.csv"
	di "Complete!"
}
* 

**********************
* Ordinal Indicators *
**********************
use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear

local bvars q_504 grp_participate trauma q_601 q_812_bin q_802_bin q_803_bin q_814_bin q_829_bin q_830_bin q_831_bin q_832_bin q_824_bin q_825_bin q_827_bin ews_participate

local ovars q_706 q_603_clean q_612 q_513 q_510 q_519 q_606 q_520

local ivars aspirations_index hdds bonding_capital_score bridging_capital_score fies_raw arssi social_capital_score resil_c

local inravars q_402_a_quart q_402_b_quart q_402_c_quart q_402_d_quart q_402_e_quart q_402_f_quart q_402_g_quart q_402_h_quart q_402_i_quart q_402_j_quart q_402_k_quart q_402_l_quart q_402_m_quart q_402_n_quart q_402_o_quart q_402_p_quart q_402_q_quart q_402_r_quart q_402_s_quart q_402_t_quart q_402_u_quart

local brisco Akobo Budi Duk Leer Pibor Uror

				

*Overall
foreach survey in ovars  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_ord_overall.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear


			foreach var in ``survey''{
			qui levelsof `var', local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui svy: proportion `var'
			if _rc!=2000 {
			matrix pctmatrix= e(b)	
			local k=colsof(pctmatrix)
			forvalues j=1/`k' { /* J = Position in matrix of k choice variables */
				local choice=choicevector[1,`j']
				local freqpct=(pctmatrix[1,`j'])
				qui summ `var' if `var'==`choice'
				local n=r(N)
				* Label Nomenclature: varname_value_calculation_grade
				file write myfile _newline  "`var'_`choice'_freqpct,`freqpct'"
				file write myfile _newline  "`var'_`choice'_n,`n'"
				}
				}
			}
						
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_ord_overall.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_o_overall") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_ord_overall.csv"
	di "Complete!"
}
*

*Overall - Median
foreach survey in ovars  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_ord_med_overall.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear

			foreach var in ``survey''{
			qui estpost tabstat `var', s(median)
			matrix A = e(p50)
			local median = (A[1,1])
			* Label Nomenclature: varname_value_calculation_grade
			file write myfile _newline  "`var'_median,`median'"
			}
						
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_ord_med_overall.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_o_med_overall") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_ord_med_overall.csv"
	di "Complete!"
}
*

*By County
foreach bcj of local brisco {
foreach survey in ovars  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_ord_county.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear


			foreach var in ``survey''{
			qui levelsof `var' if county=="`bcj'", local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui svy: proportion `var' if county=="`bcj'"
			if _rc!=2000 {
			matrix pctmatrix= e(b)	
			local k=colsof(pctmatrix)
			forvalues j=1/`k' { /* J = Position in matrix of k choice variables */
				local choice=choicevector[1,`j']
				local freqpct=(pctmatrix[1,`j'])
				qui summ `var' if `var'==`choice' & county=="`bcj'"
				local n=r(N)
				* Label Nomenclature: varname_value_calculation_grade
				file write myfile _newline  "`var'_`choice'_`bcj'_freqpct,`freqpct'"
				file write myfile _newline  "`var'_`choice'_`bcj'_n,`n'"
				}
				}
			}
			}
			
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_ord_county.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_o_county_`bcj'") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_ord_county.csv"
	di "Complete!"
}
*

*By County - Median
foreach bcj of local brisco {
foreach survey in ovars  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_ord_med_county.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear


			foreach var in ``survey''{
			qui estpost tabstat `var' if county=="`bcj'", s(median)
			matrix A = e(p50)
			local median = (A[1,1])
			* Label Nomenclature: varname_value_calculation_grade
			file write myfile _newline  "`var'_`bcj'_median,`median'"
			}
			}
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_ord_med_county.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_o_med_county_`bcj'") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_ord_med_county.csv"
	di "Complete!"
}
*

*Urban/Rural
foreach survey in ovars  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_ord_location.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear

			foreach ur in 1 2 {
			foreach var in ``survey''{
			qui levelsof `var' if q_206==`ur', local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui svy: proportion `var' if q_206==`ur'
			if _rc!=2000 {
			matrix pctmatrix= e(b)	
			local k=colsof(pctmatrix)
			forvalues j=1/`k' { /* J = Position in matrix of k choice variables */
				local choice=choicevector[1,`j']
				local freqpct=(pctmatrix[1,`j'])
				qui summ `var' if `var'==`choice' & q_206==`ur'
				local n=r(N)
				* Label Nomenclature: varname_value_calculation_grade
				file write myfile _newline  "`var'_`choice'_`ur'_freqpct,`freqpct'"
				file write myfile _newline  "`var'_`choice'_`ur'_n,`n'"
				}
				}
			}
			}	
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_ord_location.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_ord_location") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_ord_location.csv"
	di "Complete!"
}
* 

*Urban/Rural - Median
foreach survey in ovars  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_ord_med_location.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear

			foreach ur in 1 2 {
			foreach var in ``survey''{
			qui estpost tabstat `var' if q_206==`ur', s(median)
			matrix A = e(p50)
			local median = (A[1,1])
			* Label Nomenclature: varname_value_calculation_grade
			file write myfile _newline  "`var'_`ur'_median,`median'"
			}
			}
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_ord_med_location.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_ord_med_location") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_ord_med_location.csv"
	di "Complete!"
}
* 

*Male/Female Respondent
foreach survey in ovars  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_ord_sex.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear

			foreach sx in 1 2 {
			foreach var in ``survey''{
			qui levelsof `var' if q_302==`sx', local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui svy: proportion `var' if q_302==`sx'
			if _rc!=2000 {
			matrix pctmatrix= e(b)	
			local k=colsof(pctmatrix)
			forvalues j=1/`k' { /* J = Position in matrix of k choice variables */
				local choice=choicevector[1,`j']
				local freqpct=(pctmatrix[1,`j'])
				qui summ `var' if `var'==`choice' & q_302==`sx'
				local n=r(N)
				* Label Nomenclature: varname_value_calculation_grade
				file write myfile _newline  "`var'_`choice'_`sx'_freqpct,`freqpct'"
				file write myfile _newline  "`var'_`choice'_`sx'_n,`n'"
				}
				}
			}
			}	
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_ord_sex.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_ord_sex") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_ord_sex.csv"
	di "Complete!"
}
* 


*Male/Female Respondent
foreach survey in ovars  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_ord_med_sex.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear

			foreach sx in 1 2 {
			foreach var in ``survey''{
			qui estpost tabstat `var' if q_302==`sx', s(median)
			matrix A = e(p50)
			local median = (A[1,1])
			* Label Nomenclature: varname_value_calculation_grade
			file write myfile _newline  "`var'_`sx'_median,`median'"
			}
			}
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_ord_med_sex.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_ord_med_sex") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_ord_med_sex.csv"
	di "Complete!"
}
* 

***********************
* Interval Indicators *
***********************

use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear

local bvars q_504 grp_participate trauma q_601 q_812_bin q_802_bin q_803_bin q_814_bin q_829_bin q_830_bin q_831_bin q_832_bin q_824_bin q_825_bin q_827_bin ews_participate

local ovars q_706 q_603_clean q_612 q_513 q_510 q_519 q_606 q_520

local ivars aspirations_index hdds bonding_capital_score bridging_capital_score fies_raw arssi social_capital_score resil_c

local inravars q_402_a_quart q_402_b_quart q_402_c_quart q_402_d_quart q_402_e_quart q_402_f_quart q_402_g_quart q_402_h_quart q_402_i_quart q_402_j_quart q_402_k_quart q_402_l_quart q_402_m_quart q_402_n_quart q_402_o_quart q_402_p_quart q_402_q_quart q_402_r_quart q_402_s_quart q_402_t_quart q_402_u_quart

local brisco Akobo Budi Duk Leer Pibor Uror

*Overall
foreach survey in ivars  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_int_overall.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear


			foreach var in ``survey''{
			svy: mean `var'
			matrix A= e(b)	
			local mean=(A[1,1])
			* Label Nomenclature: varname_value_calculation_grade
			file write myfile _newline  "`var'_mean,`mean'"
				}
				
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_int_overall.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_i_overall") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_int_overall.csv"
	di "Complete!"
}
*

*By County
foreach bcj of local brisco {
foreach survey in ivars  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_int_county.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear

			foreach var in ``survey''{
			qui svy: mean `var' if county=="`bcj'"
			matrix A= e(b)	
			local mean=(A[1,1])
			* Label Nomenclature: varname_value_calculation_grade
			file write myfile _newline  "`var'_`bcj'_mean,`mean'"
				}
				}
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_int_county.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_i_county_`bcj'") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_int_county.csv"
	di "Complete!"
}
*

*Urban/Rural
foreach survey in ivars  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_int_location.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear

			foreach ur in 1 2 {
			foreach var in ``survey''{
			qui svy: mean `var' if q_206==`ur'
			matrix A= e(b)	
			local mean=(A[1,1])
			* Label Nomenclature: varname_value_calculation_grade
			file write myfile _newline  "`var'_`ur'_mean,`mean'"
				}
				}
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_int_location.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_int_location") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_int_location.csv"
	di "Complete!"
}
* 

*Male/Female Respondent
foreach survey in ivars  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_int_sex.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear

			foreach sx in 1 2 {
			foreach var in ``survey''{
			qui svy: mean `var' if q_302==`sx'
			matrix A= e(b)	
			local mean=(A[1,1])
			* Label Nomenclature: varname_value_calculation_grade
			file write myfile _newline  "`var'_`sx'_mean,`mean'"
				}
				}
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_int_sex.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_int_sex") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_int_sex.csv"
	di "Complete!"
}
* 


use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear

local bvars q_504 grp_participate trauma q_601 q_812_bin q_802_bin q_803_bin q_814_bin q_829_bin q_830_bin q_831_bin q_832_bin q_824_bin q_825_bin q_827_bin ews_participate

local ovars q_706 q_603_clean q_612 q_513 q_510 q_519 q_606 q_520

local ivars aspirations_index hdds bonding_capital_score bridging_capital_score fies_raw arssi social_capital_score resil_c

local inravars q_402_a_quart q_402_b_quart q_402_c_quart q_402_d_quart q_402_e_quart q_402_f_quart q_402_g_quart q_402_h_quart q_402_i_quart q_402_j_quart q_402_k_quart q_402_l_quart q_402_m_quart q_402_n_quart q_402_o_quart q_402_p_quart q_402_q_quart q_402_r_quart q_402_s_quart q_402_t_quart q_402_u_quart

local brisco Akobo Budi Duk Leer Pibor Uror

*Vax var q_315 --> part of HH schedule dataset

*************************
* Income Rank Variables *
*************************

*Overall
foreach survey in inravars  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_inra_overall.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear


			foreach var in ``survey''{
			qui levelsof `var', local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui svy: proportion `var'
			if _rc!=2000 {
			matrix pctmatrix= e(b)	
			local k=colsof(pctmatrix)
			forvalues j=1/`k' { /* J = Position in matrix of k choice variables */
				local choice=choicevector[1,`j']
				local freqpct=(pctmatrix[1,`j'])
				qui summ `var' if `var'==`choice'
				local n=r(N)
				* Label Nomenclature: varname_value_calculation_grade
				file write myfile _newline  "`var'_`choice'_freqpct,`freqpct'"
				file write myfile _newline  "`var'_`choice'_n,`n'"
				}
				}
			}
						
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_inra_overall.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_inra_overall") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_inra_overall.csv"
	di "Complete!"
}
*

*By County
foreach bcj of local brisco {
foreach survey in inravars  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_inra_county.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear


			foreach var in ``survey''{
			qui levelsof `var' if county=="`bcj'", local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui svy: proportion `var' if county=="`bcj'"
			if _rc!=2000 {
			matrix pctmatrix= e(b)	
			local k=colsof(pctmatrix)
			forvalues j=1/`k' { /* J = Position in matrix of k choice variables */
				local choice=choicevector[1,`j']
				local freqpct=(pctmatrix[1,`j'])
				qui summ `var' if `var'==`choice' & county=="`bcj'"
				local n=r(N)
				* Label Nomenclature: varname_value_calculation_grade
				file write myfile _newline  "`var'_`choice'_`bcj'_freqpct,`freqpct'"
				file write myfile _newline  "`var'_`choice'_`bcj'_n,`n'"
				}
				}
			}
			}
			
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_inra_county.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_inra_county_`bcj'") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_inra_county.csv"
	di "Complete!"
}
*

*Urban/Rural
foreach survey in inravars  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_inra_location.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear

			foreach ur in 1 2 {
			foreach var in ``survey''{
			qui levelsof `var' if q_206==`ur', local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui svy: proportion `var' if q_206==`ur'
			if _rc!=2000 {
			matrix pctmatrix= e(b)	
			local k=colsof(pctmatrix)
			forvalues j=1/`k' { /* J = Position in matrix of k choice variables */
				local choice=choicevector[1,`j']
				local freqpct=(pctmatrix[1,`j'])
				qui summ `var' if `var'==`choice' & q_206==`ur'
				local n=r(N)
				* Label Nomenclature: varname_value_calculation_grade
				file write myfile _newline  "`var'_`choice'_`ur'_freqpct,`freqpct'"
				file write myfile _newline  "`var'_`choice'_`ur'_n,`n'"
				}
				}
			}
			}	
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_inra_location.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_inra_location") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_inra_location.csv"
	di "Complete!"
}
* 

*Male/Female Respondent
foreach survey in inravars  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_inra_sex.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_weighted.dta", clear

			foreach sx in 1 2 {
			foreach var in ``survey''{
			qui levelsof `var' if q_302==`sx', local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui svy: proportion `var' if q_302==`sx'
			if _rc!=2000 {
			matrix pctmatrix= e(b)	
			local k=colsof(pctmatrix)
			forvalues j=1/`k' { /* J = Position in matrix of k choice variables */
				local choice=choicevector[1,`j']
				local freqpct=(pctmatrix[1,`j'])
				qui summ `var' if `var'==`choice' & q_302==`sx'
				local n=r(N)
				* Label Nomenclature: varname_value_calculation_grade
				file write myfile _newline  "`var'_`choice'_`sx'_freqpct,`freqpct'"
				file write myfile _newline  "`var'_`choice'_`sx'_n,`n'"
				}
				}
			}
			}	
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_inra_sex.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_inra_sex") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_inra_sex.csv"
	di "Complete!"
}
* 

************************
* Measles Vax Variable *
************************

use "`inpath'mesp_household_baseline_hh_survey_schedule_weighted.dta", clear

local bvars q_504 grp_participate trauma q_601 q_812_bin q_802_bin q_803_bin q_814_bin q_829_bin q_830_bin q_831_bin q_832_bin q_824_bin q_825_bin q_827_bin ews_participate

local ovars q_706 q_603_clean q_612 q_513 q_510 q_519 q_606 q_520

local ivars aspirations_index hdds bonding_capital_score bridging_capital_score fies_raw arssi social_capital_score resil_c

local inravars q_402_a_quart q_402_b_quart q_402_c_quart q_402_d_quart q_402_e_quart q_402_f_quart q_402_g_quart q_402_h_quart q_402_i_quart q_402_j_quart q_402_k_quart q_402_l_quart q_402_m_quart q_402_n_quart q_402_o_quart q_402_p_quart q_402_q_quart q_402_r_quart q_402_s_quart q_402_t_quart q_402_u_quart

local vax q_315

local brisco Akobo Budi Duk Leer /*Pibor*/ Uror

*Overall
foreach survey in vax  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_vax_overall.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_schedule_weighted.dta", clear


			foreach var in ``survey''{
			qui levelsof `var', local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui svy: proportion `var'
			if _rc!=2000 {
			matrix pctmatrix= e(b)	
			local k=colsof(pctmatrix)
			forvalues j=1/`k' { /* J = Position in matrix of k choice variables */
				local choice=choicevector[1,`j']
				local freqpct=(pctmatrix[1,`j'])
				qui summ `var' if `var'==`choice'
				local n=r(N)
				* Label Nomenclature: varname_value_calculation_grade
				file write myfile _newline  "`var'_`choice'_freqpct,`freqpct'"
				file write myfile _newline  "`var'_`choice'_n,`n'"
				}
				}
			}
						
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_vax_overall.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_vax_overall") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_vax_overall.csv"
	di "Complete!"
}
*

*By County
foreach bcj of local brisco {
foreach survey in vax  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_vax_county.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_schedule_weighted.dta", clear


			foreach var in ``survey''{
			qui levelsof `var' if county=="`bcj'", local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui svy: proportion `var' if county=="`bcj'"
			if _rc!=2000 {
			matrix pctmatrix= e(b)	
			local k=colsof(pctmatrix)
			forvalues j=1/`k' { /* J = Position in matrix of k choice variables */
				local choice=choicevector[1,`j']
				local freqpct=(pctmatrix[1,`j'])
				qui summ `var' if `var'==`choice' & county=="`bcj'"
				local n=r(N)
				* Label Nomenclature: varname_value_calculation_grade
				file write myfile _newline  "`var'_`choice'_`bcj'_freqpct,`freqpct'"
				file write myfile _newline  "`var'_`choice'_`bcj'_n,`n'"
				}
				}
			}
			}
			
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_vax_county.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_vax_county_`bcj'") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_vax_county.csv"
	di "Complete!"
}
*

/*Urban/Rural
foreach survey in vax  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_vax_location.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath2'mesp_household_baseline_hh_survey_schedule_weighted.dta", clear

			foreach ur in 1 2 {
			foreach var in ``survey''{
			qui levelsof `var' if q_206==`ur', local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui svy: proportion `var' if q_206==`ur'
			if _rc!=2000 {
			matrix pctmatrix= e(b)	
			local k=colsof(pctmatrix)
			forvalues j=1/`k' { /* J = Position in matrix of k choice variables */
				local choice=choicevector[1,`j']
				local freqpct=(pctmatrix[1,`j'])
				qui summ `var' if `var'==`choice' & q_206==`ur'
				local n=r(N)
				* Label Nomenclature: varname_value_calculation_grade
				file write myfile _newline  "`var'_`choice'_`ur'_freqpct,`freqpct'"
				file write myfile _newline  "`var'_`choice'_`ur'_n,`n'"
				}
				}
			}
			}	
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_vax_location.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_vax_location") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_vax_location.csv"
	di "Complete!"
}
*/

*Male/Female Respondent
foreach survey in vax  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_indicators_vax_sex.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_schedule_weighted.dta", clear

			foreach sx in 1 2 {
			foreach var in ``survey''{
			qui levelsof `var' if q_302==`sx', local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui svy: proportion `var' if q_302==`sx'
			if _rc!=2000 {
			matrix pctmatrix= e(b)	
			local k=colsof(pctmatrix)
			forvalues j=1/`k' { /* J = Position in matrix of k choice variables */
				local choice=choicevector[1,`j']
				local freqpct=(pctmatrix[1,`j'])
				qui summ `var' if `var'==`choice' & q_302==`sx'
				local n=r(N)
				* Label Nomenclature: varname_value_calculation_grade
				file write myfile _newline  "`var'_`choice'_`sx'_freqpct,`freqpct'"
				file write myfile _newline  "`var'_`choice'_`sx'_n,`n'"
				}
				}
			}
			}	
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_indicators_vax_sex.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_indicators_weighted.xlsx", sheet("inds_vax_sex") sheetmodify
	erase "`outpath'baseline_hh_survey_indicators_vax_sex.csv"
	di "Complete!"
}
* 
