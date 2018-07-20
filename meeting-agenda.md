# Space for Networks Agenda and Notes

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