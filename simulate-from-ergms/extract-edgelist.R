
load("./out/simulate-on-oscar-racemix-plus-dist-plus-negbin-odeg0-3-indeg0-1-orignialdata.RData")
library(network)

class(sim_results[[1]])
list.vertex.attributes(sim_results[[1]])
el <- as.edgelist(sim_results[[1]])
dim(el)
