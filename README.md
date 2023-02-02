# README #

## Setting up environment 
- Brown's Oscar is used as an example
- Instructions are general purpose Linux

### Clone from Bitbucket

```bash
git clone [git@bitbucket.org](mailto:git@bitbucket.org):jozik/hepcep_networks.git
```

### Load and launch R

```bash
module load R/3.6.0
R
cd hepcep_networks
```

<aside>
💡 3.6.0 is the closest version of R that Oscar has to what I was running on Midway 2 (3.6.1)

</aside>

### Restore the environment

First ensure that the `.libPaths()` are set to the project's own library:

In R,

```bash
library(packrat)
> library(packrat)
> .libPaths() # TEST - this is not the project-specific library
[1] "/gpfs/home/akhann16/R/x86_64-pc-linux-gnu-library/3.6"
[2] "/gpfs/rt/7.2/opt/R/3.6.0/lib64/R/library"             
> packrat::init() # CHANGE to the project-specific library
Initializing packrat project in directory:
- "/gpfs/home/akhann16/code/hepcep_networks"
Initialization complete!
Packrat mode on. Using library in directory:
- "/gpfs/home/akhann16/code/hepcep_networks/packrat/lib"
> .libPaths()
[1] "/gpfs/home/akhann16/code/hepcep_networks/packrat/lib/x86_64-pc-linux-gnu/3.6.0"    
[2] "/gpfs/home/akhann16/code/hepcep_networks/packrat/lib-ext/x86_64-pc-linux-gnu/3.6.0"
[3] "/gpfs/home/akhann16/code/hepcep_networks/packrat/lib-R/x86_64-pc-linux-gnu/3.6.0"  
>
```


Then, restore the packages with

```bash
packrat::restore() 
```

### Test if needed packages are loading

```bash
> library(ergm)
Loading required package: network
network: Classes for Relational Data
Version 1.16.0 created on 2019-11-30.
copyright (c) 2005, Carter T. Butts, University of California-Irvine
                    Mark S. Handcock, University of California -- Los Angeles
                    David R. Hunter, Penn State University
                    Martina Morris, University of Washington
                    Skye Bender-deMoll, University of Washington
 For citation information, type citation("network").
 Type help("network-package") to get started.

ergm: version 3.10.4, created on 2019-06-10
Copyright (c) 2019, Mark S. Handcock, University of California -- Los Angeles
                    David R. Hunter, Penn State University
                    Carter T. Butts, University of California -- Irvine
                    Steven M. Goodreau, University of Washington
                    Pavel N. Krivitsky, University of Wollongong
                    Martina Morris, University of Washington
                    with contributions from
                    Li Wang
                    Kirk Li, University of Washington
                    Skye Bender-deMoll, University of Washington
                    Chad Klumb
Based on "statnet" project software (statnet.org).
For license and citation information see statnet.org/attribution
or type citation("ergm").

NOTE: Versions before 3.6.1 had a bug in the implementation of the bd()
constriant which distorted the sampled distribution somewhat. In
addition, Sampson's Monks datasets had mislabeled vertices. See the
NEWS and the documentation for more details.

NOTE: Some common term arguments pertaining to vertex attribute and
level selection have changed in 3.10.0. See terms help for more
details. Use ‘options(ergm.term=list(version="3.9.4"))’ to use old
behavior.

> library(network)
```

### Install jozik’s `ergm.userterms` package

From within R,

```bash
install.packages("/gpfs/home/akhann16/code/hepcep_networks/ergm.userterms", type="source", repos=NULL)
```

Test if the correct `ergm.userterms` is loaded:

```bash
> library(ergm.userterms)
Loading required package: statnet.common

Attaching package: ‘statnet.common’

The following object is masked from ‘package:base’:

    order

ergm.userterms: version 3.1.1, created on 2020-02-01
Copyright (c) 2020, Jonathan Ozik
                    Mark S. Handcock, University of California -- Los Angeles
                    David R. Hunter, Penn State University
                    Carter T. Butts, University of California -- Irvine
                    Steven M. Goodreau, University of Washington
                    Pavel N. Krivitsky, University of Wollongong
                    Martina Morris, University of Washington
Based on "statnet" project software (statnet.org).
For license and citation information see statnet.org/attribution
or type citation("ergm.userterms").

NOTE: If you use custom ERGM terms based on ‘ergm.userterms’ version
prior to 3.1, you will need to perform a one-time update of the package
boilerplate files (the files that you did not write or modify) from
‘ergm.userterms’ 3.1 or later. See help('eut-upgrade') for
instructions.
```

Test a simple example using jozik’s ergm.userterms:

```bash
>         nw.size <- 10000
>         m = matrix(c(rep(1,nw.size-1),2:nw.size), byrow = FALSE, ncol = 2)
>         ggg <- as.network(m, matrix.type='edgelist',directed = F)
>         ggg %v% "lat" <- seq(41.9,41.3,length.out = nw.size)
>         ggg %v% "lon" <- rep(-87.6964695120882,times = nw.size)
>         summary(ggg ~ dist(1:7))    
dist1 dist2 dist3 dist4 dist5 dist6 dist7 
   30   211  4613  5145     0     0     0
```

## Doing the ERGM analysis
   - Go to file [fit-ergms/ergm-estimation-with-meta-data.R](https://bitbucket.org/jozik/hepcep_networks/src/master/fit-ergms/ergm-estimation-with-meta-data.R):
      * All data inputs are in [`data`](https://bitbucket.org/jozik/hepcep_networks/src/master/data/)
      * If needed, the `meta-mixing-init-net.RData` file can be generated by running 
        [fit-ergms/generate-starting-network-meta-data.R](https://bitbucket.org/jozik/hepcep_networks/src/master/fit-ergms/generate-starting-network-meta-data.R)
      * Update lat/lon data as needed (see section `Read lat/lon data ------------------------------ `)


