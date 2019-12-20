# Simulate network (n=32K) from ERGM fit 
# parameterized with meta data  


rm(list=ls())


# Libraries ----------

library(network)
library(ergm)
library(dplyr)
#library(ergm.userterms)


# Data ----------

load("out/model6-2-increase-san.RData")


# Model summary
summary(fit.metadata.mixing)


# MCMC diagnostics
pdf(file="out/model7-increase-san-increase-san.pdf")
mcmc.diagnostics(fit.metadata.mixing)
dev.off()


# Simulate networks ----------

net <- simulate(fit.metadata.mixing)
net


# Investigate netstats ----------

summary(net ~ edges)
edges_target

summary(net ~ nodemix("gender"))
round(c(tgt.female.pctfemale, tgt.female.pctmale, tgt.male.pctfemale, tgt.male.pctmale), 0)

summary(net ~ nodemix("young"))
round(c(tgt.old.pctold, tgt.old.pctyoung, tgt.young.pctold, tgt.young.pctyoung))

summary(net ~ nodemix("race.num"))
round(
  c(target.w.w, target.b.w, target.h.w, target.o.w,
    target.w.b, target.b.b, target.h.b, target.o.b,
    target.w.h, target.b.h, target.h.h, target.o.h,
    target.w.o, target.b.o, target.h.o, target.o.o),
  0
                 )



summary(net ~ idegree(0:4)) 
inedges$n_nodes[1:4]

summary(net ~ odegree(0:4)) 
outedges$n_nodes[1:5]


save.image("out/simulate-model6-2-increase-san.RData")


