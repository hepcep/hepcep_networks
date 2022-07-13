# README #

HepCEP project networks repository


## Custom `ergm.userterms` package, including `dist` term

To test the `ergm.userterms` package: 
    - Package is on this [repository](https://bitbucket.org/jozik/hepcep_networks/src/master/fit-ergms/). 
    - Cloning the repository from bitbucket will save the pacakge code
    - The package can then be installed via `R CMD INSTALL  ergm.userterms`
    - See sample test code below

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

## Running the 