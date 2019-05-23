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

## edges
abs(network.edgecount(sim)-edges_target)/
  edges_target

## out- and in-degrees
degs.to.investigate <- 0:10

odegree_mat <- matrix(summary(sim ~ 
                                odegree(degs.to.investigate)), 
                      nrow=1, byrow = TRUE)/network.size(sim)
odegree_summ <- apply(odegree_mat, 2, mean)
cbind(odegree_summ, 
      c(outedges[["n_nodes"]][degs.to.investigate+1]/n)
)

idegree_mat <- matrix(summary(sim ~ 
                                idegree(degs.to.investigate)), 
                      nrow=1, byrow = TRUE)/network.size(sim)
idegree_summ <- apply(idegree_mat, 2, mean)
cbind(idegree_summ, 
      c(inedges[["n_nodes"]][degs.to.investigate+1]/n)
)

mixingmatrix(sim, "race.num")


save.image("out/simulate-meta-mixing-ergm-fit.RData")
