# Analyze synthetic dataset with 32K nodes 
# Fit ERGM with 5 dyadic independent terms

rm(list=ls())


# Libraries ----------

library(network)
library(ergm)
library(dplyr)
library(ergm.userterms)


# Data ----------

load("meta-mixing-init-net.RData")
# refer to "population_2014-08-17--11.00.43--analysis.R" for an example

# Recode to add new variables to dataset ----------

# young (< 26, to be set = 1) vs old (>= 26, to be set = 0) 
age.cat <- n0 %v% "age.cat"
age.cat.df <- as.data.frame(age.cat)
age.cat.df <-  
  mutate(age.cat, young = ifelse(age.cat == 0, 1, 0), .data = age.cat.df)
xtabs(~age.cat+young, data = age.cat.df)


# Initialize network and add attributes ----------

n0 %v% "young" <- age.cat.df$young


# Generate target statistics from meta-mixing data ----------

## gender 
### mixing information from meta-analysis of sathcap AND socnet
edges.male.end <- mean(c(0.58, 0.59))
edges.female.end <- mean(c(0.40, 0.41))

male.pctmale <- 0.53 
male.pctfemale <- 0.47
female.pctmale <- 0.75
female.pctfemale <- 0.22

### set gender targets 
tgt.male.pctmale <- edges_target*edges.male.end*male.pctmale
tgt.male.pctfemale <- edges_target*edges.male.end*male.pctfemale
tgt.female.pctmale <- edges_target*edges.female.end*female.pctmale  
tgt.female.pctfemale <- edges_target*edges.female.end*female.pctfemale

## young (1=young; 0=old)
### mixing information from meta-analysis of sathcap AND socnet
edges.young.end <- 0.10
edges.old.end <- 0.90
  
young.pctyoung <- 0.60
young.pctold <- 0.40
old.pctyoung <- 0.14
old.pctold <- 0.86
 
## set young targets from meta data
tgt.young.pctyoung <- edges_target * edges.young.end * young.pctyoung
tgt.young.pctold <- edges_target * edges.young.end * young.pctold
tgt.old.pctyoung <- edges_target * edges.old.end * old.pctyoung
tgt.old.pctold <- edges_target * edges.old.end * old.pctold


# ## chicago 
# ### mixing information from meta-analysis of sathcap AND socnet
# chicago.pctchicago <- 0.67
# chicago.pctnonchicago <- 0.30
# nonchicago.pctchicago <- 0.60
# nonchicago.pctnonchicago <- 0.40
# 
# ### mixing from simulation
# chicago.mm <- mixingmatrix(sim, "chicago") #fem=1, chicago=2
# from.nonchicago <- sum(chicago.mm$matrix[,1])
# from.chicago <- sum(chicago.mm$matrix[,2])
# 
# ### set chicago targets from sathcap
# tgt.chicago.pctchicago <- from.chicago*chicago.pctchicago
# tgt.chicago.pctnonchicago <- from.chicago*chicago.pctnonchicago
# tgt.nonchicago.pctchicago <- from.nonchicago*chicago.pctchicago
# tgt.nonchicago.pctnonchicago <- from.nonchicago*chicago.pctnonchicago
# 
# ## race (1=Hisp, 2=NH Black,3=NHWhite, 4=O)
# race.1.1 <- 0.58
# race.1.2 <- 0.12
# race.1.3 <- 0.18
# race.1.4 <- 0.12
# race.2.1 <- 0.06
# race.2.2 <- 0.83
# race.2.3 <- 0.10
# race.2.4 <- 0.01
# race.3.1 <- 0.12
# race.3.2 <- 0.10
# race.3.3 <- 0.73
# race.3.4 <- 0.05
# race.4.1 <- 0.22
# race.4.2 <- 0.21
# race.4.3 <- 0.43
# race.4.4 <- 0.14

# Fit ERGM (with SATHCAP mixing) ----------

fit.sathcap.mixing <- 
  ergm(
    n0 ~ 
      edges +
      #odegree(c(0, 2, 3)) + idegree(c(0, 2, 3))+
      nodemix("gender", base=1)+
      nodemix("young", base=1),
      target.stats = c(edges_target,
                     c(tgt.female.pctmale, tgt.male.pctfemale, tgt.male.pctmale),
                     c(tgt.old.pctyoung, tgt.young.pctold, tgt.young.pctyoung)
                     ),
    eval.loglik = FALSE,
    control = control.ergm(MCMLE.maxit = 500)
  )


save.image("out/meta-mixing-ergm-fit.RData")
