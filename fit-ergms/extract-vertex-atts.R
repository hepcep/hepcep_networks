# Extract vertex attributes from simulated network 

rm(list=ls())

# Libraries ----------

library(network)

# Load data ----------

load("out/simulate-racemix-plus-dist-plus-negbin-indeg0-2-orignialdata.RData")
data <- read.csv("/project2/ahotton/khanna7/HepCep/data/pwids_with_lat_lon_original_zips.csv", header = T) #updated on july 3 2021

# Check network list ---------

class(sim_results); length(sim_results)
net1 <- sim_results[[1]]
net1


# Extract the first vertex attribute list from all networks ---------

vertex.att.list <- list.vertex.attributes(net1)
get.vertex.attribute(net1, vertex.att.list[1])
vertex.att.1 <- 
  lapply(sim_results, 
       function(x) get.vertex.attribute(x, vertex.att.list[1])
)
class(vertex.att.1); length(vertex.att.1)
vertex.att.1[1]


# Extract all vertex attribute lists from all networks ---------

vertex.att.all <- vector(mode = "list", length = length(sim_results))  

for(j in 1:length(sim_results)){
  for (i in 1:length(vertex.att.all)){
    vertex.att.all[[j]][[i]] <- get.vertex.attribute(sim_results[[j]],
                                                   vertex.att.list[i]
                                                   )
  }
}

lapply(vertex.att.all, function(x)
  names(x) <- vertex.att.list
)

# Compare agent ordering above to network object ---------

#data <- data[-32001,] #the dataset consists of 32001 agents but the networks only contain 32K nodes
#dim(data)

identical(sim_results[[1]] %v% "lat", data$lat)
identical(sim_results[[1]] %v% "lon", data$lon)
## ordering between the data set and the network matches


# Extract vertex names and add to pwid_with_lat_lon.csv datset ---------

vertex.names <- sim_results[[1]] %v% "vertex.names" 
pwid_w_vertex_names <- cbind(vertex.names,
                             data)

# Save data

saveRDS(vertex.att.all, file = "out/vertex_att_all_oct72021.RDS")
saveRDS(pwid_w_vertex_names, file="out/pwid_w_vertex_names_oct72021.RDS")
