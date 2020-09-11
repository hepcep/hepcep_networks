# Generate multi-variable boxplots for Hep-cep | B.Brickman 08/11/20
rm(list=ls())

## Choose Output Directory
output_dir <- "~/Desktop"

# Libraries ----------
library(network)
library(ergm)
library(ergm.userterms)
library(ggplot2)
library(reshape) #for melt function (not used here, but useful later)
library(cowplot) #for plot_grid layout function
library(RColorBrewer)


# Load in Data ----------
load("/home/bryan/Desktop/sim100networks.indeg02.RData")



# Load in terms ---------
nsim.vec <- 1:100
sim.race.num <- lapply(nsim.vec, function (x) summary(sim100networks.indeg02[[x]] ~ nodemix("race.num")))### CRASHES EVERY TIME
sim.gender   <- lapply(nsim.vec, function (x) summary(sim100networks.indeg02[[x]] ~ nodemix("gender")))#NO CRASH
sim.young    <- lapply(nsim.vec, function (x) summary(sim100networks.indeg02[[x]] ~ nodemix("young")))#NOCRASH
sim.dist     <- lapply(nsim.vec, function (x) summary(sim100networks.indeg02[[x]] ~ dist(1:4)))#NO CRASH

################################################################################

##Gender
#create dataframes
o0 = data.frame(sex="ff", count=unlist(lapply(sim.gender, function (x) x["mix.gender.female.female"])))
o1 = data.frame(sex="fm", count=unlist(lapply(sim.gender, function (x) x["mix.gender.female.male"])))
o2 = data.frame(sex="mf", count=unlist(lapply(sim.gender, function (x) x["mix.gender.male.female"])))
o3 = data.frame(sex="mm", count=unlist(lapply(sim.gender, function (x) x["mix.gender.male.male"])))
#o4 = data.frame(outdegree="4", count=lapply(sim.gender, function (x) x["mix.gender.female.female"])), probs = c(2.5/100, 97.5/100))
full = rbind(o0,o1,o2,o3)
#Shorthand dataframes, bind combination plot data
zero.data = o0
one.data = o1
two.data = o2
three.data = o3
#four.data = o4
#full.data = rbind(o0,o1,o2,o3,o4)
#initialize boxplots
zero_plot <- ggplot(zero.data, aes(x=sex, y=count, fill=sex))
one_plot <- ggplot(one.data, aes(x=sex, y=count, fill=sex))
two_plot <- ggplot(two.data, aes(x=sex, y=count, fill=sex))
three_plot <- ggplot(three.data, aes(x=sex, y=count, fill=sex))
#four_plot <- ggplot(four.data, aes(x=outdegree, y=count, fill=outdegree))

#two_three_four_plot <- ggplot(two_three_four.data, aes(x=outdegree, y=count, fill=outdegree))
#full_plot <- ggplot(full.data, aes(x=outdegree, y=count, fill=outdegree))
#manage target data
targets <- c(20300,5500,2400,2000, 1400)
targets.df <- data.frame(outdegree=c("0","1","2","3","4"),y=targets)
#final boxplot adjustments
o <- zero_plot + geom_violin() + #geom_jitter(alpha=0.2) +
  #geom_point(x="0",y=300,color="green") +
  #coord_cartesian(ylim=c(20100,20550)) +
  #scale_y_continuous(breaks=seq(20100, 20550,100)) +
  geom_hline(yintercept=c(2699))  
#geom_jitter(alpha=0.12)

#geom_segment(data = targets.df, color="red", aes(outdegree = as.numeric(outdegree[1]) - 1, #The left side segment adjustment doesn't work with this numbering 
#                                              y = y,
#                                             xend = as.numeric(outdegree) + 0.5,
#                                            yend = y))
a <- one_plot + geom_violin() + geom_hline(yintercept=c(7487)) 
#geom_jitter(alpha=0.12)
b <- two_plot + geom_violin() + geom_hline(yintercept=c(6784)) 
#geom_jitter(alpha=0.12)
c <- three_plot + geom_violin() + geom_hline(yintercept=c(7674))  
#geom_jitter(alpha=0.12)
#d <- four_final <- four_plot + geom_violin() + geom_hline(yintercept=c(838)) 
#geom_jitter(alpha=0.12) 

#full_final <- full_plot + geom_boxplot() + 
#  scale_x_discrete(breaks=c("outdeg0","outdeg1","outdeg2","outdeg3","outdeg4"),
#labels=c("0","1","2","3","4"))
#color palette
pal  <- scale_fill_brewer(palette="Dark2")
#no legend
nl   <- theme(legend.position = "none") 
#no x/y labels
no_y <- theme(axis.title.y = element_blank())
no_x <- theme(axis.title.x = element_blank())

#output framed plot
plot_grid(o + pal + theme_bw() +nl + no_x,
          a + pal + theme_bw() +nl + no_y + no_x,
          b + pal + theme_bw() +nl,
          c + pal + theme_bw() +nl + no_y,
          #    d + pal + theme_bw()+nl,
          ncol = 2)
o + pal + theme_bw() +nl + no_x
a + pal + theme_bw() +nl + no_y + no_x
b + pal + theme_bw() +nl
c + pal + theme_bw() +nl + no_y
################################################################################

##Age
##This numbering disagrees with the manuscript-- middle two are old-young THEN young-old in this code
i0 = data.frame(indegree="0.0", count=unlist(lapply(sim.young, function (x) x["mix.young.0.0"])), probs = c(2.5/100, 97.5/100))
i1 = data.frame(indegree="1.0", count=unlist(lapply(sim.young, function (x) x["mix.young.1.0"])), probs = c(2.5/100, 97.5/100))
i2 = data.frame(indegree="0.1", count=unlist(lapply(sim.young, function (x) x["mix.young.0.1"])), probs = c(2.5/100, 97.5/100))
i3 = data.frame(indegree="1.1", count=unlist(lapply(sim.young, function (x) x["mix.young.1.1"])), probs = c(2.5/100, 97.5/100))
#i4 = data.frame(indegree="4", count=indeg4)
full_indeg = rbind(i0,i1,i2,i3)
#Shorthand dataframes, bind combination plot data
izero.data = i0
ione.data = i1
itwo.data = i2
ithree.data = i3
#ifour.data = i4
ifull.data = rbind(i0,i1,i2,i3)
#initialize boxplots
izero_plot <- ggplot(izero.data, aes(x=indegree, y=count, fill=indegree))
ione_plot <- ggplot(ione.data, aes(x=indegree, y=count, fill=indegree))
itwo_plot <- ggplot(itwo.data, aes(x=indegree, y=count, fill=indegree))
ithree_plot <- ggplot(ithree.data, aes(x=indegree, y=count, fill=indegree))
#ifour_plot <- ggplot(ifour.data, aes(x=indegree, y=count, fill=indegree))
#two_three_four_plot <- ggplot(two_three_four.data, aes(x=outdegree, y=count, fill=outdegree))
ifull_plot <- ggplot(ifull.data, aes(x=indegree, y=count, fill=indegree))

#final boxplot adjustments
io <- zero_final <- izero_plot + geom_violin() + geom_hline(yintercept=c(18992))
#geom_jitter(alpha=0.2) +
ia <- one_final <- ione_plot + geom_violin() + geom_hline(yintercept=c(1008)) 
#geom_jitter(alpha=0.12)
ib <- two_final <- itwo_plot + geom_violin() + geom_hline(yintercept=c(3170)) 
#geom_jitter(alpha=0.12)
ic <- three_final <- ithree_plot + geom_violin() + geom_hline(yintercept=c(1474))  
#geom_jitter(alpha=0.12)
#id <- four_final <- ifour_plot + geom_violin() + geom_hline(yintercept=c(617)) 
#geom_jitter(alpha=0.12) 
i_f <- ifull_plot + geom_boxplot()

#Generating Plots
#color palette
pal <- scale_fill_brewer(palette="Dark2")
#indegree framed plot
plot_grid(io + pal + theme_bw()+nl+no_x,
          ia + pal + theme_bw()+nl+no_x+no_y,
          ib + pal + theme_bw()+nl,
          ic + pal + theme_bw()+nl+no_y,
          i_f + pal + theme_bw()+nl,
          ncol = 2)

io
ia
ib
ic
i_f
################################################################################
##Distance
d1 = data.frame(distance="0.0", count=unlist(lapply(sim.dist, function (x) x["dist1"])), probs = c(2.5/100, 97.5/100))
d2 = data.frame(distance="0.0", count=unlist(lapply(sim.dist, function (x) x["dist2"])), probs = c(2.5/100, 97.5/100))
d3 = data.frame(distance="0.0", count=unlist(lapply(sim.dist, function (x) x["dist3"])), probs = c(2.5/100, 97.5/100))
d4 = data.frame(distance="0.0", count=unlist(lapply(sim.dist, function (x) x["dist4"])), probs = c(2.5/100, 97.5/100))
full_distance = rbind(i0,i1,i2,i3)


d1_plot <- ggplot(izero.data, aes(x=distance, y=count, fill=indegree))
d2_plot <- ggplot(ione.data, aes(x=distance, y=count, fill=indegree))
d3_plot <- ggplot(itwo.data, aes(x=distance, y=count, fill=indegree))
d4_plot <- ggplot(ithree.data, aes(x=distance, y=count, fill=indegree))
dfull_plot <- ggplot(full_distance, aes(x=distance, y=count, fill=indegree)) + cgeom_boxplot()

#final boxplot adjustments
d1f <- d1_plot + geom_violin() + geom_hline(yintercept=c(18992))
#geom_jitter(alpha=0.2) +
d2f <- d2_plot + geom_violin() + geom_hline(yintercept=c(1008)) 
#geom_jitter(alpha=0.12)
d3f <- d3_plot + geom_violin() + geom_hline(yintercept=c(3170)) 
#geom_jitter(alpha=0.12)
d4f <- d4_plot + geom_violin() + geom_hline(yintercept=c(1474))  

##Generating Plots
#color palette
pal <- scale_fill_brewer(palette="Dark2")
#indegree framed plot
plot_grid(d1f + pal + theme_bw()+nl+no_x,
          d2f + pal + theme_bw()+nl+no_x+no_y,
          d3f + pal + theme_bw()+nl,
          d4f + pal + theme_bw()+nl+no_y,
          #dfull_out + pal + theme_bw()+nl,
          ncol = 2)
          
#Generate individual plots
d1f
d2f
d3f
d4f
dfull_plot
