---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Data Structures](data_structures) &#187; Dealing with missing values

<br>

A common task in data analysis is dealing with missing values.  In R, missing values are represented by `NA`  We can easily work with missing values by:

* <a href="#testing">Testing for missing values</a>
* <a href="#recoding">Recoding missing values</a>
* <a href="#excluding">Excluding missing values</a>

<br>

<a name="testing"></a>

# Testing for Missing Values
To identify missing values use `is.na()` which returns a logical vector with 'TRUE' in NA element locations:

{% highlight r %}
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
{% endhighlight %}

To identify the location or the number of NAs we can leverage the `which()` and `sum()` functions:

{% highlight r %}
# identify location of NAs in vector
which(is.na(x))
## [1] 5 8

# identify count of NAs in data frame
sum(is.na(df))
## [1] 3
{% endhighlight %}

<br>

<a name="recoding"></a>

# Recoding Missing Values
To recode missing values; or recode specific indicators that represent missing values, we can use normal subsetting and assignment operations.

{% highlight r %}
# recode missing values with the mean
x[is.na(x)] <- mean(x, na.rm = TRUE)
round(x, 2)
## [1] 1.00 2.00 3.00 4.00 3.83 6.00 7.00 3.83

# vector that codes missing values as 99
df <- data.frame(col1 = c(1:3, 99), col2 = c(2.5, 4.2, 99, 3.2))

# change 99s to NAs
df[df == 99] <- NA
df
##   col1 col2
## 1    1  2.5
## 2    2  4.2
## 3    3   NA
## 4   NA  3.2
{% endhighlight %}

<br>

<a name="excluding"></a>

# Excluding Missing Values
We can exclude missing values in a couple different ways:

{% highlight r %}
# To exclude from mathematical opertions use `na.rm = TRUE` argument
x <- c(1:4, NA, 6:7, NA)

mean(x)
## [1] NA
mean(x, na.rm = TRUE)
## [1] 3.833333

# to find complete cases leverage the `complete.cases()` function
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

# returns logical vector for rows which are complete cases
complete.cases(df)
## [1]  TRUE FALSE  TRUE FALSE

# subset with complete.cases to get complete cases
df[complete.cases(df), ]
##   col1 col2 col3 col4
## 1    1 this TRUE  2.5
## 3    3   is TRUE  3.2

# or use na.omit() to get same as above
na.omit(df)
##   col1 col2 col3 col4
## 1    1 this TRUE  2.5
## 3    3   is TRUE  3.2

# or subset with `!` operator to get incomplete cases
df[!complete.cases(df), ]
##   col1 col2  col3 col4
## 2    2 <NA> FALSE  4.2
## 4   NA text  TRUE   NA
{% endhighlight %}


<br>

<small><a href="#">Go to top</a></small>

