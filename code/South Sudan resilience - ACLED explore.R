# South Sudan resilience
# ACLED explore


source("code/00 South Sudan resilience - prep.R")

dat <- dat %>%
  mutate(date = mdy(date))

frq(dat$date)
frq(dat$county)

counties <- c("Akobo","Budi","Duk","Leer","Pibor","Uror")
counties

min(dat$date)
max(dat$date)

str(dat)[1:5]

acled <- read_csv("data/contextual/ACLED 2020-07-30-2021-08-31-South_Sudan.csv")

acled <- acled %>%
  mutate(date = dmy(event_date)) %>%
  filter(event_type!="Protests",
         date < as.Date("2021-05-23"),
         date > as.Date("2020-12-31"),
         admin2 %in% counties)

write_csv(acled, "data/contextual/ACLED filtered Jan-May 2021.csv")


acled_County <- acled %>%
  group_by()

frq(acled$event_date)
frq(acled$date)
frq(acled$admin1)
frq(acled$admin2)

cnty <- split(dat, dat$county)

apply(cnty, FUN=function(x) frq(x$date))

a <- map(cnty, function(x) frq(x$date))

date <- dat %>%
  group_by(county) %>%
  summarize(min=min(date),
            max=max(date))

date

describe(dat$shock_exposure_index)

ggplot(dat, aes(shock_exposure_index)) + 
  geom_bar()

frq(dat$shock_exposure_index
    )

frq(dat$trauma)

tab_xtab(dat$trauma, 
         dat$county,
         show.col.prc = T)



