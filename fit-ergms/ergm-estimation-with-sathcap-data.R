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
### mixing information from sathcap
male.pctmale <- 0.5842
male.pctfemale <- 0.4158
female.pctmale <- 0.6523
female.pctfemale <- 0.3477

### mixing from simulation
gender.mm <- mixingmatrix(sim, "gender") #fem=1, male=2
from.female <- sum(gender.mm$matrix[,1])
from.male <- sum(gender.mm$matrix[,2])

### set gender targets from sathcap
tgt.male.pctmale <- from.male*male.pctmale
tgt.male.pctfemale <- from.male*male.pctfemale
tgt.female.pctmale <- from.female*male.pctmale  
tgt.female.pctfemale <- from.female*male.pctfemale


# Fit ERGM (with SATHCAP mixing) ----------

fit.sathcap.mixing <- 
  ergm(
    n0 ~ 
      edges +
      #odegree(c(0, 2, 3)) + idegree(c(0, 2, 3))+
      nodematch("gender", diff=TRUE),
    target.stats = c(nedges,
                     #outdeg_tbl[c(1, 3, 4)], indeg_tbl[c(1, 3, 4)],
                     c(tgt.female.pctfemale, tgt.male.pctmale)                     
                     ),
    eval.loglik = FALSE,
    control = control.ergm(MCMLE.maxit = 500)
  )


save.image("sathcap-mixing-network.RData")
