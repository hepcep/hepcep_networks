rm(list=ls())

# Libraries ---------------------------

library(network)
library(ergm)
library(dplyr)
library(ergm.userterms)


# Load data ---------------------------

load("simulate-convergence-setup.RData")


# Fit ERGM with mixing targets derived above ---------------------------

fit.mixing <- ergm(n0 ~ edges + 
              dist(dist.terms)+
              nodemix("race", base=c(1))+
              nodematch("gender", diff=TRUE)+ 
              nodematch("chicago", diff=TRUE)+
              odegree(c(0,2,3))+ 
              idegree(c(0,2,3)),
              target.stats = c(
                  nedges_mean, 
                  dist.nedge.distribution[dist.terms],
                  race_mm_mat_mean[c(2:16)],
                  gender_mm_mat_mean[c(1,4)],
                  chicago_mm_mat_mean[c(1,4)],
                  outdeg_tbl[c(1,3,4)], 
                  indeg_tbl[c(1,3,4)]
                  ),
            eval.loglik = FALSE,
            control = control.ergm(MCMLE.maxit = 200)
)

# Simualte ERGM from above with mixing targets derived above ---------------------------

sim <- simulate(fit.mixing)
sim

# Compare statistics ---------------------------

network.edgecount(sim); nedges_mean
summary(sim ~ dist(1:7)); dist_mat_mean
mixingmatrix(sim, "race")

# Save data ---------------------------

save.image("large-net-dist-term-mixing.RData")
