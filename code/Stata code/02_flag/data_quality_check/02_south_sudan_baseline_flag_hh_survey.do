*******************************************************************************
* South Sudan Pilot Household Survey
* Sean Kelly
* April 29, 2021
* File uses: mesp_household_pilot_survey_clean.dta; mesp_household_pilot_survey_hh_schedule_clean.dta
* File saves: south_sudan_hh_survey_pilot_flags_list.txt
* This file takes the datasets and runs flags for data quality checks in the 
* questionnaire administration manual
*******************************************************************************

*Create file paths
local inpath "W:\Shared\Projects\6073.04 SSD MESP\Tech\Deliverables\Household Survey\Pilot\data\02_clean\"
local outpath "W:\Shared\Projects\6073.04 SSD MESP\Tech\Deliverables\Household Survey\Pilot\results\excel\"

*Load dataset 
use "`inpath'mesp_household_pilot_survey_clean.dta", clear 

*New var for rowid
gen rowid=_n

*Screening
cap rm "`outpath'south_sudan_hh_survey_pilot_flags_list.txt"
cap file close myfile1
file open myfile1 using "`outpath'south_sudan_hh_survey_pilot_flags_list.txt", write
file write myfile1 "sno" _tab "Freq" _tab "record_id" _tab "description" _tab "Condition"

****HH Questionnaire****
local i = 0
*1) record_id missing 
local i = `i'+1
tabmiss record_id
local ids_freq = r(sum)
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "n/a" _tab "record_id is missing" _tab `"tabmiss record_id"'

*2) informed consent missing 
local i = `i'+1
levelsof record_id if q_101==., local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "consent is missing" _tab `"if q_101==."'

*3) informed consent is no
local i = `i'+1
levelsof record_id  if q_101==0, local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "consent is no" _tab `"if q_101 == 0"'

*4) State missing 
local i = `i'+1
levelsof record_id if state==".", local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "state is missing" _tab `"if state==."'

*5) County missing 
local i = `i'+1
levelsof record_id if county==".", local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "county is missing" _tab `"if county==."'

*6) Payam missing 
local i = `i'+1
levelsof record_id if payam==".", local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "payam is missing" _tab `"if payam==."'

*7) Boma missing 
local i = `i'+1
levelsof record_id if boma==".", local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "boma is missing" _tab `"if boma==."'

*8) EA missing 
local i = `i'+1
levelsof record_id if q_205==".", local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "EA is missing" _tab `"if q_205==."'

*9) Location missing
local i = `i'+1
levelsof record_id if q_206==., local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "Location is missing" _tab `"if q_206==."'


*10) Name of head of household missing
local i = `i'+1
levelsof record_id if q_207==".", local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "Name of Head of HH is missing" _tab `"if q_207==."' 

*11) Name of head of respondent missing
local i = `i'+1
levelsof record_id if q_208==".", local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "Name of respondent is missing" _tab `"if q_208==."' 

*12) Interview date missing
local i = `i'+1
levelsof record_id if q_209==".", local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "Interview date is missing" _tab `"if q_209==."'

*13) Enumerator name missing
local i = `i'+1
levelsof record_id if q_210_a==".", local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "Enumerator name is missing" _tab `"if q_210_a==."'

*14) Enumerator ID missing
local i = `i'+1
levelsof record_id if q_210_b==".", local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "Enumerator ID is missing" _tab `"if q_210_b==."'

*15) Language of Interview missing
local i = `i'+1
levelsof record_id if q_211==., local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "Language is missing" _tab `"if q_211==."'

*16) Start time missing
local i = `i'+1
levelsof record_id if q_212==".", local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "Start time is missing" _tab `"if q_212==."'

*17) End time missing
local i = `i'+1
levelsof record_id if q_901==".", local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "End time is missing" _tab `"if q_901==."'

*18) Negative time
local i = `i'+1
levelsof record_id if survey_minutes<0, local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "Negative survey time" _tab `"if survey_minutes<0"'

*19) Time less than 45 minutes
local i = `i'+1
levelsof record_id if survey_minutes2<45, local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "Survey less than 45 minutes" _tab `"if survey_minutes2<45"'

*20) Time greater than 90 minutes
local i = `i'+1
levelsof record_id if survey_minutes2>90, local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "Survey more than 90 minutes" _tab `"if survey_minutes2>90"'

*21) Latitude missing
local i = `i'+1
levelsof record_id if latitude==., local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "Latitude missing" _tab `"if latitude==."'

*22) Longitude missing
local i = `i'+1
levelsof record_id if longitude==., local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "Longitude missing" _tab `"if longitude==."'

*23) Duplicate entries
local i = `i'+1
duplicates tag state county boma payam q_205 month day year q_403 q_404 q_405 q_406 q_407 q_408 q_409 q_410 q_411 q_412 q_413 q_414 q_415 q_416 q_417 q_418 q_419, gen(dup_task)
levelsof record_id if dup_task>0 , local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "Duplicate entry" _tab `"state county boma payam q_205 q_403 q_404 q_405 q_406 q_407 q_408 q_409 q_410 q_411 q_412 q_413 q_414 q_415 q_416 q_417 q_418 q_419"'

*24) Empty rows
local i = `i'+1
levelsof record_id if q_403==. & q_404==. & q_405==. & q_406==. & q_407==. & q_408==. & q_409==. & q_410==. & q_411==. & q_412==. & q_413==. & q_414==. & q_415==. & q_416==. & q_417==. & q_418==. & q_419==., local(record_id) clean
local ids_freq: word count `record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id'" _tab "Likely empty row of data" _tab `"if q_403 - q_419==."'

* close tempfile and save to memory
file close myfile1
drop rowid

*Load dataset 
use "`inpath'mesp_household_pilot_survey_hh_schedule_clean.dta", clear 

*New var for rowid
gen rowid=_n

*Screening
cap rm "`outpath'south_sudan_hh_survey_schedule_pilot_flags_list.txt"
cap file close myfile1
file open myfile1 using "`outpath'south_sudan_hh_survey_schedule_pilot_flags_list.txt", write
file write myfile1 "sno" _tab "Freq" _tab "record_id" _tab "description" _tab "Condition"

****HH Schedule****
local i = 0
*1) Name of household member missing 
local i = `i'+1
levelsof child_record_id if q_301==".", local(child_record_id) clean
local ids_freq: word count `child_record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`child_record_id'" _tab "Name of household member is missing" _tab `"if q_301==."'

*2) Sex missing 
local i = `i'+1
levelsof child_record_id if q_302==., local(child_record_id) clean
local ids_freq: word count `child_record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`child_record_id'" _tab "Sex of household member is missing" _tab `"if q_302==."'

*3) HH Relationship missing 
local i = `i'+1
levelsof child_record_id if q_303==., local(child_record_id) clean
local ids_freq: word count `child_record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`child_record_id'" _tab "HH relationship is missing" _tab `"if q_303==."'

*4) Age missing 
local i = `i'+1
levelsof child_record_id if q_304==., local(child_record_id) clean
local ids_freq: word count `child_record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`child_record_id'" _tab "Age is missing" _tab `"if q_304==."'

*5) Literacy missing 
local i = `i'+1
levelsof child_record_id if q_305==., local(child_record_id) clean
local ids_freq: word count `child_record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`child_record_id'" _tab "Literacy is missing" _tab `"if q_305==."'

*6) Ever attended school missing 
local i = `i'+1
levelsof child_record_id if q_306==., local(child_record_id) clean
local ids_freq: word count `child_record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`child_record_id'" _tab "School attended is missing" _tab `"if q_306==."'

*7) Reason not attended school missing 
local i = `i'+1
levelsof child_record_id if q_306==0 & q_307==., local(child_record_id) clean
local ids_freq: word count `child_record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`child_record_id'" _tab "Reason not attended is missing" _tab `"if q_306==0 & q_307==."'

*8) Highest level of education missing 
local i = `i'+1
levelsof child_record_id if q_308==., local(child_record_id) clean
local ids_freq: word count `child_record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`child_record_id'" _tab "Highest edu level is missing" _tab `"if q_308==."'

*9) Marital status missing 
local i = `i'+1
levelsof child_record_id if q_309==. & q_304>12, local(child_record_id) clean
local ids_freq: word count `child_record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`child_record_id'" _tab "Marital status is missing" _tab `"if q_309==. & q_304>12"'

*10) Economic activity missing 
local i = `i'+1
levelsof child_record_id if q_314==. & q_304>10, local(child_record_id) clean
local ids_freq: word count `child_record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`child_record_id'" _tab "Economic activity is missing" _tab `"if q_314==. & q_304>10"'

*11) Vaccine status missing 
local i = `i'+1
levelsof child_record_id if q_315==. & q_304<5, local(child_record_id) clean
local ids_freq: word count `child_record_id'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`child_record_id'" _tab "Vaccine status is missing" _tab `"if q_315==. & q_304<5"'

* close tempfile and save to memory
file close myfile1
drop rowid
