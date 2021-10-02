# BPPS
# data prep

packages <- c("arm", "BMA", "brms", "corrplot", "dummies","DescTools", "estimatr","extrafont", "extrafontdb", "janitor",
              "reshape2","tidyr","broom", "haven", "HH","Hmisc","lubridate","knitr", "margins", "magrittr", "plotrix",
              "scales","survey", "srvyr", "sysfonts", "foreign","car", "ICC", "openxlsx", "ggrepel", "readr",
              "readxl", "sjmisc", "sjPlot", "sjstats", "sjlabelled", "skimr","labelled", "texreg", "janitor","psych","dplyr",
              "tidyverse", "viridis", "here", "ggridges", "ggthemes", "DT", "jtools", "huxtable", "stringi", "gghighlight",
              "plm", "brms", "rstan", "rstanarm","tidybayes","texreg","gt","gtsummary","huxtable","stargazer", "gsynth",
              "panelView", "assertr", "pointblank", "validate", "sandwich", "workflowr")

lapply(packages, library, character.only=T)

# font_add_google("Source Sans Pro", "sans-serif")

options(digits=3, scipen=6)
#options(digits=8, scipen=9)

# set default
base <- theme_bw() + theme(panel.grid.minor.x=element_blank(),
                           panel.grid.minor.y=element_blank(),
                           plot.title=element_text(face="bold",size=18, hjust=.5, family = "Source Sans Pro"),
                           plot.subtitle = element_text(size=16, family="Source Sans Pro"),
                           plot.caption=element_text(size=12, family="Source Sans Pro"),
                           axis.title=element_text(size=16, family="Source Sans Pro"),
                           axis.text=element_text(size=14, family="Source Sans Pro"),
                           legend.text=element_text(size=14, family="Source Sans Pro"),
                           strip.text=element_text(size=14, family="Source Sans Pro"),
                           panel.border=element_blank(),
                           axis.ticks = element_blank())

theme_set(base)

faceted <- theme_bw() +
  theme(panel.grid.minor.x=element_blank(),
        panel.grid.minor.y=element_blank(),
        plot.title=element_text(face="bold",size=18, hjust=.5, family = "Source Sans Pro"),
        plot.subtitle = element_text(size=16, family="Source Sans Pro"),
        plot.caption=element_text(size=12, family="Source Sans Pro"),
        axis.title=element_text(size=16, family="Source Sans Pro"),
        axis.text=element_text(size=14, family="Source Sans Pro"),
        legend.text=element_text(size=14, family="Source Sans Pro"),
        strip.text=element_text(size=14, family="Source Sans Pro"))


# reg plot
#
# tidy_out <- function(data, term_key=term_key) {
#   tidy(data) %>%
#     mutate(lower = estimate - 1.96*std.error,
#            upper = estimate + 1.96*std.error,
#            color=case_when(lower > 0 ~ "#002F6C",
#                            upper < 0 ~ "#BA0C2F",
#                            TRUE ~ "#8C8985")) %>%
#     left_join(term_key) %>%
#     filter(term_lab != "Intercept")
# }
#
#
# regplot <- function(data, xmin, xmax, limits) {
#   p <- ggplot(data, aes(x=estimate, y=fct_reorder(term_lab, estimate)), color = color, fill = color) +
#     geom_vline(xintercept=0, color="darkgrey", size=1.2) +
#     geom_errorbarh(aes(xmin=lower, xmax=upper), color=data$color, height=0, size=1.2, alpha = 0.7) +
#     geom_label(aes(label=paste0(round(estimate*100,1), "%" )),color = data$color, size=4.5) +
#     scale_x_continuous(breaks=seq(xmin, xmax, .05),
#                        limits=limits,
#                        labels = scales::percent_format(accuracy=1)) +
#     labs(x = "", y = "")
#
#   return(p)
# }

# read data

# dat <- haven::read_spss("data/raw/Iraq Perception study_Jul2021-final_codedv2.sav",
#                         user_na = T)
#
# datNames <- data.frame(names(dat))
#
# options(survey.lonely.psu="certainty")
#
# svydat1 <- svydesign(data = dat,
#                     ids = ~PSU,
#                     strata = ~Gov)
#
# svydat2 <- svydesign(data = dat,
#                      ids= ~PSU + ~1,
#                      strata = ~Gov)
#
# svydat3 <- svydesign(data = dat,
#                     ids= ~District + ~SubDistrict + ~PSU,
#                     strata = ~Gov)
#
# svyrdat <- dat %>%
#   as_survey_design(ids = PSU,
#                    strata=Gov)

path <- "data/Iraq hh instrument pre-codebook.xlsx"

labs <- path %>%
  excel_sheets() %>%
  set_names() %>%
  lapply(function(x) read_xlsx(x, path=path))

lablist <- names(labs) %>%
  as.data.frame()


yes_key <- labs$yes_no
agree4_key <- labs$agree4
prov_key <- labs$province
strat_key <- labs$strata
sex_key <- labs$sex
fem_key <- labs$female
eth_key <- labs$ethnic_group
fem_key <- labs$female
eth_key <- labs$ethnic_group
eth_key2 <- labs$eth_grp2
gov_key <- labs$governorate %>%
  rename(Gov=gov)
loc_key <- labs$locality
#age_key <- labs$age_grp
age_key <- data.frame(age_grp=1:4,
                      age_grp_lab=c("18-25","26-35","36-45", "46+"))
ov_key <- data.frame(ov=1,
                     ov_lab="Overall")
rel_key <- labs$rel_grp
rel_key2 <- labs$rel_grp2
rel_key3 <- labs$rel_grp3
rel_key4 <- labs$rel_grp4
educ_key <- labs$educ2
educ_key
age_grp_key <- labs$age_grpAID
age_grp_key
employ_key <- labs$employ
often_key <- labs$often2
count_key <-labs$count
security_key <- labs$security_source

# eth2 <- data.frame(eth_code = 1:7,
#                    eth_lab = get_labels(dat$ethnicity))
#
# ageAID <- data.frame(age_grpAID=1:3,
#                    age_lab=get_labels(dat$age_grpAID))
# ageAID
#
# ageAf <- data.frame(age_grpAf=1:3,
#                      age_lab=get_labels(dat$age_grpAf))
# ageAf
#
# sec2 <- data.frame(sec_code = 1:7,
#                    sec_lab=get_labels(dat$security_provider))
#
# logo <- labs$logo
#
# ed2 <- data.frame(education=1:3,
#                   edu_lab=get_labels(dat$education))
# ed2
#
# rad <- data.frame(C4a=1:112,
#                   radio=get_labels(dat$C4a))
#
# tv <- data.frame(C9a=1:85,
#                  tv=get_labels(dat$C9a))


#term_key <- read_csv("output/term key.csv")

#term_key2 <- read_csv("output/term key2.csv")
#term_key2

# functions ----

ov_tab <- function(design, var) {

  design %>%
    #group_by({{groupvar}}) %>%
    summarise(prop=survey_mean({{var}}, na.rm=T, deff="replace"),
              Sample=survey_total({{var}}, na.rm=T)) %>%
    mutate(ind_type="Overall",
           disag="disag",
           margin = prop_se*1.96,
           lower=prop - margin,
           upper=prop + margin,
           ci=paste(round(lower,3), round(upper,3), sep="-"))
}

disag_tab <- function(design, var, groupvar, ind_type, key) {

  key <- key %>%
    rename(disag=2)

  design %>%
    group_by({{groupvar}}) %>%
    summarise(prop=survey_mean({{var}}, na.rm=T, deff="replace"),
              Sample=survey_total({{var}}, na.rm=T)) %>%
    mutate(ind_type=ind_type,
           margin = prop_se*1.96,
           lower=prop - margin,
           upper=prop + margin,
           ci=paste(round(lower,3), round(upper,3), sep="-")) %>%
    left_join(key) %>%
    relocate(disag, .after=ind_type)
}


tidy_out <- function(data, term_key=term_key) {
  tidy(data) %>%
    mutate(lower = estimate - 1.96*std.error,
           upper = estimate + 1.96*std.error,
           color=case_when(lower > 0 ~ "#002F6C",
                           upper < 0 ~ "#BA0C2F",
                           TRUE ~ "#8C8985")) %>%
    left_join(term_key) %>%
    filter(term_lab != "Intercept")
}


regplot <- function(data, xmin, xmax, limits) {
  p <- ggplot(data, aes(x=estimate, y=fct_reorder(term_lab, estimate)), color = color, fill = color) +
    geom_vline(xintercept=0, color="darkgrey", size=1.2) +
    geom_errorbarh(aes(xmin=lower, xmax=upper), color=data$color, height=0, size=1.2, alpha = 0.7) +
    geom_label(aes(label=paste0(round(estimate*100,1), "%" )),color = data$color, size=4.5) +
    scale_x_continuous(breaks=seq(xmin, xmax, .05),
                       limits=limits,
                       labels = scales::percent_format(accuracy=1)) +
    labs(x = "", y = "")

  return(p)
}


# data ----

dat <- read_rds("data/prepared/Iraq Perception HH Survey.rds")

options(survey.lonely.psu="certainty")


dat$unemployed <- case_when(dat$employ==3 ~ 1
                            , dat$employ %in% c(1,2,4)~0)


svydat <- svydesign(data = dat,
                    ids = ~PSU,
                    strata = ~Gov)

svyrdat <- dat %>%
  as_survey_design(ids = PSU,
                   strata=Gov)


inc_key <- data.frame(inc=1:3,
                      inc_lab = get_labels(dat$inc))
inc_key

educ_key <- educ_key %>%
  rename(education=educ)

educ_key

merged_premise <- read_rds("data/prepared/Iraq Perception Study - merged premise tasks.rds")


