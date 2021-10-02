*******************************************************************************
* South Sudan Baseline Household Survey
* Sean Kelly
* August 5, 2021
* File uses: mesp_household_baseline_survey_weights.dta;
* mesp_household_baseline_survey_hh_schedule_clean.dta
* File saves: mesp_household_baseline_survey_hh_schedule_weighted.dta
* This file calculates the sample weights and merges them to survey data
*******************************************************************************

* Datasets of interest and variables within each file - macro names match filename infixes *
local inpath "W:\Shared\Projects\6073.04 SSD MESP\Tech\Deliverables\Household Survey\Baseline\data\03_clean\"
local outpath "W:\Shared\Projects\6073.04 SSD MESP\Tech\Deliverables\Household Survey\Baseline\data\05_sample_weights\"

use "`outpath'mesp_household_baseline_survey_weights.dta", replace

*Merge weights with dataset
merge 1:m ea using "`inpath'mesp_household_baseline_survey_hh_schedule_clean.dta" // perfect merge

drop _merge row_id

order county_hh_pop_nbs hh_pop_est_nbs county_wt1 county_hh_pop_msi hh_pop_est_msi county_wt2 hh_pop_list hh_sample hh_wt final_wt1 final_wt2, after(resp_link)

order state county payam boma ea, after(record_id)

*Set Survey specifications
egen countyXea=group(county ea)
label var countyXea "Stage 1 Stratification"
egen countyXeaXrecord=group(county ea record_id)
label var countyXeaXrecord "Stage 2 Stratification"

svyset ea [pweight = final_wt1], strata (countyXea) fpc(county_hh_pop_nbs) || record_id, fpc(hh_pop_list) strata (record_id) singleunit(scaled) vce(linearized)

drop county_hh_pop_msi hh_pop_est_msi county_wt2 final_wt2

*save
save "`outpath'mesp_household_baseline_hh_survey_schedule_weighted.dta", replace


*svyset ea [pweight = final_wt2], strata (countyXea) fpc(county_hh_pop_msi) || record_id, fpc(hh_pop_list) strata (record_id) singleunit(scaled) vce(linearized)

*save
*save "`outpath'mesp_household_baseline_hh_survey_schedule_weighted2.dta", replace