# Session 1: An introduction to statistical programming

################
# Getting Help #
################

help("sum")
?mean
example("sum")

######################
# Set Your Directory #
######################

getwd()

# Exercise: set your working directory using setwd()


#####################
# R as a Calculator #
#####################

4 + 3 / 10 ^ 2
4 + (3 / 10 ^ 2)
(4 + 3) / 10 ^ 2
1 / 17 ^ 7
1 / 0
Inf - Inf


##################
# Simple Objects #
##################

x <- 3                  # assign 3 to x
x                       # evaluate x

x <- x + 1              # we can increment (build onto) existing objects
x

x = 3                   # BAD
x <- 3                  # GOOD

X                       # case sensitive


##############
# YOUR TURN! #
##############
# Calculate Q in the in the economic order quantity model presented
D <- 1000
K <- 5
h <- .25

Q <- sqrt((2 * D * K) / h)
Q



#########################
# Workspace Environment #
#########################

ls()                    # list objects in your global environment
rm(D)                   # remove defined object
rm(list = ls())         # remove all objects


###########
# Vectors #
###########

1:10
-3:5

x <- 1:10
y <- c(2, 5, -1)


#################
# Vectorization #
#################

x <- c(1, 3, 4) 
y <- c(1, 2, 4)

x + y
x * y
x > y

long <- 1:10
short <- 1:4

long + short


##############
# YOUR TURN! #
##############
# Calculate Q in the in the economic order quantity model presented
D <- 1000
K <- 5
h <- c(.25, .50, .75)

Q <- sqrt((2 * D * K) / h)
Q



#########################
# Working with Packages #
#########################




##############
# YOUR TURN! #
##############
# Download the packages listed
install.packages("dplyr")
install.packages("tidyr")
install.packages("ggplot2")
install.packages("stringr")
install.packages("lubridate")




##################
# Using Packages #
##################

library(dplyr)                                  # activate package
help(package = "dplyr")                         # provides details regarding package
vignette(package = "dplyr")                     # list vignettes available for a package
vignette("introduction", package = "dplyr")     # view specific vignette







