*******************************************************************************
* South Sudan Baseline Household Survey
* Sean Kelly
* July 30, 2021
* File uses: mesp_household_baseline_hh_survey_scored.dta
* File saves: mesp_household_baseline_hh_survey_des.xlsx
* This file runs a descriptive analysis of HH survey data
*******************************************************************************

* Datasets of interest and variables within each file - macro names match filename infixes *
local inpath "W:\Shared\Projects\6073.04 SSD MESP\Tech\Deliverables\Household Survey\Baseline\data\04_scoring\"
local outpath "W:\Shared\Projects\6073.04 SSD MESP\Tech\Deliverables\Household Survey\Baseline\results\excel\"

**********
* County *
**********

use "`inpath'mesp_household_baseline_hh_survey_scored.dta", clear

local brisco Akobo Budi Duk Leer Pibor Uror

local hhsurvey q_401_a q_401_b q_401_c q_401_d q_401_e q_401_f q_401_g q_401_h q_401_i q_401_j q_401_k q_401_l q_401_m q_401_n q_401_o q_401_p q_401_q q_401_r q_401_s q_401_t q_401_u q_402_a q_402_b q_402_c q_402_d q_402_e q_402_f q_402_g q_402_h q_402_i q_402_j q_402_k q_402_l q_402_m q_402_n q_402_o q_402_p q_402_q q_402_r q_402_s q_402_t q_402_u q_403 q_404 q_405 q_406 q_407 q_408 q_409 q_410 q_411 q_412 q_413 q_414 q_415 q_416 q_417 q_418 q_419 q_420 q_421 q_422 q_423 q_424 q_425 q_426 q_427 q_428 q_429 q_430 q_431 q_432 q_433 q_434 q_435 q_436 q_437 q_438 q_439 q_440 q_441 q_442 q_443 q_444 q_445 q_446 q_447 q_448 q_449 q_450 q_451 q_452 q_453 q_455 q_456 q_457 q_458 q_459 q_460 q_461 q_462 q_463 q_464 q_465 q_466 q_468 q_469 q_470 q_471 q_472 q_473 q_474 q_475 q_476 q_477 q_478 q_479 q_480 q_481 q_482 q_483 q_484 q_485 q_486 q_488 q_489 q_490 q_491 q_492 q_493 q_494 q_495 q_496 q_497 q_498 q_501a q_501b q_501c q_501d q_501e q_501f q_501g q_501h q_501i q_501j q_501k q_501l q_501m q_501n q_501o q_501p q_502a q_502b q_502c q_502d q_502e q_502f q_502g q_502h q_502i q_502j q_502k q_502l q_502m q_502n q_502o q_502p q_504 q_508 q_509 q_510 q_510_bin q_511 q_512_1 q_512_2 q_512_3 q_512_4 q_512_5 q_512_6 q_512_7 q_512_8 q_513 q_513_bin q_517 q_518_1 q_518_2 q_518_3 q_518_4 q_518_5 q_518_6 q_518_7 q_518_8 q_518_9 q_519 q_520 q_601 q_602_1 q_602_2 q_602_3 q_602_4 q_602_5 q_602_6 q_602_7 q_602_8 q_602_9 q_602_10 q_602_11 q_602_12 q_602_13 q_602_14 q_602_15 q_602_16 q_602_17 q_603 q_605 q_606 q_607_a q_607_b q_607_c q_607_d q_607_e q_607_f q_607_g q_607_h q_607_i q_607_j q_607_k q_608_a q_608_b q_608_c q_608_d q_608_e q_608_f q_608_g q_608_h q_608_i q_608_j q_608_k q_610 q_611 q_612 q_629 q_630 q_631 q_632 q_633 q_634 q_635 q_636 q_637 q_638 q_704 q_705_1 q_705_2 q_705_3 q_705_4 q_705_5 q_705_6 q_705_7 q_705_8 q_705_9 q_705_10 q_706 q_706_bin q_707 q_708 q_711 q_715 q_719 q_723 q_727 q_731 q_801 q_802 q_802_bin q_803 q_803_bin q_812 q_812_bin q_813 q_814 q_814_bin q_818 q_820 q_821 q_822 q_823 q_824 q_824_bin q_825 q_825_bin q_827 q_827_bin q_829 q_829_bin q_830_new q_831_new q_832_new

*Overall
foreach survey in hhsurvey  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_desc_overall.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_scored.dta", clear


			foreach var in ``survey''{
			qui levelsof `var', local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui proportion `var'
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
	qui insheet using "`outpath'baseline_hh_survey_desc_overall.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_des.xlsx", sheet("overall") sheetmodify
	erase "`outpath'baseline_hh_survey_desc_overall.csv"
	di "Complete!"
}
*

*By County
foreach bcj of local brisco {
foreach survey in hhsurvey  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_desc_county.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_scored.dta", clear


			foreach var in ``survey''{
			qui levelsof `var' if county=="`bcj'", local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui proportion `var' if county=="`bcj'"
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
	qui insheet using "`outpath'baseline_hh_survey_desc_county.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_des.xlsx", sheet("county_`bcj'") sheetmodify
	erase "`outpath'baseline_hh_survey_desc_county.csv"
	di "Complete!"
}
*

*****************
* Urban / Rural *
*****************

use "`inpath'mesp_household_baseline_hh_survey_scored.dta", clear

local brisco Akobo Budi Duk Leer Pibor Uror

local hhsurvey q_401_a q_401_b q_401_c q_401_d q_401_e q_401_f q_401_g q_401_h q_401_i q_401_j q_401_k q_401_l q_401_m q_401_n q_401_o q_401_p q_401_q q_401_r q_401_s q_401_t q_401_u q_402_a q_402_b q_402_c q_402_d q_402_e q_402_f q_402_g q_402_h q_402_i q_402_j q_402_k q_402_l q_402_m q_402_n q_402_o q_402_p q_402_q q_402_r q_402_s q_402_t q_402_u q_403 q_404 q_405 q_406 q_407 q_408 q_409 q_410 q_411 q_412 q_413 q_414 q_415 q_416 q_417 q_418 q_419 q_420 q_421 q_422 q_423 q_424 q_425 q_426 q_427 q_428 q_429 q_430 q_431 q_432 q_433 q_434 q_435 q_436 q_437 q_438 q_439 q_440 q_441 q_442 q_443 q_444 q_445 q_446 q_447 q_448 q_449 q_450 q_451 q_452 q_453 q_455 q_456 q_457 q_458 q_459 q_460 q_461 q_462 q_463 q_464 q_465 q_466 q_468 q_469 q_470 q_471 q_472 q_473 q_474 q_475 q_476 q_477 q_478 q_479 q_480 q_481 q_482 q_483 q_484 q_485 q_486 q_488 q_489 q_490 q_491 q_492 q_493 q_494 q_495 q_496 q_497 q_498 q_501a q_501b q_501c q_501d q_501e q_501f q_501g q_501h q_501i q_501j q_501k q_501l q_501m q_501n q_501o q_501p q_502a q_502b q_502c q_502d q_502e q_502f q_502g q_502h q_502i q_502j q_502k q_502l q_502m q_502n q_502o q_502p q_504 q_508 q_509 q_510 q_510_bin q_511 q_512_1 q_512_2 q_512_3 q_512_4 q_512_5 q_512_6 q_512_7 q_512_8 q_513 q_513_bin q_517 q_518_1 q_518_2 q_518_3 q_518_4 q_518_5 q_518_6 q_518_7 q_518_8 q_518_9 q_519 q_520 q_601 q_602_1 q_602_2 q_602_3 q_602_4 q_602_5 q_602_6 q_602_7 q_602_8 q_602_9 q_602_10 q_602_11 q_602_12 q_602_13 q_602_14 q_602_15 q_602_16 q_602_17 q_603 q_605 q_606 q_607_a q_607_b q_607_c q_607_d q_607_e q_607_f q_607_g q_607_h q_607_i q_607_j q_607_k q_608_a q_608_b q_608_c q_608_d q_608_e q_608_f q_608_g q_608_h q_608_i q_608_j q_608_k q_610 q_611 q_612 q_629 q_630 q_631 q_632 q_633 q_634 q_635 q_636 q_637 q_638 q_704 q_705_1 q_705_2 q_705_3 q_705_4 q_705_5 q_705_6 q_705_7 q_705_8 q_705_9 q_705_10 q_706 q_706_bin q_707 q_708 q_711 q_715 q_719 q_723 q_727 q_731 q_801 q_802 q_802_bin q_803 q_803_bin q_812 q_812_bin q_813 q_814 q_814_bin q_818 q_820 q_821 q_822 q_823 q_824 q_824_bin q_825 q_825_bin q_827 q_827_bin q_829 q_829_bin q_830_new q_831_new q_832_new

*Overall
foreach survey in hhsurvey  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_desc_overall_location.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_scored.dta", clear

			foreach ur in 1 2 {
			foreach var in ``survey''{
			qui levelsof `var' if q_206==`ur', local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui proportion `var' if q_206==`ur'
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
	qui insheet using "`outpath'baseline_hh_survey_desc_overall_location.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_des.xlsx", sheet("location") sheetmodify
	erase "`outpath'baseline_hh_survey_desc_overall_location.csv"
	di "Complete!"
}

*

*By County
foreach bcj of local brisco {
foreach survey in hhsurvey  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_desc_county_location.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_scored.dta", clear

			foreach ur in 1 2 {
			foreach var in ``survey''{
			qui levelsof `var' if county=="`bcj'" & q_206==`ur', local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui proportion `var' if county=="`bcj'" & q_206==`ur'
			if _rc!=2000 {
			matrix pctmatrix= e(b)	
			local k=colsof(pctmatrix)
			forvalues j=1/`k' { /* J = Position in matrix of k choice variables */
				local choice=choicevector[1,`j']
				local freqpct=(pctmatrix[1,`j'])
				qui summ `var' if `var'==`choice' & county=="`bcj'" & q_206==`ur'
				local n=r(N)
				* Label Nomenclature: varname_value_calculation_grade
				file write myfile _newline  "`var'_`choice'_`bcj'_`ur'_freqpct,`freqpct'"
				file write myfile _newline  "`var'_`choice'_`bcj'_`ur'_n,`n'"
				}
				}
			}
			}
}
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_desc_county_location.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_des.xlsx", sheet("county_`bcj'_location") sheetmodify
	erase "`outpath'baseline_hh_survey_desc_county_location.csv"
	di "Complete!"
}

*

di "Eccoli! I risultati sono pronti!"

*********************
* Sex of Head of HH *
*********************

use "`inpath'mesp_household_baseline_hh_survey_scored.dta", clear

local brisco Akobo Budi Duk Leer Pibor Uror

local hhsurvey q_401_a q_401_b q_401_c q_401_d q_401_e q_401_f q_401_g q_401_h q_401_i q_401_j q_401_k q_401_l q_401_m q_401_n q_401_o q_401_p q_401_q q_401_r q_401_s q_401_t q_401_u q_402_a q_402_b q_402_c q_402_d q_402_e q_402_f q_402_g q_402_h q_402_i q_402_j q_402_k q_402_l q_402_m q_402_n q_402_o q_402_p q_402_q q_402_r q_402_s q_402_t q_402_u q_403 q_404 q_405 q_406 q_407 q_408 q_409 q_410 q_411 q_412 q_413 q_414 q_415 q_416 q_417 q_418 q_419 q_420 q_421 q_422 q_423 q_424 q_425 q_426 q_427 q_428 q_429 q_430 q_431 q_432 q_433 q_434 q_435 q_436 q_437 q_438 q_439 q_440 q_441 q_442 q_443 q_444 q_445 q_446 q_447 q_448 q_449 q_450 q_451 q_452 q_453 q_455 q_456 q_457 q_458 q_459 q_460 q_461 q_462 q_463 q_464 q_465 q_466 q_468 q_469 q_470 q_471 q_472 q_473 q_474 q_475 q_476 q_477 q_478 q_479 q_480 q_481 q_482 q_483 q_484 q_485 q_486 q_488 q_489 q_490 q_491 q_492 q_493 q_494 q_495 q_496 q_497 q_498 q_501a q_501b q_501c q_501d q_501e q_501f q_501g q_501h q_501i q_501j q_501k q_501l q_501m q_501n q_501o q_501p q_502a q_502b q_502c q_502d q_502e q_502f q_502g q_502h q_502i q_502j q_502k q_502l q_502m q_502n q_502o q_502p q_504 q_508 q_509 q_510 q_510_bin q_511 q_512_1 q_512_2 q_512_3 q_512_4 q_512_5 q_512_6 q_512_7 q_512_8 q_513 q_513_bin q_517 q_518_1 q_518_2 q_518_3 q_518_4 q_518_5 q_518_6 q_518_7 q_518_8 q_518_9 q_519 q_520 q_601 q_602_1 q_602_2 q_602_3 q_602_4 q_602_5 q_602_6 q_602_7 q_602_8 q_602_9 q_602_10 q_602_11 q_602_12 q_602_13 q_602_14 q_602_15 q_602_16 q_602_17 q_603 q_605 q_606 q_607_a q_607_b q_607_c q_607_d q_607_e q_607_f q_607_g q_607_h q_607_i q_607_j q_607_k q_608_a q_608_b q_608_c q_608_d q_608_e q_608_f q_608_g q_608_h q_608_i q_608_j q_608_k q_610 q_611 q_612 q_629 q_630 q_631 q_632 q_633 q_634 q_635 q_636 q_637 q_638 q_704 q_705_1 q_705_2 q_705_3 q_705_4 q_705_5 q_705_6 q_705_7 q_705_8 q_705_9 q_705_10 q_706 q_706_bin q_707 q_708 q_711 q_715 q_719 q_723 q_727 q_731 q_801 q_802 q_802_bin q_803 q_803_bin q_812 q_812_bin q_813 q_814 q_814_bin q_818 q_820 q_821 q_822 q_823 q_824 q_824_bin q_825 q_825_bin q_827 q_827_bin q_829 q_829_bin q_830_new q_831_new q_832_new

*Overall
foreach survey in hhsurvey  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_desc_overall_hhsex.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_scored.dta", clear

			foreach sx in 1 2 3 {
			foreach var in ``survey''{
			qui levelsof `var' if hh_head_sex==`sx', local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui proportion `var' if hh_head_sex==`sx'
			if _rc!=2000 {
			matrix pctmatrix= e(b)	
			local k=colsof(pctmatrix)
			forvalues j=1/`k' { /* J = Position in matrix of k choice variables */
				local choice=choicevector[1,`j']
				local freqpct=(pctmatrix[1,`j'])
				qui summ `var' if `var'==`choice' & hh_head_sex==`sx'
				local n=r(N)
				* Label Nomenclature: varname_value_calculation_grade
				file write myfile _newline  "`var'_`choice'_`sx'_freqpct,`freqpct'"
				file write myfile _newline  "`var'_`choice'_`sx'_n,`n'"
				}
				}
			}
			}	
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_desc_overall_hhsex.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_des.xlsx", sheet("hh_head_sex") sheetmodify
	erase "`outpath'baseline_hh_survey_desc_overall_hhsex.csv"
	di "Complete!"
}

*

*By County
foreach bcj of local brisco {
foreach survey in hhsurvey  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_desc_county_hhsex.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_scored.dta", clear

			foreach sx in 1 2 3 {
			foreach var in ``survey''{
			qui levelsof `var' if county=="`bcj'" & hh_head_sex==`sx', local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui proportion `var' if county=="`bcj'" & hh_head_sex==`sx'
			if _rc!=2000 {
			matrix pctmatrix= e(b)	
			local k=colsof(pctmatrix)
			forvalues j=1/`k' { /* J = Position in matrix of k choice variables */
				local choice=choicevector[1,`j']
				local freqpct=(pctmatrix[1,`j'])
				qui summ `var' if `var'==`choice' & county=="`bcj'" & hh_head_sex==`sx'
				local n=r(N)
				* Label Nomenclature: varname_value_calculation_grade
				file write myfile _newline  "`var'_`choice'_`bcj'_`sx'_freqpct,`freqpct'"
				file write myfile _newline  "`var'_`choice'_`bcj'_`sx'_n,`n'"
				}
				}
			}
			}
}
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_desc_county_hhsex.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_des.xlsx", sheet("county_`bcj'_hh_sex") sheetmodify
	erase "`outpath'baseline_hh_survey_desc_county_hhsex.csv"
	di "Complete!"
}

*

***************************
* Education of Respondent *
***************************

use "`inpath'mesp_household_baseline_hh_survey_scored.dta", clear

local brisco Akobo Budi Duk Leer Pibor Uror

local hhsurvey q_401_a q_401_b q_401_c q_401_d q_401_e q_401_f q_401_g q_401_h q_401_i q_401_j q_401_k q_401_l q_401_m q_401_n q_401_o q_401_p q_401_q q_401_r q_401_s q_401_t q_401_u q_402_a q_402_b q_402_c q_402_d q_402_e q_402_f q_402_g q_402_h q_402_i q_402_j q_402_k q_402_l q_402_m q_402_n q_402_o q_402_p q_402_q q_402_r q_402_s q_402_t q_402_u q_403 q_404 q_405 q_406 q_407 q_408 q_409 q_410 q_411 q_412 q_413 q_414 q_415 q_416 q_417 q_418 q_419 q_420 q_421 q_422 q_423 q_424 q_425 q_426 q_427 q_428 q_429 q_430 q_431 q_432 q_433 q_434 q_435 q_436 q_437 q_438 q_439 q_440 q_441 q_442 q_443 q_444 q_445 q_446 q_447 q_448 q_449 q_450 q_451 q_452 q_453 q_455 q_456 q_457 q_458 q_459 q_460 q_461 q_462 q_463 q_464 q_465 q_466 q_468 q_469 q_470 q_471 q_472 q_473 q_474 q_475 q_476 q_477 q_478 q_479 q_480 q_481 q_482 q_483 q_484 q_485 q_486 q_488 q_489 q_490 q_491 q_492 q_493 q_494 q_495 q_496 q_497 q_498 q_501a q_501b q_501c q_501d q_501e q_501f q_501g q_501h q_501i q_501j q_501k q_501l q_501m q_501n q_501o q_501p q_502a q_502b q_502c q_502d q_502e q_502f q_502g q_502h q_502i q_502j q_502k q_502l q_502m q_502n q_502o q_502p q_504 q_508 q_509 q_510 q_510_bin q_511 q_512_1 q_512_2 q_512_3 q_512_4 q_512_5 q_512_6 q_512_7 q_512_8 q_513 q_513_bin q_517 q_518_1 q_518_2 q_518_3 q_518_4 q_518_5 q_518_6 q_518_7 q_518_8 q_518_9 q_519 q_520 q_601 q_602_1 q_602_2 q_602_3 q_602_4 q_602_5 q_602_6 q_602_7 q_602_8 q_602_9 q_602_10 q_602_11 q_602_12 q_602_13 q_602_14 q_602_15 q_602_16 q_602_17 q_603 q_605 q_606 q_607_a q_607_b q_607_c q_607_d q_607_e q_607_f q_607_g q_607_h q_607_i q_607_j q_607_k q_608_a q_608_b q_608_c q_608_d q_608_e q_608_f q_608_g q_608_h q_608_i q_608_j q_608_k q_610 q_611 q_612 q_629 q_630 q_631 q_632 q_633 q_634 q_635 q_636 q_637 q_638 q_704 q_705_1 q_705_2 q_705_3 q_705_4 q_705_5 q_705_6 q_705_7 q_705_8 q_705_9 q_705_10 q_706 q_706_bin q_707 q_708 q_711 q_715 q_719 q_723 q_727 q_731 q_801 q_802 q_802_bin q_803 q_803_bin q_812 q_812_bin q_813 q_814 q_814_bin q_818 q_820 q_821 q_822 q_823 q_824 q_824_bin q_825 q_825_bin q_827 q_827_bin q_829 q_829_bin q_830_new q_831_new q_832_new

*Overall
foreach survey in hhsurvey  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_desc_overall_edu.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_scored.dta", clear

			foreach ed in 0 1 2 {
			foreach var in ``survey''{
			qui levelsof `var' if q_308_three==`ed', local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui proportion `var' if q_308_three==`ed'
			if _rc!=2000 {
			matrix pctmatrix= e(b)	
			local k=colsof(pctmatrix)
			forvalues j=1/`k' { /* J = Position in matrix of k choice variables */
				local choice=choicevector[1,`j']
				local freqpct=(pctmatrix[1,`j'])
				qui summ `var' if `var'==`choice' & q_308_three==`ed'
				local n=r(N)
				* Label Nomenclature: varname_value_calculation_grade
				file write myfile _newline  "`var'_`choice'_`ed'_freqpct,`freqpct'"
				file write myfile _newline  "`var'_`choice'_`ed'_n,`n'"
				}
				}
			}
			}	
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_desc_overall_edu.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_des.xlsx", sheet("resp_edu") sheetmodify
	erase "`outpath'baseline_hh_survey_desc_overall_edu.csv"
	di "Complete!"
}

*

*By County
foreach bcj of local brisco {
foreach survey in hhsurvey  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_desc_county_edu.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_scored.dta", clear

			foreach ed in 0 1 2 {
			foreach var in ``survey''{
			qui levelsof `var' if county=="`bcj'" & q_308_three==`ed', local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui proportion `var' if county=="`bcj'" & q_308_three==`ed'
			if _rc!=2000 {
			matrix pctmatrix= e(b)	
			local k=colsof(pctmatrix)
			forvalues j=1/`k' { /* J = Position in matrix of k choice variables */
				local choice=choicevector[1,`j']
				local freqpct=(pctmatrix[1,`j'])
				qui summ `var' if `var'==`choice' & county=="`bcj'" & q_308_three==`ed'
				local n=r(N)
				* Label Nomenclature: varname_value_calculation_grade
				file write myfile _newline  "`var'_`choice'_`bcj'_`ed'_freqpct,`freqpct'"
				file write myfile _newline  "`var'_`choice'_`bcj'_`ed'_n,`n'"
				}
				}
			}
			}
}
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_desc_county_edu.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_des.xlsx", sheet("county_`bcj'_edu") sheetmodify
	erase "`outpath'baseline_hh_survey_desc_county_edu.csv"
	di "Complete!"
}

*

*********************
* Sex of Respondent *
*********************

use "`inpath'mesp_household_baseline_hh_survey_scored.dta", clear

local brisco Akobo Budi Duk Leer Pibor Uror

local hhsurvey q_401_a q_401_b q_401_c q_401_d q_401_e q_401_f q_401_g q_401_h q_401_i q_401_j q_401_k q_401_l q_401_m q_401_n q_401_o q_401_p q_401_q q_401_r q_401_s q_401_t q_401_u q_402_a q_402_b q_402_c q_402_d q_402_e q_402_f q_402_g q_402_h q_402_i q_402_j q_402_k q_402_l q_402_m q_402_n q_402_o q_402_p q_402_q q_402_r q_402_s q_402_t q_402_u q_403 q_404 q_405 q_406 q_407 q_408 q_409 q_410 q_411 q_412 q_413 q_414 q_415 q_416 q_417 q_418 q_419 q_420 q_421 q_422 q_423 q_424 q_425 q_426 q_427 q_428 q_429 q_430 q_431 q_432 q_433 q_434 q_435 q_436 q_437 q_438 q_439 q_440 q_441 q_442 q_443 q_444 q_445 q_446 q_447 q_448 q_449 q_450 q_451 q_452 q_453 q_455 q_456 q_457 q_458 q_459 q_460 q_461 q_462 q_463 q_464 q_465 q_466 q_468 q_469 q_470 q_471 q_472 q_473 q_474 q_475 q_476 q_477 q_478 q_479 q_480 q_481 q_482 q_483 q_484 q_485 q_486 q_488 q_489 q_490 q_491 q_492 q_493 q_494 q_495 q_496 q_497 q_498 q_501a q_501b q_501c q_501d q_501e q_501f q_501g q_501h q_501i q_501j q_501k q_501l q_501m q_501n q_501o q_501p q_502a q_502b q_502c q_502d q_502e q_502f q_502g q_502h q_502i q_502j q_502k q_502l q_502m q_502n q_502o q_502p q_504 q_508 q_509 q_510 q_510_bin q_511 q_512_1 q_512_2 q_512_3 q_512_4 q_512_5 q_512_6 q_512_7 q_512_8 q_513 q_513_bin q_517 q_518_1 q_518_2 q_518_3 q_518_4 q_518_5 q_518_6 q_518_7 q_518_8 q_518_9 q_519 q_520 q_601 q_602_1 q_602_2 q_602_3 q_602_4 q_602_5 q_602_6 q_602_7 q_602_8 q_602_9 q_602_10 q_602_11 q_602_12 q_602_13 q_602_14 q_602_15 q_602_16 q_602_17 q_603 q_605 q_606 q_607_a q_607_b q_607_c q_607_d q_607_e q_607_f q_607_g q_607_h q_607_i q_607_j q_607_k q_608_a q_608_b q_608_c q_608_d q_608_e q_608_f q_608_g q_608_h q_608_i q_608_j q_608_k q_610 q_611 q_612 q_629 q_630 q_631 q_632 q_633 q_634 q_635 q_636 q_637 q_638 q_704 q_705_1 q_705_2 q_705_3 q_705_4 q_705_5 q_705_6 q_705_7 q_705_8 q_705_9 q_705_10 q_706 q_706_bin q_707 q_708 q_711 q_715 q_719 q_723 q_727 q_731 q_801 q_802 q_802_bin q_803 q_803_bin q_812 q_812_bin q_813 q_814 q_814_bin q_818 q_820 q_821 q_822 q_823 q_824 q_824_bin q_825 q_825_bin q_827 q_827_bin q_829 q_829_bin q_830_new q_831_new q_832_new

*Overall
foreach survey in hhsurvey  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_desc_overall_resp_sex.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_scored.dta", clear

			foreach sx in 1 2 {
			foreach var in ``survey''{
			qui levelsof `var' if q_302==`sx', local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui proportion `var' if q_302==`sx'
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
	qui insheet using "`outpath'baseline_hh_survey_desc_overall_resp_sex.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_des.xlsx", sheet("resp_sex") sheetmodify
	erase "`outpath'baseline_hh_survey_desc_overall_resp_sex.csv"
	di "Complete!"
}

*

*By County
foreach bcj of local brisco {
foreach survey in hhsurvey  {
	di "Creating values for `survey'..."
	qui file open myfile using "`outpath'baseline_hh_survey_desc_county_resp_sex.csv", write replace
	file write myfile "Variable, Value"
	use "`inpath'mesp_household_baseline_hh_survey_scored.dta", clear

			foreach sx in 1 2 {
			foreach var in ``survey''{
			qui levelsof `var' if county=="`bcj'" & q_302==`sx', local(uniqlist)
			mata: st_matrix("choicevector", strtoreal(tokens(st_local("uniqlist"))))
			cap qui proportion `var' if county=="`bcj'" & q_302==`sx'
			if _rc!=2000 {
			matrix pctmatrix= e(b)	
			local k=colsof(pctmatrix)
			forvalues j=1/`k' { /* J = Position in matrix of k choice variables */
				local choice=choicevector[1,`j']
				local freqpct=(pctmatrix[1,`j'])
				qui summ `var' if `var'==`choice' & county=="`bcj'" & q_302==`sx'
				local n=r(N)
				* Label Nomenclature: varname_value_calculation_grade
				file write myfile _newline  "`var'_`choice'_`bcj'_`sx'_freqpct,`freqpct'"
				file write myfile _newline  "`var'_`choice'_`bcj'_`sx'_n,`n'"
				}
				}
			}
			}
}
		
	file close myfile
	qui insheet using "`outpath'baseline_hh_survey_desc_county_resp_sex.csv", comma names clear
	qui export excel using "`outpath'mesp_household_baseline_hh_survey_des.xlsx", sheet("county_`bcj'_resp_sex") sheetmodify
	erase "`outpath'baseline_hh_survey_desc_county_resp_sex.csv"
	di "Complete!"
}

*

di "Eccoli! I risultati sono pronti!"
