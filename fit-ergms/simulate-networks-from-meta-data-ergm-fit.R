# Simulate network (n=32K) from ERGM fit 
# parameterized with meta data  


rm(list=ls())


# Libraries ----------

library(network)
library(ergm)
library(dplyr)
#library(ergm.userterms)


# Data ----------

load("out/model3-5.RData")


# Model summary
summary(fit.metadata.mixing)


# MCMC diagnostics
pdf(file="out/model3-5.pdf")
mcmc.diagnostics(fit.metadata.mixing)
dev.off()


# Simulate networks ----------

net <- simulate(fit.metadata.mixing)
net


# Investigate netstats ----------

summary(net ~ edges)
edges_target

summary(net ~ idegree(0:4)) 
inedges$n_nodes[1:4]


save.image("out/simulate-model-3-5.RData")
