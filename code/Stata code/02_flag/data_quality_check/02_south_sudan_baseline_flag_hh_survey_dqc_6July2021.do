*******************************************************************************
* South Sudan Pilot Household Survey
* Sean Kelly
* May 28, 2021
*******************************************************************************
* File uses: mesp_household_baseline_survey_english_hh_schedule_preprocessed_dqc_6July2021.dta;
* mesp_household_baseline_survey_english_preprocessed_dqc_6July2021.dta;
* mesp_household_baseline_survey_nuer_hh_schedule_preprocessed_dqc_6July2021.dta;
* mesp_household_baseline_survey_nuer_preprocessed_dqc_6July2021.dta;
* mesp_household_baseline_survey_murle_hh_schedule_preprocessed_dqc_6July2021.dta;
* mesp_household_baseline_survey_murle_preprocessed_dqc_6July2021.dta;
* mesp_household_baseline_survey_jie_hh_schedule_preprocessed_dqc_6July2021.dta;
* mesp_household_baseline_survey_jie_preprocessed_dqc_6July2021.dta;
********************************************************************************
* File saves: south_sudan_hh_survey_baseline_flags_english_dqc_6July2021_list.txt
* south_sudan_hh_survey_schedule_baseline_flags_english_dqc_6July2021_list.txt
* south_sudan_hh_survey_baseline_flags_nuer_dqc_6July2021_list.txt
* south_sudan_hh_survey_schedule_baseline_flags_nuer_dqc_6July2021_list.txt
* south_sudan_hh_survey_baseline_flags_murle_dqc_6July2021_list.txt
* south_sudan_hh_survey_schedule_baseline_flags_murle_dqc_6July2021_list.txt
* south_sudan_hh_survey_baseline_flags_jie_dqc_6July2021_list.txt
* south_sudan_hh_survey_schedule_baseline_flags_jie_dqc_6July2021_list.txt
********************************************************************************
* This file takes the datasets and runs flags for data quality checks in the 
* questionnaire administration manual
********************************************************************************

*Create file paths
local inpath "W:\Shared\Projects\6073.04 SSD MESP\Tech\Deliverables\Household Survey\Baseline\data\01_preprocess\"
local outpath "W:\Shared\Projects\6073.04 SSD MESP\Tech\Deliverables\Household Survey\Baseline\data\02_flag\"


*************************
* Main HH Questionnaire *
*************************

*Load dataset 

local langz didinga dinka english murle nuer

foreach lng of local langz {
use "`inpath'mesp_household_baseline_survey_`lng'_preprocessed_dqc_6July2021.dta", clear 

tostring q_208, replace

gen state = "."
replace state = "Eastern Equatoria" if strpos(q_201_204, "Eastern Equatoria")
replace state = "Jonglei" if strpos(q_201_204, "Jonglei")
replace state = "Unity" if strpos(q_201_204, "Unity")
label var state "State of South Sudan"
tab state, m 

gen county = "." 
replace county = "Akobo" if strpos(q_201_204, "Akobo")
replace county = "Budi" if strpos(q_201_204, "Budi")
replace county = "Duk" if strpos(q_201_204, "Duk")
replace county = "Pibor" if strpos(q_201_204, "Pibor")
replace county = "Uror" if strpos(q_201_204, "Uror")
replace county = "Leer" if strpos(q_201_204, "Leer")
label var county "County of State"
tab county, m

gen payam = "."
replace payam = "Adok" if strpos(q_201_204, "Adok")
replace payam = "Ageer" if strpos(q_201_204, "Ageer")
replace payam = "Alali" if strpos(q_201_204, "Alali")
replace payam = "Bamarch" if strpos(q_201_204, "Bamarch")
replace payam = "Bilkey" if strpos(q_201_204, "Bilkey")
replace payam = "Bou" if strpos(q_201_204, "Bou")
replace payam = "Buma" if strpos(q_201_204, "Buma")
replace payam = "Buong" if strpos(q_201_204, "Buong")
replace payam = "Dengjok" if strpos(q_201_204, "Dengjok")
replace payam = "Diror" if strpos(q_201_204, "Diror")
replace payam = "Dok" if strpos(q_201_204, "Dok")
replace payam = "Dongchak" if strpos(q_201_204, "Dongchak")
replace payam = "Guat" if strpos(q_201_204, "Guat")
replace payam = "Gumuruk" if strpos(q_201_204, "Gumuruk")
replace payam = "Juong Kang" if strpos(q_201_204, "Juong Kang")
replace payam = "Karam" if strpos(q_201_204, "Karam")
replace payam = "Kimotong" if strpos(q_201_204, "Kimotong")
replace payam = "Kiziongora (Kezengor)" if strpos(q_201_204, "Kiziongora (Kezengor)")
replace payam = "Komori" if strpos(q_201_204, "Komori")
replace payam = "Lekuangole" if strpos(q_201_204, "Lekuangole")
replace payam = "Lekuangole(Lokuangule)" if strpos(q_201_204, "Lekuangole(Lokuangule)")
replace payam = "Loriyok" if strpos(q_201_204, "Loriyok")
replace payam = "Lotukei" if strpos(q_201_204, "Lotukei")
replace payam = "Loudo" if strpos(q_201_204, "Loudo")
replace payam = "Marow" if strpos(q_201_204, "Marow")
replace payam = "Marow(Maruwo)" if strpos(q_201_204, "Marow(Maruwo)")
replace payam = "Miwono(Meoun)" if strpos(q_201_204, "Miwono(Meoun)")
replace payam = "Motot" if strpos(q_201_204, "Motot")
replace payam = "Nagishot" if strpos(q_201_204, "Nagishot")
replace payam = "Napak" if strpos(q_201_204, "Napak")
replace payam = "Nauro" if strpos(q_201_204, "Nauro")
replace payam = "Nyandit" if strpos(q_201_204, "Nyandit")
replace payam = "Padeah" if strpos(q_201_204, "Padeah")
replace payam = "Padiet" if strpos(q_201_204, "Padiet")
replace payam = "Pagak" if strpos(q_201_204, "Pagak")
replace payam = "Panyang" if strpos(q_201_204, "Panyang")
replace payam = "Pathai" if strpos(q_201_204, "Pathai")
replace payam = "Payai" if strpos(q_201_204, "Payai")
replace payam = "Payuel" if strpos(q_201_204, "Payuel")
replace payam = "Pibor" if strpos(q_201_204, "Pibor")
replace payam = "Pieri" if strpos(q_201_204, "Pieri")
replace payam = "Pilieny" if strpos(q_201_204, "Pilieny")
replace payam = "Puolchuol" if strpos(q_201_204, "Puolchuol")
replace payam = "Tiam" if strpos(q_201_204, "Tiam")
replace payam = "Verteth" if strpos(q_201_204, "Verteth")
replace payam = "Walgak" if strpos(q_201_204, "Walgak")
replace payam = "Wuror" if strpos(q_201_204, "Wuror")
replace payam = "Wuror(Uror)" if strpos(q_201_204, "Wuror(Uror)")
replace payam = "Yang" if strpos(q_201_204, "Yang")
label var payam "Payam of County"
tab payam, m


gen boma = "." 
replace boma = "Amiel" if strpos(q_201_204, "Amiel")
replace boma = "Angaimo" if strpos(q_201_204, "Angaimo")
replace boma = "Aparawanga" if strpos(q_201_204, "Aparawanga")
replace boma = "Ayueldit" if strpos(q_201_204, "Ayueldit")
replace boma = "Baan" if strpos(q_201_204, "Baan")
replace boma = "Beh" if strpos(q_201_204, "Beh")
replace boma = "Bongjok" if strpos(q_201_204, "Bongjok")
replace boma = "Bou" if strpos(q_201_204, "Bou")
replace boma = "Buong Kuel" if strpos(q_201_204, "Buong Kuel")
replace boma = "Charit" if strpos(q_201_204, "Charit")
replace boma = "Chawa" if strpos(q_201_204, "Chawa")
replace boma = "Chiban" if strpos(q_201_204, "Chiban")
replace boma = "Chindor" if strpos(q_201_204, "Chindor")
replace boma = "Chueidok" if strpos(q_201_204, "Chueidok")
replace boma = "Dakriang" if strpos(q_201_204, "Dakriang")
replace boma = "Dangjop" if strpos(q_201_204, "Dangjop")
replace boma = "Derkuach" if strpos(q_201_204, "Derkuach")
replace boma = "Dhar" if strpos(q_201_204, "Dhar")
replace boma = "Dhuony" if strpos(q_201_204, "Dhuony")
replace boma = "Dik" if strpos(q_201_204, "Dik")
replace boma = "Dok" if strpos(q_201_204, "Dok")
replace boma = "Dorok" if strpos(q_201_204, "Dorok")
replace boma = "Duok" if strpos(q_201_204, "Duok")
replace boma = "Gaatweel" if strpos(q_201_204, "Gaatweel")
replace boma = "Gakdong" if strpos(q_201_204, "Gakdong")
replace boma = "Gokgoak" if strpos(q_201_204, "Gokgoak")
replace boma = "Guat" if strpos(q_201_204, "Guat")
replace boma = "Guenchat" if strpos(q_201_204, "Guenchat")
replace boma = "Guic" if strpos(q_201_204, "Guic")
replace boma = "Itingi" if strpos(q_201_204, "Itingi")
replace boma = "Itti" if strpos(q_201_204, "Itti")
replace boma = "Jokrial A" if strpos(q_201_204, "Jokrial A")
replace boma = "Jokrial B" if strpos(q_201_204, "Jokrial B")
replace boma = "Jolong" if strpos(q_201_204, "Jolong")
replace boma = "Jundit" if strpos(q_201_204, "Jundit")
replace boma = "Kactong" if strpos(q_201_204, "Kactong")
replace boma = "Kadumakuc" if strpos(q_201_204, "Kadumakuc")
replace boma = "Kaigai" if strpos(q_201_204, "Kaigai")
replace boma = "Kali" if strpos(q_201_204, "Kali")
replace boma = "Karam" if strpos(q_201_204, "Karam")
replace boma = "Kavachoch" if strpos(q_201_204, "Kavachoch")
replace boma = "Kawer" if strpos(q_201_204, "Kawer")
replace boma = "Kelero" if strpos(q_201_204, "Kelero")
replace boma = "Kerenga" if strpos(q_201_204, "Kerenga")
replace boma = "Kerewan" if strpos(q_201_204, "Kerewan")
replace boma = "Kibongorok" if strpos(q_201_204, "Kibongorok")
replace boma = "Kier" if strpos(q_201_204, "Kier")
replace boma = "Kikilai" if strpos(q_201_204, "Kikilai")
replace boma = "Kilanya" if strpos(q_201_204, "Kilanya")
replace boma = "Kirongu" if strpos(q_201_204, "Kirongu")
replace boma = "Komori" if strpos(q_201_204, "Komori")
replace boma = "Kongor" if strpos(q_201_204, "Kongor")
replace boma = "Kudele" if strpos(q_201_204, "Kudele")
replace boma = "Kuel" if strpos(q_201_204, "Kuel")
replace boma = "Kuerdiek" if strpos(q_201_204, "Kuerdiek")
replace boma = "Kuerguarnyabiel" if strpos(q_201_204, "Kuerguarnyabiel")
replace boma = "Kuerluot" if strpos(q_201_204, "Kuerluot")
replace boma = "Kulier" if strpos(q_201_204, "Kulier")
replace boma = "Kuluzur" if strpos(q_201_204, "Kuluzur")
replace boma = "Kumagaab" if strpos(q_201_204, "Kumagaab")
replace boma = "Kuombuong" if strpos(q_201_204, "Kuombuong")
replace boma = "Kur" if strpos(q_201_204, "Kur")
replace boma = "Lawol" if strpos(q_201_204, "Lawol")
replace boma = "Lekuangole" if strpos(q_201_204, "Lekuangole")
replace boma = "Lenyirieth" if strpos(q_201_204, "Lenyirieth")
replace boma = "Lohipor" if strpos(q_201_204, "Lohipor")
replace boma = "Lorema" if strpos(q_201_204, "Lorema")
replace boma = "Lothigira" if strpos(q_201_204, "Lothigira")
replace boma = "Manguet" if strpos(q_201_204, "Manguet")
replace boma = "Manydhing" if strpos(q_201_204, "Manydhing")
replace boma = "Manyirany" if strpos(q_201_204, "Manyirany")
replace boma = "Manyloden" if strpos(q_201_204, "Manyloden")
replace boma = "Manymar" if strpos(q_201_204, "Manymar")
replace boma = "Mareng" if strpos(q_201_204, "Mareng")
replace boma = "Mer" if strpos(q_201_204, "Mer")
replace boma = "Mewun" if strpos(q_201_204, "Mewun")
replace boma = "Monita" if strpos(q_201_204, "Monita")
replace boma = "Monychak" if strpos(q_201_204, "Monychak")
replace boma = "Morech" if strpos(q_201_204, "Morech")
replace boma = "Motot" if strpos(q_201_204, "Motot")
replace boma = "Murlil" if strpos(q_201_204, "Murlil")
replace boma = "Nawukali" if strpos(q_201_204, "Nawukali")
replace boma = "Ngarahach" if strpos(q_201_204, "Ngarahach")
replace boma = "Ngarich" if strpos(q_201_204, "Ngarich")
replace boma = "Ngatuba" if strpos(q_201_204, "Ngatuba")
replace boma = "Ngueny" if strpos(q_201_204, "Ngueny")
replace boma = "Norkong" if strpos(q_201_204, "Norkong")
replace boma = "Nuer" if strpos(q_201_204, "Nuer")
replace boma = "Nukta" if strpos(q_201_204, "Nukta")
replace boma = "Nyadiar" if strpos(q_201_204, "Nyadiar")
replace boma = "Nyakor" if strpos(q_201_204, "Nyakor")
replace boma = "Nyalongoro" if strpos(q_201_204, "Nyalongoro")
replace boma = "Nyamachul" if strpos(q_201_204, "Nyamachul")
replace boma = "Nyergeny" if strpos(q_201_204, "Nyergeny")
replace boma = "Nyony" if strpos(q_201_204, "Nyony")
replace boma = "Obor" if strpos(q_201_204, "Obor")
replace boma = "Okau" if strpos(q_201_204, "Okau")
replace boma = "Old Akobo" if strpos(q_201_204, "Old Akobo")
replace boma = "Padeah" if strpos(q_201_204, "Padeah")
replace boma = "Padida" if strpos(q_201_204, "Padida")
replace boma = "Padiet" if strpos(q_201_204, "Padiet")
replace boma = "Pading" if strpos(q_201_204, "Pading")
replace boma = "Padoi" if strpos(q_201_204, "Padoi")
replace boma = "Pagaleng" if strpos(q_201_204, "Pagaleng")
replace boma = "Pajut" if strpos(q_201_204, "Pajut")
replace boma = "Pakam" if strpos(q_201_204, "Pakam")
replace boma = "Pakuem" if strpos(q_201_204, "Pakuem")
replace boma = "Panhiam" if strpos(q_201_204, "Panhiam")
replace boma = "Panom" if strpos(q_201_204, "Panom")
replace boma = "Panyang" if strpos(q_201_204, "Panyang")
replace boma = "Pathai" if strpos(q_201_204, "Pathai")
replace boma = "Pathat" if strpos(q_201_204, "Pathat")
replace boma = "Patuatnoi" if strpos(q_201_204, "Patuatnoi")
replace boma = "Pawai" if strpos(q_201_204, "Pawai")
replace boma = "Pawiny" if strpos(q_201_204, "Pawiny")
replace boma = "Payai" if strpos(q_201_204, "Payai")
replace boma = "Payak" if strpos(q_201_204, "Payak")
replace boma = "Payuel" if strpos(q_201_204, "Payuel")
replace boma = "Pibor" if strpos(q_201_204, "Pibor")
replace boma = "Pilieny" if strpos(q_201_204, "Pilieny")
replace boma = "Piobokoi" if strpos(q_201_204, "Piobokoi")
replace boma = "Poktap" if strpos(q_201_204, "Poktap")
replace boma = "Pulngere" if strpos(q_201_204, "Pulngere")
replace boma = "Rabarab" if strpos(q_201_204, "Rabarab")
replace boma = "Riangchengoi" if strpos(q_201_204, "Riangchengoi")
replace boma = "Riangchukuel" if strpos(q_201_204, "Riangchukuel")
replace boma = "Rine" if strpos(q_201_204, "Rine")
replace boma = "Suguro" if strpos(q_201_204, "Suguro")
replace boma = "Tala" if strpos(q_201_204, "Tala")
replace boma = "Tangnyang" if strpos(q_201_204, "Tangnyang")
replace boma = "Tataman" if strpos(q_201_204, "Tataman")
replace boma = "Thangong" if strpos(q_201_204, "Thangong")
replace boma = "Tharuop" if strpos(q_201_204, "Tharuop")
replace boma = "Thempiny" if strpos(q_201_204, "Thempiny")
replace boma = "Thonyor" if strpos(q_201_204, "Thonyor")
replace boma = "Thuguro" if strpos(q_201_204, "Thuguro")
replace boma = "Tindiir" if strpos(q_201_204, "Tindiir")
replace boma = "Tolwa" if strpos(q_201_204, "Tolwa")
replace boma = "Tuak" if strpos(q_201_204, "Tuak")
replace boma = "Tulugi" if strpos(q_201_204, "Tulugi")
replace boma = "Turu" if strpos(q_201_204, "Turu")
replace boma = "Ulang" if strpos(q_201_204, "Ulang")
replace boma = "Uleng" if strpos(q_201_204, "Uleng")
replace boma = "Viveno" if strpos(q_201_204, "Viveno")
replace boma = "Walgak" if strpos(q_201_204, "Walgak")
replace boma = "Wechjal" if strpos(q_201_204, "Wechjal")
replace boma = "Wecpuot" if strpos(q_201_204, "Wecpuot")
replace boma = "Week" if strpos(q_201_204, "Week")
replace boma = "Weijiokni" if strpos(q_201_204, "Weijiokni")
replace boma = "Weikey" if strpos(q_201_204, "Weikey")
replace boma = "Wunkuel" if strpos(q_201_204, "Wunkuel")
replace boma = "Wunngony" if strpos(q_201_204, "Wunngony")
replace boma = "Wunthor" if strpos(q_201_204, "Wunthor")
replace boma = "Yian" if strpos(q_201_204, "Yian")
tab boma, m
label var boma "Boma of Payam"

gen ea = "."
replace ea = "720401001202" if strpos(q_201_204, "720401001202")
replace ea = "720401002202" if strpos(q_201_204, "720401002202")
replace ea = "720401003202" if strpos(q_201_204, "720401003202")
replace ea = "720401003203" if strpos(q_201_204, "720401003203")
replace ea = "720401003204" if strpos(q_201_204, "720401003204")
replace ea = "720402001201" if strpos(q_201_204, "720402001201")
replace ea = "720402001202" if strpos(q_201_204, "720402001202")
replace ea = "720402001203" if strpos(q_201_204, "720402001203")
replace ea = "720402004201" if strpos(q_201_204, "720402004201")
replace ea = "720402006201" if strpos(q_201_204, "720402006201")
replace ea = "720403001201" if strpos(q_201_204, "720403001201")
replace ea = "720403001202" if strpos(q_201_204, "720403001202")
replace ea = "720403001204" if strpos(q_201_204, "720403001204")
replace ea = "720403001205" if strpos(q_201_204, "720403001205")
replace ea = "720403002202" if strpos(q_201_204, "720403002202")
replace ea = "720403003201" if strpos(q_201_204, "720403003201")
replace ea = "720403003204" if strpos(q_201_204, "720403003204")
replace ea = "720403004201" if strpos(q_201_204, "720403004201")
replace ea = "720403004203" if strpos(q_201_204, "720403004203")
replace ea = "720403004204" if strpos(q_201_204, "720403004204")
replace ea = "720404001201" if strpos(q_201_204, "720404001201")
replace ea = "720404001202" if strpos(q_201_204, "720404001202")
replace ea = "720404003201" if strpos(q_201_204, "720404003201")
replace ea = "720404003202" if strpos(q_201_204, "720404003202")
replace ea = "720404003203" if strpos(q_201_204, "720404003203")
replace ea = "720405001201" if strpos(q_201_204, "720405001201")
replace ea = "720405001204" if strpos(q_201_204, "720405001204")
replace ea = "720405002202" if strpos(q_201_204, "720405002202")
replace ea = "720405003203" if strpos(q_201_204, "720405003203")
replace ea = "720405003205" if strpos(q_201_204, "720405003205")
replace ea = "720405004203" if strpos(q_201_204, "720405004203")
replace ea = "720405005202" if strpos(q_201_204, "720405005202")
replace ea = "720405005204" if strpos(q_201_204, "720405005204")
replace ea = "720405005207" if strpos(q_201_204, "720405005207")
replace ea = "720405006203" if strpos(q_201_204, "720405006203")
replace ea = "720405006205" if strpos(q_201_204, "720405006205")
replace ea = "720406001202" if strpos(q_201_204, "720406001202")
replace ea = "720406002201" if strpos(q_201_204, "720406002201")
replace ea = "720406003201" if strpos(q_201_204, "720406003201")
replace ea = "720406003202" if strpos(q_201_204, "720406003202")
replace ea = "720501002201" if strpos(q_201_204, "720501002201")
replace ea = "720501003201" if strpos(q_201_204, "720501003201")
replace ea = "720501004201" if strpos(q_201_204, "720501004201")
replace ea = "720501006201" if strpos(q_201_204, "720501006201")
replace ea = "720501008201" if strpos(q_201_204, "720501008201")
replace ea = "720502001201" if strpos(q_201_204, "720502001201")
replace ea = "720502001204" if strpos(q_201_204, "720502001204")
replace ea = "720502002202" if strpos(q_201_204, "720502002202")
replace ea = "720502003204" if strpos(q_201_204, "720502003204")
replace ea = "720502004204" if strpos(q_201_204, "720502004204")
replace ea = "720502006201" if strpos(q_201_204, "720502006201")
replace ea = "720502006205" if strpos(q_201_204, "720502006205")
replace ea = "720503001201" if strpos(q_201_204, "720503001201")
replace ea = "720503001203" if strpos(q_201_204, "720503001203")
replace ea = "720503002202" if strpos(q_201_204, "720503002202")
replace ea = "720503002206" if strpos(q_201_204, "720503002206")
replace ea = "720503004201" if strpos(q_201_204, "720503004201")
replace ea = "720503005202" if strpos(q_201_204, "720503005202")
replace ea = "720503007202" if strpos(q_201_204, "720503007202")
replace ea = "720503008202" if strpos(q_201_204, "720503008202")
replace ea = "720504002201" if strpos(q_201_204, "720504002201")
replace ea = "720504003203" if strpos(q_201_204, "720504003203")
replace ea = "720504005203" if strpos(q_201_204, "720504005203")
replace ea = "720504007202" if strpos(q_201_204, "720504007202")
replace ea = "720505001201" if strpos(q_201_204, "720505001201")
replace ea = "720505002201" if strpos(q_201_204, "720505002201")
replace ea = "720505002202" if strpos(q_201_204, "720505002202")
replace ea = "720505003202" if strpos(q_201_204, "720505003202")
replace ea = "720505004205" if strpos(q_201_204, "720505004205")
replace ea = "720506001201" if strpos(q_201_204, "720506001201")
replace ea = "720506002203" if strpos(q_201_204, "720506002203")
replace ea = "720506005202" if strpos(q_201_204, "720506005202")
replace ea = "720507002202" if strpos(q_201_204, "720507002202")
replace ea = "720507003201" if strpos(q_201_204, "720507003201")
replace ea = "720507004201" if strpos(q_201_204, "720507004201")
replace ea = "720507004202" if strpos(q_201_204, "720507004202")
replace ea = "720508001204" if strpos(q_201_204, "720508001204")
replace ea = "720508003201" if strpos(q_201_204, "720508003201")
replace ea = "720508003202" if strpos(q_201_204, "720508003202")
replace ea = "720508004202" if strpos(q_201_204, "720508004202")
replace ea = "720701003201" if strpos(q_201_204, "720701003201")
replace ea = "720702001202" if strpos(q_201_204, "720702001202")
replace ea = "720702003201" if strpos(q_201_204, "720702003201")
replace ea = "720702003202" if strpos(q_201_204, "720702003202")
replace ea = "720702004201" if strpos(q_201_204, "720702004201")
replace ea = "720702004203" if strpos(q_201_204, "720702004203")
replace ea = "720703001103" if strpos(q_201_204, "720703001103")
replace ea = "720703001104" if strpos(q_201_204, "720703001104")
replace ea = "720703001105" if strpos(q_201_204, "720703001105")
replace ea = "720703001106" if strpos(q_201_204, "720703001106")
replace ea = "720703001108" if strpos(q_201_204, "720703001108")
replace ea = "720703002202" if strpos(q_201_204, "720703002202")
replace ea = "720703002204" if strpos(q_201_204, "720703002204")
replace ea = "720703003201" if strpos(q_201_204, "720703003201")
replace ea = "720703003206" if strpos(q_201_204, "720703003206")
replace ea = "720703004201" if strpos(q_201_204, "720703004201")
replace ea = "720703004204" if strpos(q_201_204, "720703004204")
replace ea = "720704002201" if strpos(q_201_204, "720704002201")
replace ea = "720704003202" if strpos(q_201_204, "720704003202")
replace ea = "720705001201" if strpos(q_201_204, "720705001201")
replace ea = "720705001202" if strpos(q_201_204, "720705001202")
replace ea = "720705001204" if strpos(q_201_204, "720705001204")
replace ea = "720705002202" if strpos(q_201_204, "720705002202")
replace ea = "720705003203" if strpos(q_201_204, "720705003203")
replace ea = "720705004202" if strpos(q_201_204, "720705004202")
replace ea = "720706001201" if strpos(q_201_204, "720706001201")
replace ea = "720706001205" if strpos(q_201_204, "720706001205")
replace ea = "720706003201" if strpos(q_201_204, "720706003201")
replace ea = "720706004201" if strpos(q_201_204, "720706004201")
replace ea = "720707001202" if strpos(q_201_204, "720707001202")
replace ea = "720707001205" if strpos(q_201_204, "720707001205")
replace ea = "720707002202" if strpos(q_201_204, "720707002202")
replace ea = "720707002203" if strpos(q_201_204, "720707002203")
replace ea = "720707003202" if strpos(q_201_204, "720707003202")
replace ea = "720707003204" if strpos(q_201_204, "720707003204")
replace ea = "720707003205" if strpos(q_201_204, "720707003205")
replace ea = "720707004201" if strpos(q_201_204, "720707004201")
replace ea = "720707004203" if strpos(q_201_204, "720707004203")
replace ea = "720708002202" if strpos(q_201_204, "720708002202")
replace ea = "720708004202" if strpos(q_201_204, "720708004202")
replace ea = "720901003201" if strpos(q_201_204, "720901003201")
replace ea = "720901006201" if strpos(q_201_204, "720901006201")
replace ea = "720902002204" if strpos(q_201_204, "720902002204")
replace ea = "720902004203" if strpos(q_201_204, "720902004203")
replace ea = "720902006202" if strpos(q_201_204, "720902006202")
replace ea = "720902007201" if strpos(q_201_204, "720902007201")
replace ea = "720902008201" if strpos(q_201_204, "720902008201")
replace ea = "720902010201" if strpos(q_201_204, "720902010201")
replace ea = "720902010207" if strpos(q_201_204, "720902010207")
replace ea = "720903001202" if strpos(q_201_204, "720903001202")
replace ea = "720903004202" if strpos(q_201_204, "720903004202")
replace ea = "720904001202" if strpos(q_201_204, "720904001202")
replace ea = "720904001203" if strpos(q_201_204, "720904001203")
replace ea = "720904003202" if strpos(q_201_204, "720904003202")
replace ea = "720904003204" if strpos(q_201_204, "720904003204")
replace ea = "720904003211" if strpos(q_201_204, "720904003211")
replace ea = "720904003214" if strpos(q_201_204, "720904003214")
replace ea = "720904004201" if strpos(q_201_204, "720904004201")
replace ea = "720904004203" if strpos(q_201_204, "720904004203")
replace ea = "720904005206" if strpos(q_201_204, "720904005206")
replace ea = "720904007201" if strpos(q_201_204, "720904007201")
replace ea = "720904008201" if strpos(q_201_204, "720904008201")
replace ea = "720904008206" if strpos(q_201_204, "720904008206")
replace ea = "720904010201" if strpos(q_201_204, "720904010201")
replace ea = "720905003201" if strpos(q_201_204, "720905003201")
replace ea = "720905005202" if strpos(q_201_204, "720905005202")
replace ea = "720906001202" if strpos(q_201_204, "720906001202")
replace ea = "720907001205" if strpos(q_201_204, "720907001205")
replace ea = "720907002201" if strpos(q_201_204, "720907002201")
replace ea = "720907004202" if strpos(q_201_204, "720907004202")
replace ea = "720907005202" if strpos(q_201_204, "720907005202")
replace ea = "720907006203" if strpos(q_201_204, "720907006203")
replace ea = "720907006207" if strpos(q_201_204, "720907006207")
replace ea = "720907008201" if strpos(q_201_204, "720907008201")
replace ea = "720907009105" if strpos(q_201_204, "720907009105")
replace ea = "720907009110" if strpos(q_201_204, "720907009110")
replace ea = "720907010204" if strpos(q_201_204, "720907010204")
replace ea = "720908003203" if strpos(q_201_204, "720908003203")
replace ea = "720908006205" if strpos(q_201_204, "720908006205")
replace ea = "720908007201" if strpos(q_201_204, "720908007201")
replace ea = "730701002201" if strpos(q_201_204, "730701002201")
replace ea = "730701002202" if strpos(q_201_204, "730701002202")
replace ea = "730701002203" if strpos(q_201_204, "730701002203")
replace ea = "730701002206" if strpos(q_201_204, "730701002206")
replace ea = "730701003203" if strpos(q_201_204, "730701003203")
replace ea = "730701003204" if strpos(q_201_204, "730701003204")
replace ea = "730701003206" if strpos(q_201_204, "730701003206")
replace ea = "730701003208" if strpos(q_201_204, "730701003208")
replace ea = "730702001202" if strpos(q_201_204, "730702001202")
replace ea = "730702001203" if strpos(q_201_204, "730702001203")
replace ea = "730702003201" if strpos(q_201_204, "730702003201")
replace ea = "730702003202" if strpos(q_201_204, "730702003202")
replace ea = "730702004201" if strpos(q_201_204, "730702004201")
replace ea = "730702004202" if strpos(q_201_204, "730702004202")
replace ea = "730703001101" if strpos(q_201_204, "730703001101")
replace ea = "730703001102" if strpos(q_201_204, "730703001102")
replace ea = "730703001103" if strpos(q_201_204, "730703001103")
replace ea = "730703002101" if strpos(q_201_204, "730703002101")
replace ea = "730703002102" if strpos(q_201_204, "730703002102")
replace ea = "730703002103" if strpos(q_201_204, "730703002103")
replace ea = "730703003201" if strpos(q_201_204, "730703003201")
replace ea = "730703003202" if strpos(q_201_204, "730703003202")
replace ea = "730704001202" if strpos(q_201_204, "730704001202")
replace ea = "730704002201" if strpos(q_201_204, "730704002201")
replace ea = "730704002202" if strpos(q_201_204, "730704002202")
replace ea = "730704003201" if strpos(q_201_204, "730704003201")
replace ea = "730705001203" if strpos(q_201_204, "730705001203")
replace ea = "730705002201" if strpos(q_201_204, "730705002201")
replace ea = "730705003201" if strpos(q_201_204, "730705003201")
replace ea = "730706001202" if strpos(q_201_204, "730706001202")
replace ea = "730706001203" if strpos(q_201_204, "730706001203")
replace ea = "730706001204" if strpos(q_201_204, "730706001204")
replace ea = "730706002202" if strpos(q_201_204, "730706002202")
replace ea = "730706002205" if strpos(q_201_204, "730706002205")
replace ea = "730707001202" if strpos(q_201_204, "730707001202")
replace ea = "730707001205" if strpos(q_201_204, "730707001205")
replace ea = "730707002203" if strpos(q_201_204, "730707002203")
replace ea = "730707003202" if strpos(q_201_204, "730707003202")
replace ea = "730708001202" if strpos(q_201_204, "730708001202")
replace ea = "730708001205" if strpos(q_201_204, "730708001205")
replace ea = "930601001203" if strpos(q_201_204, "930601001203")
replace ea = "930601002202" if strpos(q_201_204, "930601002202")
replace ea = "930601003201" if strpos(q_201_204, "930601003201")
replace ea = "930601003203" if strpos(q_201_204, "930601003203")
replace ea = "930602002202" if strpos(q_201_204, "930602002202")
replace ea = "930602002204" if strpos(q_201_204, "930602002204")
replace ea = "930602003201" if strpos(q_201_204, "930602003201")
replace ea = "930602003204" if strpos(q_201_204, "930602003204")
replace ea = "930602003206" if strpos(q_201_204, "930602003206")
replace ea = "930602004201" if strpos(q_201_204, "930602004201")
replace ea = "930602005203" if strpos(q_201_204, "930602005203")
replace ea = "930602006202" if strpos(q_201_204, "930602006202")
replace ea = "930602006204" if strpos(q_201_204, "930602006204")
replace ea = "930603001201" if strpos(q_201_204, "930603001201")
replace ea = "930603002201" if strpos(q_201_204, "930603002201")
replace ea = "930603002204" if strpos(q_201_204, "930603002204")
replace ea = "930604001202" if strpos(q_201_204, "930604001202")
replace ea = "930604001206" if strpos(q_201_204, "930604001206")
replace ea = "930604002204" if strpos(q_201_204, "930604002204")
replace ea = "930604002206" if strpos(q_201_204, "930604002206")
replace ea = "930604004201" if strpos(q_201_204, "930604004201")
replace ea = "930604004204" if strpos(q_201_204, "930604004204")
replace ea = "930605001202" if strpos(q_201_204, "930605001202")
replace ea = "930605002201" if strpos(q_201_204, "930605002201")
replace ea = "930605002203" if strpos(q_201_204, "930605002203")
replace ea = "930605003201" if strpos(q_201_204, "930605003201")
replace ea = "930605003202" if strpos(q_201_204, "930605003202")
replace ea = "930606001204" if strpos(q_201_204, "930606001204")
replace ea = "930606003203" if strpos(q_201_204, "930606003203")
replace ea = "930606003207" if strpos(q_201_204, "930606003207")
replace ea = "930607001202" if strpos(q_201_204, "930607001202")
replace ea = "930607002202" if strpos(q_201_204, "930607002202")
replace ea = "930607003201" if strpos(q_201_204, "930607003201")
replace ea = "930607004203" if strpos(q_201_204, "930607004203")
replace ea = "930608001202" if strpos(q_201_204, "930608001202")
replace ea = "930608001205" if strpos(q_201_204, "930608001205")
replace ea = "930608002206" if strpos(q_201_204, "930608002206")
replace ea = "930608003201" if strpos(q_201_204, "930608003201")
replace ea = "930608004201" if strpos(q_201_204, "930608004201")
replace ea = "930608004203" if strpos(q_201_204, "930608004203")
replace ea = "720501004204" if strpos(q_201_204, "720501004204")
replace ea = "720508004201" if strpos(q_201_204, "720508004201")
replace ea = "720508003204" if strpos(q_201_204, "720508003204")
replace ea = "720505001202" if strpos(q_201_204, "720505001202")
replace ea = "720505003201" if strpos(q_201_204, "720505003201")
replace ea = "720503001205" if strpos(q_201_204, "720503001205")
replace ea = "720501003202" if strpos(q_201_204, "720501003202")
replace ea = "720703003207" if strpos(q_201_204, "720703003207")
replace ea = "720703001107" if strpos(q_201_204, "720703001107")
replace ea = "720703001102" if strpos(q_201_204, "720703001102")
replace ea = "720703004203" if strpos(q_201_204, "720703004203")
replace ea = "720703004202" if strpos(q_201_204, "720703004202")
replace ea = "720502003202" if strpos(q_201_204, "720502003202")
replace ea = "720508001202" if strpos(q_201_204, "720508001202")
replace ea = "730706002204" if strpos(q_201_204, "730706002204")
replace ea = "730706002201" if strpos(q_201_204, "730706002201")
replace ea = "730701001203" if strpos(q_201_204, "730701001203")
replace ea = "730705001202" if strpos(q_201_204, "730705001202")
replace ea = "730701003205" if strpos(q_201_204, "730701003205")
replace ea = "730701001202" if strpos(q_201_204, "730701001202")
replace ea = "730708001206" if strpos(q_201_204, "730708001206")
replace ea = "730704001203" if strpos(q_201_204, "730704001203")
replace ea = "720705001203" if strpos(q_201_204, "720705001203")
replace ea = "720705002203" if strpos(q_201_204, "720705002203")
replace ea = "730706002203" if strpos(q_201_204, "730706002203")
replace ea = "720503005201" if strpos(q_201_204, "720503005201")
replace ea = "720503004202" if strpos(q_201_204, "720503004202")
replace ea = "720501006202" if strpos(q_201_204, "720501006202")

destring ea, replace
tab ea, m
label var ea "EA of Boma"
format ea %12.0f

order state county payam boma ea, after(record_id)

*Create month, day, and year variables
gen month = substr(q_209, 6, 2)
destring month, replace
label var month "Month of Survey"
label def mnt 3 "March" 4 "April" 5 "May" 6 "June"
label val month mnt
tab month, m
gen day = substr(q_209, 9, 2)
destring day, replace
label var day "Day of Survey"
tab day, m
gen year = substr(q_209, 1, 4)
destring year, replace
label var year "Year of Survey"
tab year, m
order month day year, after(boma)

egen time_started_str = concat(q_209 q_212), punct(" ")
gen time_started = clock(time_started_str, "YMDhm")
format time_started %tc
label var time_started "Time Survey Started"

egen time_ended_str = concat(q_209 q_901), punct(" ")
gen time_ended = clock(time_ended_str, "YMDhm")
format time_ended %tc
label var time_ended "Time Survey Ended"

gen survey_minutes = minutes(time_ended - time_started)
format survey_minutes %9.2f
label var survey_minutes "Time in Minutes to Administer Survey (Calculated)"

gen survey_minutes2 = edited_duration / 60
label var survey_minutes2 "Time in Minutes to Administer Survey (Fulcrum)"

order time_started time_ended survey_minutes survey_minutes2, after(year)
drop time_started_str time_ended_str

egen date = concat(month day year), punc("-")
drop if county=="Akobo" & month<5
drop if county=="Aboko" & month==5 & day<31
drop if county=="Budi" & month<5
drop if county=="Budi" & month==5 & day<24
drop if county=="Duk" & month<5
drop if county=="Duk" & month==5 & day<28
drop if county=="Pibor" & month<5
drop if county=="Pibor" & month==5 & day<23
drop if county=="Leer" & month<5
drop if county=="Leer" & month==5 & day<28
drop if county=="Uror" & month<6
drop if county=="Uror" & month==6 & day<3

*New var for rowid
gen rowid=_n

*Screening
cap rm "`outpath'south_sudan_hh_survey_baseline_flags_`lng'_dqc_6July2021_list.txt"
cap file close myfile1
file open myfile1 using "`outpath'south_sudan_hh_survey_baseline_flags_`lng'_dqc_6July2021_list.txt", write
file write myfile1 "sno" _tab "Freq" _tab "record_id2" _tab "description" _tab "Condition"

****HH Questionnaire****

tostring ea, gen(ea_str) usedisplayformat

egen record_id2 = concat(record_id date assigned_to q_210_a ea_str), punc(",")

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
levelsof record_id2 if q_101==., local(record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "consent is missing" _tab `"if q_101==."'

*3) informed consent is no
local i = `i'+1
levelsof record_id  if q_101==0, local(record_id) clean
local ids_freq: word count `record_id'
levelsof record_id2  if q_101==0, local(record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "consent is no" _tab `"if q_101 == 0"'

*4) State missing 
local i = `i'+1
levelsof record_id if state==".", local(record_id) clean
local ids_freq: word count `record_id'
levelsof record_id2 if state==".", local(record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "state is missing" _tab `"if state==."'

*5) County missing 
local i = `i'+1
levelsof record_id if county==".", local(record_id) clean
local ids_freq: word count `record_id'
levelsof record_id2 if county==".", local(record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "county is missing" _tab `"if county==."'

*6) Payam missing 
local i = `i'+1
levelsof record_id if payam==".", local(record_id) clean
local ids_freq: word count `record_id'
levelsof record_id2 if payam==".", local(record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "payam is missing" _tab `"if payam==."'

*7) Boma missing 
local i = `i'+1
levelsof record_id if boma==".", local(record_id) clean
local ids_freq: word count `record_id'
levelsof record_id2 if boma==".", local(record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "boma is missing" _tab `"if boma==."'

*8) EA missing 
local i = `i'+1
levelsof record_id if ea==., local(record_id) clean
local ids_freq: word count `record_id'
levelsof record_id2 if ea==., local(record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "EA is missing" _tab `"if q_205==."'

*9) Location missing
local i = `i'+1
levelsof record_id if q_206==., local(record_id) clean
local ids_freq: word count `record_id'
levelsof record_id2 if q_206==., local(record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "Location is missing" _tab `"if q_206==."'

*10) Name of head of household missing
local i = `i'+1
levelsof record_id if q_207==".", local(record_id) clean
local ids_freq: word count `record_id'
levelsof record_id2 if q_207==".", local(record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "Name of Head of HH is missing" _tab `"if q_207==."' 

*11) Name of head of respondent missing
local i = `i'+1
levelsof record_id if q_208==".", local(record_id) clean
local ids_freq: word count `record_id'
levelsof record_id2 if q_208==".", local(record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "Name of respondent is missing" _tab `"if q_208==."' 

*12) Interview date missing
local i = `i'+1
levelsof record_id if q_209==".", local(record_id) clean
local ids_freq: word count `record_id'
levelsof record_id2 if q_209==".", local(record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "Interview date is missing" _tab `"if q_209==."'

*13) Enumerator name missing
local i = `i'+1
levelsof record_id if q_210_a==".", local(record_id) clean
local ids_freq: word count `record_id'
levelsof record_id2 if q_210_a==".", local(record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "Enumerator name is missing" _tab `"if q_210_a==."'

/*14) Enumerator ID missing
local i = `i'+1
levelsof record_id2 if q_210_b==".", local(record_id2) clean
local ids_freq: word count `record_id2'
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "Enumerator ID is missing" _tab `"if q_210_b==."'
*/

*15) Language of Interview missing
local i = `i'+1
levelsof record_id if q_211==., local(record_id) clean
local ids_freq: word count `record_id'
levelsof record_id2 if q_211==., local(record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "Language is missing" _tab `"if q_211==."'

*16) Start time missing
local i = `i'+1
levelsof record_id if q_212==".", local(record_id) clean
local ids_freq: word count `record_id'
levelsof record_id2 if q_212==".", local(record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "Start time is missing" _tab `"if q_212==."'

*17) End time missing
local i = `i'+1
levelsof record_id if q_901==".", local(record_id) clean
local ids_freq: word count `record_id'
levelsof record_id2 if q_901==".", local(record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "End time is missing" _tab `"if q_901==."'

*18) Negative time
local i = `i'+1
levelsof record_id if survey_minutes<0, local(record_id) clean
local ids_freq: word count `record_id'
levelsof record_id2 if survey_minutes<0, local(record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "Negative survey time" _tab `"if survey_minutes<0"'

*19) Time less than 30 minutes
local i = `i'+1
levelsof record_id if survey_minutes2<30, local(record_id) clean
local ids_freq: word count `record_id'
levelsof record_id2 if survey_minutes2<30, local(record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "Survey less than 30 minutes" _tab `"if survey_minutes2<30"'

*20) Time greater than 90 minutes
local i = `i'+1
levelsof record_id if survey_minutes2>90, local(record_id) clean
local ids_freq: word count `record_id'
levelsof record_id2 if survey_minutes2>90, local(record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "Survey more than 90 minutes" _tab `"if survey_minutes2>90"'

*21) Latitude missing
local i = `i'+1
levelsof record_id if latitude==., local(record_id) clean
local ids_freq: word count `record_id'
levelsof record_id2 if latitude==., local(record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "Latitude missing" _tab `"if latitude==."'

*22) Longitude missing
local i = `i'+1
levelsof record_id if longitude==., local(record_id) clean
local ids_freq: word count `record_id'
levelsof record_id2 if longitude==., local(record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "Longitude missing" _tab `"if longitude==."'

*23) Duplicate entries
local i = `i'+1
duplicates tag state county boma payam q_205 q_205 month day year q_401_a q_401_b q_401_c q_401_d q_401_e q_401_f q_401_g q_401_h q_401_i q_401_j q_401_k q_401_l q_401_m q_401_n q_401_o q_401_p q_401_q q_401_r q_401_s q_401_t q_401_u q_401_u_specify q_402_a q_402_b q_402_c q_402_d q_402_e q_402_f q_402_g q_402_h q_402_i q_402_j q_402_k q_402_l q_402_m q_402_n q_402_o q_402_p q_402_q q_402_r q_402_s q_402_t q_402_u q_403 q_404 q_405 q_406 q_407 q_408 q_409 q_410 q_411 q_412 q_413 q_414 q_415 q_416 q_417 q_418 q_419 q_420 q_421 q_422 q_423 q_424 q_425 q_426 q_427 q_428 q_429 q_430 q_431 q_432 q_433 q_434 q_435 q_436 q_437 q_438 q_439 q_440 q_441 q_442 q_443 q_444 q_445 q_446 q_447 q_448 q_449 q_450 q_451 q_452 q_453 q_455 q_456 q_457 q_458 q_459 q_460 q_461 q_462 q_463 q_464 q_465 q_466 q_468 q_469 q_470 q_471 q_472 q_473 q_474 q_475 q_476 q_477 q_478 q_479 q_480 q_481 q_482 q_483 q_484 q_485 q_486 q_488 q_489 q_490 q_491 q_492 q_493 q_494 q_495 q_496 q_497 q_498 q_501a q_501b q_501c q_501d q_501e q_501f q_501g q_501h q_501i q_501j q_501k q_501l q_501m q_501n q_501o q_501p q_502a q_502b q_502c q_502d q_502e q_502f q_502g q_502h q_502i q_502j q_502k q_502l q_502m q_502n q_502o q_502p q_504 q_508 q_509 q_509_a q_510 q_511 q_512_1 q_512_2 q_512_3 q_512_4 q_512_5 q_512_6 q_512_7 q_512_8 q_512_8_specify q_513 q_517 q_518_1 q_518_2 q_518_3 q_518_4 q_518_5 q_518_6 q_518_7 q_518_8 q_518_9 q_518_9_specify q_519 q_520 q_601 q_602_1 q_602_2 q_602_3 q_602_4 q_602_5 q_602_6 q_602_7 q_602_8 q_602_9 q_602_10 q_602_11 q_602_12 q_602_13 q_602_14 q_602_15 q_602_16 q_602_17 q_602_17_specify q_603  q_605 q_605_specify q_606 q_607_a q_607_b q_607_c q_607_d q_607_e q_607_f q_607_g q_607_h q_607_i q_607_j q_607_k q_608_a q_608_b q_608_c q_608_d q_608_e q_608_f q_608_g q_608_h q_608_i q_608_j q_608_k q_610 q_611 q_612 q_629 q_630 q_631 q_632 q_633 q_634 q_635 q_636 q_637 q_638 q_704 q_705_1 q_705_2 q_705_3 q_705_4 q_705_5 q_705_6 q_705_7 q_705_8 q_705_9 q_705_10 q_705_10_specify q_706 q_707 q_708 q_708_08_specify q_711 q_715 q_719 q_723 q_727 q_731 q_801 q_801_6_specify q_802 q_803 q_812 q_812_7_specify q_813 q_813_7_specify q_814 q_818 q_820 q_822 q_823 q_824 q_825 q_827 q_829 q_830_new q_831_new q_832_new, gen(dup_task)
levelsof record_id if dup_task>0 , local(record_id) clean
local ids_freq: word count `record_id'
levelsof record_id2 if dup_task>0 , local(record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "Duplicate entry" _tab "`state county boma payam q_205 month day year q_401_a q_401_b q_401_c q_401_d q_401_e q_401_f q_401_g q_401_h q_401_i q_401_j q_401_k q_401_l q_401_m q_401_n q_401_o q_401_p q_401_q q_401_r q_401_s q_401_t q_401_u q_401_u_specify q_402_a q_402_b q_402_c q_402_d q_402_e q_402_f q_402_g q_402_h q_402_i q_402_j q_402_k q_402_l q_402_m q_402_n q_402_o q_402_p q_402_q q_402_r q_402_s q_402_t q_402_u q_403 q_404 q_405 q_406 q_407 q_408 q_409 q_410 q_411 q_412 q_413 q_414 q_415 q_416 q_417 q_418 q_419 q_420 q_421 q_422 q_423 q_424 q_425 q_426 q_427 q_428 q_429 q_430 q_431 q_432 q_433 q_434 q_435 q_436 q_437 q_438 q_439 q_440 q_441 q_442 q_443 q_444 q_445 q_446 q_447 q_448 q_449 q_450 q_451 q_452 q_453 q_455 q_456 q_457 q_458 q_459 q_460 q_461 q_462 q_463 q_464 q_465 q_466 q_468 q_469 q_470 q_471 q_472 q_473 q_474 q_475 q_476 q_477 q_478 q_479 q_480 q_481 q_482 q_483 q_484 q_485 q_486 q_488 q_489 q_490 q_491 q_492 q_493 q_494 q_495 q_496 q_497 q_498 q_501a q_501b q_501c q_501d q_501e q_501f q_501g q_501h q_501i q_501j q_501k q_501l q_501m q_501n q_501o q_501p q_502a q_502b q_502c q_502d q_502e q_502f q_502g q_502h q_502i q_502j q_502k q_502l q_502m q_502n q_502o q_502p q_504 q_508 q_509 q_509_a q_510 q_511 q_512_1 q_512_2 q_512_3 q_512_4 q_512_5 q_512_6 q_512_7 q_512_8 q_512_8_specify q_513 q_517 q_518_1 q_518_2 q_518_3 q_518_4 q_518_5 q_518_6 q_518_7 q_518_8 q_518_9 q_518_9_specify q_519 q_520 q_601 q_602_1 q_602_2 q_602_3 q_602_4 q_602_5 q_602_6 q_602_7 q_602_8 q_602_9 q_602_10 q_602_11 q_602_12 q_602_13 q_602_14 q_602_15 q_602_16 q_602_17 q_602_17_specify q_603  q_605 q_605_specify q_606 q_607_a q_607_b q_607_c q_607_d q_607_e q_607_f q_607_g q_607_h q_607_i q_607_j q_607_k q_608_a q_608_b q_608_c q_608_d q_608_e q_608_f q_608_g q_608_h q_608_i q_608_j q_608_k q_610 q_611 q_612 q_629 q_630 q_631 q_632 q_633 q_634 q_635 q_636 q_637 q_638 q_704 q_705_1 q_705_2 q_705_3 q_705_4 q_705_5 q_705_6 q_705_7 q_705_8 q_705_9 q_705_10 q_705_10_specify q_706 q_707 q_708 q_708_08_specify q_711 q_715 q_719 q_723 q_727 q_731 q_801 q_801_6_specify q_802 q_803 q_812 q_812_7_specify q_813 q_813_7_specify q_814 q_818 q_820 q_822 q_823 q_824 q_825 q_827 q_829 q_830_new q_831_new q_832_new'"

*24) Empty rows
local i = `i'+1
levelsof record_id if q_403==. & q_404==. & q_405==. & q_406==. & q_407==. & q_408==. & q_409==. & q_410==. & q_411==. & q_412==. & q_413==. & q_414==. & q_415==. & q_416==. & q_417==. & q_418==. & q_419==., local(record_id) clean
local ids_freq: word count `record_id'
levelsof record_id2 if q_403==. & q_404==. & q_405==. & q_406==. & q_407==. & q_408==. & q_409==. & q_410==. & q_411==. & q_412==. & q_413==. & q_414==. & q_415==. & q_416==. & q_417==. & q_418==. & q_419==., local(record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`record_id2'" _tab "Likely empty row of data" _tab `"if q_403 - q_419==."'

* close tempfile and save to memory
file close myfile1
drop rowid
save "`outpath'mesp_household_baseline_survey_`lng'_hh_flag_dqc_6July2021.dta", replace
}
*

***************
* HH Schedule *
***************

*Load dataset 

foreach lng of local langz {
use "`inpath'mesp_household_baseline_survey_`lng'_hh_schedule_preprocessed_dqc_6July2021.dta", clear 

*New var for rowid
gen rowid=_n

*Screening
cap rm "`outpath'south_sudan_hh_survey_schedule_baseline_flags_`lng'_dqc_6July2021_list.txt"
cap file close myfile1
file open myfile1 using "`outpath'south_sudan_hh_survey_schedule_baseline_flags_`lng'_dqc_6July2021_list.txt", write
file write myfile1 "sno" _tab "Freq" _tab "child_record_id2" _tab "description" _tab "Condition"

****HH Schedule****
egen child_record_id2 = concat(child_record_id created_at created_by), punc("_")

local i = 0
*1) Name of household member missing 
local i = `i'+1
levelsof child_record_id if q_301==".", local(child_record_id) clean
local ids_freq: word count `child_record_id'
levelsof child_record_id2 if q_301==".", local(child_record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`child_record_id2'" _tab "Name of household member is missing" _tab `"if q_301==."'

*2) Sex missing 
local i = `i'+1
levelsof child_record_id if q_302==., local(child_record_id) clean
local ids_freq: word count `child_record_id'
levelsof child_record_id2 if q_302==., local(child_record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`child_record_id2'" _tab "Sex of household member is missing" _tab `"if q_302==."'

*3) HH Relationship missing 
local i = `i'+1
levelsof child_record_id if q_303==., local(child_record_id) clean
local ids_freq: word count `child_record_id'
levelsof child_record_id2 if q_303==., local(child_record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`child_record_id2'" _tab "HH relationship is missing" _tab `"if q_303==."'

*4) Age missing 
local i = `i'+1
levelsof child_record_id if q_304==., local(child_record_id) clean
local ids_freq: word count `child_record_id'
levelsof child_record_id2 if q_304==., local(child_record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`child_record_id2'" _tab "Age is missing" _tab `"if q_304==."'

*5) Literacy missing 
local i = `i'+1
levelsof child_record_id if q_305==., local(child_record_id) clean
local ids_freq: word count `child_record_id'
levelsof child_record_id2 if q_305==., local(child_record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`child_record_id2'" _tab "Literacy is missing" _tab `"if q_305==."'

*6) Ever attended school missing 
local i = `i'+1
levelsof child_record_id if q_306==., local(child_record_id) clean
local ids_freq: word count `child_record_id'
levelsof child_record_id2 if q_306==., local(child_record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`child_record_id2'" _tab "School attended is missing" _tab `"if q_306==."'

*7) Reason not attended school missing 
local i = `i'+1
levelsof child_record_id if q_306==0 & q_307==., local(child_record_id) clean
local ids_freq: word count `child_record_id'
levelsof child_record_id2 if q_306==0 & q_307==., local(child_record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`child_record_id2'" _tab "Reason not attended is missing" _tab `"if q_306==0 & q_307==."'

*8) Highest level of education missing 
local i = `i'+1
levelsof child_record_id if q_308==. & q_304>=6, local(child_record_id) clean
local ids_freq: word count `child_record_id'
levelsof child_record_id2 if q_308==. & q_304>=6, local(child_record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`child_record_id2'" _tab "Highest edu level is missing" _tab `"if q_308==. & q_306>=6"'

*9) Marital status missing 
local i = `i'+1
levelsof child_record_id if q_309==. & q_304>12, local(child_record_id) clean
local ids_freq: word count `child_record_id'
levelsof child_record_id2 if q_309==. & q_304>12, local(child_record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`child_record_id2'" _tab "Marital status is missing" _tab `"if q_309==. & q_304>12"'

*10) Economic activity missing 
local i = `i'+1
levelsof child_record_id if q_314==. & q_304>10, local(child_record_id) clean
local ids_freq: word count `child_record_id'
levelsof child_record_id2 if q_314==. & q_304>10, local(child_record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`child_record_id2'" _tab "Economic activity is missing" _tab `"if q_314==. & q_304>10"'

*11) Vaccine status missing 
local i = `i'+1
levelsof child_record_id if q_315==. & q_304<5, local(child_record_id) clean
local ids_freq: word count `child_record_id'
levelsof child_record_id2 if q_315==. & q_304<5, local(child_record_id2) clean
file write myfile1 _newline  "`i'" _tab "`ids_freq'" _tab "`child_record_id2'" _tab "Vaccine status is missing" _tab `"if q_315==. & q_304<5"'

* close tempfile and save to memory
file close myfile1
drop rowid

save "`outpath'mesp_household_baseline_survey_`lng'_hh_schedule_flag_dqc_6July2021.dta", replace
}
*
ATTENZIONE

use "`outpath'mesp_household_baseline_survey_didinga_hh_flag_dqc_6July2021.dta", clear
append using "`outpath'mesp_household_baseline_survey_dinka_hh_flag_dqc_6July2021.dta", force
append using "`outpath'mesp_household_baseline_survey_english_hh_flag_dqc_6July2021.dta", force
append using "`outpath'mesp_household_baseline_survey_jie_hh_flag_dqc_6July2021.dta", force
append using "`outpath'mesp_household_baseline_survey_murle_hh_flag_dqc_6July2021.dta", force
append using "`outpath'mesp_household_baseline_survey_nuer_hh_flag_dqc_6July2021.dta", force

drop if county=="Akobo" & month<5
drop if county=="Akobo" & month==5 & day<31 
drop if county=="Budi" & month<5
drop if county=="Budi" & month==5 & day<24
drop if county=="Duk" & month<5
drop if county=="Duk" & month==5 & day<28
drop if county=="Leer" & month<5
drop if county=="Leer" & month==5 & day<28
drop if county=="Pibor" & month<5
drop if county=="Pibor" & month==5 & day<23
drop if county=="Uror" & month<6
drop if county=="Uror" & month==6 & day<3

save "`outpath'mesp_household_baseline_survey_combined_hh_flag_dqc_6July2021.dta", replace

