
# South Sudan resilience
# Aspirations explore

# prep ---- 

source("code/00 South Sudan resilience - prep.R")

library(missMDA)

#dat <- read_dta("data/04_scoring/mesp_household_baseline_hh_survey_scored.dta")

# dat <- read_dta("data/05_sample_weights/mesp_household_baseline_hh_survey_weighted.dta")
# 
# datNames <- data.frame(names(dat))
# names(dat)

# remove pii

# dat <- dat %>%
#   select(-q_207, -q_208, -q_210_a)
# 
# library(readr)
# 
# write_rds(dat, file="data/local/mesp_household_baseline_hh_survey_weighted.rds")
# write_dta(dat, "data/local/mesp_household_baseline_hh_survey_weighted.dta")
# 
# dat <- read_rds(file="data/04_scoring/mesp_household_baseline_hh_survey_scored.dta")

?read_rds

frq(dat$q_629)

frq(dat$q_630)

frq(dat$abs_fatalism1)

asp <- dat %>%
  select(q_629,
         q_630,
         q_632,
         q_633,
         q_634,
         q_635)

frq(dat$q_631)

lapply(asp, frq)

frq(dat$q_633)

dat <- dat %>%
  mutate(asp1 = ifelse(q_629==1, 1,0),
         asp2 = ifelse(q_630==1, 1,0),
         asp3 = case_when(q_634 < 4 ~ 1,
                                     q_634 > 3 ~0,
                                     TRUE ~ NA_real_),
         asp4 = case_when(q_635 < 4 ~ 1,
                                     q_635 > 3 ~ 0,
                                     TRUE ~ NA_real_),
         asp5 = ifelse(q_632==1, 1,0),
         asp6 = ifelse(q_633==6, NA,
                       ifelse(q_633==4 | q_633==5, 1, 0)),
         aspirations_index2 = asp1 + asp2 + asp3 + asp4 + asp5 + asp6,
         aspirations_index2_cen = scale(aspirations_index2))

describe(dat$aspirations_index2)

