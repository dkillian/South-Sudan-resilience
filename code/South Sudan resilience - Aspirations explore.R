
# South Sudan resilience
# Aspirations explore

# prep ---- 

source("code/00 South Sudan resilience - prep.R")

library(missMDA)
library(missForest)

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

# Aspirations ---- 

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

write_dta(dat, "data/local/mesp_household_baseline_hh_survey_weighted.dta")

svydat <- svydesign(data = dat,
                    ids = ~ea,
                    weights= ~final_wt1,
                    strata = ~county)

svyrdat <- dat %>%
  as_survey_design(ids = ea,
                   strata=county,
                   weights=final_wt1)



# missing data imputation ---- 

locus <- dat %>%
  select(county,
         hhsize=household_members,
         q_636:q_638) %>%
  as.data.frame() %>%
  mutate(County = factor(county)) %>%
  select(-county)

#locus[,2:5] <- lapply(locus[,2:5], as.numeric)
locus[,1:4] <- lapply(locus[,1:4], as.numeric)


str(locus)
head(locus)
describe(locus)
frq(locus$county)

?missForest
locus_out <- missForest(xmis=locus)

locus_out

locus_forest_out <- locus_out$ximp

describe(locus_forest_out)

locus_famd_imp <- imputeFAMD(locus)

str(locus_famd_imp)

locus_famd_out <- locus_famd_imp$completeObs

str(locus_famd_out)
describe(locus_famd_out)

frq(locus$County)

locus_forest_out %>%
  select(2:4) %>%
  fa.parallel(cor="poly")

loc_forest_fa <- locus_forest_out %>%
  select(2:4) %>%
  fa(cor="poly")

loc_forest_fa
str(loc_forest_fa)

a <- loc_forest_fa$scores
describe(a)

frq(a)

dat <- dat %>%
  mutate(Locus = loc_forest_fa$scores)

describe(dat$Locus)

ggplot(dat, aes(x=Locus)) + 
  geom_density(color="darkblue", size=1)

