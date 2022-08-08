# Simulate network (n=32K) from ERGM fit
# parameterized with meta data


rm(list=ls())


# Libraries ----------

library(network)
library(ergm)



# Data ----------

load("../../fit-ergms/out/racemix-plus-dist-plus-negbin-odeg0-3-indeg0-1-orignialdata.RData")


# Model summary
summary(fit.metadata.mixing)


# MCMC diagnostics
pdf(file="out/new-synthpop.pdf")
mcmc.diagnostics(fit.metadata.mixing)
dev.off()
