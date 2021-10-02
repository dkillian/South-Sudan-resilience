*******************************************************************************
* South Sudan Baseline Household Survey
* Sean Kelly
* July 30, 2021
* File uses: mesp_household_baseline_survey_clean.dta
* mesp_household_baseline_survey_hh_schedule_clean.dta
* File saves: mesp_household_baseline_hh_survey_scored.dta
* mesp_household_baseline_survey_hh_schedule_scored.dta
* This file creates variables required for the analysis of indicators in the SOW
*******************************************************************************

* Datasets of interest and variables within each file - macro names match filename infixes *
local inpath "W:\Shared\Projects\6073.04 SSD MESP\Tech\Deliverables\Household Survey\Baseline\data\03_clean\"
local outpath "W:\Shared\Projects\6073.04 SSD MESP\Tech\Deliverables\Household Survey\Baseline\data\04_scoring\"

use "`inpath'mesp_household_baseline_survey_clean.dta", clear

*1	Level of knowledge of organizations doing humanitarian or development work in the community
 /* uses q_504, no scoring */
 
tab q_504 county, m

*2	Aspirations index
gen abs_fatalism1 = 0
replace abs_fatalism1 = 1 if q_629==1 & q_630==1
replace abs_fatalism1 = . if (q_629==. & q_630==.) | (q_629==. & q_630!=.) | (q_629!=. & q_630==.)
label var abs_fatalism1 "Absence Fatalism Sub-Index Component 1"
tab abs_fatalism1 county, m

gen abs_fatalism2 = 0
replace abs_fatalism2 = 1 if q_634==4 | q_634==5 | q_634==6
replace abs_fatalism2 = . if q_634==.
label var abs_fatalism2 "Absence Fatalism Sub-Index Component 2"
tab abs_fatalism2 county, m

gen abs_fatalism3 = 0
replace abs_fatalism3 = 1 if q_635==4 | q_635==5 | q_635==6
replace abs_fatalism3 = . if q_635==.
label var abs_fatalism3 "Absence Fatalism Sub-Index Component 3"
tab abs_fatalism3 county, m

gen belief_future=0
replace belief_future=1 if q_632==1 & (q_633==4 | q_633==5)
replace belief_future=. if q_632==. & q_633==.
label var belief_future "Belief in Future Sub-Index"
tab belief_future county, m

gen aspirations_index = abs_fatalism1 + abs_fatalism2 + abs_fatalism3 + belief_future
label var aspirations_index "Aspirations Index"
tab aspirations_index county, m

*3	Percent of households reporting participation in community groups
gen grp_participate = 0
replace grp_participate = 1 if (q_501a==1 & q_502a==1) | (q_501b==1 & q_502b==1) | (q_501c==1 & q_502c==1) | (q_501d==1 & q_502d==1) | (q_501e==1 & q_502e==1) | (q_501f==1 & q_502f==1) | (q_501g==1 & q_502g==1) | (q_501h==1 & q_502h==1) | (q_501i==1 & q_502i==1) | (q_501j==1 & q_502j==1) | (q_501k==1 & q_502k==1) | (q_501l==1 & q_502l==1) | (q_501m==1 & q_502m==1) | (q_501n==1 & q_502n==1) | (q_501o==1 & q_502o==1) | (q_501p==1 & q_502p==1)

replace grp_participate = . if (q_501a==. & q_502a==.) & (q_501b==. & q_502b==.) & (q_501c==. & q_502c==.) & (q_501d==. & q_502d==.) & (q_501e==. & q_502e==.) & (q_501f==. & q_502f==.) & (q_501g==. & q_502g==.) & (q_501h==. & q_502h==.) & (q_501i==. & q_502i==.) & (q_501j==. & q_502j==.) & (q_501k==. & q_502k==.) & (q_501l==. & q_502l==.) & (q_501m==. & q_502m==.) & (q_501n==. & q_502n==.) & (q_501o==. & q_502o==.) & (q_501p==. & q_502p==.)

label var grp_participate "Community Group Participation"

tab grp_participate county, m
label def grpp 0 "No, does not participate" 1 "Yes, participates in groups"
label val grp_participate grpp

*4	Percent of households reporting symptoms of trauma
gen trauma = 0
replace trauma = 1 if q_711==1 | q_715==1 | q_719==1 | q_723==1 | q_727==1 | q_731==1
replace traum = . if q_711==. & q_715==. & q_719==. & q_723==. & q_727==. & q_731==.
label var trauma "Incidence of trauma"

label def trm 0 "No incidence of trauma" 1 "Yes, incidence of trauma"
label val trauma trm 

tab trauma county, m

*5	Local perception of quality of available health services
 /* uses q_706, no scoring */

tab q_706 county, m

gen q_706_bin = .
replace q_706_bin = 0 if q_706==4
replace q_706_bin = 0 if q_706==5
replace q_706_bin = 1 if q_706==1
replace q_706_bin = 1 if q_706==2
replace q_706_bin = 1 if q_706==3
order q_706_bin, after(q_706)
label var q_706_bin "Q706: Quality of healthcare services (binary)"
label def pn 0 "Negative Impression" 1 "Positive Impression"
tab q_706 q_706_bin, m

*6	Household diversity of income-earning sources

local hhiv q_401_a q_401_b q_401_c q_401_d q_401_e q_401_f q_401_g q_401_h q_401_i q_401_j q_401_k q_401_l q_401_m q_401_n q_401_o q_401_p q_401_q q_401_r q_401_s q_401_t q_401_u

foreach hh of local hhiv {
recode `hh' (8=0) (9=0) (.=0), gen(`hh'_bin)
order `hh'_bin, after(`hh')
label val `hh'_bin yesno
tab `hh'_bin, m
}
*
label var q_401_a_bin "Q 401_a: Sources of HH food/income - Own farming/crop production (binary)"
label var q_401_b_bin "Q 401_b: Sources of HH food/income - Own cattle production (binary)"
label var q_401_c_bin "Q 401_c: Sources of HH food/income - Own goats production (binary)"
label var q_401_d_bin "Q 401_d: Sources of HH food/income - Own sheep production (binary)"
label var q_401_e_bin "Q 401_e: Sources of HH food/income - Own fishing and sales (binary)"
label var q_401_f_bin "Q 401_f: Sources of HH food/income - Ag wage labor (within the village) (binary)"
label var q_401_g_bin "Q 401_g: Sources of HH food/income - Ag wage labor (outside of village) (binary)"
label var q_401_h_bin "Q 401_h: Sources of HH food/income - Non-ag wage labor (within village) (binary)"
label var q_401_i_bin "Q 401_i: Sources of HH food/income - Non-ag wage labor (outside of village) (binary)"
label var q_401_j_bin "Q 401_j: Sources of HH food/income - Salaried work (binary)"
label var q_401_k_bin "Q 401_k: Sources of HH food/income - Sale of wild bush products (binary)"
label var q_401_l_bin "Q 401_l: Sources of HH food/income - Honey production and sales (binary)"
label var q_401_m_bin "Q 401_m: Sources of HH food/income - Petty trade (selling other products) (binary)"
label var q_401_n_bin "Q 401_n: Sources of HH food/income - Petty trade (selling own products) (binary)"
label var q_401_o_bin "Q 401_o: Sources of HH food/income - Self-employment / own business (ag) (binary)"
label var q_401_p_bin "Q 401_p: Sources of HH food/income - Self-employment / own business (non-ag) (binary)"
label var q_401_q_bin "Q 401_q: Sources of HH food/income - Rental of land, house, rooms (binary)"
label var q_401_r_bin "Q 401_r: Sources of HH food/income - Remittances (binary)"
label var q_401_s_bin "Q 401_s: Sources of HH food/income - Gifts / inheritance (binary)"
label var q_401_t_bin "Q 401_t: Sources of HH food/income - Safety net food / cash assistance (binary)"
label var q_401_u_bin "Q 401_u: Sources of HH food/income - Other (binary)"

local hhrv q_402_a q_402_b q_402_c q_402_d q_402_e q_402_f q_402_g q_402_h q_402_i q_402_j q_402_k q_402_l q_402_m q_402_n q_402_o q_402_p q_402_q q_402_r q_402_s q_402_t q_402_u

label def hhrks 0 "Unranked" 1 "First" 2 "Second" 3 "Third"

foreach hh of local hhrv {
recode `hh' (.=0), gen(`hh'_quart)
order `hh'_quart, after(`hh')
label val `hh'_quart hhrks
tab `hh'_quart, m
}
*

label var q_402_a_quart "Q 402_a: Rank sources - Own farming/crop production (quart)"
label var q_402_b_quart "Q 402_b: Rank sources - Own cattle production (quart)"
label var q_402_c_quart "Q 402_c: Rank sources - Own goats production (quart)"
label var q_402_d_quart "Q 402_d: Rank sources - Own sheep production (quart)"
label var q_402_e_quart "Q 402_e: Rank sources - Own fishing and sales (quart)"
label var q_402_f_quart "Q 402_f: Rank sources - Ag wage labor (within the village) (quart)"
label var q_402_g_quart "Q 402_g: Rank sources - Ag wage labor (outside of village) (quart)"
label var q_402_h_quart "Q 402_h: Rank sources - Non-ag wage labor (within village) (quart)"
label var q_402_i_quart "Q 402_i: Rank sources - Non-ag wage labor (outside of village) (quart)"
label var q_402_j_quart "Q 402_j: Rank sources - Salaried work (quart)"
label var q_402_k_quart "Q 402_k: Rank sources - Sale of wild bush products (quart)"
label var q_402_l_quart "Q 402_l: Rank sources - Honey production and sales (quart)"
label var q_402_m_quart "Q 402_m: Rank sources - Petty trade (selling other products) (quart)"
label var q_402_n_quart "Q 402_n: Rank sources - Petty trade (selling own products) (quart)"
label var q_402_o_quart "Q 402_o: Rank sources - Self-employment / own business (ag) (quart)"
label var q_402_p_quart "Q 402_p: Rank sources - Self-employment / own business (non-ag) (quart)"
label var q_402_q_quart "Q 402_q: Rank sources - Rental of land, house, rooms (quart)"
label var q_402_r_quart "Q 402_r: Rank sources - Remittances (quart)"
label var q_402_s_quart "Q 402_s: Rank sources - Gifts / inheritance (quart)"
label var q_402_t_quart "Q 402_t: Rank sources - Safety net food / cash assistance (quart)"
label var q_402_u_quart "Q 402_u: Rank sources - Other (quart)"

*7	Local perception of SGBV
 /* uses q_812, no scoring */

tab q_812 county, m

gen q_812_bin = 1
replace q_812_bin = 0 if q_812==1
replace q_812_bin = . if q_812==.
tab q_812 q_812_bin, m

order q_812_bin, after(q_812)
label var q_812_bin "Q812: Is gender-based violence acceptable (binary)"
label def acpt 0 "Not acceptable" 1 "Acceptable"
label val q_812_bin acpt

*8	Household Dietary Diversity Scale
local hddsvars q_403 q_404 q_405 q_406 q_407 q_408 q_409 q_410 q_411 q_412 q_413 q_414 q_415 q_416 q_417 q_418 q_419
foreach hdv of local hddsvars {
replace `hdv'=0 if `hdv'==.	
}
*

gen vegetable = 0
replace vegetable = 1 if q_405==1 | q_406==1 | q_407==1
replace vegetable = . if q_405==. & q_406==. & q_407==.
label var vegetable "HDDS - Vegetables"
tab vegetable county, m

gen fruit = 0 
replace fruit = 1 if q_408==1 | q_409==1
replace fruit = . if q_408==. & q_409==.
label var fruit "HDDS - Fruits"
tab fruit county, m

gen meat = 0
replace meat = 1 if q_410==1 | q_411==1 | q_412==1
replace meat = . if q_410==. & q_411==. & q_412==.
label var meat "HDDS - Meats"
tab meat county, m

gen hdds = q_403 + q_404 + vegetable + fruit + meat + q_413 + q_414 + q_415 + q_416 + q_417 + q_418 + q_419
label var hdds "HDDS Score"
tab hdds county, m

*9	Number of reported conflicts
 /* uses q_601, no scoring */

tab q_601 county, m

*10	Severity of reported conflicts (deaths, loss of assets, displacements)
 /* uses q_603, no scoring */

tab q_603 county, m

gen q_603_clean = .
replace q_603_clean=1 if q_603==1
replace q_603_clean=2 if q_603==2
replace q_603_clean=3 if q_603==3
replace q_603_clean=4 if q_603==4
order q_603_clean, after(q_603)
label var q_603 "Q603: How severe an impact did conflict have on HH ability to meet needs"
label val q_603_clean cimpact

*11	Level of bonding social capital, among members of targeted communities

tab q_490, m
tab q_491, m

recode q_491 (2=0) (3=0) (.=0), generate(rc_q_491)
replace rc_q_491=. if q_490==.

tab q_491 rc_q_491, m
order rc_q_491, after(q_491) 
label var rc_q_491 "Q491: Recode for bonding social capital sub-index"

tab q_494, m
tab q_495, m

recode q_495 (2=0) (3=0) (.=0), generate(rc_q_495)
replace rc_q_495=. if q_494==.

tab q_495 rc_q_495, m
order rc_q_495, after(q_495) 
label var rc_q_495 "Q495: Recode for bonding social capital sub-index"

gen bonding_capital_raw = q_490 + rc_q_491 + q_494 + rc_q_495
tab bonding_capital_raw, m // 23 missing values
tab bonding_capital_raw
label var bonding_capital_raw "Bonding Capital Raw Score"

/*Bonding sub-index= Weighted sum of 0/1 responses to questions 1, 2, 5 and 6 / survey-weighted number of households in the
sample with social capital data / 4 * 100*/

*gen bonding_capital_score = bonding_capital_raw / (r(N)) / 4 * 100

gen bonding_capital_score = (bonding_capital_raw / 4) * 100

tab bonding_capital_score county, m

label var bonding_capital_score "Bonding Capital Score Scaled"

*12	Level of bridging social capital, among members of targeted communities
tab q_492, m
tab q_493, m

recode q_493 (2=0) (3=0) (.=0), generate(rc_q_493)
replace rc_q_493=. if q_492==.

tab q_493 rc_q_493, m
order rc_q_493, after(q_493) 
label var rc_q_493 "Q493: Recode for bridging social capital sub-index"

tab q_496, m
tab q_497, m

recode q_497 (2=0) (3=0) (.=0), generate(rc_q_497)
replace rc_q_497=. if q_496==.

tab q_497 rc_q_497, m

order rc_q_497, after(q_497) 
label var rc_q_497 "Q497: Recode for bridging social capital sub-index"

gen bridging_capital_raw = q_492 + rc_q_493 + q_496 + rc_q_497
tab bridging_capital_raw, m // 29 missing values
label var bridging_capital_raw "Bridging Capital Raw Score"


/*Bridging sub-index = Weighted sum of 0/1 responses to questions 3, 4, 7 and 8 / survey-weighted number of households in the
sample with social capital data / 4 * 100 */

*gen bridging_capital_score = bridging_capital_raw / (r(N)) / 4 * 100

gen bridging_capital_score = (bridging_capital_raw / 4) * 100

tab bridging_capital_score county, m

label var bridging_capital_score "Bridging Capital Score Scaled"

*13	Level of acceptance of targeted social practices

*Cattle raiding: q_802
*Early marriage: q_803

tab q_802 county, m

tab q_803 county, m

gen q_802_bin = 1
replace q_802_bin = 0 if q_802==5
replace q_802_bin = . if q_802==.
tab q_802 q_802_bin, m

order q_802_bin, after(q_802)
label var q_802_bin "Q802: Is cattle raiding acceptable (binary)"
label val q_802_bin acpt


gen q_803_bin = 1
replace q_803_bin = 0 if q_803==5
replace q_803_bin = . if q_803==.
tab q_803 q_803_bin, m

order q_803_bin, after(q_803)
label var q_803_bin "Q803: Is early marriage acceptable (binary)"
label val q_803_bin acpt

*14	Households’ positions on food security scale, within targeted communities

gen fies_raw = q_422 + q_423 + q_424 + q_425 + q_426 + q_427 + q_428 + q_429

tab fies_raw county, m

label var fies_raw "Food Insecurity Experience Scale (HH) Raw"

*15	Perception of usefulness of emergency community action plans
tab q_610 county, m // if community has plan

tab q_612 county, m // effectiveness of plan

*16	Percent of households which report favorable opinions of educating girls
tab q_813 county, m // What is the most influential factor in your household in determining which family member receives education?

tab q_814 county, m // Girls should receive the same education opportunities as boys

gen q_814_bin = .
replace q_814_bin=0 if q_814==1
replace q_814_bin=0 if q_814==2
replace q_814_bin=0 if q_814==3
replace q_814_bin=1 if q_814==4
replace q_814_bin=1 if q_814==5
replace q_814_bin=1 if q_814==6
tab q_814 q_814_bin, m

order q_814_bin, after(q_814)
label var q_814_bin "Q814: Girls should receive same edu opportunities as boys (binary)"
label def adbin 0 "Disagree" 1 "Agree"
label val q_814_bin adbin

*17	Level of confidence in community and other sub-national institutions that govern natural resources
tab q_511 county, m

tab q_513 county, m

gen q_513_bin = .
replace q_513_bin = 0 if q_513==1
replace q_513_bin = 0 if q_513==2
replace q_513_bin = 1 if q_513==3
replace q_513_bin = 1 if q_513==4
order q_513_bin, after(q_513)
label var q_513_bin "Q513: Confidence in institutions that control resources (binary)"
label def conf2 0 "None or little confidence" 1 "Confidence"
label val q_513_bin conf2

tab q_513 q_513_bin, m

*18	Level of acceptance of trafficking in persons (TIP)
tab q_829 county, m

gen q_829_bin = 1
replace q_829_bin = 0 if q_829==6
replace q_829_bin = . if q_829==.
tab q_829 q_829_bin, m

order q_829_bin, after(q_829)
label var q_829_bin "Q829: Is trafficking in persons acceptable (binary)"
label val q_829_bin acpt

tab q_830_new county, m

gen q_830_bin = .
replace q_830_bin=0 if q_830_new==1
replace q_830_bin=0 if q_830_new==2
replace q_830_bin=0 if q_830_new==3
replace q_830_bin=1 if q_830_new==4
replace q_830_bin=1 if q_830_new==5
replace q_830_bin=1 if q_830_new==6
tab q_830_new q_830_bin, m

order q_830_bin, after(q_830_new)
label var q_830_bin "Q830: Trafficking is acceptable to obtain a wife (binary)"
label val q_830_bin adbin

tab q_831_new county, m

gen q_831_bin = .
replace q_831_bin=0 if q_831_new==1
replace q_831_bin=0 if q_831_new==2
replace q_831_bin=0 if q_831_new==3
replace q_831_bin=1 if q_831_new==4
replace q_831_bin=1 if q_831_new==5
replace q_831_bin=1 if q_831_new==6
tab q_831_new q_831_bin, m

order q_831_bin, after(q_831_new)
label var q_831_bin "Q831: Trafficking is acceptable to obtain cattle (binary)"
label val q_831_bin adbin

tab q_832_new county, m

gen q_832_bin = .
replace q_832_bin=0 if q_832_new==1
replace q_832_bin=0 if q_832_new==2
replace q_832_bin=0 if q_832_new==3
replace q_832_bin=1 if q_832_new==4
replace q_832_bin=1 if q_832_new==5
replace q_832_bin=1 if q_832_new==6
tab q_832_new q_832_bin, m

order q_832_bin, after(q_832_new)
label var q_832_bin "Q832: Trafficking is acceptable to obtain land (binary)"
label val q_832_bin adbin

*19	Level of acceptance of the practice of bride prices
tab q_824 county, m

gen q_824_bin = .
replace q_824_bin = 0 if q_824==1
replace q_824_bin = 1 if q_824>1 & q_824<.
replace q_824_bin = . if q_824==.
tab q_824 q_824_bin, m

order q_824_bin, after(q_824)
label var q_824_bin "Q824: Are you willing to accept bride price (binary)"
label val q_824_bin acpt

tab q_825 county, m

gen q_825_bin = .
replace q_825_bin=0 if q_825==1
replace q_825_bin=0 if q_825==2
replace q_825_bin=0 if q_825==3
replace q_825_bin=1 if q_825==4
replace q_825_bin=1 if q_825==5
replace q_825_bin=1 if q_825==6
tab q_825 q_825_bin, m

order q_825_bin, after(q_825)
label var q_825_bin "Q825: Bride price is an acceptable transaction (binary)"
label val q_825_bin adbin

tab q_827 county, m

gen q_827_bin = .
replace q_827_bin=0 if q_827==1
replace q_827_bin=0 if q_827==2
replace q_827_bin=0 if q_827==3
replace q_827_bin=1 if q_827==4
replace q_827_bin=1 if q_827==5
replace q_827_bin=1 if q_827==6
tab q_827 q_827_bin, m

order q_827_bin, after(q_827)
label var q_827_bin "Q827: Bride price is an important tradition (binary)"
label val q_827_bin adbin

*20	Level of confidence in community institutions that oversee, monitor, or direct humanitarian and development investments
tab q_508 county, m

tab q_510 county, m

gen q_510_bin = .
replace q_510_bin = 0 if q_510==1
replace q_510_bin = 0 if q_510==2
replace q_510_bin = 1 if q_510==3
replace q_510_bin = 1 if q_510==4
order q_510_bin, after(q_510)
label var q_510_bin "Q510: Confidence in institutions that assistance (binary)"
label val q_510_bin conf2
tab q_510 q_510_bin, m

*21	Proportion of households which participate in an early warning system

gen ews_participate = 0
replace ews_participate = 1 if q_607_a==1 | q_607_b==1 | q_607_c==1 | q_607_d==1 | q_607_e==1 | q_607_f==1 | q_607_g==1 | q_607_h==1 | q_607_i==1 | q_607_j==1 | q_607_k==1

replace ews_participate = . if q_607_a==. & q_607_b==. & q_607_c==. & q_607_d==. & q_607_e==. & q_607_f==. & q_607_g==. & q_607_h==. & q_607_i==. & q_607_j==. & q_607_k==.

label var ews_participate "Early Warning System Participation"

label def ewsp 0 "No, does not participate" 1 "Yes, participates in EWS"
label val ews_participate ewsp

tab ews_participate county, m

*22	Proportion of children in target areas (9-59 months) vaccinated for measles

*Need HH schedule --> q_315

*23	Percent of population that are satisfied with government services
tab q_517 county, m

tab q_519 county, m

*24	Level of satisfaction with the involvement of traditional leaders in conflict resolution

tab q_605 county, m

tab q_606 county, m

*25	Perception of improved state/government legitimacy
tab q_520 county, m

*26	Ability to recover from shocks and stresses index
gen shock_stress = . 

replace shock_stress = 1 if q_436==1 | q_439==1 | q_442==1 | q_445==1 | q_448==1 | q_451==1 | q_455==1 | q_458==1 | q_461==1 | q_464==1 | q_468==1 | q_471==1 | q_474==1 | q_477==1 | q_480==1 | q_484==1

replace shock_stress = 0 if (q_436==0 | q_436==.) & (q_439==0 | q_439==.) & (q_442==0 | q_442==.) & (q_445==0 | q_445==.) & (q_448==0 | q_448==.) & (q_451==0 | q_451==.) & (q_455==0 | q_455==.) & (q_458==0 | q_458==.) & (q_461==0 | q_461==.) & (q_464==0 | q_464==.) & (q_468==0 | q_468==.) & (q_471==0 | q_471==.) & (q_474==0 | q_474==.) & (q_477==0 | q_477==.) & (q_480==0 | q_480==.) & (q_484==0 | q_484==.) 

replace shock_stress = . if q_436==. & q_439==. & q_442==. & q_445==. & q_448==. & q_451==. & q_455==. & q_458==. & q_461==. & q_464==. & q_468==. & q_471==. & q_474==. & q_477==. & q_480==. & q_484==. 

tab shock_stress, m

label var shock_stress "Whether HH experienced a shock or stress"

recode q_488 (3=1)(1=3), gen(rc_q_488)
recode q_489 (3=1)(1=3), gen(rc_q_489)
order rc_q_488, after(q_488)
order rc_q_489, after(q_489)
label var rc_q_488 "Q 488:Recode for ability to recover"
label var rc_q_489 "Q 489:Recode for ability to recover"

gen ability_recover = rc_q_488 + rc_q_489
tab ability_recover, m

label var ability_recover "Ability to Recover Raw"

replace q_438=1 if record_id=="e3a8224d-24bf-4585-bf5e-7531c4e9c0a6"
replace q_438=1 if record_id=="dee62f97-124d-4b05-b2d5-ae466d01c049"
gen flood_severity = q_437 + q_438
replace flood_severity = 0 if q_436!=1
tab flood_severity, m
label var flood_severity "Flood severity index"

replace q_441=1 if record_id=="825a548c-a913-45fd-af6d-4aee24df3c5a"
gen little_rain_severity = q_440 + q_441
replace little_rain_severity = 0 if q_439!=1
tab little_rain_severity, m
label var little_rain_severity "Little rain severity index"

replace q_444=1 if record_id=="8b4332a3-62b4-4d33-96bb-5a421cd4a4d1"
replace q_444=1 if record_id=="b679076d-eae2-4c20-830b-ce9bd0aa6c7f"
gen erosion_severity = q_443 + q_444
replace erosion_severity = 0 if q_442!=1
tab erosion_severity, m
label var erosion_severity "Erosion severity index"

replace q_447 = 1 if record_id=="cbd3e9c5-1497-4d2a-a5a2-2c0f2a318690"
gen loss_land_severity = q_446 + q_447
replace loss_land_severity = 0 if q_445!=1
tab loss_land_severity, m
label var loss_land_severity "Loss of land severity index"

replace q_450=1 if record_id=="00dad3fe-3e59-4d67-97eb-f293859a0e9f"
replace q_449=1 if record_id=="1e4a05e9-5c6e-4633-bd45-d0116456a973"
replace q_450=1 if record_id=="757c44c5-4420-40d0-a0ad-ff123236e388"
replace q_450=1 if record_id=="4cf2b95b-f061-4f43-bde4-7c79434d5950"
replace q_450=1 if record_id=="7166a5af-eee3-4f6c-85e9-162773f11028"
gen food_price_inc_severity = q_449 + q_450
replace food_price_inc_severity = 0 if q_448!=1
tab food_price_inc_severity, m
label var food_price_inc_severity "Food price increase severity index"


replace q_453=1 if record_id=="ed31847e-fc0f-48b5-8b62-ebd7624d801b"
replace q_453=1 if record_id=="db9e9ea3-4717-41e5-be8a-3c1753689dc0"
replace q_453=1 if record_id=="b983f8a8-784a-4c87-8a30-b629ab7cec14"
gen theft_severity = q_452 + q_453
replace theft_severity = 0 if q_451!=1
tab theft_severity, m
label var theft_severity "Theft severity index"

replace q_457=1 if record_id=="c9ba1ed1-65b7-4c0c-a02e-0f7521f26d9d"
gen ag_input_severity = q_456 + q_457
replace ag_input_severity = 0 if q_455!=1
tab ag_input_severity, m
label var ag_input_severity "Agriculture input severity index"

gen crop_disease_severity = q_459 + q_460
replace crop_disease_severity = 0 if q_458!=1
tab crop_disease_severity, m
label var crop_disease_severity "Crop disease severity index"


replace q_462=1 if record_id=="c4b69ce7-59c6-469e-a99d-e48111ab5a60"
replace q_462=1 if record_id=="3e3d8ec1-aeec-4b45-83c2-ffd068beadf4"
replace q_462=1 if record_id=="0ed635be-58d9-48ef-bf3f-e2d25160c3bf"
replace q_463=1 if record_id=="c4b69ce7-59c6-469e-a99d-e48111ab5a60"
gen pest_severity = q_462 + q_463 
replace pest_severity = 0 if q_461!=1
tab pest_severity, m
label var pest_severity "Crop pest severity index"

replace q_466=1 if record_id=="27df14e5-293a-40d2-a2e4-e43a6595feb9"
replace q_466=1 if record_id=="fa2425db-3611-4e23-b8d3-999d57c34a03"
replace q_465=1 if record_id=="825a548c-a913-45fd-af6d-4aee24df3c5a"
gen crop_theft_severity = q_465 + q_466
replace crop_theft_severity = 0 if q_464!=1
tab crop_theft_severity, m
label var crop_theft_severity "Crop theft severity index"

replace q_470=1 if record_id=="381ffc05-8bc8-4578-b3d4-7766df578c20"
replace q_470=1 if record_id=="e8a0af31-d92c-45ba-baaa-3bcdddb85c73"
replace q_470=1 if record_id=="a0687a41-023b-4fb4-927b-f8925494c7d9"
replace q_469=1 if record_id=="58732f12-fd14-4210-8fea-b0ba82371bb0"
gen livestock_input_severity = q_469 + q_470 
replace livestock_input_severity = 0 if q_468!=1
tab livestock_input_severity, m
label var livestock_input_severity "Livestock input severity index"

replace q_473=1 if record_id=="02c7f9d8-1e88-4bb9-8a0f-a75a02a36eff"
replace q_473=1 if record_id=="efe3c4a8-f6c0-4425-88ac-db4477d9880a"
gen livestock_disease_severity = q_472 + q_473
replace livestock_disease_severity = 0 if q_471!=1
tab livestock_disease_severity, m
label var livestock_disease_severity "Livestock disease severity index"

replace q_475=1 if record_id=="632a3064-2150-4854-9b70-3b42ef26b8de"
replace q_475=1 if record_id=="877d0580-7863-4c77-8c92-7fbb8611b879"
replace q_476=1 if record_id=="b0e9ad52-cfb4-4732-aa55-6be394770323"
gen livestock_theft_severity = q_475 + q_476
replace livestock_theft_severity = 0 if q_474!=1
tab livestock_theft_severity, m
label var livestock_theft_severity "Livestock theft severity index"

replace q_479=1 if record_id=="6ea2bf04-b63e-4486-94fa-f30a8cc20d1a"
replace q_479=1 if record_id=="9458c60f-a81f-4063-96e8-bad6ef34b8cb"
replace q_479=1 if record_id=="34abc2a4-4fc8-4cfe-b299-dc64f84c5f16"
replace q_479=1 if record_id=="2ca80329-87bf-4031-a421-a397312c085b"
replace q_478=1 if record_id=="2ca80329-87bf-4031-a421-a397312c085b"
replace q_478=1 if record_id=="97c97570-39cd-47f0-9919-ef91a1cd4819"
gen no_sell_crop_severity = q_478 + q_479
replace no_sell_crop_severity = 0 if q_477!=1
tab no_sell_crop_severity, m
label var no_sell_crop_severity "Unable to sell crops severity index"


replace q_483=1 if record_id=="5b21bbd4-89b9-48e1-aae8-70a6908d6b35"
replace q_483=1 if record_id=="91e00437-6423-4d3e-abd4-f8dad5e3f400"
replace q_483=1 if record_id=="ba898dab-9cb4-4c28-89d7-f312aadd8430"
replace q_483=1 if record_id=="bca33f26-7411-474a-9548-3dbfffc6bcb7"
replace q_483=1 if record_id=="9dc95006-3dc9-480a-b242-e9c3fc6ccfe3"
replace q_483=1 if record_id=="c97360be-5e50-4c4d-89ad-0e118410968b"
replace q_483=1 if record_id=="58aca06b-ba06-43b9-9d71-2e4967fd67d7"
replace q_483=1 if record_id=="b0e9ad52-cfb4-4732-aa55-6be394770323"
replace q_483=1 if record_id=="c4b69ce7-59c6-469e-a99d-e48111ab5a60"
replace q_483=1 if record_id=="c76626d2-0491-41c5-8d9f-7fb97392694c"
replace q_483=1 if record_id=="cb84c3ee-e51f-4acc-b731-09608f423bc5"
replace q_483=1 if record_id=="aa6c9b58-b6ac-4ad2-906c-e7d82de491cd"
replace q_483=1 if record_id=="cb52d336-281b-42a9-877d-5d82806bb0e5"
replace q_483=1 if record_id=="42ee106a-6a11-4744-8d40-3aaca599d566"
replace q_483=1 if record_id=="7bf0c839-d065-4a4d-9566-e5e58c9822d1"
replace q_483=1 if record_id=="be6bb141-a1fa-413c-9eb5-0a8dd7673ac9"
replace q_481=1 if record_id=="0adcf6b6-b448-4832-b23f-3bc8d1dd9f33"
gen illness_severity = q_481 + q_483
replace illness_severity = 0 if q_480!=1
tab illness_severity, m
label var illness_severity "Illness severity index"

replace q_486=1 if record_id=="ba898dab-9cb4-4c28-89d7-f312aadd8430"
replace q_486=1 if record_id=="09999d41-6366-401e-871b-a46177d0564f"
gen death_severity = q_485 + q_486
replace death_severity = 0 if q_484!=1
tab death_severity, m
label var death_severity "Death severity index"

local shockz q_436 q_439 q_442 q_445 q_448 q_451

foreach shz of local shockz {
replace `shz'=0 if `shz'==.
}
*

local fshockz q_455 q_458 q_461 q_464
foreach fshz of local fshockz {
replace `fshz' = 0 if `fshz'==. & q_401_a==1	
}
*

local lshockz q_468 q_471 q_474 q_477 q_480 q_484 
foreach lshz of local lshockz {
replace `lshz' = 0 if `lshz'==. & (q_401_b==1 | q_401_c==1 | q_401_d==1)
}
*

gen shock_exposure_index = (q_436*flood_severity) + (q_439*little_rain_severity) + (q_442*erosion_severity) + (q_445*loss_land_severity) + (q_448*food_price_inc_severity) + (q_451*theft_severity) + (q_455*ag_input_severity) + (q_458*crop_disease_severity) + (q_461*pest_severity) + (q_464*crop_theft_severity) + (q_468*livestock_input_severity) + (q_471*livestock_disease_severity) + (q_474*livestock_theft_severity) + (q_477*no_sell_crop_severity) + (q_480*illness_severity) + (q_484*death_severity)

tab shock_exposure_index, m

replace shock_exposure_index = (q_436*flood_severity) + (q_439*little_rain_severity) + (q_442*erosion_severity) + (q_445*loss_land_severity) + (q_448*food_price_inc_severity) + (q_451*theft_severity) + (q_468*livestock_input_severity) + (q_471*livestock_disease_severity) + (q_474*livestock_theft_severity) + (q_477*no_sell_crop_severity) + (q_480*illness_severity) + (q_484*death_severity) if q_401_a!=1 & (q_401_b==1 | q_401_c==1 | q_401_d==1)

replace shock_exposure_index = (q_436*flood_severity) + (q_439*little_rain_severity) + (q_442*erosion_severity) + (q_445*loss_land_severity) + (q_448*food_price_inc_severity) + (q_451*theft_severity) + (q_455*ag_input_severity) + (q_458*crop_disease_severity) + (q_461*pest_severity) if q_401_a==1 & q_401_b!=1 & q_401_c!=1 & q_401_d!=1

replace shock_exposure_index = (q_436*flood_severity) + (q_439*little_rain_severity) + (q_442*erosion_severity) + (q_445*loss_land_severity) + (q_448*food_price_inc_severity) + (q_451*theft_severity) if q_401_a!=1 & q_401_b!=1 & q_401_c!=1 & q_401_d!=1

label var shock_exposure_index "Shock Exposure Index Raw"

reg ability_recover shock_exposure_index
*Coefficient on shock_exposure_index is of 1 in the shock exposure index can be expected to change the ability to recover index
*Coefficient is -0.00200573
gen shock_exposure_adjust =  -0.00200573
label var shock_exposure_adjust "Shock Exposure Adjustment Factor"

mean shock_exposure_index
*Mean of shock_exposure_index = 48.225091 = y
gen mean_shock_exposure = 48.225091
label var mean_shock_exposure "Mean of Shock Exposure Index Raw"

*Ability to Recover from Shocks and Stresses Index (ARSSI)
gen arssi = ability_recover + shock_exposure_adjust * (mean_shock_exposure-shock_exposure_index)
tab arssi, m
label var arssi "Ability to Recover from Shocks and Stresses Index"

*27	Social capital at the household level (FtF)
gen social_capital_score = (bonding_capital_score + bridging_capital_score) / 2
tab social_capital_score county, m
label var social_capital_score "Social Capital Score"

*28	Belief local government will respond effectively to future shocks and stresses
tab q_498, m
recode q_498 (3=.) (2=0), gen(resil_c)
label var resil_c "Resilience C - Belief local govt will respond effectively to future shocks and stresses"
label def resc 0 "No, will not be able to" 1 "Yes"
label val resil_c resc
tab resil_c, m

*Education Var for Adam Bloom
tab q_308, m

gen q_308_three = .
replace q_308_three = 0 if q_308==0
replace q_308_three = 1 if q_308==1
replace q_308_three = 2 if q_308>1 & q_308<8
order q_308_three, after(q_308)
label var q_308_three "Q308: Respondent's level of edu (collapsed)"
label def hedu2 0 "None" 1 "Primary" 2 "Secondary or higher"
label val q_308_three hedu
tab q_308 q_308_three, m

*Indicator vars for analysis
/* 1. q_504, 2. aspirations_index, 3. grp_participate, 4. trauma, 5. q_706, 6. q_401_a_quad - q_401_u_quad, 7. q_812, 8. hdds, 9. q_601, 10. q_603, 11. bonding_capital_score, 12. bridging_capital_score, 13. q_802 and q_803, 14. fies_raw, 15. q_612, 16. q_814, 17. q_513, 18. q_829-q_832_new, 19. q_824 and q_825 and q_827, 20. q_510, 21. ews_participate, 22. q_315, 23. q_519, 24. q_606, 25. q_520, 26. arssi,  27. social_capital_score, 28. resil_c
*/

*egen resp_link = concat(record_id q_208), punct("-")

*Save dataset
save "`outpath'mesp_household_baseline_hh_survey_scored.dta", replace

export excel using "`outpath'mesp_household_baseline_hh_survey_scored.xlsx", firstrow(variables) nolabel missing(".") replace

codebookout "`outpath'mesp_household_baseline_codebook_hh_survey_scored.xlsx", replace
