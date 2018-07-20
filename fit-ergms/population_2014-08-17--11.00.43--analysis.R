# Analyze synthetic dataset with 32K nodes 
# Fit ERGM with 5 dyadic independent terms

rm(list=ls())
# Libraries ----------

library(network)
library(ergm)
library(dplyr)
library(ergm.userterms)

# Data ----------

data <- read.csv("/project/khanna7/Projects/midway2/HepCep/data/pwids_with_lat_lon.csv", header = T)
dim(data)
glimpse(data)


# Summary Statistics ----------

indeg <- data$Drug_in_degree
outdeg <- data$Drug_out_degree

indeg_tbl <- as.numeric(table(indeg))
outdeg_tbl <- as.numeric(table(outdeg))

summary(indeg)
summary(outdeg)

hist(indeg, breaks = 32)
hist(outdeg, breaks = 32)

nedges <- max(c(sum(indeg)),
              sum((outdeg))
              )
                
mdeg <- nedges/nrow(data)
sum(indeg)
sum(outdeg)

dist.prop.distribution <- c(30, 12, 12, 15, 15, 10)
dist.nedge.distribution <- nedges*dist.prop.distribution

    
# Fit ERGM ----------

n0 <- network.initialize(n = nrow(data))
n0 %v% "lat" <- data$lat
n0 %v% "lon" <- data$lon

dist.terms <- 1:4

##  fit <- ergm(n0 ~ edges + odegree(0) + idegree(0),
##             target.stats = c(nedges, outdeg_tbl[1], indeg_tbl[1]),
##             eval.loglik = FALSE,
##             control = control.ergm(MCMLE.maxit = 100)
##             )

## sim <- simulate(fit)
## sim

## fit.add.degrees <-
##   ergm(
##     n0 ~ edges + odegree(c(0, 2)) + idegree(c(0,2)),
##     target.stats = c(nedges, outdeg_tbl[c(1,3)], indeg_tbl[c(1,3)]),
##     eval.loglik = FALSE,
##     control = control.ergm(MCMLE.maxit = 100)
##   )

## summary(fit.add.degrees)
## sim.fit.add.degrees <- simulate(fit.add.degrees)

## fit <- ergm(n0 ~ edges + odegree(0) + idegree(0)+
##            + dist(1:6),
##             target.stats = c(nedges, outdeg_tbl[1], indeg_tbl[1],
##                              dist.nedge.distribution),
##             eval.loglik = FALSE,
##             control = control.ergm(MCMLE.maxit = 500)
##             )

##############################
#ABOVE ERGM DID NOT CONVERGE
##############################

## fit <- ergm(n0 ~ edges + odegree(0) + idegree(0)+
##            + dist(dist.terms),
##             target.stats = c(nedges, outdeg_tbl[1], indeg_tbl[1],
##                              dist.nedge.distribution[dist.terms]),
##             eval.loglik = FALSE,
##             control = control.ergm(MCMLE.maxit = 500)
##             )
##############################
#ABOVE ERGM DID NOT CONVERGE
##############################

fit <- ergm(n0 ~ edges + 
            dist(dist.terms),
            target.stats = c(nedges, 
                             dist.nedge.distribution[dist.terms]),
            eval.loglik = FALSE,
            control = control.ergm(MCMLE.maxit = 500)
            )


sim <- simulate(fit)
sim

## fit.add.degrees.dist <-
##   ergm(
##     n0 ~ edges + odegree(c(0, 2)) + idegree(c(0,2))+
##     dist(1:6),
##     target.stats = c(nedges, outdeg_tbl[c(1,3)], indeg_tbl[c(1,3)],
##                      dist.nedge.distribution),
##     eval.loglik = FALSE,
##     control = control.ergm(MCMLE.maxit = 100)
##   )

## summary(fit.add.degrees.dist)
## sim.fit.add.degrees.dist <- simulate(fit.add.degrees.dist)

# Compare simulated out- and in-degrees vs empirical

## # only degree 0
## summary(sim ~ odegree(0:3))/sum(summary(sim ~ odegree(0:3))) 
## outdeg_tbl/nrow(data)

## summary(sim ~ idegree(0:3))/sum(summary(sim ~ idegree(0:3)))
## indeg_tbl/nrow(data)

## #degrees 0 and 2

## summary(sim.fit.add.degrees ~ odegree(0:3))/sum(summary(sim.fit.add.degrees ~ odegree(0:3))) 
## outdeg_tbl[1:4]/nrow(data)

## summary(sim.fit.add.degrees ~ idegree(0:3))/sum(summary(sim.fit.add.degrees ~ idegree(0:3)))
## indeg_tbl[1:4]/nrow(data)

#degrees 0 and 2 and dist

## summary(sim.fit.add.degrees.dist ~ odegree(0:3))/sum(summary(sim.fit.add.degrees.dist ~ odegree(0:3))) 
## outdeg_tbl[1:4]/nrow(data)

## summary(sim.fit.add.degrees.dist ~ idegree(0:3))/sum(summary(sim.fit.add.degrees.dist ~ idegree(0:3)))
## indeg_tbl[1:4]/nrow(data)

save.image("large-net-dist-term.RData")
