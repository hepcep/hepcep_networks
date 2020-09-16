# Agenda and Notes   

## Notes: 09/11/2020
* Turns out Francis's estimation code using the development vesion of ERGM didn't have `outdeg0-3+indeg0-2`. It only had `ideg(0:2)`.   
* For now, we should then use the `racemix-plus-dist-plus-negbin-indeg0-1-outdeg0-3` model.
*  See the ERGM fit at `/project2/khanna7/Projects/midway2/HepCep/hepcep_networks/fit-ergms/out/racemix-plus-dist-plus-negbin-outdeg0-3-indeg0-1.Rout`
and the simulation output from this model at `simulate-racemix-plus-dist-plus-negbin-indeg0-1-outdeg0-3.Rout`.




## To be done: 09/11/2020
* Use the the `outdeg0-3+indeg0-2` model. 
* Aditya and Bryan will synthesize the figures and numerical results from the 100 networks simulated from above
* Aditya to update [Table 5](https://uofi.box.com/s/v12cgpyhaszv6oott247a2bx6ibkblnf) with the above
* Explain the custom ERGM term code line-by-line in the [Appendix](https://uofi.box.com/s/mfaas3rae6bp821d1xwn0yp3jkusnz5j).
* Collect the manuscript text, tables, figures, and Appendices so that the ERGM pieces are complete. 
* Figure collection might be the most tedious part. For the unspecified parameters, maybe color them differently to make it clear that those 
parameters were left out of the ERGM specification?
* **** Very important: resimulate the 100 networks data that Francis has:***
```
load("/project2/khanna7/francis/HepCep/racemix-plus-dist-plus-negbin-indeg0-2.RData")
```
as done [previously](https://bitbucket.org/jozik/hepcep_networks/src/master/fit-ergms/simulate-networks-from-meta-data-ergm-fit.R)
and analyzed [previously](https://bitbucket.org/jozik/hepcep_networks/src/master/fit-ergms/summaries-across-simulated-distributions.R).

This will then give Bryan the necessary starting points to generate the outputs.

## Update: 08/17/2020

* How do we show the target statistics for ERGm terms that are not specified? Look at papers, ask Steve
or Francis, ...
* Bryan will work on visualizations of the in-deg 0-2 model that Francis fit using the `dev` 
ERGM version that he has. See simulated data from this model in:

```
-rw-rw-r-- 1 francislee pi-khanna7 106356262 Aug 2 00:29 sim100networks.indeg02.RData
```
at

```
/project2/khanna7/francis/HepCep
```


## Update: 07/17/2020
* We discussed Table 5, comparing the simulated means and IQRs to the targets. 
IQRs might be too restrictive, and we can use the 2.5th, 97.5th percentile instead.
We can also plot the simulated statistcs as boxplots to display the matching.
Aditya can ask Bryan to help with the figure.

* We can move Table 5 to the Appendix if we plot the data that are presented there. 
Jonathan and Aditya will put together an explanation of the distance term there, and
make the code avaiable in a public repository.

* Visualizing the network might not be necessary. The visualization described above
might be sufficient.

## Update: 06/05/2020
* [Draft](https://docs.google.com/document/d/1T2YGBbAw2meBmqe9HklzXndT1nbxfas17G7yY0ghKZw/edit?usp=sharing) response to Steve
* A `racemix+ideg(0)+odeg(0)+dist()` model converged: See `/project2/khanna7/Projects/midway2/HepCep/hepcep_networks/fit-ergms/out/simulat
e-racemix-plus-negbin-indeg0-outdeg0-only.Rout`
* A `racemix+ideg(0)+odeg(0:3)+dist()` model converged once (a model has to converge twice for statnet default to consider it good), then timed out. I am running it again.
* I haven't had a chance to work on the draft yet, but I will once I am done compiling results from the latest fits.

 
## Update: 05/08/2020
* Follow-up questions and next steps with statnet
* New updates from Mary Ellen:
[data](https://uchicago.box.com/s/e1ne8ychrsklutj9irwd50p785bnpwv8) and 
[explanation](https://uchicago.box.com/s/qt0rl101gfp2w9z00dv9a2j4nmhxjxyo)

## Update: 04/20/2020
* Sent follow-up [questions](https://docs.google.com/document/d/1CycWPgfvj_TIAE5p6uy_l1_5yqGU_opYvqeBKza1WH8/edit?usp=sharing) on simultanelouslys spcifying i- and o-degrees to NMG.

## Meeting: 03/27/2020
* Draft write-up is coming together, Box link shared.
* Let's discuss what is there and next steps
* Coding question  about summarizing aggregate data 

## Meeting: 02/14/2020
* o-degre + dist model converged. i-degree+dist didnt, but try again
* Work on summarizing the results of ERGM fitting and generation for the HepCep meta analysis paper
* Work on preparing a follow-up to NMG with questions on i-degree+o-degree simultaneously


## Meeting: 01/31/2020
* I have had success with getting convergent models with good MCMC diagnostics for dyadic independent models, even including race terms.
* Fitting models with odegree and idegree is still in progress.
* Report on the dyadic indepdent models is at: https://docs.google.com/document/d/1aXZq6LyLMfFhJXM3fmr_8TTLbxC6P6UaT90DHGgEW3A/edit?usp=sharing
* Perhaps it is worth trying to incude the distance terms with the dyadic independent model as I am experimenting with i- and 0-degrees.
* If possible, let us talk about the mechanics of including the distance terms. A quick refresher on the mechanics would be helpful.

### To-do:
* (AK) Simultaneously specifying i- and o-degrees is not working. AK will follow-up with JO by Sunday.
Try specifying only one of those and see how the fit goes.
If that fit (with i- OR o-degree specified) converges, then we can still build a narrative.    
                 
* AK/JO Check if the target stats for distance are available: https://uchicago.box.com/s/w6pkvzhlzbg9b581722ag55oce5wt572

* JO will check on how the custom user terms need to be modified to incorporate the new data.

* JO will speak to PIs about AK's effort and submission to Sunbelt deadline (02/07)

## Meeting: 01/14/2020
Based on feedback from call with NMG:

* The most important step, I think, is to increase the MCMC parameters and see if that helps improve Model 0, and then subsequent models. 
* Fit for Model 0 should be perfect before we move forward.
* Check for any bugs on the race mixing specifications. 
* If indegree+outdegree together still doesn�t work, then that might be worth a subsequent conversation wit h NMG..


## Meeting: 12/18/2019
Discuss the draft [email](https://docs.google.com/document/d/1wAeHIDCO1Ekj7fRlbMNIGbObEmNWVnNusJLPjTE6rmg/edit?usp=sharing) to statnet, and plan needed edits before sending.

## Meeting: 10/04/2019
Model 3:           
`edges +
      idegree(c(deg.terms)) +      
      nodematch("race.num", diff=T)...
      SAN.maxit = 100`,
 where degrees = 1:3, looks OK.
 
 Model 3.5: 
`+       edges +
+       idegree(deg.terms) +
+       odegree(deg.terms) +
+       nodematch("race.num", diff=T),
deg.terms <- 1:3`
looks very bad on the netstats of the simulated network.

Additionally,
Model 4: `edges +
idegree(deg.terms) +
odegree(deg.terms) +
nodematch("race.num", diff=T), deg.terms <- 1:4`
and 
Model 5: 
`       edges +
       idegree(deg.terms) +
       odegree(deg.terms) +
       nodematch("race.num", diff=T)+
       nodemix("gender", base=1)+
       nodemix("young", base=1),
       deg.terms <- 1:4`
were both degenerate.

*** Try Model 3.5 with increased SAN parameters ****


Notes:
1. Possible bug in outdegree specification.       
2. The network parameters are physically incompatible with each other.   
3. The learning (SAN/MCMC) parameters need to be increased (or specified differently).  

To do:
1. The synthesize the model outputs so far.
2. Compose an email back to the statnet listserv.   

                                     
## Meeting: 09/13/2019

We should talk about: (1) Generating synthetic networks; (2) Basmattee's manuscript draft and our response to it.


In response to our model fitting question to the Statnet listserv, we received the following [suggestions](https://docs.google.com/document/d/1wAeHIDCO1Ekj7fRlbMNIGbObEmNWVnNusJLPjTE6rmg/edit?usp=sharing):   
* To add terms one-by-one to diagnose the problems (I was already doing this).
* To use a large number of MCMC iterations (I was already doing this).
* To check the model summaries using `summary(fit...)`
* To generate the MCMC diagnostic plots.
* To use netstats to check each term.   

Based on this feedback, I have [examined](https://docs.google.com/document/d/16NzSIrIDhWZWqqEnRKv2VURSazpDjByG2GePwMJgiIs/edit?usp=sharing) four models, paying attention to the steps we were asked to articulate:    
* Model 0: `edges + nodemix("gender", base=1)+ nodemix("young", base=1)`  
* Model 1: ` Model 1: edges + nodemix("gender", base=1)+ nodemix("young", base=1)+ nodemix("race.num", base=1)`      
* Model 2: `edges + idegree(c(deg.terms)) + nodematch("race.num", diff=T)+ nodeifactor("race")`      
* Model 3: `edges + idegree(c(deg.terms)) + nodematch("race.num", diff=T)`          

I still have to do the `netstats` investigation, but the rest of it is there.   

Assuming the goal is still to produce a synthetic network wtih 32,000 nodes, next, I will explore 

* Model 3-5 (if needed): Add outedges to Model 3 
* Model 4: And at least up to the fourth degree on i- and o-degree  
* Model 5: Add nodemix("gender", base=1) and nodemix("young", base=1) to Model 5 
* Model 6 - Model 3.5 + nodemix("gender", base=1)
* Model 7 - Model 6 + nodemix("young", base=1)

If Model 6 looks OK, we can: (1) add the distance terms to it as well; 
(2) follow-up with the statnet listserv, in terms of sharing the output they asked for and checking if the fit could
be improved by increasing specific ERGM control parameters. 
I will aim to do by the end of next week.


## Meeting: 07/19/2019
* I tried a race `nodematch` term to the          
```
edges+
idegree(1:3)+odegree(1:3)+
nodemix("gender", base=1)+
nodemix("young", base=1)
```
model that seemed to generate a reasonable fit, and which we described in our email to the statnet listserv on 06/14/2019.  
* The model with nodematch added did not work well, details in the [Google doc](https://docs.google.com/document/d/1JBKLihbtemgnyVHN9DpmqCb0NJcOKB5UkdWUAAOnh-I/edit?usp=sharing)  
(Refer to the model with "race.num", since that contains the correct ordering of nodal attributes).      
* I will prepare a summary of notes for Jonathan on the recent statnet listerv conversation between Martina, Carter and Fillipo Santi.       
* Jonathan and I will then review the conversation to see if there are any helpful tips for us to understand our network structure better.      
* We will then implement those tips and/or go back to the statnet list for help.       
       
     
## Meeting: 07/09/2019
* Review email sent to statnet listserv
* Review alternate specification of model fit with `nodeifactor+nodeofactor+nodematch` instead of `nodemix`.

## Meeting: 06/14/2019
* Jonathan and I discussed the progress on ERGM fitting below, and drafted an email to the statnet helplist. 
* Aditya has sent that email.  

## Model fit notes (05/29/2019):
* Following model:
```
edges+
idegree(1:3)+odegree(1:3)+
nodemix("gender", base=1)+
nodemix("young", base=1)
```
does not converge but networks simulated from fit seem [close](https://docs.google.com/document/d/1JBKLihbtemgnyVHN9DpmqCb0NJcOKB5UkdWUAAOnh-I/edit?usp=sharing).

* Adding all four race mixing terms to this model using `nodemix` produces a degenerate model. 
Recommended solution is to increase san parameters. A ten-fold increase in `SAN.maxit=100, SAN.burnin.times=100`
 did not help.

* Model with full race mixing specified does work when i- and o-degree terms are left out.

* Next step is to try specifying other configurations for race mixing when i- and o-degrees are included.

* If that doesn't work, email `statnet` listserv. 
   
## May 9, 2019:
* Use distribution data from demogr.xlsx to assign groups.
* Pages 1 and 2 contain the % of in-edges and pages 3-4 contain the % of out-edges which can be multiplied by n (total number of agents) to get indegree and outdegree. 
* We can sum the number of in and out-degrees to get the total number of in and out edges.   

To do:
* I will set up the starting networks based on the demographic data, and compute the numebr of target in and out edges, and check if they are close.
* Jonathan will email the group about target number of edges for the cells in each of the mixing matrices.

## April 26, 2019:
* Synthesize recent conversations with the broader HepCep team and discuss next coding steps. 
* From file, "demog_prop_est" sasign groups 1 - 32 with %s.
* Use "distributions" Excel file from the first three tabs to fit ERGM.
To do later:    
* Zipcode distributions
* In the "zipcount" file, create demographic group IDs with proportion.
* Ignore zipcat = 0

## Feb 1 and Feb 15, 2019:       
* No meeting (waiting for response from UIC team)    

## January 18, 2019:   
* Emailed the HepCep group (Basmattee, Anna, Mary Ellen) regarding next steps:
```


On 1/18/19, 12:37 PM, "Ozik, Jonathan" <jozik@anl.gov> wrote:

    Hi all,
    
    I wanted to check back in on our joint meta-analysis and ERGM paper work. Have you been able to look further into or compile the relevant data? Please let us know if we should set up a follow up call or if you need any information from our end.
    
    Jonathan
```

## December 07, 2018 (non-meeting notes)
* Debrief regarding calls with Basmattee (11/09 and 12/06).
* Tabled about potential terms we may need for HeCep, nodefactor may work, or an "interaction" nodefactor as per Jenness et al, line 75 [here](https://github.com/EpiModel/PrEPGuidelines/blob/master/scripts/estimation/02.estim.R).

## November 12, 2018 (non-meeting notes)
* Removing `keep` argument in `nodemix` (as per to-do from November 9) still gives a convergent model.
```
> # Fit ERGM with mixing targets derived above ---------------------------
> 
> fit.mixing <- ergm(n0 ~ edges + 
+               dist(dist.terms)+
+               nodemix("race", base=c(1))+
+               nodematch("gender", diff=TRUE)+ 
+               nodematch("chicago", diff=TRUE)+
+               odegree(c(0,2,3))+ 
+               idegree(c(0,2,3)),
+               target.stats = c(
+                   nedges_mean, 
+                   dist.nedge.distribution[dist.terms],
+                   race_mm_mat_mean[c(2:16)],
+                   gender_mm_mat_mean[c(1,4)],
+                   chicago_mm_mat_mean[c(1,4)],
+                   outdeg_tbl[c(1,3,4)], 
+                   indeg_tbl[c(1,3,4)]
+                   ),
+             eval.loglik = FALSE,
+             control = control.ergm(MCMLE.maxit = 200)
+ )
Unable to match target stats. Using MCMLE estimation.
Starting maximum likelihood estimation via MCMLE:
Iteration 1 of at most 200:
Optimizing with step length 0.130963704709344.
The log-likelihood improved by 3.128.
...
Iteration 200 of at most 200:
Optimizing with step length 0.0366082455954375.
The log-likelihood improved by 1.638.
MCMLE estimation did not converge after 200 iterations. The estimated coefficients may not be accurate. Estimation may be resumed by passing the coefficients as initial values; see 'init' under ?control.ergm for details.
This model was fit using MCMC.  To examine model diagnostics and check for degeneracy, use the mcmc.diagnostics() function.
> 
> # Simualte ERGM from above with mixing targets derived above ---------------------------
> 
> sim <- simulate(fit.mixing)
> sim
 Network attributes:
  vertices = 32001 
  directed = TRUE 
  hyper = FALSE 
  loops = FALSE 
  multiple = FALSE 
  bipartite = FALSE 
  total edges= 16333 
    missing edges= 0 
    non-missing edges= 16333 

 Vertex attribute names: 
    age age_started azi chicago daily_injection_intensity fraction_recept_sharing gender hcv lat lon num_buddies race syringe_source vertex.names zip zz 

 Edge attribute names not shown 
> 
> # Compare statistics ---------------------------
> 
> network.edgecount(sim); nedges_mean
[1] 16333
[1] 15833.67
> summary(sim ~ dist(1:7)); dist_mat_mean
dist1 dist2 dist3 dist4 dist5 dist6 dist7 
 4663  1881  1932  2498  2529  1835   995 
[1] 4519.19 1807.88 1919.56 2517.60 2460.31 1628.49  980.64
> mixingmatrix(sim, "race")
       To
From       1    2    3   4 Total
  1     1487  826 1920 126  4359
  2      795 1567 1628  86  4076
  3     1802 1429 3975 227  7433
  4      122   98  227  18   465
  Total 4206 3920 7750 457 16333
> 
> # Save data ---------------------------
> 
> save.image("large-net-dist-term-mixing.RData")
> 
> proc.time()
    user   system  elapsed 
7554.853   36.120 7598.442 
```

## November 9, 2018 
* Talk through the modeling exercise and notes below.   
*To do:*
* Why is there s `keep` argument in `nodemix`? Try removing it?

## November 2, 2018 (non-meeting notes)
* Adding race mixing terms seem to produce reasonable results (see below)        
* When i tried to run the ERGM fit to 500 iterations, the model hung at 212, twice. That was weird.

```

> 
> # Load data ---------------------------
> 
> load("simulate-convergence-setup.RData")
> 
> 
> # Fit ERGM with mixing targets derived above ---------------------------
> 
> fit.mixing <- ergm(n0 ~ edges + 
+               dist(dist.terms)+
+               nodemix("race", base=c(1))+
+               nodematch("gender", diff=TRUE, keep=c(1,4))+ 
+               nodematch("chicago", diff=TRUE, keep=c(1,4))+
+               odegree(c(0,2,3))+ 
+               idegree(c(0,2,3)),
+               target.stats = c(
+                   nedges_mean, 
+                   dist.nedge.distribution[dist.terms],
+                   race_mm_mat_mean[c(2:16)],
+                   gender_mm_mat_mean[c(1,4)],
+                   chicago_mm_mat_mean[c(1,4)],
+                   outdeg_tbl[c(1,3,4)], 
+                   indeg_tbl[c(1,3,4)]
+                   ),
+             eval.loglik = FALSE,
+             control = control.ergm(MCMLE.maxit = 200)
+ )
Unable to match target stats. Using MCMLE estimation.
Starting maximum likelihood estimation via MCMLE:
Iteration 1 of at most 200:
Optimizing with step length 0.112684084557912.
The log-likelihood improved by 2.725.
Iteration 2 of at most 200:
...
Iteration 198 of at most 200:
Optimizing with step length 0.0793548444627166.
The log-likelihood improved by 1.513.
Iteration 199 of at most 200:
Optimizing with step length 0.0695780145887017.
The log-likelihood improved by 2.021.
Iteration 200 of at most 200:
Optimizing with step length 0.0339390788183932.
The log-likelihood improved by 1.611.
MCMLE estimation did not converge after 200 iterations. The estimated coefficients may not be accurate. Estimation may be resumed by passing the coefficients as initial values; see 'init' under ?control.ergm for details.
This model was fit using MCMC.  To examine model diagnostics and check for degeneracy, use the mcmc.diagnostics() function.
> 
> # Simualte ERGM from above with mixing targets derived above ---------------------------
> 
> sim <- simulate(fit.mixing)
> sim
 Network attributes:
  vertices = 32001 
  directed = TRUE 
  hyper = FALSE 
  loops = FALSE 
  multiple = FALSE 
  bipartite = FALSE 
  total edges= 16276 
    missing edges= 0 
    non-missing edges= 16276 

 Vertex attribute names: 
    age age_started azi chicago daily_injection_intensity fraction_recept_sharing gender hcv lat lon num_buddies race syringe_source vertex.names zip zz 

 Edge attribute names not shown 
 > # Compare statistics ---------------------------
> 
> network.edgecount(sim); nedges_mean
[1] 16276
[1] 15833.67
> summary(sim ~ dist(1:7)); dist_mat_mean
dist1 dist2 dist3 dist4 dist5 dist6 dist7 
 4626  1828  1967  2509  2468  1871  1007 
[1] 4519.19 1807.88 1919.56 2517.60 2460.31 1628.49  980.64
> mixingmatrix(sim, "race")
       To
From       1    2    3   4 Total
  1     1452  780 1898 123  4253
  2      842 1590 1609 101  4142
  3     1761 1423 4031 225  7440
  4       97   88  229  27   441
  Total 4152 3881 7767 476 16276

# target race mixing (fills above matrix by column)
> race_mm_mat_mean
 [1] 1496.09  841.32 1728.88  112.23  824.42 1560.46
 [7] 1399.37   98.13 1866.76 1539.03 3694.66  215.42
[13]  125.12   98.84  209.98   22.96

...

> # Save data ---------------------------
> 
> save.image("large-net-dist-term-mixing.RData")
> 
> proc.time()
    user   system  elapsed 
9369.545   38.992 9419.191 

```

## October 19, 2018 (non-meeting update)
* Set up for testing convergence of models with target statistics estimated from 100 networks, including coding for 
race, gender, Chicago residence is [here](https://bitbucket.org/jozik/hepcep_networks/src/master/fit-ergms/simulate-convergence-setup.R).    

* We did this exercise because we don't have reliable estimates of mixing by race, gender or Chicago residence.   
   
* Convergence of model fit with edges, distance, odegree, idegree, chicago-mixing, gender-mixing below. Add race in next 
(I was getting some form of specification error in that.)        

```     
> rm(list=ls())
> 
> # Libraries ---------------------------
> 
> library(network)
network: Classes for Relational Data
Version 1.13.0.1 created on 2015-08-31.
copyright (c) 2005, Carter T. Butts, University of California-Irvine
                    Mark S. Handcock, University of California -- Los Angeles
                    David R. Hunter, Penn State University
                    Martina Morris, University of Washington
                    Skye Bender-deMoll, University of Washington
 For citation information, type citation("network").
 Type help("network-package") to get started.

> library(ergm)
Loading required package: statnet.common

Attaching package: 'statnet.common'

The following object is masked from 'package:base':

    order


ergm: version 3.8.0, created on 2017-08-18
Copyright (c) 2017, Mark S. Handcock, University of California -- Los Angeles
                    David R. Hunter, Penn State University
                    Carter T. Butts, University of California -- Irvine
                    Steven M. Goodreau, University of Washington
                    Pavel N. Krivitsky, University of Wollongong
                    Martina Morris, University of Washington
                    with contributions from
                    Li Wang
                    Kirk Li, University of Washington
                    Skye Bender-deMoll, University of Washington
Based on "statnet" project software (statnet.org).
For license and citation information see statnet.org/attribution
or type citation("ergm").

NOTE: Versions before 3.6.1 had a bug in the implementation of the bd()
constriant which distorted the sampled distribution somewhat. In
addition, Sampson's Monks datasets had mislabeled vertices. See the
NEWS and the documentation for more details.


Attaching package: 'ergm'

The following objects are masked from 'package:statnet.common':

    colMeans.mcmc.list, sweep.mcmc.list

> library(dplyr)

Attaching package: 'dplyr'

The following objects are masked from 'package:stats':

    filter, lag

The following objects are masked from 'package:base':

    intersect, setdiff, setequal, union

> library(ergm.userterms)

ergm.userterms: version 3.1.1, created on 2013-04-26
Copyright (c) 2013, Mark S. Handcock, University of California -- Los Angeles
                    David R. Hunter, Penn State University
                    Carter T. Butts, University of California -- Irvine
                    Steven M. Goodreau, University of Washington
                    Pavel N. Krivitsky, University of Wollongong
                    Martina Morris, University of Washington
Based on "statnet" project software (statnet.org).
For license and citation information see statnet.org/attribution
or type citation("ergm.userterms").

NOTE: If you use custom ERGM terms based on 'ergm.userterms' version
prior to 3.1, you will need to perform a one-time update of the package
boilerplate files (the files that you did not write or modify) from
'ergm.userterms' 3.1 or later. See help('eut-upgrade') for
instructions.

Warning messages:
1: replacing previous import 'statnet.common::colMeans.mcmc.list' by 'ergm::colMeans.mcmc.list' when loading 'ergm.userterms' 
2: replacing previous import 'statnet.common::sweep.mcmc.list' by 'ergm::sweep.mcmc.list' when loading 'ergm.userterms' 
> 
> 
> # Load data ---------------------------
> 
> load("simulate-convergence-setup.RData")
> 
> 
> # Fit ERGM with mixing targets derived above ---------------------------
> 
> fit.mixing <- ergm(n0 ~ edges + 
+               dist(dist.terms) +
+               #nodematch("race", diff=TRUE, keep=c(1,3,6,10))+
+               nodematch("gender", diff=TRUE, keep=c(1,4))+ 
+               nodematch("chicago", diff=TRUE, keep=c(1,4))+
+               odegree(c(0,2,3))+ 
+               idegree(c(0,2,3)),
+               target.stats = c(
+                   nedges_mean, 
+                   dist.nedge.distribution[dist.terms],
+                   #race_mm_mat_mean[c(1,3,6,10)],
+                   gender_mm_mat_mean[c(1,4)],
+                   chicago_mm_mat_mean[c(1,4)],
+                   outdeg_tbl[c(1,3,4)], 
+                   indeg_tbl[c(1,3,4)]
+                   ),
+             eval.loglik = FALSE,
+             control = control.ergm(MCMLE.maxit = 500)
+ )
Unable to match target stats. Using MCMLE estimation.
Starting maximum likelihood estimation via MCMLE:
Iteration 1 of at most 500:
Optimizing with step length 0.192489573511744.
The log-likelihood improved by 6.734.
Iteration 2 of at most 500:
Optimizing with step length 0.240416658815067.
The log-likelihood improved by 1.56.
Iteration 3 of at most 500:
...
The log-likelihood improved by 1.577.
Iteration 499 of at most 500:
Optimizing with step length 0.151438045602504.
The log-likelihood improved by 1.558.
Iteration 500 of at most 500:
Optimizing with step length 0.117474149225453.
The log-likelihood improved by 1.945.
MCMLE estimation did not converge after 500 iterations. The estimated coefficients may not be accurate. Estimation may be resumed by passing the coefficients as initial values; see 'init' under ?control.ergm for details.
This model was fit using MCMC.  To examine model diagnostics and check for degeneracy, use the mcmc.diagnostics() function.
> 
> # Simualte ERGM from above with mixing targets derived above ---------------------------
> 
> sim <- simulate(fit.mixing)
> sim
 Network attributes:
  vertices = 32001 
  directed = TRUE 
  hyper = FALSE 
  loops = FALSE 
  multiple = FALSE 
  bipartite = FALSE 
  total edges= 16272 
    missing edges= 0 
    non-missing edges= 16272 

 Vertex attribute names: 
    age age_started azi chicago daily_injection_intensity fraction_recept_sharing gender hcv lat lon num_buddies race syringe_source vertex.names zip zz 

 Edge attribute names not shown 
> 
> # Compare statistics ---------------------------
> 
> network.edgecount(sim); nedges_mean
[1] 16272
[1] 15833.67
> summary(sim ~ dist(1:7)); dist_mat_mean
dist1 dist2 dist3 dist4 dist5 dist6 dist7 
 4615  1831  1959  2455  2535  1866  1011 
[1] 4519.19 1807.88 1919.56 2517.60 2460.31 1628.49  980.64
> 
> # Save data ---------------------------
> 
> save.image("large-net-dist-term-mixing.RData")
> 
> proc.time()
    user   system  elapsed 
6775.931   48.892 6830.738      
        
```        



## October 12, 2018
* I am sorry I haven't had a chance to make much progress on these tasks given everything that has been going on with BARS and other things. 
* I am working on it now. I'll have some questions for you today, and then complete the task list from last time over next week. 
* I will send an update by email while you are away.

To-do:
* Recode Zip in data as `chicago=1, else=0` if first three digits of Zip are 606.
* Consider race mixing, gender mixing and chicago mixing as test cases for convergence with mixing parameters
* Complete to-dos from September 14.

## September 14, 2018
* Think about the strengths and weaknesses of ERGM as opposed to Sasha's APK approach (in terms of using ERGM to predict the exact links that are represented in the data)
* Think about how these cross-sectional fits can be translated to the type of dynamic model that we are interested in. 
* Verified Steve G's recommendation on flipping order of `dist` terms to see if one that gets the NA switches. See [here](https://bitbucket.org/jozik/hepcep_networks/src/master/fit-ergms/jozik-network-test.R).

**To do:**   

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