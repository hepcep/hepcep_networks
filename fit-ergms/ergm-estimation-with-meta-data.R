# Analyze synthetic dataset with 32K nodes 
# Fit ERGM with 5 dyadic independent terms

rm(list=ls())

# Initiate environment ------------------------------
setwd(".")

packrat::init()
.libPaths()
#packrat::restore("../")

# Libraries ----------

library(network)
library(ergm)
library(dplyr)
library(ergm.userterms)



# Input Network Data ------------------------------

load("fit-ergms/out/meta-mixing-init-net.RData") #path for updated meta mixing with synthpop 

inedges <- read.csv("data/pplrss.csv") #in- and out-edges
outedges <- read.csv("data/ppldss.csv")
negbin_indeg <- read.csv("data/negbin-indeg.csv")
negbin_outdeg <- read.csv("data/negbin-outdeg.csv")


# Read Latitude/Longidtude Data ------------------------------ 

data <- read.csv("data/synthpop-2023-01-04 21_10_46.csv")

glimpse(data)

# Recode to add new variables to dataset ------------------------------

# young (< 26, to be set = 1) vs old (>= 26, to be set = 0) 
age.cat <- n0 %v% "age.cat"
age.cat.df <- as.data.frame(age.cat)
age.cat.df <-  
  mutate(age.cat, young = ifelse(age.cat == 0, 1, 0), .data = age.cat.df)
xtabs(~age.cat+young, data = age.cat.df)

# recode race variable to set ordering of categories
race <- n0 %v% "race"
race.num <- recode(race, 
                   white = 1, black = 2,
                   hispanic = 3, other = 4)

# Initialize network and add attributes ----------

n0 %v% "young" <- age.cat.df$young
n0 %v% "race.num" <- race.num
n0 %v% "lat" <- data$lat
n0 %v% "lon" <- data$lon

# Generate target statistics from meta-mixing data ----------

## gender 
### mixing information from meta-analysis of sathcap AND socnet
edges.male.end <- mean(c(0.58, 0.59))
edges.female.end <- mean(c(0.40, 0.41))

male.pctmale <- 0.53 
male.pctfemale <- 0.47
female.pctmale <- 0.75
female.pctfemale <- 0.22

### set gender targets 
tgt.male.pctmale <- edges_target*edges.male.end*male.pctmale
tgt.male.pctfemale <- edges_target*edges.male.end*male.pctfemale
tgt.female.pctmale <- edges_target*edges.female.end*female.pctmale  
tgt.female.pctfemale <- edges_target*edges.female.end*female.pctfemale

## young (1=young; 0=old)
### mixing information from meta-analysis of sathcap AND socnet
edges.young.end <- 0.10
edges.old.end <- 0.90
  
young.pctyoung <- 0.60
young.pctold <- 0.40
old.pctyoung <- 0.14
old.pctold <- 0.86
 
## set young targets from meta data
tgt.young.pctyoung <- edges_target * edges.young.end * young.pctyoung
tgt.young.pctold <- edges_target * edges.young.end * young.pctold
tgt.old.pctyoung <- edges_target * edges.old.end * old.pctyoung
tgt.old.pctold <- edges_target * edges.old.end * old.pctold


## chicago
### mixing information from meta-analysis of sathcap AND socnet

edges.chicago.end <- 0.87
edges.nonchicago.end <- 0.13

chicago.pctchicago <- 0.67
chicago.pctnonchicago <- 0.30
nonchicago.pctchicago <- 0.60
nonchicago.pctnonchicago <- 0.40


# ### mixing from simulation
# chicago.mm <- mixingmatrix(sim, "chicago") #fem=1, chicago=2
# from.nonchicago <- sum(chicago.mm$matrix[,1])
# from.chicago <- sum(chicago.mm$matrix[,2])
# 
# ### set chicago targets from sathcap
# tgt.chicago.pctchicago <- from.chicago*chicago.pctchicago
# tgt.chicago.pctnonchicago <- from.chicago*chicago.pctnonchicago
# tgt.nonchicago.pctchicago <- from.nonchicago*chicago.pctchicago
# tgt.nonchicago.pctnonchicago <- from.nonchicago*chicago.pctnonchicago


## race (1=Black, 2=hispani,3=other, 4=white)

table(n0 %v% "race.num") # will be sorted as per 1=W, 2=B, 3=H, 4=O

pct_to_white	<- mean(c(0.30, 0.31))
pct_to_black	<- mean(c(0.41,	0.42))
pct_to_hispanic	<- mean(c(0.21, 0.22))
pct_to_other	<- mean(c(0.04,	0.05))

race.w.w <- 0.73
race.b.w <- 0.10
race.h.w <- 0.12
race.o.w <- 0.04
race.w.b <- 0.10
race.b.b <- 0.83
race.h.b <- 0.06
race.o.b <- 0.01
race.w.h <- 0.21
race.b.h <- 0.15
race.h.h <- 0.62
race.o.h <- 0.02
race.w.o <- 0.43
race.b.o <- 0.21
race.h.o <- 0.22
race.o.o <- 0.14

target.w.w <- edges_target * pct_to_white * race.w.w
target.b.w <- edges_target * pct_to_white * race.b.w
target.h.w <- edges_target * pct_to_white * race.h.w
target.o.w <- edges_target * pct_to_white * race.o.w

target.w.b <- edges_target * pct_to_black * race.w.b
target.b.b <- edges_target * pct_to_black * race.b.b
target.h.b <- edges_target * pct_to_black * race.h.b
target.o.b <- edges_target * pct_to_black * race.o.b

target.w.h <- edges_target * pct_to_hispanic * race.w.h
target.b.h <- edges_target * pct_to_hispanic * race.b.h
target.h.h <- edges_target * pct_to_hispanic * race.h.h
target.o.h <- edges_target * pct_to_hispanic * race.o.h

target.w.o <- edges_target * pct_to_other * race.w.o
target.b.o <- edges_target * pct_to_other * race.b.o
target.h.o <- edges_target * pct_to_other * race.h.o
target.o.o <- edges_target * pct_to_other * race.o.o

## degree distributions
inedges <- inedges %>% 
  mutate(n_nodes = n*nbprob)
outedges <- outedges %>% 
  mutate(n_nodes = n*nbprob)

negbin_inedges <- negbin_indeg %>% 
  mutate(n_nodes = n*nbprob)
negbin_outedges <- negbin_outdeg %>% 
  mutate(n_nodes = n*nbprob)

## distance term

dist.prop.distribution <- c(15.7, 35.1, 24.1, 22)/100
dist.nedge.distribution <- edges_target*dist.prop.distribution

# Fit ERGM (with SATHCAP mixing) ----------


deg.terms <- 0:3
indeg.terms <- 0:1
dist.terms <- 1:3 #fourth is left out

fit.metadata.mixing <-
  ergm(
    n0 ~
      edges +
      nodemix("gender", base=1)+
      nodemix("young", base=1)+
      nodemix("race.num", base=1)+
      idegree(indeg.terms)+
      odegree(deg.terms)+
      dist(dist.terms),
    target.stats = c(edges_target,
                     c(tgt.female.pctmale, tgt.male.pctfemale, tgt.male.pctmale),           
                     c(tgt.old.pctyoung, tgt.young.pctold, tgt.young.pctyoung),
                     c(            target.b.w, target.h.w, target.o.w,
                                   target.w.b, target.b.b, target.h.b, target.o.b,
                                   target.w.h, target.b.h, target.h.h, target.o.h,
                                   target.w.o, target.b.o, target.h.o, target.o.o),
                     c(negbin_inedges$n_nodes[c(indeg.terms+1)]),
                     c(outedges$n_nodes[c(deg.terms+1)]),
                     c(dist.nedge.distribution[dist.terms])
                     
    ),
    eval.loglik = FALSE,
    control = control.ergm(MCMLE.maxit = 500,
                           MCMC.interval = 1e5,
                           MCMC.samplesize = 1e5,
                           SAN.control = control.san(
                             SAN.maxit = 500, 
                             SAN.init.maxedges = 20000*10, 
                             SAN.nsteps = 1e8
                           )
                           
    )
  )

save.image("on-oscar-racemix-plus-dist-plus-negbin-odeg0-3-indeg0-1-orignialdata.RData")
