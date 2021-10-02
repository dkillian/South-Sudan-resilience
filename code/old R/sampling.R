

cluster <- 1:300

cluster_pop <- runif(300, 2000, 12000)

?rpois
?runif

cluster_selection_wr <- sample(cluster, 100, replace=T, prob = cluster_pop)

cluster_selection_wor <- sample(cluster, 100, replace=F)

?sample

out <- cluster[cluster_selection]

out2 <- cluster %in% cluster_selection_wor

cluster_selected <- as.numeric(out2)
  
  
ifelse(cluster==cluster_selection, 1,0)

cluster_selected

pop <- sum(cluster_pop)

cluster_frame <- data.frame(cluster, cluster_pop, cluster_selected) %>%
  mutate(cluster_prob_wr = cluster_pop / sum(cluster_pop),
         cluster_prob_wor = 1/300,
         hh_prob = 17 / (cluster_pop / 8))

cluster_frame

sample <- cluster_frame %>%
  filter(cluster_selected==1) %>%
  mutate(ov_prob = cluster_prob_wor*hh_prob,
         weight = 1/ov_prob,
         strat_pop_tot = cluster_pop / cluster_prob_wor)

sum(sample$weight)


library(tidyverse)


library(sjmisc)
frq(cluster_selection)

library(tidyverse)
?geom_abline
?abline
?plot

plot(mtcars$cyl, mtcars$mpg)
abline(a = 37, b = 2)

range(0:300)


diff(c(1,2))
