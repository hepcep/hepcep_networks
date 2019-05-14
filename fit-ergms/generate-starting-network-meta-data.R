# Initialize starting network with 32K nodes and meta data 


rm(list=ls())

# Libraries ----------

library(readxl) #not able to directly sftp the csv datasets
library(network)
library(ergm)
library(dplyr)


# Data ----------

# demography
demog.data <- read_excel("../HepCEP_ERGM/demog_prop_est.xlsx") 


# Initialize network ----------

n <- 32000
n0 <- network.initialize(n = n, directed = TRUE)


# Set vertex attributes ----------

# group assignment
groups <- demog.data$group
group.assignment <- sample(groups, n, replace = TRUE, prob = demog.data$prop)
set.vertex.attribute(n0, "group", value = group.assignment)

# add gender based on group assignment
male <- which(group.assignment <= 16)
set.vertex.attribute(n0, "gender", 
                     value = "female") #initialize all nodes as "female"
set.vertex.attribute(n0, "gender", 
                     value = "male", v = male) #assign male attribute as per group
table(n0 %v% "gender")

# add race based on group assignment
race.indicator <- (group.assignment-1) %/% 4
white <- union(which(race.indicator == 0), which(race.indicator == 4))
black <- union(which(race.indicator == 1), which(race.indicator == 5))
hispanic <- union(which(race.indicator == 2), which(race.indicator == 6))

set.vertex.attribute(n0, "race", 
                     value = "other") #initialize all nodes as "other"
set.vertex.attribute(n0, "race", 
                     value = "white", v = white) 
set.vertex.attribute(n0, "race", 
                     value = "black", v = black)
set.vertex.attribute(n0, "race", 
                     value = "hispanic", v = hispanic)
table(n0 %v% "race")

# add age category based on group assignment:
  # 18-25: age.cat = 0, 25-34: age.cat=1, 
  # 35-44, age.cat = 2, 45+: age.cat = 3
age.cat.indicator <- (group.assignment - 1) %% 4
set.vertex.attribute(n0, "age.cat", 
                     value = age.cat.indicator) 
table(n0 %v% "age.cat")


# Save RData ----------

save.image(file="meta-mixing-init-net.RData")