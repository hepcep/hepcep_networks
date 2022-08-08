# Simulate network (n=32K) from ERGM fit 
# parameterized with meta data  


rm(list=ls())


# Libraries ----------

library(network)
library(ergm)
library(dplyr)
library(ergm.userterms)


# Data ----------

load("../fit-ergms/out/racemix-plus-dist-plus-negbin-odeg0-3-indeg0-1-orignialdata.RData")


# Model summary
summary(fit.metadata.mixing)


# Simulate 1 network ----------

net <- simulate(fit.metadata.mixing)
net


# Investigate netstats on 1 network ----------

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

summary(net ~ dist(1:4))
round(dist.nedge.distribution)

# Simulate 100 networks ----------

nsim.vec <- 1:100
sim_results <- as.list(nsim.vec)
set.seed(Sys.time())

for (iter in 1:length(nsim.vec)){
  sim_results[[iter]] <- simulate(fit.metadata.mixing,
                                  nsim=1
                                  )
}


#  Investigate netstats on 100 networks ----------

## edgecount
ecount <- unlist(lapply(sim_results, network.edgecount))
summary(ecount); edges_target

## outdegree
outdeg0 <- unlist(lapply(sim_results, 
                        function (x) summary(x ~ odegree(0))
                        ))
outdeg1 <- unlist(lapply(sim_results, 
                         function (x) summary(x ~ odegree(1))
))
outdeg2 <- unlist(lapply(sim_results, 
                         function (x) summary(x ~ odegree(2))
))
outdeg3 <- unlist(lapply(sim_results, 
                         function (x) summary(x ~ odegree(3))
))
outdeg4 <- unlist(lapply(sim_results, 
                         function (x) summary(x ~ odegree(4))
))


c(mean(outdeg0), mean(outdeg1), mean(outdeg2), mean(outdeg3), mean(outdeg4))
outedges$n_nodes[1:5]

## indegree
indeg0 <- unlist(lapply(sim_results, 
                         function (x) summary(x ~ idegree(0))
))
indeg1 <- unlist(lapply(sim_results, 
                         function (x) summary(x ~ idegree(1))
))
indeg2 <- unlist(lapply(sim_results, 
                         function (x) summary(x ~ idegree(2))
))
indeg3 <- unlist(lapply(sim_results, 
                         function (x) summary(x ~ idegree(3))
))
indeg4 <- unlist(lapply(sim_results, 
                         function (x) summary(x ~ idegree(4))
))


c(mean(indeg0), mean(indeg1), mean(indeg2), mean(indeg3), mean(indeg4))
inedges$n_nodes[1:5]

## nodemix(race.num)
race.num <- unlist(lapply(sim_results, 
                         function (x) summary(x ~ nodemix("race.num"))
))

summary(sim_results[[1]] ~ nodemix("race.num"))
round(
  c(target.w.w, target.b.w, target.h.w, target.o.w,
    target.w.b, target.b.b, target.h.b, target.o.b,
    target.w.h, target.b.h, target.h.h, target.o.h,
    target.w.o, target.b.o, target.h.o, target.o.o),
  0
)

## nodemix(gender)
gender <- unlist(lapply(sim_results, 
                          function (x) summary(x ~ nodemix("gender"))
))

summary(sim_results[[10]] ~ nodemix("gender"))
round(c(tgt.female.pctfemale, tgt.female.pctmale, tgt.male.pctfemale, tgt.male.pctmale), 0)

## nodemix(young)
young <- unlist(lapply(sim_results, 
                        function (x) summary(x ~ nodemix("young"))
)) 

summary(sim_results[[10]] ~ nodemix("young"))
round(c(tgt.old.pctold, tgt.old.pctyoung, tgt.young.pctold, tgt.young.pctyoung))

save.image("out/simulate-racemix-plus-dist-plus-negbin-odeg0-3-indeg0-1-orignialdata.RData")

