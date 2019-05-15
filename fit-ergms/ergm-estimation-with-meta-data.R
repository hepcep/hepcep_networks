# Analyze synthetic dataset with 32K nodes 
# Fit ERGM with 5 dyadic independent terms

rm(list=ls())

# Libraries ----------

library(network)
library(ergm)
library(dplyr)
library(ergm.userterms)

# Data ----------

load("large-net-dist-term.RData") 
# refer to "population_2014-08-17--11.00.43--analysis.R" for details


# Recode to add new variables to dataset ----------

# young (< 26, coded 1) vs old (>= 26, coded 0) (from SATHCAP)
data <-  
  mutate(data, young = ifelse(Age < 26, 1, 0))


# Initialize network and add attributes ----------

n0 %v% "young" <- data$young


# Generate target statistics from SATHCAP mixing data ----------

## gender 
### mixing information from meta-analysis of sathcap AND socnet
male.pctmale <- 0.53
male.pctfemale <- 0.47
female.pctmale <- 0.75
female.pctfemale <- 0.22

### mixing from simulation
gender.mm <- mixingmatrix(sim, "gender") #fem=1, male=2
from.female <- sum(gender.mm$matrix[,1])
from.male <- sum(gender.mm$matrix[,2])

### set gender targets from sathcap
tgt.male.pctmale <- from.male*male.pctmale
tgt.male.pctfemale <- from.male*male.pctfemale
tgt.female.pctmale <- from.female*male.pctmale  
tgt.female.pctfemale <- from.female*male.pctfemale

## young (1=young; 0=old) 
### mixing information from meta-analysis of sathcap AND socnet
young.pctyoung <- 0.60
young.pctold <- 0.40
old.pctyoung <- 0.14
old.pctold <- 0.86

### mixing from simulation
sim %v% "young" <- n0 %v% "young" #attach "young" att for sim from n0
young.mm <- mixingmatrix(sim, "young")
from.old <- sum(young.mm$matrix[,1])
from.young <- sum(young.mm$matrix[,2])

### set young targets from sathcap
tgt.young.pctyoung <- from.young*young.pctyoung
tgt.young.pctold <- from.young*young.pctold
tgt.old.pctyoung <- from.old*young.pctyoung  
tgt.old.pctold <- from.old*young.pctold

## chicago 
### mixing information from meta-analysis of sathcap AND socnet
chicago.pctchicago <- 0.67
chicago.pctnonchicago <- 0.30
nonchicago.pctchicago <- 0.60
nonchicago.pctnonchicago <- 0.40

### mixing from simulation
chicago.mm <- mixingmatrix(sim, "chicago") #fem=1, chicago=2
from.nonchicago <- sum(chicago.mm$matrix[,1])
from.chicago <- sum(chicago.mm$matrix[,2])

### set chicago targets from sathcap
tgt.chicago.pctchicago <- from.chicago*chicago.pctchicago
tgt.chicago.pctnonchicago <- from.chicago*chicago.pctnonchicago
tgt.nonchicago.pctchicago <- from.nonchicago*chicago.pctchicago
tgt.nonchicago.pctnonchicago <- from.nonchicago*chicago.pctnonchicago

## race (1=Hisp, 2=NH Black,3=NHWhite, 4=O)
race.1.1 <- 0.58
race.1.2 <- 0.12
race.1.3 <- 0.18
race.1.4 <- 0.12
race.2.1 <- 0.06
race.2.2 <- 0.83
race.2.3 <- 0.10
race.2.4 <- 0.01
race.3.1 <- 0.12
race.3.2 <- 0.10
race.3.3 <- 0.73
race.3.4 <- 0.05
race.4.1 <- 0.22
race.4.2 <- 0.21
race.4.3 <- 0.43
race.4.4 <- 0.14

# Fit ERGM (with SATHCAP mixing) ----------

fit.sathcap.mixing <- 
  ergm(
    n0 ~ 
      edges +
      #odegree(c(0, 2, 3)) + idegree(c(0, 2, 3))+
      nodematch("gender", diff=TRUE)+
      nodematch("young", diff=TRUE)+
      nodematch("chicago", diff=TRUE)+
      nodematch("race", diff=T),
      #+
      #nodeofactor("race", base=1)+
      #nodeifactor("race", base=1),
    target.stats = c(nedges,
                     #outdeg_tbl[c(1, 3, 4)], indeg_tbl[c(1, 3, 4)],
                     c(tgt.female.pctfemale, tgt.male.pctmale),
                     c(tgt.young.pctyoung, tgt.old.pctold),
                     c(tgt.chicago.pctchicago, tgt.nonchicago.pctnonchicago),
                     c(race.1.1,           
                                 race.2.2, 
                                           race.3.3, 
                                                     race.4.4
                     )
                     #c(sum(race.2.1, race.2.2, race.2.3, race.2.4),
                        #sum(race.3.1, race.3.2, race.3.3, race.3.4),
                        #sum(race.4.1, race.4.2, race.4.3, race.4.4)),
                     #c(sum(race.1.2, race.2.2, race.3.2, race.4.2),
                        #sum(race.1.3, race.2.3, race.3.3, race.4.3),
                        #sum(race.1.4, race.2.4, race.3.4, race.4.4))
                     ),
    eval.loglik = FALSE,
    control = control.ergm(MCMLE.maxit = 500)
  )


save.image("sathcap-mixing-network.RData")
