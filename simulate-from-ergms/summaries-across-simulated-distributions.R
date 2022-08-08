# Summarize simulated statistics across multiple networks


rm(list=ls())


# Libraries ----------

library(network)
library(ergm)
library(ergm.userterms)

# Data ----------


load("out/simulate-racemix-plus-dist-plus-negbin-odeg0-3-indeg0-1-orignialdata.RData")

# Compute summaries and IQRs ----------

edgecount.sim.data <- (unlist(lapply(sim_results, function (x) network.edgecount(x)))) #edge count summary
mean(edgecount.sim.data)
quantile(edgecount.sim.data, probs = c(2.5/100, 97.5/100))

summary(outdeg0)
summary(outdeg1) 
summary(outdeg2)
summary(outdeg3)
summary(outdeg4)

summary(indeg0)
summary(indeg1) 
summary(indeg2)
summary(indeg3)
summary(indeg4)

indeg.gr.0.1 <- n - (indeg0 + indeg1)
summary(indeg.gr.0.1)
quantile(indeg.gr.0.1, probs = c(2.5/100, 97.5/100))

outdeg.gr.0.3 <- n - (outdeg0 + outdeg1 + outdeg2 + outdeg3)
summary(outdeg.gr.0.3)
quantile(outdeg.gr.0.3, probs = c(2.5/100, 97.5/100))

sim.race.num <- lapply(nsim.vec, function (x) summary(sim_results[[x]] ~ nodemix("race.num")))
summary(unlist(lapply(sim.race.num, function (x) x["mix.race.num.1.1"])))
summary(unlist(lapply(sim.race.num, function (x) x["mix.race.num.2.1"])))
summary(unlist(lapply(sim.race.num, function (x) x["mix.race.num.3.1"])))
summary(unlist(lapply(sim.race.num, function (x) x["mix.race.num.4.1"])))
summary(unlist(lapply(sim.race.num, function (x) x["mix.race.num.1.2"])))
summary(unlist(lapply(sim.race.num, function (x) x["mix.race.num.2.2"])))
summary(unlist(lapply(sim.race.num, function (x) x["mix.race.num.3.2"])))
summary(unlist(lapply(sim.race.num, function (x) x["mix.race.num.4.2"])))
summary(unlist(lapply(sim.race.num, function (x) x["mix.race.num.1.3"])))
summary(unlist(lapply(sim.race.num, function (x) x["mix.race.num.2.3"])))
summary(unlist(lapply(sim.race.num, function (x) x["mix.race.num.3.3"])))
summary(unlist(lapply(sim.race.num, function (x) x["mix.race.num.4.3"])))
summary(unlist(lapply(sim.race.num, function (x) x["mix.race.num.1.4"])))
summary(unlist(lapply(sim.race.num, function (x) x["mix.race.num.2.4"])))
summary(unlist(lapply(sim.race.num, function (x) x["mix.race.num.3.4"])))
summary(unlist(lapply(sim.race.num, function (x) x["mix.race.num.4.4"])))

sim.gender <- lapply(nsim.vec, function (x) summary(sim_results[[x]] ~ nodemix("gender")))
summary(unlist(lapply(sim.gender, function (x) x["mix.gender.female.female"])))
summary(unlist(lapply(sim.gender, function (x) x["mix.gender.male.female"])))
summary(unlist(lapply(sim.gender, function (x) x["mix.gender.female.male"])))
summary(unlist(lapply(sim.gender, function (x) x["mix.gender.male.male"])))

sim.young <- lapply(nsim.vec, function (x) summary(sim_results[[x]] ~ nodemix("young")))
summary(unlist(lapply(sim.young, function (x) x["mix.young.0.0"])))
summary(unlist(lapply(sim.young, function (x) x["mix.young.1.0"])))
summary(unlist(lapply(sim.young, function (x) x["mix.young.0.1"])))
summary(unlist(lapply(sim.young, function (x) x["mix.young.1.1"])))

sim.dist <- lapply(nsim.vec, function (x) summary(sim_results[[x]] ~ dist(1:4)))
summary(unlist(lapply(sim.dist, function (x) x["dist1"])))
summary(unlist(lapply(sim.dist, function (x) x["dist2"])))
summary(unlist(lapply(sim.dist, function (x) x["dist3"])))
summary(unlist(lapply(sim.dist, function (x) x["dist4"])))


