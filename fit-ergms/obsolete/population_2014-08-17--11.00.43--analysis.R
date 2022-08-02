# Analyze synthetic dataset with 32K nodes 
# Fit ERGM with 5 dyadic independent terms

rm(list=ls())
# Libraries ----------

library(network)
library(ergm)
library(dplyr)
library(ergm.userterms)

# Data ----------

data <- read.csv("/project/khanna7/Projects/midway2/HepCep/data/pwids_with_lat_lon.csv", header = T)
dim(data)
glimpse(data)

# Summary Statistics ----------

indeg <- data$Drug_in_degree
outdeg <- data$Drug_out_degree

indeg_tbl <- as.numeric(table(indeg))
outdeg_tbl <- as.numeric(table(outdeg))

summary(indeg)
summary(outdeg)

hist(indeg, breaks = 32)
hist(outdeg, breaks = 32)

nedges <- max(c(sum(indeg)),
              sum((outdeg))
              )
                
mdeg <- nedges/nrow(data)
sum(indeg)
sum(outdeg)

dist.prop.distribution <- c(30, 12, 12, 15, 15, 10, 6)/100 #seventh term calculated as 1-sum(of first 6)
dist.nedge.distribution <- nedges*dist.prop.distribution

# Recode variables ----------

## chicago vs nonchicago
data <-  
  mutate(data, chicago = ifelse(substr(Zip, 1, 3) == "606", 1, 0))


# Initialize network and add attributes ----------

n0 <- network.initialize(n = nrow(data))

n0 %v% "age" <- data$Age
n0 %v% "gender" <- as.numeric(data$Gender) #1=F; 2=M
n0 %v% "race" <- as.numeric(data$Race)# 1=Hisp, 2=NH Black,3=NHWhite, 4=O
n0 %v% "zip" <- data$Zip
n0 %v% "syringe_source" <- as.numeric(data$Syringe_source) #1=HR, 2=nonHR
n0 %v% "hcv" <- as.numeric(data$HCV)#1=C, 2=E, 3=inf.acute, 4=R, 5=S
n0 %v% "age_started" <- data$Age_Started
n0 %v% "num_buddies" <- data$Num.Buddies
n0 %v% "daily_injection_intensity" <- data$Daily_injection_intensity
n0 %v% "fraction_recept_sharing" <- data$Fraction_recept_sharing
n0 %v% "zz" <- data$zz
n0 %v% "azi" <- data$azi
#n0 %v% "zip1" <- data$Zip.1 #identical to "Zip"
n0 %v% "lat" <- data$lat
n0 %v% "lon" <- data$lon
n0 %v% "chicago" <- data$chicago #mutated chicago variable

dist.terms <- c(1:5,7) #leave one out 

list.vertex.attributes(n0)


# Fit ERGM ----------

fit <- ergm(n0 ~ edges + 
            dist(dist.terms) +
            odegree(c(0,2,3)) + idegree(c(0,2,3)),
            target.stats = c(nedges, 
                             dist.nedge.distribution[dist.terms],
                             outdeg_tbl[c(1,3,4)], indeg_tbl[c(1,3,4)]),
            eval.loglik = FALSE,
            control = control.ergm(MCMLE.maxit = 500)
            )

list.vertex.attributes(n0)

sim <- simulate(fit)
sim

list.vertex.attributes(n0)

save.image("large-net-dist-term.RData")
