*******************************************************************************
* South Sudan Baseline Household Survey
* Sean Kelly
* August 5, 2021
* File uses: MESP_HH_Listing_Clean-Dataset-08-03-2021.xlsx
* File saves: mesp_household_baseline_survey_weights_HH.dta;
* mesp_household_baseline_hh_survey_weighted.dta
* This file calculates the sample weights and merges them to survey data
*******************************************************************************

* Datasets of interest and variables within each file - macro names match filename infixes *
local inpath "W:\Shared\Projects\6073.04 SSD MESP\Tech\Deliverables\Household Survey\Baseline\data\04_scoring\"
local outpath "W:\Shared\Projects\6073.04 SSD MESP\Tech\Deliverables\Household Survey\Baseline\data\05_sample_weights\"

import excel using "`outpath'MESP_HH_Listing_Clean-Dataset-08-03-2021.xlsx", sheet("Combined") firstrow clear

*Format dataset

rename State state
label var state "State of South Sudan"

rename County county 
label var county "County of South Sudan"

rename Payam payam 
label var payam "Payam of County in South Sudan"

rename Boma boma 
label var boma "Boma of Payam"

rename EA_ID ea 
label var ea "Enumeration Area"
format ea %15.0f


rename TotalHouseholdsListed hh_pop_list
label var hh_pop_list "Number of households in EA according to listing"

gen row_id = _n
label var row_id "Row ID"
order row_id, before(state)

*Fix duplicate EA between Uror and Duk / Cross-reference with dataset
unique ea // 222 records, 219 unique EAs --> 3 duplicate EAs

duplicates list ea // 720403001202, 720403002202, 720507002202

sort ea

brow if ea==720403001202 | ea==720403002202 | ea==720507002202

*Fix 720507002202 
/*EA exists in Duk and Uror, Uror is the correct one per NBS. */
drop if row_id==69
replace hh_pop = 342 + 144 if ea==720507002202

drop if row_id==9 
drop if row_id==13

drop row_id

gen row_id = _n
label var row_id "Row ID"
order row_id, before(state)

local brisco Akobo Budi Duk Leer Pibor Uror
foreach bcj of local brisco {
unique ea if county=="`bcj'"
}
*

/* Akobo has 37, Budi has 37, Duk has 34, Leer has 37, Pibor has 37, Uror has 37 */

*Still one extra EA in Duk. Only 34 EAs in cleaned and scored dataset.

unique ea // 219 unique values, no duplicates.

drop if ea==720405005207 // not present in cleaned dataset

*Add number of households sampled for each EA from dataset
gen hh_sample= . 
replace hh_sample=17 if ea==720702001202
replace hh_sample=17 if ea==720702003201
replace hh_sample=17 if ea==720702003202
replace hh_sample=17 if ea==720702004201
replace hh_sample=17 if ea==720702004203
replace hh_sample=17 if ea==720703001101
replace hh_sample=17 if ea==720703001102
replace hh_sample=16 if ea==720703001103
replace hh_sample=17 if ea==720703001104
replace hh_sample=17 if ea==720703001105
replace hh_sample=17 if ea==720703001106
replace hh_sample=17 if ea==720703001107
replace hh_sample=17 if ea==720703001108
replace hh_sample=17 if ea==720703003201
replace hh_sample=17 if ea==720703003202
replace hh_sample=17 if ea==720703003207
replace hh_sample=17 if ea==720703004201
replace hh_sample=17 if ea==720703004202
replace hh_sample=15 if ea==720703004203
replace hh_sample=17 if ea==720703004204
replace hh_sample=17 if ea==720704002201
replace hh_sample=17 if ea==720704003202
replace hh_sample=17 if ea==720705001201
replace hh_sample=17 if ea==720705001202
replace hh_sample=17 if ea==720705001203
replace hh_sample=17 if ea==720705002202
replace hh_sample=17 if ea==720705002203
replace hh_sample=17 if ea==720705003201
replace hh_sample=17 if ea==720705003203
replace hh_sample=16 if ea==720705004204
replace hh_sample=17 if ea==720706003201
replace hh_sample=17 if ea==720706004201
replace hh_sample=17 if ea==720707002201
replace hh_sample=17 if ea==720707002202
replace hh_sample=17 if ea==720707002203
replace hh_sample=17 if ea==720708002202
replace hh_sample=17 if ea==720708004202
replace hh_sample=17 if ea==930601002202
replace hh_sample=17 if ea==930601003201
replace hh_sample=16 if ea==930601003203
replace hh_sample=17 if ea==930602002201
replace hh_sample=17 if ea==930602002202
replace hh_sample=17 if ea==930602002204
replace hh_sample=17 if ea==930602003201
replace hh_sample=17 if ea==930602003204
replace hh_sample=17 if ea==930602003206
replace hh_sample=17 if ea==930602004201
replace hh_sample=17 if ea==930602005201
replace hh_sample=17 if ea==930602005203
replace hh_sample=17 if ea==930602006202
replace hh_sample=17 if ea==930602006204
replace hh_sample=17 if ea==930603001201
replace hh_sample=15 if ea==930603002201
replace hh_sample=15 if ea==930604001206
replace hh_sample=17 if ea==930604002204
replace hh_sample=17 if ea==930604002206
replace hh_sample=17 if ea==930604004201
replace hh_sample=17 if ea==930604004202
replace hh_sample=17 if ea==930604004204
replace hh_sample=15 if ea==930605001202
replace hh_sample=17 if ea==930605002203
replace hh_sample=17 if ea==930605003201
replace hh_sample=17 if ea==930605003203
replace hh_sample=17 if ea==930606002201
replace hh_sample=17 if ea==930606003203
replace hh_sample=17 if ea==930606003207
replace hh_sample=17 if ea==930607001202
replace hh_sample=17 if ea==930607002202
replace hh_sample=17 if ea==930607003201
replace hh_sample=17 if ea==930607004203
replace hh_sample=17 if ea==930608001202
replace hh_sample=17 if ea==930608001205
replace hh_sample=15 if ea==930608004201
replace hh_sample=17 if ea==930608004203
replace hh_sample=17 if ea==720401001202
replace hh_sample=17 if ea==720401003202
replace hh_sample=17 if ea==720401003203
replace hh_sample=17 if ea==720401003204
replace hh_sample=2 if ea==720402001201
replace hh_sample=5 if ea==720402001202
replace hh_sample=17 if ea==720403001201
replace hh_sample=17 if ea==720403001202
replace hh_sample=17 if ea==720403002201
replace hh_sample=17 if ea==720403002202
replace hh_sample=17 if ea==720403003202
replace hh_sample=15 if ea==720403001205
replace hh_sample=10 if ea==720403003201
replace hh_sample=15 if ea==720403003204
replace hh_sample=16 if ea==720403004201
replace hh_sample=17 if ea==720403004202
replace hh_sample=17 if ea==720403004203
replace hh_sample=17 if ea==720403004204
replace hh_sample=17 if ea==720403004205
replace hh_sample=17 if ea==720404002201
replace hh_sample=17 if ea==720404003202
replace hh_sample=17 if ea==720405003202
replace hh_sample=13 if ea==720405003203
replace hh_sample=17 if ea==720405003205
replace hh_sample=17 if ea==720405005202
replace hh_sample=17 if ea==720405005204
replace hh_sample=17 if ea==720405005206
replace hh_sample=17 if ea==720405006203
replace hh_sample=17 if ea==720405006204
replace hh_sample=17 if ea==720406001202
replace hh_sample=17 if ea==720406002201
replace hh_sample=17 if ea==720406003201
replace hh_sample=17 if ea==720406003202
replace hh_sample=17 if ea==730701001202
replace hh_sample=17 if ea==730701001203
replace hh_sample=17 if ea==730701002202
replace hh_sample=17 if ea==730701002203
replace hh_sample=17 if ea==730701003202
replace hh_sample=16 if ea==730701003203
replace hh_sample=17 if ea==730701003205
replace hh_sample=17 if ea==730701003206
replace hh_sample=17 if ea==730701003208
replace hh_sample=17 if ea==730702001202
replace hh_sample=17 if ea==730702001203
replace hh_sample=17 if ea==730702003201
replace hh_sample=17 if ea==730702003202
replace hh_sample=17 if ea==730703001101
replace hh_sample=17 if ea==730703002101
replace hh_sample=16 if ea==730703002103
replace hh_sample=16 if ea==730703003201
replace hh_sample=17 if ea==730703003202
replace hh_sample=17 if ea==730704001202
replace hh_sample=17 if ea==730704001203
replace hh_sample=17 if ea==730704002201
replace hh_sample=15 if ea==730704002202
replace hh_sample=17 if ea==730704003201
replace hh_sample=17 if ea==730705001202
replace hh_sample=17 if ea==730705002201
replace hh_sample=16 if ea==730705003201
replace hh_sample=17 if ea==730706001202
replace hh_sample=17 if ea==730706001203
replace hh_sample=17 if ea==730706002201
replace hh_sample=16 if ea==730706002203
replace hh_sample=17 if ea==730706002204
replace hh_sample=17 if ea==730707001202
replace hh_sample=17 if ea==730707002203
replace hh_sample=17 if ea==730707003202
replace hh_sample=15 if ea==730708001201
replace hh_sample=17 if ea==730708001203
replace hh_sample=17 if ea==730708001206
replace hh_sample=16 if ea==720901003201
replace hh_sample=6 if ea==720901003203
replace hh_sample=14 if ea==720901006202
replace hh_sample=17 if ea==720902003201
replace hh_sample=15 if ea==720902003203
replace hh_sample=17 if ea==720902006201
replace hh_sample=17 if ea==720902006202
replace hh_sample=17 if ea==720902007203
replace hh_sample=17 if ea==720902002204
replace hh_sample=17 if ea==720902002205
replace hh_sample=17 if ea==720903003202
replace hh_sample=17 if ea==720903005205
replace hh_sample=17 if ea==720904001203
replace hh_sample=17 if ea==720904003210
replace hh_sample=13 if ea==720904004203
replace hh_sample=7 if ea==720904005203
replace hh_sample=9 if ea==720904005204
replace hh_sample=17 if ea==720904006204
replace hh_sample=17 if ea==720904006205
replace hh_sample=17 if ea==720904007207
replace hh_sample=16 if ea==720904010203
replace hh_sample=17 if ea==720904010205
replace hh_sample=17 if ea==720905004203
replace hh_sample=17 if ea==720905006201
replace hh_sample=16 if ea==720907001208
replace hh_sample=17 if ea==720907002201
replace hh_sample=17 if ea==720907004203
replace hh_sample=17 if ea==720907006202
replace hh_sample=3 if ea==720907006204
replace hh_sample=17 if ea==720907009103
replace hh_sample=17 if ea==720907009104
replace hh_sample=11 if ea==720907009107
replace hh_sample=14 if ea==720907009110
replace hh_sample=16 if ea==720907010203
replace hh_sample=17 if ea==720908006201
replace hh_sample=17 if ea==720908006202
replace hh_sample=17 if ea==720908006206
replace hh_sample=17 if ea==720501002201
replace hh_sample=17 if ea==720501003202
replace hh_sample=17 if ea==720501004204
replace hh_sample=17 if ea==720501006201
replace hh_sample=17 if ea==720501006202
replace hh_sample=17 if ea==720501008201
replace hh_sample=17 if ea==720502001201
replace hh_sample=17 if ea==720502001203
replace hh_sample=17 if ea==720502002203
replace hh_sample=17 if ea==720502003202
replace hh_sample=17 if ea==720502004201
replace hh_sample=15 if ea==720503001203
replace hh_sample=16 if ea==720503001205
replace hh_sample=17 if ea==720503002203
replace hh_sample=17 if ea==720503002206
replace hh_sample=17 if ea==720503004202
replace hh_sample=17 if ea==720503005201
replace hh_sample=17 if ea==720503005202
replace hh_sample=17 if ea==720503008202
replace hh_sample=15 if ea==720503007202
replace hh_sample=15 if ea==720504005201
replace hh_sample=17 if ea==720504005203
replace hh_sample=16 if ea==720504007201
replace hh_sample=17 if ea==720505001202
replace hh_sample=16 if ea==720505002201
replace hh_sample=17 if ea==720505002202
replace hh_sample=17 if ea==720505003201
replace hh_sample=15 if ea==720505004202
replace hh_sample=17 if ea==720506001201
replace hh_sample=17 if ea==720506002203
replace hh_sample=17 if ea==720506005201
replace hh_sample=17 if ea==720507002202
replace hh_sample=17 if ea==720508001202
replace hh_sample=17 if ea==720508001204
replace hh_sample=15 if ea==720508003201
replace hh_sample=17 if ea==720508003204
replace hh_sample=17 if ea==720508004201
label var hh_sample "Number of households sampled in each EA"
tab hh_sample, m

*Calculated second stage weight
gen hh_wt = hh_pop_list / hh_sample

label var hh_wt "Second stage household weight"

*Create var for HH population of each county
gen county_hh_pop_nbs = . 
replace county_hh_pop_nbs=14709 if county=="Akobo"
replace county_hh_pop_nbs=14814 if county=="Budi"
replace county_hh_pop_nbs=9083 if county=="Duk"
replace county_hh_pop_nbs=7997 if county=="Leer"
replace county_hh_pop_nbs=27883 if county=="Pibor"
replace county_hh_pop_nbs=20662 if county=="Uror"
label var county_hh_pop_nbs "Number of households in each county per NBS estimates"

gen county_hh_pop_msi = . 
replace county_hh_pop_msi=23201 if county=="Akobo"
replace county_hh_pop_msi=78388 if county=="Budi"
replace county_hh_pop_msi=10951 if county=="Duk"
replace county_hh_pop_msi=9800 if county=="Leer"
replace county_hh_pop_msi=24607 if county=="Pibor"
replace county_hh_pop_msi=30670 if county=="Uror"
label var county_hh_pop_msi "Number of households in each county per MSI estimates"

*Create var for estimated number of households in each EA
gen hh_pop_est_nbs = . 
replace hh_pop_est_nbs = 108 if ea==720707002203
replace hh_pop_est_nbs = 184 if ea==720707002202
replace hh_pop_est_nbs = 143 if ea==720707002201
replace hh_pop_est_nbs = 97 if ea==720703001108
replace hh_pop_est_nbs = 155 if ea==720703001105
replace hh_pop_est_nbs = 150 if ea==720703001106
replace hh_pop_est_nbs = 115 if ea==720703001107
replace hh_pop_est_nbs = 217 if ea==720703001104
replace hh_pop_est_nbs = 228 if ea==720703001102
replace hh_pop_est_nbs = 100 if ea==720703004203
replace hh_pop_est_nbs = 93 if ea==720703004204
replace hh_pop_est_nbs = 83 if ea==720703001103
replace hh_pop_est_nbs = 225 if ea==720703001101
replace hh_pop_est_nbs = 96 if ea==720703004202
replace hh_pop_est_nbs = 127 if ea==720703004201
replace hh_pop_est_nbs = 63 if ea==720703003207
replace hh_pop_est_nbs = 130 if ea==720703003202
replace hh_pop_est_nbs = 107 if ea==720703003201
replace hh_pop_est_nbs = 72 if ea==720705004204
replace hh_pop_est_nbs = 145 if ea==720705003203
replace hh_pop_est_nbs = 135 if ea==720705001201
replace hh_pop_est_nbs = 160 if ea==720705001203
replace hh_pop_est_nbs = 55 if ea==720705003201
replace hh_pop_est_nbs = 122 if ea==720705002202
replace hh_pop_est_nbs = 186 if ea==720705002203
replace hh_pop_est_nbs = 102 if ea==720705001202
replace hh_pop_est_nbs = 132 if ea==720706004201
replace hh_pop_est_nbs = 175 if ea==720706003201
replace hh_pop_est_nbs = 140 if ea==720704002201
replace hh_pop_est_nbs = 103 if ea==720704003202
replace hh_pop_est_nbs = 71 if ea==720708004202
replace hh_pop_est_nbs = 140 if ea==720702003202
replace hh_pop_est_nbs = 150 if ea==720702004203
replace hh_pop_est_nbs = 110 if ea==720702001202
replace hh_pop_est_nbs = 127 if ea==720702003201
replace hh_pop_est_nbs = 178 if ea==720702004201
replace hh_pop_est_nbs = 158 if ea==720708002202
replace hh_pop_est_nbs = 183 if ea==930603001201
replace hh_pop_est_nbs = 177 if ea==930604004204
replace hh_pop_est_nbs = 101 if ea==930604004202
replace hh_pop_est_nbs = 168 if ea==930602002202
replace hh_pop_est_nbs = 140 if ea==930602002204
replace hh_pop_est_nbs = 156 if ea==930604002206
replace hh_pop_est_nbs = 158 if ea==930602002201
replace hh_pop_est_nbs = 148 if ea==930604001206
replace hh_pop_est_nbs = 126 if ea==930604002204
replace hh_pop_est_nbs = 83 if ea==930608001202
replace hh_pop_est_nbs = 140 if ea==930604004201
replace hh_pop_est_nbs = 63 if ea==930602006204
replace hh_pop_est_nbs = 338 if ea==930602003201
replace hh_pop_est_nbs = 516 if ea==930602003204
replace hh_pop_est_nbs = 139 if ea==930602006202
replace hh_pop_est_nbs = 45 if ea==930602003206
replace hh_pop_est_nbs = 99 if ea==930605003203
replace hh_pop_est_nbs = 105 if ea==930606002201
replace hh_pop_est_nbs = 176 if ea==930605003201
replace hh_pop_est_nbs = 92 if ea==930606003203
replace hh_pop_est_nbs = 34 if ea==930602005203
replace hh_pop_est_nbs = 135 if ea==930605001202
replace hh_pop_est_nbs = 85 if ea==930606003207
replace hh_pop_est_nbs = 125 if ea==930605002203
replace hh_pop_est_nbs = 46 if ea==930602005201
replace hh_pop_est_nbs = 127 if ea==930602004201
replace hh_pop_est_nbs = 107 if ea==930608004203
replace hh_pop_est_nbs = 85 if ea==930608001205
replace hh_pop_est_nbs = 128 if ea==930608004201
replace hh_pop_est_nbs = 112 if ea==930603002201
replace hh_pop_est_nbs = 164 if ea==930601002202
replace hh_pop_est_nbs = 112 if ea==930601003203
replace hh_pop_est_nbs = 153 if ea==930607002202
replace hh_pop_est_nbs = 149 if ea==930601003201
replace hh_pop_est_nbs = 179 if ea==930607003201
replace hh_pop_est_nbs = 81 if ea==930607004203
replace hh_pop_est_nbs = 189 if ea==930607001202
replace hh_pop_est_nbs = 187 if ea==720401003204
replace hh_pop_est_nbs = 135 if ea==720401003202
replace hh_pop_est_nbs = 100 if ea==720406001202
replace hh_pop_est_nbs = 150 if ea==720401001202
replace hh_pop_est_nbs = 192 if ea==720406003202
replace hh_pop_est_nbs = 76 if ea==720406003201
replace hh_pop_est_nbs = 71 if ea==720406002201
replace hh_pop_est_nbs = 111 if ea==720402001202
replace hh_pop_est_nbs = 143 if ea==720403002202
replace hh_pop_est_nbs = 130 if ea==720403002201
replace hh_pop_est_nbs = 103 if ea==720403001201
replace hh_pop_est_nbs = 79 if ea==720403004205
replace hh_pop_est_nbs = 175 if ea==720403004204
replace hh_pop_est_nbs = 148 if ea==720405006204
replace hh_pop_est_nbs = 180 if ea==720403001202
replace hh_pop_est_nbs = 95 if ea==720403001205
replace hh_pop_est_nbs = 160 if ea==720405006203
replace hh_pop_est_nbs = 138 if ea==720405005204
replace hh_pop_est_nbs = 100 if ea==720405005206
replace hh_pop_est_nbs = 136 if ea==720403004202
replace hh_pop_est_nbs = 72 if ea==720403003202
replace hh_pop_est_nbs = 100 if ea==720405005202
replace hh_pop_est_nbs = 242 if ea==720403004203
replace hh_pop_est_nbs = 160 if ea==720402001201
replace hh_pop_est_nbs = 137 if ea==720405003205
replace hh_pop_est_nbs = 100 if ea==720403003204
replace hh_pop_est_nbs = 143 if ea==720405003203
replace hh_pop_est_nbs = 64 if ea==720404003202
replace hh_pop_est_nbs = 106 if ea==720405003202
replace hh_pop_est_nbs = 75 if ea==720403003201
replace hh_pop_est_nbs = 140 if ea==720403004201
replace hh_pop_est_nbs = 121 if ea==720404002201
replace hh_pop_est_nbs = 204 if ea==720401003203
replace hh_pop_est_nbs = 150 if ea==730708001203
replace hh_pop_est_nbs = 128 if ea==730708001206
replace hh_pop_est_nbs = 187 if ea==730701002203
replace hh_pop_est_nbs = 93 if ea==730707002203
replace hh_pop_est_nbs = 130 if ea==730708001201
replace hh_pop_est_nbs = 170 if ea==730701002202
replace hh_pop_est_nbs = 60 if ea==730707003202
replace hh_pop_est_nbs = 142 if ea==730701003208
replace hh_pop_est_nbs = 125 if ea==730701003206
replace hh_pop_est_nbs = 82 if ea==730707001202
replace hh_pop_est_nbs = 70 if ea==730701001203
replace hh_pop_est_nbs = 120 if ea==730701001202
replace hh_pop_est_nbs = 267 if ea==730703002103
replace hh_pop_est_nbs = 219 if ea==730703001101
replace hh_pop_est_nbs = 98 if ea==730703002101
replace hh_pop_est_nbs = 111 if ea==730701003205
replace hh_pop_est_nbs = 155 if ea==730701003203
replace hh_pop_est_nbs = 103 if ea==730701003202
replace hh_pop_est_nbs = 115 if ea==730703003201
replace hh_pop_est_nbs = 88 if ea==730703003202
replace hh_pop_est_nbs = 76 if ea==730705002201
replace hh_pop_est_nbs = 62 if ea==730702001203
replace hh_pop_est_nbs = 165 if ea==730705003201
replace hh_pop_est_nbs = 32 if ea==730702001202
replace hh_pop_est_nbs = 150 if ea==730706002204
replace hh_pop_est_nbs = 65 if ea==730705001202
replace hh_pop_est_nbs = 50 if ea==730706002203
replace hh_pop_est_nbs = 61 if ea==730704003201
replace hh_pop_est_nbs = 105 if ea==730704001203
replace hh_pop_est_nbs = 113 if ea==730706002201
replace hh_pop_est_nbs = 140 if ea==730702003202
replace hh_pop_est_nbs = 87 if ea==730702003201
replace hh_pop_est_nbs = 113 if ea==730704001202
replace hh_pop_est_nbs = 77 if ea==730704002202
replace hh_pop_est_nbs = 85 if ea==730704002201
replace hh_pop_est_nbs = 82 if ea==730706001203
replace hh_pop_est_nbs = 85 if ea==730706001202
replace hh_pop_est_nbs = 88 if ea==720903003202
replace hh_pop_est_nbs = 114 if ea==720901003201
replace hh_pop_est_nbs = 93 if ea==720903005205
replace hh_pop_est_nbs = 25 if ea==720905004203
replace hh_pop_est_nbs = 80 if ea==720902002204
replace hh_pop_est_nbs = 155 if ea==720902007203
replace hh_pop_est_nbs = 142 if ea==720902002205
replace hh_pop_est_nbs = 110 if ea==720902003203
replace hh_pop_est_nbs = 72 if ea==720902003201
replace hh_pop_est_nbs = 125 if ea==720902006202
replace hh_pop_est_nbs = 150 if ea==720908006201
replace hh_pop_est_nbs = 100 if ea==720908006202
replace hh_pop_est_nbs = 120 if ea==720908006206
replace hh_pop_est_nbs = 120 if ea==720902006201
replace hh_pop_est_nbs = 102 if ea==720907004203
replace hh_pop_est_nbs = 147 if ea==720907001208
replace hh_pop_est_nbs = 129 if ea==720907010203
replace hh_pop_est_nbs = 125 if ea==720905006201
replace hh_pop_est_nbs = 145 if ea==720907002201
replace hh_pop_est_nbs = 125 if ea==720907009110
replace hh_pop_est_nbs = 330 if ea==720907009103
replace hh_pop_est_nbs = 235 if ea==720907009104
replace hh_pop_est_nbs = 143 if ea==720907006202
replace hh_pop_est_nbs = 131 if ea==720907006204
replace hh_pop_est_nbs = 78 if ea==720904006205
replace hh_pop_est_nbs = 83 if ea==720904006204
replace hh_pop_est_nbs = 65 if ea==720904001203
replace hh_pop_est_nbs = 93 if ea==720904003210
replace hh_pop_est_nbs = 85 if ea==720904005204
replace hh_pop_est_nbs = 74 if ea==720904005203
replace hh_pop_est_nbs = 98 if ea==720904010203
replace hh_pop_est_nbs = 101 if ea==720904010205
replace hh_pop_est_nbs = 105 if ea==720904007207
replace hh_pop_est_nbs = 153 if ea==720901003203
replace hh_pop_est_nbs = 191 if ea==720901006202
replace hh_pop_est_nbs = 159 if ea==720904004203
replace hh_pop_est_nbs = 175 if ea==720907009107
replace hh_pop_est_nbs = 122 if ea==720507002202
replace hh_pop_est_nbs = 75 if ea==720508004201
replace hh_pop_est_nbs = 120 if ea==720508003201
replace hh_pop_est_nbs = 157 if ea==720508003204
replace hh_pop_est_nbs = 82 if ea==720508001202
replace hh_pop_est_nbs = 146 if ea==720504007201
replace hh_pop_est_nbs = 172 if ea==720504005201
replace hh_pop_est_nbs = 168 if ea==720503001203
replace hh_pop_est_nbs = 120 if ea==720504005203
replace hh_pop_est_nbs = 133 if ea==720503002206
replace hh_pop_est_nbs = 137 if ea==720503001205
replace hh_pop_est_nbs = 162 if ea==720503002203
replace hh_pop_est_nbs = 140 if ea==720503004202
replace hh_pop_est_nbs = 145 if ea==720505003201
replace hh_pop_est_nbs = 103 if ea==720506001201
replace hh_pop_est_nbs = 96 if ea==720503005202
replace hh_pop_est_nbs = 156 if ea==720505002202
replace hh_pop_est_nbs = 233 if ea==720505001202
replace hh_pop_est_nbs = 115 if ea==720503007202
replace hh_pop_est_nbs = 105 if ea==720503005201
replace hh_pop_est_nbs = 168 if ea==720505002201
replace hh_pop_est_nbs = 183 if ea==720506005201
replace hh_pop_est_nbs = 162 if ea==720503008202
replace hh_pop_est_nbs = 170 if ea==720506002203
replace hh_pop_est_nbs = 126 if ea==720502003202
replace hh_pop_est_nbs = 140 if ea==720501002201
replace hh_pop_est_nbs = 165 if ea==720502001203
replace hh_pop_est_nbs = 128 if ea==720501004204
replace hh_pop_est_nbs = 169 if ea==720501003202
replace hh_pop_est_nbs = 146 if ea==720502004201
replace hh_pop_est_nbs = 157 if ea==720502001201
replace hh_pop_est_nbs = 181 if ea==720502002203
replace hh_pop_est_nbs = 123 if ea==720501006202
replace hh_pop_est_nbs = 171 if ea==720501006201
replace hh_pop_est_nbs = 149 if ea==720501008201
replace hh_pop_est_nbs = 150 if ea==720508001204
replace hh_pop_est_nbs = 153 if ea==720505004202
label var hh_pop_est_nbs "Number of households in each EA per NBS estimates"
tab hh_pop_est_nbs, m

*Calculate first stage weight

gen county_wt1 = (county_hh_pop_nbs / (hh_pop_est_nbs*37))
label var county_wt "First stage county weight 1"

*Calculate final weight
gen final_wt1 = county_wt1 * hh_wt
label var final_wt1 "Final weight - product of county weight 1 and household weight"

*Calculate HH Pop Estimat per MSI
gen hh_pop_est_msi = .
replace hh_pop_est_msi = 106 if ea==720707002203
replace hh_pop_est_msi = 132 if ea==720707002202
replace hh_pop_est_msi = 219 if ea==720707002201
replace hh_pop_est_msi = 163 if ea==720703001108
replace hh_pop_est_msi = 179 if ea==720703001105
replace hh_pop_est_msi = 325 if ea==720703001106
replace hh_pop_est_msi = 203 if ea==720703001107
replace hh_pop_est_msi = 472 if ea==720703001104
replace hh_pop_est_msi = 153 if ea==720703001102
replace hh_pop_est_msi = 246 if ea==720703004203
replace hh_pop_est_msi = 765 if ea==720703004204
replace hh_pop_est_msi = 194 if ea==720703001103
replace hh_pop_est_msi = 355 if ea==720703001101
replace hh_pop_est_msi = 393 if ea==720703004202
replace hh_pop_est_msi = 199 if ea==720703004201
replace hh_pop_est_msi = 266 if ea==720703003207
replace hh_pop_est_msi = 249 if ea==720703003202
replace hh_pop_est_msi = 162 if ea==720703003201
replace hh_pop_est_msi = 170 if ea==720705004204
replace hh_pop_est_msi = 215 if ea==720705003203
replace hh_pop_est_msi = 221 if ea==720705001201
replace hh_pop_est_msi = 119 if ea==720705001203
replace hh_pop_est_msi = 197 if ea==720705003201
replace hh_pop_est_msi = 125 if ea==720705002202
replace hh_pop_est_msi = 99 if ea==720705002203
replace hh_pop_est_msi = 191 if ea==720705001202
replace hh_pop_est_msi = 349 if ea==720706004201
replace hh_pop_est_msi = 646 if ea==720706003201
replace hh_pop_est_msi = 559 if ea==720704002201
replace hh_pop_est_msi = 164 if ea==720704003202
replace hh_pop_est_msi = 117 if ea==720708004202
replace hh_pop_est_msi = 434 if ea==720702003202
replace hh_pop_est_msi = 550 if ea==720702004203
replace hh_pop_est_msi = 375 if ea==720702001202
replace hh_pop_est_msi = 463 if ea==720702003201
replace hh_pop_est_msi = 452 if ea==720702004201
replace hh_pop_est_msi = 234 if ea==720708002202
replace hh_pop_est_msi = 463 if ea==930603001201
replace hh_pop_est_msi = 685 if ea==930604004204
replace hh_pop_est_msi = 274 if ea==930604004202
replace hh_pop_est_msi = 715 if ea==930602002202
replace hh_pop_est_msi = 1052 if ea==930602002204
replace hh_pop_est_msi = 891 if ea==930604002206
replace hh_pop_est_msi = 517 if ea==930602002201
replace hh_pop_est_msi = 974 if ea==930604001206
replace hh_pop_est_msi = 454 if ea==930604002204
replace hh_pop_est_msi = 452 if ea==930608001202
replace hh_pop_est_msi = 1021 if ea==930604004201
replace hh_pop_est_msi = 436 if ea==930602006204
replace hh_pop_est_msi = 754 if ea==930602003201
replace hh_pop_est_msi = 740 if ea==930602003204
replace hh_pop_est_msi = 753 if ea==930602006202
replace hh_pop_est_msi = 144 if ea==930602003206
replace hh_pop_est_msi = 1636 if ea==930605003203
replace hh_pop_est_msi = 717 if ea==930606002201
replace hh_pop_est_msi = 1157 if ea==930605003201
replace hh_pop_est_msi = 214 if ea==930606003203
replace hh_pop_est_msi = 237 if ea==930602005203
replace hh_pop_est_msi = 3773 if ea==930605001202
replace hh_pop_est_msi = 423 if ea==930606003207
replace hh_pop_est_msi = 519 if ea==930605002203
replace hh_pop_est_msi = 2069 if ea==930602005201
replace hh_pop_est_msi = 499 if ea==930602004201
replace hh_pop_est_msi = 1393 if ea==930608004203
replace hh_pop_est_msi = 352 if ea==930608001205
replace hh_pop_est_msi = 1374 if ea==930608004201
replace hh_pop_est_msi = 1079 if ea==930603002201
replace hh_pop_est_msi = 375 if ea==930601002202
replace hh_pop_est_msi = 112 if ea==930601003203
replace hh_pop_est_msi = 383 if ea==930607002202
replace hh_pop_est_msi = 438 if ea==930601003201
replace hh_pop_est_msi = 404 if ea==930607003201
replace hh_pop_est_msi = 103 if ea==930607004203
replace hh_pop_est_msi = 454 if ea==930607001202
replace hh_pop_est_msi = 63 if ea==720401003204
replace hh_pop_est_msi = 319 if ea==720401003202
replace hh_pop_est_msi = 184 if ea==720406001202
replace hh_pop_est_msi = 30 if ea==720401001202
replace hh_pop_est_msi = 140 if ea==720406003202
replace hh_pop_est_msi = 253 if ea==720406003201
replace hh_pop_est_msi = 72 if ea==720406002201
replace hh_pop_est_msi = 280 if ea==720402001202
replace hh_pop_est_msi = 238 if ea==720403002202
replace hh_pop_est_msi = 482 if ea==720403002201
replace hh_pop_est_msi = 240 if ea==720403001201
replace hh_pop_est_msi = 85 if ea==720403004205
replace hh_pop_est_msi = 413 if ea==720403004204
replace hh_pop_est_msi = 153 if ea==720405006204
replace hh_pop_est_msi = 57 if ea==720403001202
replace hh_pop_est_msi = 37 if ea==720403001205
replace hh_pop_est_msi = 94 if ea==720405006203
replace hh_pop_est_msi = 196 if ea==720405005204
replace hh_pop_est_msi = 32 if ea==720405005206
replace hh_pop_est_msi = 129 if ea==720403004202
replace hh_pop_est_msi = 21 if ea==720403003202
replace hh_pop_est_msi = 18 if ea==720405005202
replace hh_pop_est_msi = 172 if ea==720403004203
replace hh_pop_est_msi = 1143 if ea==720402001201
replace hh_pop_est_msi = 220 if ea==720405003205
replace hh_pop_est_msi = 259 if ea==720403003204
replace hh_pop_est_msi = 76 if ea==720405003203
replace hh_pop_est_msi = 215 if ea==720404003202
replace hh_pop_est_msi = 233 if ea==720405003202
replace hh_pop_est_msi = 722 if ea==720403003201
replace hh_pop_est_msi = 127 if ea==720403004201
replace hh_pop_est_msi = 440 if ea==720404002201
replace hh_pop_est_msi = 37 if ea==720401003203
replace hh_pop_est_msi = 73 if ea==730708001203
replace hh_pop_est_msi = 413 if ea==730708001206
replace hh_pop_est_msi = 170 if ea==730701002203
replace hh_pop_est_msi = 73 if ea==730707002203
replace hh_pop_est_msi = 271 if ea==730708001201
replace hh_pop_est_msi = 342 if ea==730701002202
replace hh_pop_est_msi = 14 if ea==730707003202
replace hh_pop_est_msi = 236 if ea==730701003208
replace hh_pop_est_msi = 138 if ea==730701003206
replace hh_pop_est_msi = 65 if ea==730707001202
replace hh_pop_est_msi = 55 if ea==730701001203
replace hh_pop_est_msi = 101 if ea==730701001202
replace hh_pop_est_msi = 157 if ea==730703002103
replace hh_pop_est_msi = 86 if ea==730703001101
replace hh_pop_est_msi = 78 if ea==730703002101
replace hh_pop_est_msi = 128 if ea==730701003205
replace hh_pop_est_msi = 283 if ea==730701003203
replace hh_pop_est_msi = 210 if ea==730701003202
replace hh_pop_est_msi = 202 if ea==730703003201
replace hh_pop_est_msi = 188 if ea==730703003202
replace hh_pop_est_msi = 72 if ea==730705002201
replace hh_pop_est_msi = 115 if ea==730702001203
replace hh_pop_est_msi = 194 if ea==730705003201
replace hh_pop_est_msi = 191 if ea==730702001202
replace hh_pop_est_msi = 92 if ea==730706002204
replace hh_pop_est_msi = 134 if ea==730705001202
replace hh_pop_est_msi = 222 if ea==730706002203
replace hh_pop_est_msi = 68 if ea==730704003201
replace hh_pop_est_msi = 46 if ea==730704001203
replace hh_pop_est_msi = 126 if ea==730706002201
replace hh_pop_est_msi = 147 if ea==730702003202
replace hh_pop_est_msi = 209 if ea==730702003201
replace hh_pop_est_msi = 240 if ea==730704001202
replace hh_pop_est_msi = 173 if ea==730704002202
replace hh_pop_est_msi = 204 if ea==730704002201
replace hh_pop_est_msi = 166 if ea==730706001203
replace hh_pop_est_msi = 122 if ea==730706001202
replace hh_pop_est_msi = 819 if ea==720903003202
replace hh_pop_est_msi = 233 if ea==720901003201
replace hh_pop_est_msi = 1477 if ea==720903005205
replace hh_pop_est_msi = 25 if ea==720905004203
replace hh_pop_est_msi = 32 if ea==720902002204
replace hh_pop_est_msi = 273 if ea==720902007203
replace hh_pop_est_msi = 391 if ea==720902002205
replace hh_pop_est_msi = 98 if ea==720902003203
replace hh_pop_est_msi = 106 if ea==720902003201
replace hh_pop_est_msi = 299 if ea==720902006202
replace hh_pop_est_msi = 40 if ea==720908006201
replace hh_pop_est_msi = 81 if ea==720908006202
replace hh_pop_est_msi = 7 if ea==720908006206
replace hh_pop_est_msi = 300 if ea==720902006201
replace hh_pop_est_msi = 38 if ea==720907004203
replace hh_pop_est_msi = 40 if ea==720907001208
replace hh_pop_est_msi = 76 if ea==720907010203
replace hh_pop_est_msi = 469 if ea==720905006201
replace hh_pop_est_msi = 235 if ea==720907002201
replace hh_pop_est_msi = 92 if ea==720907009110
replace hh_pop_est_msi = 94 if ea==720907009103
replace hh_pop_est_msi = 65 if ea==720907009104
replace hh_pop_est_msi = 72 if ea==720907006202
replace hh_pop_est_msi = 7 if ea==720907006204
replace hh_pop_est_msi = 76 if ea==720904006205
replace hh_pop_est_msi = 76 if ea==720904006204
replace hh_pop_est_msi = 66 if ea==720904001203
replace hh_pop_est_msi = 238 if ea==720904003210
replace hh_pop_est_msi = 124 if ea==720904005204
replace hh_pop_est_msi = 142 if ea==720904005203
replace hh_pop_est_msi = 74 if ea==720904010203
replace hh_pop_est_msi = 63 if ea==720904010205
replace hh_pop_est_msi = 137 if ea==720904007207
replace hh_pop_est_msi = 202 if ea==720901003203
replace hh_pop_est_msi = 191 if ea==720901006202
replace hh_pop_est_msi = 27 if ea==720904004203
replace hh_pop_est_msi = 211 if ea==720907009107
replace hh_pop_est_msi = 353 if ea==720507002202
replace hh_pop_est_msi = 1122 if ea==720508004201
replace hh_pop_est_msi = 607 if ea==720508003201
replace hh_pop_est_msi = 155 if ea==720508003204
replace hh_pop_est_msi = 98 if ea==720508001202
replace hh_pop_est_msi = 242 if ea==720504007201
replace hh_pop_est_msi = 141 if ea==720504005201
replace hh_pop_est_msi = 301 if ea==720503001203
replace hh_pop_est_msi = 79 if ea==720504005203
replace hh_pop_est_msi = 241 if ea==720503002206
replace hh_pop_est_msi = 216 if ea==720503001205
replace hh_pop_est_msi = 279 if ea==720503002203
replace hh_pop_est_msi = 188 if ea==720503004202
replace hh_pop_est_msi = 171 if ea==720505003201
replace hh_pop_est_msi = 164 if ea==720506001201
replace hh_pop_est_msi = 435 if ea==720503005202
replace hh_pop_est_msi = 337 if ea==720505002202
replace hh_pop_est_msi = 315 if ea==720505001202
replace hh_pop_est_msi = 235 if ea==720503007202
replace hh_pop_est_msi = 274 if ea==720503005201
replace hh_pop_est_msi = 447 if ea==720505002201
replace hh_pop_est_msi = 114 if ea==720506005201
replace hh_pop_est_msi = 89 if ea==720503008202
replace hh_pop_est_msi = 337 if ea==720506002203
replace hh_pop_est_msi = 245 if ea==720502003202
replace hh_pop_est_msi = 149 if ea==720501002201
replace hh_pop_est_msi = 346 if ea==720502001203
replace hh_pop_est_msi = 149 if ea==720501004204
replace hh_pop_est_msi = 82 if ea==720501003202
replace hh_pop_est_msi = 169 if ea==720502004201
replace hh_pop_est_msi = 221 if ea==720502001201
replace hh_pop_est_msi = 552 if ea==720502002203
replace hh_pop_est_msi = 188 if ea==720501006202
replace hh_pop_est_msi = 60 if ea==720501006201
replace hh_pop_est_msi = 72 if ea==720501008201
replace hh_pop_est_msi = 135 if ea==720508001204
replace hh_pop_est_msi = 200 if ea==720505004202

label var hh_pop_est_msi "Number of households in each EA per MSI estimates"
tab hh_pop_est_msi, m

*Calculate first stage weight

gen county_wt2 = (county_hh_pop_msi / (hh_pop_est_msi*37))
label var county_wt2 "First stage county weight 2"

*Calculate final weight
gen final_wt2 = county_wt2 * hh_wt
label var final_wt2 "Final weight - product of county weight 2 and household weight"

order county_hh_pop_nbs hh_pop_est_nbs county_wt1 county_hh_pop_msi hh_pop_est_msi county_wt2 hh_pop_list hh_sample hh_wt final_wt1 final_wt2, after(ea)

/*
 
order county_hh_pop hh_pop_est hh_pop_msi county_wt, before(hh_pop_list)
label var hh_pop_msi "Estimated HH Pop by MSI"

gen variance = hh_pop_msi - hh_pop_list
label var variance "Diff b/w MSI estimate and listing"

gen variance_sign = 1
replace variance_sign = 0 if variance<0
label var variance_sign "Is variance positive or negative"
label def pos 0 "Negative" 1 "Positive"

gen abs_variance = abs(hh_pop_msi - hh_pop_list)
label var abs_variance "Absolute diff b/w MSI estimate and listing"

gen variance_pcnt = (variance / hh_pop_list) * 100
label var variance_pcnt "Percentage diff b/w MSI estimate and listing"

gen abs_variance_pcnt = (abs_variance / hh_pop_list) * 100
label var abs_variance_pcnt "Absolute percentage diff b/w MSI estimate and listing"

gen variance_flag = 0
replace variance_flag = 1 if abs_variance_pcnt>20
tab variance_flag, m
label var variance_flag "Absolute variance percentage > 20%"
*/

*Save
save "`outpath'mesp_household_baseline_survey_weights.dta", replace
export excel using "`outpath'mesp_household_baseline_survey_weights.xlsx", firstrow(variables) nolabel missing(".") replace
codebookout "`outpath'mesp_household_baseline_codebook_survey_weights.xlsx", replace 

twoway (histogram final_wt1, start(0) width(20) freq lcolor(blue) fcolor(none)) (histogram final_wt2 if final_wt2<2000, start(0) width(20) freq lcolor(red) fcolor(none)), legend(order(1 "NBS" 2 "MSI")) note("Histogram excludes MSI weight of 5605")

graph save "`outpath'mesp_household_baseline_weights_histogram", replace
graph export "`outpath'mesp_household_baseline_weights_histogram.png", replace

twoway (histogram final_wt1 if county=="Akobo", start(0) width(20) freq lcolor(blue) fcolor(none)) (histogram final_wt2 if county=="Akobo", start(0) width(20) freq lcolor(red) fcolor(none)), legend(order(1 "NBS" 2 "MSI"))

graph save "`outpath'mesp_household_baseline_weights_akobo_histogram", replace
graph export "`outpath'mesp_household_baseline_weights_akobo_histogram.png", replace

twoway (histogram final_wt1 if county=="Budi", start(0) width(20) freq lcolor(blue) fcolor(none)) (histogram final_wt2 if county=="Budi", start(0) width(20) freq lcolor(red) fcolor(none)), legend(order(1 "NBS" 2 "MSI"))

graph save "`outpath'mesp_household_baseline_weights_budi_histogram", replace
graph export "`outpath'mesp_household_baseline_weights_budi_histogram.png", replace

twoway (histogram final_wt1 if county=="Duk", start(0) width(20) freq lcolor(blue) fcolor(none)) (histogram final_wt2 if county=="Duk", start(0) width(20) freq lcolor(red) fcolor(none)), legend(order(1 "NBS" 2 "MSI"))

graph save "`outpath'mesp_household_baseline_weights_duk_histogram", replace
graph export "`outpath'mesp_household_baseline_weights_duk_histogram.png", replace

twoway (histogram final_wt1 if county=="Leer", start(0) width(20) freq lcolor(blue) fcolor(none)) (histogram final_wt2 if county=="Leer", start(0) width(20) freq lcolor(red) fcolor(none)), legend(order(1 "NBS" 2 "MSI"))

graph save "`outpath'mesp_household_baseline_weights_leer_histogram", replace
graph export "`outpath'mesp_household_baseline_weights_leer_histogram.png", replace

twoway (histogram final_wt1 if county=="Pibor", start(0) width(20) freq lcolor(blue) fcolor(none)) (histogram final_wt2 if county=="Pibor" & final_wt2<2000, start(0) width(20) freq lcolor(red) fcolor(none)), legend(order(1 "NBS" 2 "MSI")) note("Histogram excludes MSI weight of 5605")

graph save "`outpath'mesp_household_baseline_weights_pibor_histogram", replace
graph export "`outpath'mesp_household_baseline_weights_pibor_histogram.png", replace

twoway (histogram final_wt1 if county=="Uror", start(0) width(20) freq lcolor(blue) fcolor(none)) (histogram final_wt2 if county=="Uror", start(0) width(20) freq lcolor(red) fcolor(none)), legend(order(1 "NBS" 2 "MSI"))

graph save "`outpath'mesp_household_baseline_weights_uror_histogram", replace
graph export "`outpath'mesp_household_baseline_weights_uror_histogram.png", replace

graph close

*Merge weights with dataset
merge 1:m ea using "`inpath'mesp_household_baseline_hh_survey_scored.dta" // perfect merge

drop _merge row_id

order county_hh_pop_nbs hh_pop_est_nbs county_wt1 county_hh_pop_msi hh_pop_est_msi county_wt2 hh_pop_list hh_sample hh_wt final_wt1 final_wt2, after(resil_c)

order state county payam boma ea, after(record_id)

*Set Survey specifications
*egen countyXea=group(county ea)
*label var countyXea "Stage 1 Stratification"

*egen countyXeaXrecord=group(county ea record_id)
*label var countyXeaXrecord "Stage 2 Stratification"

drop county_hh_pop_msi hh_pop_est_msi county_wt2 final_wt2

svyset ea [pweight = final_wt1], strata (county) fpc(county_hh_pop_nbs) || record_id, fpc(hh_pop_list) strata (record_id) singleunit(scaled) vce(linearized)

*save
save "`outpath'mesp_household_baseline_hh_survey_weighted.dta", replace


*svyset ea [pweight = final_wt2], strata (county) fpc(county_hh_pop_msi) || record_id, fpc(hh_pop_list) strata (record_id) singleunit(scaled) vce(linearized)

*save
*save "`outpath'mesp_household_baseline_hh_survey_weighted2.dta", replace