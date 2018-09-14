# Agenda and Notes

## September 14, 2018
* Think about the strengths and weaknesses of ERGM as opposed to Sasha's APK approach (in terms of using ERGM to predict the exact links that are represented in the data)
* Think about how these cross-sectional fits can be translated to the type of dynamic model that we are interested in. 
* Verified Steve G's recommendation on flipping order of `dist` terms to see if one that gets the NA switches. See [here](https://bitbucket.org/jozik/hepcep_networks/src/master/fit-ergms/jozik-network-test.R).

To do:
* Generate a sample (say 100) networks from the fitted ERGM with specified targets below.   
* What are the additional mixing terms that need to be picked?     
* What is the distribution of these mixing parameters of interest on the sample of networks generated above?    
* Pick one value for that mixing parameter within this distribution.     
* Check if a convergent ERGM can be fit ny specifing this value as a target statistic for the mixing paramter of interest.     


## August 31, 2018
* Review base terms response from Steven G
* Think about the strengths and weaknesses of ERGM as opposed to Sasha's APK approach (in terms of using ERGM to predict the exact links that are represented in the data)
* Think about how these cross-sectional fits can be translated to the type of dynamic model that we are interested in. 
* Add degree 3 to converged model `*degree(c(0,2))` below, to get:         
                               
```
> dist.terms <- c(1:5,7) #leave one out 
 
> fit <- ergm(n0 ~ edges + 
+             dist(dist.terms) +
+             odegree(c(0,2,3)) + idegree(c(0,2,3)),
+             target.stats = c(nedges, 
+                              dist.nedge.distribution[dist.terms],
+                              outdeg_tbl[c(1,3,4)], indeg_tbl[c(1,3,4)]),
+             eval.loglik = FALSE,
+             control = control.ergm(MCMLE.maxit = 500)
+             )

```
Model fit is below:

```
> load("large-net-dist-term.RData")

> summary(sim ~ odegree(0:15))/sum(summary(sim ~ odegree(0:15))) 
    odegree0     odegree1     odegree2     odegree3     odegree4     odegree5 
6.997594e-01 1.933377e-01 5.674823e-02 1.724946e-02 2.253055e-02 7.437268e-03 
    odegree6     odegree7     odegree8     odegree9    odegree10    odegree11 
2.031187e-03 7.187275e-04 1.249961e-04 6.249805e-05 0.000000e+00 0.000000e+00 
   odegree12    odegree13    odegree14    odegree15 
0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 

> outdeg_tbl/nrow(data)
 [1] 7.184150e-01 2.025562e-01 4.974845e-02 1.493703e-02 6.031062e-03
 [6] 4.218618e-03 7.187275e-04 3.437393e-04 4.999844e-04 9.062217e-04
[11] 6.249805e-05 1.249961e-04 3.749883e-04 6.249805e-05 3.124902e-05
[16] 8.437236e-04 1.249961e-04

> summary(sim ~ idegree(0:15))/sum(summary(sim ~ idegree(0:15)))
    idegree0     idegree1     idegree2     idegree3     idegree4     idegree5 
6.621668e-01 2.397113e-01 6.156058e-02 1.459329e-02 1.493703e-02 4.656104e-03 
    idegree6     idegree7     idegree8     idegree9    idegree10    idegree11 
1.624949e-03 7.187275e-04 3.124902e-05 0.000000e+00 0.000000e+00 0.000000e+00 
   idegree12    idegree13    idegree14    idegree15 
0.000000e+00 0.000000e+00 0.000000e+00 0.000000e+00 

> indeg_tbl/nrow(data)
 [1] 6.766039e-01 2.407425e-01 5.546702e-02 1.368707e-02 5.468579e-03
 [6] 2.874910e-03 1.593700e-03 9.062217e-04 9.062217e-04 6.249805e-05
[11] 1.562451e-04 7.812256e-04 9.374707e-05 4.999844e-04 6.249805e-05
[16] 9.374707e-05

> 
```
         
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
See output in `out/large-net-edges-dist-1thru5-7.RData`.

* Now add some degree terms here. 
Following model didn't converge as per the default convergence metrics, but output may be worth examining:
`out/large-net-edges-dist-indeg0-2-outdeg0-2.RData`
```
 dist.terms <- c(1:5,7) #leave one out 
> 
> fit <- ergm(n0 ~ edges + 
+             dist(dist.terms) +
+             odegree(c(0, 2)) + idegree(c(0,2)),
+             target.stats = c(nedges, 
+                              dist.nedge.distribution[dist.terms],
+                              outdeg_tbl[c(1,3)], indeg_tbl[c(1,3)]),
+             eval.loglik = FALSE,
+             control = control.ergm(MCMLE.maxit = 500)
+             )
Unable to match target stats. Using MCMLE estimation.
Starting maximum likelihood estimation via MCMLE:
Iteration 1 of at most 500:
Optimizing with step length 0.212847367446147.
...
Iteration 500 of at most 500:
Optimizing with step length 0.527544819426537.
The log-likelihood improved by 1.868.
MCMLE estimation did not converge after 500 iterations. The estimated coefficients may not be accurate. Estimation may be resumed by passing the coefficients as initial values; see 'init' under ?control.ergm for details.
This model was fit using MCMC.  To examine model diagnostics and check for degeneracy, use the mcmc.diagnostics() function.
> 
> 
> sim <- simulate(fit)
> sim
 Network attributes:
  vertices = 32001 
  directed = TRUE 
  hyper = FALSE 
  loops = FALSE 
  multiple = FALSE 
  bipartite = FALSE 
  total edges= 15796 
    missing edges= 0 
    non-missing edges= 15796 

 Vertex attribute names: 
    lat lon vertex.names 

 Edge attribute names not shown 
```
* Above model seems to produce reasonable output, even though ERGM did not converge as per default criteria:

```
> load("large-net-edges-dist-indeg0-2-outdeg0-2.RData")
> ls()
 [1] "data"                    "dist.nedge.distribution" "dist.prop.distribution"  "dist.terms"             
 [5] "fit"                     "indeg"                   "indeg_tbl"               "mdeg"                   
 [9] "n0"                      "nedges"                  "outdeg"                  "outdeg_tbl"             
[13] "sim"                    
> sim
 Network attributes:
  vertices = 32001 
  directed = TRUE 
  hyper = FALSE 
  loops = FALSE 
  multiple = FALSE 
  bipartite = FALSE 
  total edges= 15796 
    missing edges= 0 
    non-missing edges= 15796 

 Vertex attribute names: 
    lat lon vertex.names 

 Edge attribute names not shown 


> summary(sim ~ dist(1:7))/(sum(summary(sim ~ dist(1:7))))
     dist1      dist2      dist3      dist4      dist5      dist6      dist7 
0.29450494 0.11971385 0.11971385 0.15003798 0.15351988 0.10268422 0.05982527 
> dist.nedge.distribution
[1] 4704.60 1881.84 1881.84 2352.30 2352.30 1568.20  940.92
> dist.nedge.distribution/sum(dist.nedge.distribution)
[1] 0.30 0.12 0.12 0.15 0.15 0.10 0.06

> outdeg_tbl
 [1] 22990  6482  1592   478   193   135    23    11    16    29     2     4    12     2     1    27     4

> summary(sim ~ odegree(0:10))
 odegree0  odegree1  odegree2  odegree3  odegree4  odegree5  odegree6  odegree7  odegree8  odegree9 
    22565      5776      1764      1316       416       119        36         4         4         1 
odegree10 
        0 

> indeg_tbl
 [1] 21652  7704  1775   438   175    92    51    29    29     2     5    25     3    16     2     3
> summary(sim ~ idegree(0:10))
 idegree0  idegree1  idegree2  idegree3  idegree4  idegree5  idegree6  idegree7  idegree8  idegree9 idegree10 
    21350      7381      1876      1018       293        67        12         3         0         1         0 
 
```

#### To-dos:
* Specify degree 3 in out- and in-degrees in the above model with edges+dist+deg(0,2)
* Think about the strengths and weaknesses of ERGM as opposed to Sasha's APK approach. 
* Think about how these cross-sectional fits can be translated to the type of dynamic model that we are interested in. 

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