# README #

HepCEP project networks repository

```R
library(network)

# Test of dist metric 
nw.size <- 10000
m = matrix(c(rep(1,nw.size-1),2:nw.size), byrow = FALSE, ncol = 2)
ggg <- as.network(m, matrix.type='edgelist',directed = F)
ggg %v% "lat" <- seq(41.9,41.3,length.out = nw.size)
ggg %v% "lon" <- rep(-87.6964695120882,times = nw.size)
summary(ggg ~ dist(1:7))

```
