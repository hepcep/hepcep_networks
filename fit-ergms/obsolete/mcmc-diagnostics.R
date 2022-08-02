# Simulate network (n=32K) from ERGM fit 
# parameterized with meta data  


rm(list=ls())


# Libraries ----------

library(network)
library(ergm)
library(dplyr)
library(ergm.userterms)


# Data ----------

#load("out/model1-increase-MCMC-params.RData") # model 1a
#load("out/model6-w-racenodemix-outdeg0-3only-increase-MCMC-params.RData") #model 1b
#load("out/model6-w-racenodemix-ideg0-3only-increase-MCMC-params.RData")
#load("out/racemix-plus-dist-2.RData") #model 2a
load("out/racemix-plus-dist-plus-odeg.RData") #model 2b

# Model summary
summary(fit.metadata.mixing)


# MCMC diagnostics
#jpeg(file="out/model1-mcmc-diags.jpg") #naming convention as per email to statnet on 04/20
mcmc.diagnostics(fit.metadata.mixing)
#dev.off()


