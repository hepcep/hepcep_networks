# Analyze synthetic dataset with 32K nodes 
# Fit ERGM with 5 dyadic independent terms

rm(list=ls())
# Libraries ----------

library(network)
library(ergm)
library(dplyr)

# Data ----------

load("out/population_2014-08-17--11.00.43.RData")
ls()


# Check starting network (2 degrees specified) ----------
sim.fit.add.degrees
list.vertex.attributes(sim.fit.add.degrees)

# Compare simulated in- and out-degrees vs. empirical ----------
  #full details at out/big-pop-two-degrees.Rout 


# Add attribute information to network ----------

n0 %v% "age" <- data$Age
n0 %v% "sex" <- as.numeric(data$Gender)-1 #0=F, 1=M
n0%v% "race" <- as.numeric(data$Race)-1 # 0=Hisp, 1=NH-black, 2=White
n0%v% "zipcode" <- data$Zip
n0%v% "hcv" <- as.numeric(data$HCV)


# Recode attributes as needed  ----------

## Create new variable age_cat: <25 = 0, 25-30=1, rest=2
data <-
  data %>% mutate(age_cat = 
                  ifelse(data$Age < 25, 0, data$Age)) 

length(which(data$age_cat == 0)) == length(which(data$Age < 25)) #check

data <- 
  mutate(data, age_cat = 
             ifelse(data$age_cat >= 30, 2, data$age_cat)) 
length(which(data$age_cat == 2)) == length(which(data$Age >= 30)) #check
   
data <- 
  mutate(data, age_cat = 
           ifelse(data$age_cat >= 25, 1, data$age_cat)) 
length(which(data$age_cat == 1)) == 
  length(intersect(
  which(data$Age >= 25), which(data$Age < 30)
  )) #check

n0 %v% "age_cat" <- data$age_cat

## Create new variable hcv_status: 1 = chronic+infectious_acute, 0=else
data <- 
  data %>% mutate(hcv_status = recode(HCV, 
                                      "chronic" = 1,
                                      "infectious_acute" = 1,
                                      "exposed" = 0,
                                      "recovered" = 0,
                                      "susceptible" = 0
                                      )
                                      )
table(data$hcv_status)
table(data$HCV)

n0 %v% "hcv_status" <- data$hcv_status

## Create new variable race_recode: 0=NH White, 1=Hispanic, 2=NH-black-mixed-other
data <- 
  data %>% mutate(race_recode = recode(Race, 
                                       "NHWhite" = 0,
                                       "Hispanic" = 1,
                                       "NHBlack" = 2,
                                       "Other" = 2)
                  )

table(data$race_recode)
table(data$Race)

n0 %v% "race_recode" <- data$race_recode

# Compute nedges.target ----------

n.female <- length(which(n0 %v% "sex" == 0))
n.male <- length(which(n0 %v% "sex" == 1))
n <- n.male+n.female

pop.mean.deg <- ((n.male*4.0)+(n.female*3.5))/n

n.edges.target <- n*pop.mean.deg/2

# Compute statistics for nodematch terms ----------


## nodematch on sex

nedges.sex.0 <- #fem-fem 
  data %>% 
  mutate(all_edges = Drug_in_degree + Drug_out_degree) %>%
  filter(Gender == "Female") %>%
  summarise(n.edges.sex.0 = sum(all_edges))

nedges.sex.1 <- #male-male 
  data %>% 
  mutate(all_edges = Drug_in_degree + Drug_out_degree) %>%
  filter(Gender == "Male") %>%
  summarise(n.edges.sex.1 = sum(all_edges))

nedges.sex.0.0 <- as.numeric(3.5*0.36*nedges.sex.0)*1/2 #female-female
nedges.sex.1.1 <- as.numeric(4.0*0.70*nedges.sex.1)*1/2 #male-male

## nodematch on race
nedges.race.0 <- #white 
data %>% 
  mutate(all_edges = Drug_in_degree + Drug_out_degree) %>%
  filter(Race == "NHWhite") %>%
  summarise(n.edges.w = sum(all_edges))

nedges.race.1 <- #hisp
data %>% 
  mutate(all_edges = Drug_in_degree + Drug_out_degree) %>%
  filter(Race == "Hispanic") %>%
  summarise(n.edges.h = sum(all_edges))

nedges.race.2 <- #black
data %>% 
  mutate(all_edges = Drug_in_degree + Drug_out_degree) %>%
  filter(Race == "Black" | Race == "Other") %>%
  summarise(n.edges.b = sum(all_edges))

nedges.race.0.0 <- as.numeric(0.80*nedges.race.0)*1/2
nedges.race.1.1 <- as.numeric(0.35*nedges.race.1)*1/2
nedges.race.2.2 <- as.numeric(0.12*nedges.race.2)*1/2

## nodematch on HCV

nedges.hcv.0 <- #HCV-negative
  data %>% 
  mutate(all_edges = Drug_in_degree + Drug_out_degree) %>%
  filter(hcv_status == 0) %>%
  summarise(n.edges.hcv.0 = sum(all_edges))

nedges.hcv.1 <- #HCV-positive
  data %>% 
  mutate(all_edges = Drug_in_degree + Drug_out_degree) %>%
  filter(hcv_status == 1) %>%
  summarise(n.edges.hcv.1 = sum(all_edges))

nedges.hcv.0.0 <- as.numeric(0.66*nedges.hcv.1)*1/2 #neg-neg
nedges.hcv.1.1 <- as.numeric(0.23*nedges.hcv.0)*1/2 #pos-pos

# Fit ERGM with nodematch ----------

add.nodematch.one <-
  ergm(
    n0 ~ edges + odegree(c(0, 2)) + idegree(c(0,2))+
      nodematch("sex", diff=TRUE),
    target.stats = c(n.edges.target, outdeg_tbl[c(1,3)], indeg_tbl[c(1,3)],
                     nedges.sex.0.0, nedges.sex.1.1
                    ),
    eval.loglik = FALSE,
    control = control.ergm(MCMLE.maxit = 100)
  )

# add.nodematch.two <-
#   ergm(
#     n0 ~ edges + odegree(c(0, 2)) + idegree(c(0,2))+
#       nodematch("sex", diff=TRUE)+
#       nodematch("race_recode", diff=TRUE),
#     target.stats = c(nedges, outdeg_tbl[c(1,3)], indeg_tbl[c(1,3)],
#                      nedges.sex.0.0, nedges.sex.1.1,
#                      nedges.race.0.0, nedges.race.1.1, nedges.race.2.2),
#     eval.loglik = FALSE,
#     control = control.ergm(MCMLE.maxit = 100)
#   )
# 
# 
# add.nodematch.all <-
#   ergm(
#     n0 ~ edges + odegree(c(0, 2)) + idegree(c(0,2))+
#       nodematch("sex", diff=TRUE)+
#       nodematch("race_recode", diff=TRUE)+
#       nodematch("hcv_status", diff=TRUE),
#     target.stats = c(nedges, outdeg_tbl[c(1,3)], indeg_tbl[c(1,3)],
#                      nedges.sex.0.0, nedges.sex.1.1,
#                      nedges.race.0.0, nedges.race.1.1, nedges.race.2.2,
#                      nedges.hcv.0.0, nedges.hcv.1.1),
#     eval.loglik = FALSE,
#     control = control.ergm(MCMLE.maxit = 100)
#   )

## Save object
save.image(file="out/add-nodematch-rev.RData")
