library(network)
library(igraph)

load("out/simulate-racemix-plus-dist-plus-negbin-odeg0-3-indeg0-1-orignialdata.RData")

# Grab one network instance
net <- sim_results[[1]]

edges_df <- as.data.frame.network(net, unit = "edges")
verts_df <- as.data.frame.network(net, unit = "vertices")

g <- graph_from_data_frame(edges_df, directed=TRUE, vertices=verts_df)

write_graph(g, "net.graphml", format="graphml")
