# Simulate network (n=32K) from ERGM fit 
# parameterized with meta data  


rm(list=ls())


# Libraries ----------

library(network)
library(ergm)
library(dplyr)
#library(ergm.userterms)


# Data ----------

load("out/meta-mixing-ergm-fit.RData")


# Simulate networks ----------

sim <- simulate(fit.sathcap.mixing)
sim


# Investigate statistics of simulated network(s) ----------

abs(network.edgecount(sim)-edges_target)/edges_target

mixingmatrix(sim, "race.num")

save.image("out/simulate-meta-mixing-ergm-fit.RData")
