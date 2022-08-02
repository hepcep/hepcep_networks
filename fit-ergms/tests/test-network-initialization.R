# Test initialized network data
## i.e., check if the proportions of nodes in various categories match targets from synthpop


# Libraries ----------

library(testthat) #using v2.3.2 for compatibility with my rlang
library(network)
library(dplyr)

# Data ----------

load(file="../meta-mixing-init-net.RData")
demog_data <- read.csv("../../data/synthpop-2022-07-25 13_21_04.csv")


# Make race variables consistent with previous dataset ----------

demog_data <-
  demog_data %>% 
  mutate(race=recode(race, "Wh"="W", "Bl"="B", "Hi"="H", "Ot"="O"))


# Test 1: gender  ----------

table(n0%v%"gender")
prop_fem_in_network <- as.numeric(table(n0%v%"gender")["female"]/(network.size(n0)))
prop_male_in_network <- as.numeric(table(n0%v%"gender")["male"]/(network.size(n0)))


expected_females <- which(demog_data$sex == "F")
expected_females_prop <- length(expected_females)/nrow(demog_data)

expected_males <- which(demog_data$sex == "M")
expected_males_prop <- length(expected_males)/nrow(demog_data)

expect_equal(prop_fem_in_network, expected_females_prop, tolerance=0.001)
expect_equal(prop_male_in_network, expected_males_prop, tolerance=0.001)


# Test 2: race  ----------

table(n0%v%"race")

prop_white_in_network <- as.numeric(table(n0%v%"race")["white"]/(network.size(n0)))
prop_black_in_network <- as.numeric(table(n0%v%"race")["black"]/(network.size(n0)))
prop_hispanic_in_network <- as.numeric(table(n0%v%"race")["hispanic"]/(network.size(n0)))
prop_other_in_network <- as.numeric(table(n0%v%"race")["other"]/(network.size(n0)))

expected_white <- which(demog_data$race == "W")
expected_white_prop <- length(expected_white)/nrow(demog_data)

expected_black <- which(demog_data$race == "B")
expected_black_prop <- length(expected_black)/nrow(demog_data)

expected_hispanic <- which(demog_data$race == "H")
expected_hispanic_prop <- length(expected_hispanic)/nrow(demog_data)

expected_other <- which(demog_data$race == "O")
expected_other_prop <- length(expected_other)/nrow(demog_data)

expect_equal(prop_white_in_network, expected_white_prop, tolerance=0.01)
expect_equal(prop_black_in_network, expected_black_prop, tolerance=0.01)
expect_equal(prop_hispanic_in_network, expected_hispanic_prop, tolerance=0.01)
expect_equal(prop_other_in_network, expected_other_prop, tolerance=0.01)
