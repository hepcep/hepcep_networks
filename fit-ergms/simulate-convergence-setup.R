rm(list=ls())

# Libraries ---------------------------

library(network)
library(ergm)
library(dplyr)
library(ergm.userterms)


# Load data ---------------------------

load("large-net-dist-term.RData")


# Simulate 100 networks ---------------------------

sim <- simulate(fit, nsim = 100)
class(sim)
sim[[1]]
sim[[100]]


# Select parameter(s), check its distribution ---------------------------

## edges 
nedges <- lapply(sim, function (x) network.edgecount(x))
nedges_mean <- mean(unlist(nedges)) 

## dist
dist_list <- lapply(sim, function (x) summary(x ~ dist(1:7)))
dist_mat <- matrix(unlist(dist_list), nrow = length(sim), byrow = TRUE)
dist_mat_mean <- apply(dist_mat, 2, mean)

## odegree
odegree_list <- lapply(sim, function (x) summary(x ~ odegree(1:7)))
odegree_mat <- matrix(unlist(odegree_list), nrow = length(sim), byrow = TRUE)
odegree_mat_mean <- apply(odegree_mat, 2, mean)

## idegree
idegree_list <- lapply(sim, function (x) summary(x ~ idegree(1:7)))
idegree_mat <- matrix(unlist(idegree_list), nrow = length(sim), byrow = TRUE)
idegree_mat_mean <- apply(idegree_mat, 2, mean)

## race-mixing
race_mm <- lapply(sim, function (x) as.numeric(mixingmatrix(x, "race")$matrix))
race_mm_mat <- matrix(unlist(race_mm), nrow = length(sim), byrow = TRUE)
race_mm_mat_mean <- apply(race_mm_mat, 2, mean)

##gender-mixing
gender_mm <- lapply(sim, function (x) as.numeric(mixingmatrix(x, "gender")$matrix))
gender_mm_mat <- matrix(unlist(gender_mm), nrow = length(sim), byrow = TRUE)
gender_mm_mat_mean <- apply(gender_mm_mat, 2, mean)

# ##chicago-nonchicago (zip starts with 606)
chicago_mm <- lapply(sim, function (x) as.numeric(mixingmatrix(x, "chicago")$matrix))
chicago_mm_mat <- matrix(unlist(chicago_mm), nrow = length(sim), byrow = TRUE)
chicago_mm_mat_mean <- apply(chicago_mm_mat, 2, mean)

# Save set up for simulating covergence
save.image("simulate-convergence-setup.RData")