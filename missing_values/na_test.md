---
layout: tutorial
title: Testing for Missing Values
permalink: /na_test
---

To identify missing values use `is.na()` which returns a logical vector with `TRUE` in the element locations that contain missing values represented by `NA`.  `is.na()` will work on vectors, lists, matrices, and data frames. 


```r
# vector with missing data
x <- c(1:4, NA, 6:7, NA)
x
## [1]  1  2  3  4 NA  6  7 NA

is.na(x)
## [1] FALSE FALSE FALSE FALSE  TRUE FALSE FALSE  TRUE

# data frame with missing data
df <- data.frame(col1 = c(1:3, NA),
                 col2 = c("this", NA,"is", "text"), 
                 col3 = c(TRUE, FALSE, TRUE, TRUE), 
                 col4 = c(2.5, 4.2, 3.2, NA),
                 stringsAsFactors = FALSE)

# identify NAs in full data frame
is.na(df)
##       col1  col2  col3  col4
## [1,] FALSE FALSE FALSE FALSE
## [2,] FALSE  TRUE FALSE FALSE
## [3,] FALSE FALSE FALSE FALSE
## [4,]  TRUE FALSE FALSE  TRUE

# identify NAs in specific data frame column
is.na(df$col4)
## [1] FALSE FALSE FALSE  TRUE
```

To identify the location or the number of NAs we can leverage the `which()` and `sum()` functions:


```r
# identify location of NAs in vector
which(is.na(x))
## [1] 5 8

# identify count of NAs in data frame
sum(is.na(df))
## [1] 3
```
