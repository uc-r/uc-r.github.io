---
layout: page
title: Dealing with Missing Values
permalink: /missing_values
---

A common task in data analysis is dealing with missing values.  In R, missing values are often represented by `NA` or some other value that represents missing values (i.e. `99`).  We can easily work with missing values and in this section you will learn how to:

- [Test for missing values](#na_test)
- [Recode missing values](#na_recode)
- [Exclude missing values](#na_exclude)

<br>

## Test for missing values {#na_test}
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

<br>

## Recode missing values {#na_recode}
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

<br>

## Exclude missing values {#na_exclude}
We can exclude missing values in a couple different ways. First, if we want to exclude missing values from mathematical operations use the `na.rm = TRUE` argument. If you do not exclude these values most functions will return an `NA`.


```r
# A vector with missing values
x <- c(1:4, NA, 6:7, NA)

# including NA values will produce an NA output
mean(x)
## [1] NA

# excluding NA values will calculate the mathematical operation for all non-missing values
mean(x, na.rm = TRUE)
## [1] 3.833333
```

We may also desire to subset our data to obtain complete observations, those observations (rows) in our data that contain no missing data. We can do this a few different ways.


```r
# data frame with missing values
df <- data.frame(col1 = c(1:3, NA),
                 col2 = c("this", NA,"is", "text"), 
                 col3 = c(TRUE, FALSE, TRUE, TRUE), 
                 col4 = c(2.5, 4.2, 3.2, NA),
                 stringsAsFactors = FALSE)

df
##   col1 col2  col3 col4
## 1    1 this  TRUE  2.5
## 2    2 <NA> FALSE  4.2
## 3    3   is  TRUE  3.2
## 4   NA text  TRUE   NA
```

First, to find complete cases we can leverage the `complete.cases()` function which returns a logical vector identifying rows which are complete cases. So in the following case rows 1 and 3 are complete cases. We can use this information to subset our data frame which will return the rows which `complete.cases()` found to be `TRUE`.


```r
complete.cases(df)
## [1]  TRUE FALSE  TRUE FALSE

# subset with complete.cases to get complete cases
df[complete.cases(df), ]
##   col1 col2 col3 col4
## 1    1 this TRUE  2.5
## 3    3   is TRUE  3.2

# or subset with `!` operator to get incomplete cases
df[!complete.cases(df), ]
##   col1 col2  col3 col4
## 2    2 <NA> FALSE  4.2
## 4   NA text  TRUE   NA
```

An shorthand alternative is to simply use `na.omit()` to omit all rows containing missing values.


```r
# or use na.omit() to get same as above
na.omit(df)
##   col1 col2 col3 col4
## 1    1 this TRUE  2.5
## 3    3   is TRUE  3.2
```
