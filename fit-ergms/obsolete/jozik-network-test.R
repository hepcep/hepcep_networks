# To test dist term in ergm.userterms package 

rm(list=ls())

# libraries ----

library(network)
library(ergm.userterms)

# Initialize (and test with) undirected network ----

# set up network 1
nw.size <- 32000
m = matrix(c(rep(1,nw.size-1),2:nw.size), byrow = FALSE, ncol = 2)
ggg <- as.network(m, matrix.type='edgelist',directed = F)
ggg %v% "lat" <- seq(41.9,41.3,length.out = nw.size)
ggg %v% "lon" <- rep(-87.6964695120882,times = nw.size)

# test summary statistic
summary(ggg ~ dist(1:4))

# fit ergm
undir1 <- ergm(ggg ~ edges + dist(c(1:3))) #leaving one out to avoid collinearity
summary(undir1)

undir2 <- ergm(ggg ~ edges + dist(4:1)) #specifying in reverse order
summary(undir2)

# simulate and test gof
sim.undir1 <- simulate(undir1, simulate=100, statsonly = T, 
                       coef = c(coef(undir1))
                       )

# Initialize (and test with) directed network ----

gggD <- as.network(m, matrix.type='edgelist',directed = T)
gggD %v% "lat" <- seq(41.9,41.3,length.out = nw.size)
gggD %v% "lon" <- rep(-87.6964695120882,times = nw.size)

# test summary statistic
summary(gggD ~ dist(1:4))

# fit ergm
dir1 <- ergm(ggg ~ edges + dist(1:3)) #coefficient for 4th distance term, if included, is NA
summary(dir1)

# simulate and test gof
sim.dir1 <- simulate(dir1, simulate=100, statsonly = T, 
                     coef = c(coef(dir1))
)
sim.dir1 #simulated
summary(gggD ~ edges + dist(1:4)) #observed
