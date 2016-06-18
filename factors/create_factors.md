---
layout: tutorial
title: Creating, Converting & Inspecting Factors
permalink: /create_factors/
---


Factor objects can be created with the `factor()` function:

```r
# create a factor string
gender <- factor(c("male", "female", "female", "male", "female"))
gender
## [1] male   female female male   female
## Levels: female male

# inspect to see if it is a factor class
class(gender)
## [1] "factor"

# show that factors are just built on top of integers
typeof(gender)
## [1] "integer"

# See the underlying representation of factor
unclass(gender)
## [1] 2 1 1 2 1
## attr(,"levels")
## [1] "female" "male"

# what are the factor levels?
levels(gender)
## [1] "female" "male"

# show summary of counts
summary(gender)
## female   male 
##      3      2
```

If we have a vector of character strings or integers we can easily convert to factors:

```r
group <- c("Group1", "Group2", "Group2", "Group1", "Group1")
str(group)
##  chr [1:5] "Group1" "Group2" "Group2" "Group1" "Group1"

# convert from characters to factors
as.factor(group)
## [1] Group1 Group2 Group2 Group1 Group1
## Levels: Group1 Group2
```
