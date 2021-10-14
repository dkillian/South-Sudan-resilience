# South Sudan resilience
# Trauma explore

source("code/00 South Sudan resilience - prep.R")

# prep ---- 

trauma <- dat %>%
  select(q_711,
         q_715,
         q_719,
         q_723,
         q_727,
         q_731)

map(trauma, frq)

trauma <- trauma %>%
  mutate(trauma_thoughts = case_when(q_711 == 1 ~ 1,
                                     TRUE ~ 0),
         trauma_feelings = case_when(q_715 == 1 ~ 1,
                                     TRUE ~ 0),
         trauma_behavior = case_when(q_719 == 1 ~ 1,
                                     TRUE ~ 0),
         trauma_relations = case_when(q_723 == 1 ~ 1,
                                     TRUE ~ 0),
         trauma_physical = case_when(q_727 == 1 ~ 1,
                                     TRUE ~ 0),
         trauma_function = case_when(q_731 == 1 ~ 1,
                                     TRUE ~ 0)) %>%
  select(-(1:6))

frq(trauma$trauma_thoughts)

map(trauma, frq)

fa.parallel(trauma, 
            cor="tet")

trauma_fa_3 <- fa(trauma,
                  nfactors=3,
                  cor="tet")

trauma_fa_3

trauma_fa_3_scores <- trauma_fa_3$scores %>%
  as.data.frame()

describe(trauma_fa_3_scores)

head(trauma_fa_3_scores)

ggplot(trauma_fa_3_scores, aes(MR2)) + 
  geom_density()

# fac1: physical and functioning
# fac2: thoughts and feelings
# fac3: behavioral

trauma_fa_2 <- fa(trauma,
                  nfactors=2,
                  cor="tet")

trauma_fa_2

trauma_fa_1 <- fa(trauma,
                  cor="tet")

trauma_fa_1

# I suppose go with factor 2 of the three factor model

trauma <- trauma %>%
  mutate(stress=ifelse(trauma_fa_3_scores$MR2>0, 1,0))

frq(trauma$stress)

dat <- dat %>%
  cbind(trauma)

write_dta(dat, "data/local/SSD resilience baseline prepared.dta")

