# Agenda and Notes

## July 31, 2018
* Emailed Steve G about the seventh distance parameter to check if it is being assigned an ERGM coefficientof NA 
because it is considered to be a base term.
* We have seen that the starting network in our [example](https://bitbucket.org/jozik/hepcep_networks/src/master/fit-ergms/jozik-network-test.R)
produced valid estimates and simulated network outputs with a population size of 10K. 
This model specification works even with a population of size 32K. 
* The model crashes When we attempt to fit an ERGM with target statistics specified for a newtwork with 32K nodes. 
Think about whether these specified target statistics are somehow incorrect. 
* Found the error in above -- I had forgotten to divide the %s in the distance distribution by 100. 
After I corrected the error, the following model converged:

```
dist.terms <- c(1:5,7) #leave one out 

fit <- ergm(n0 ~ edges + 
            dist(dist.terms),
            target.stats = c(nedges, 
                             dist.nedge.distribution[dist.terms]),
            eval.loglik = FALSE,
            control = control.ergm(MCMLE.maxit = 500)
            )


```

* Now add some degree terms here.

## July 27, 2018
* Critique email to statnet listserv regarding NA parameter.
* Discuss if large population model (32K nodes) with edges+dist(c(1:5,7)) works. Might not know the answer by the time we start our call. 
On reason may be that in the network of size 10K we first initialized a random network and then estimated coefficients for `edges+dist(c(1:5,7)`.
In the case with 32K nodes, we are trying to supply target statistics for parameters and estimate coefficients that way.

## July 20, 2018
* ERGMs using the distance term did not work on the full network. 
Most failed with a degeneracy error, it was not just a matter of converging. 
See [sample models](https://bitbucket.org/jozik/hepcep_networks/src/master/fit-ergms/population_2014-08-17--11.00.43--analysis.R):

```
dist.terms <- 1:4

fit.add.degrees.dist <-
   ergm(
     n0 ~ edges + odegree(c(0, 2)) + idegree(c(0,2))+
     dist(1:6),
     target.stats = c(nedges, outdeg_tbl[c(1,3)], indeg_tbl[c(1,3)],
                      dist.nedge.distribution),
     eval.loglik = FALSE,
     control = control.ergm(MCMLE.maxit = 100)
   )

fit <- ergm(n0 ~ edges + odegree(0) + idegree(0)+
            + dist(1:6),
             target.stats = c(nedges, outdeg_tbl[1], indeg_tbl[1],
                              dist.nedge.distribution),
             eval.loglik = FALSE,
             control = control.ergm(MCMLE.maxit = 500)
            )

fit <- ergm(n0 ~ edges + odegree(0) + idegree(0)+
            + dist(dist.terms),
             target.stats = c(nedges, outdeg_tbl[1], indeg_tbl[1],
                              dist.nedge.distribution[dist.terms]),
             eval.loglik = FALSE,
             control = control.ergm(MCMLE.maxit = 500)
             )

fit <- ergm(n0 ~ edges + 
            dist(dist.terms),
            target.stats = c(nedges, 
                             dist.nedge.distribution[dist.terms]),
            eval.loglik = FALSE,
            control = control.ergm(MCMLE.maxit = 500)
            )

```

* Since edges+dist did not work, I tested a [smaller network](https://bitbucket.org/jozik/hepcep_networks/src/master/fit-ergms/jozik-network-test.R) 
with 10K nodes. Fits on this one worked, except the directed network gave an NA as the coefficient for the 7th term in ergm. 
I am not sure what a coefficient of NA means in ERGMs.

* Two things to think about: a. why is the coef for the 7th term NA, b) why are the ERGMs on the full network not converging.