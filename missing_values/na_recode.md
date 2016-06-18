---
layout: tutorial
title: Recode Missing Values
permalink: /na_recode
---

To recode missing values; or recode specific indicators that represent missing values, we can use normal subsetting and assignment operations. For example, we can recode missing values in vector `x` with the mean values in `x` by first subsetting the vector to identify `NA`s and then assign these elements a value. Similarly, if missing values are represented by another value (i.e. `99`) we can simply subset the data for the elements that contain that value and then assign a desired value to those elements.


```r
# recode missing values with the mean
# vector with missing data
x <- c(1:4, NA, 6:7, NA)
x
## [1]  1  2  3  4 NA  6  7 NA

x[is.na(x)] <- mean(x, na.rm = TRUE)

round(x, 2)
## [1] 1.00 2.00 3.00 4.00 3.83 6.00 7.00 3.83

# data frame that codes missing values as 99
df <- data.frame(col1 = c(1:3, 99), col2 = c(2.5, 4.2, 99, 3.2))

# change 99s to NAs
df[df == 99] <- NA
df
##   col1 col2
## 1    1  2.5
## 2    2  4.2
## 3    3   NA
## 4   NA  3.2
```
