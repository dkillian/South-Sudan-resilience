
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

