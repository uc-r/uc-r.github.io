---
layout: tutorial
title: Integer vs. Double
permalink: /integer_double/
---

The two most common numeric classes used in R are integer and double (for double precision floating point numbers). R automatically converts between these two classes when needed for mathematical purposes. As a result, it's feasible to use R and perform analyses for years without specifying these differences. To check whether a pre-existing vector is made up of integer or double values you can use `typeof(x)` which will tell you if the vector is a double, integer, logical, or character type.

<br>

## Creating Integer and Double Vectors
By default, when you create a numeric vector using the `c()` function it will produce a vector of double precision numeric values.  To create a vector of integers using `c()` you must specify explicity by placing an `L` directly after each number.


```r
# create a string of double-precision values
dbl_var <- c(1, 2.5, 4.5)  
dbl_var
## [1] 1.0 2.5 4.5

# placing an L after the values creates a string of integers
int_var <- c(1L, 6L, 10L)
int_var
## [1]  1  6 10
```

<br>

## Converting Between Integer and Double Values
By default, if you read in data that has no decimal points or you [create numeric values](#generating_sequence_numbers) using the `x <- 1:10` method the numeric values will be coded as integer.  If you want to change a double to an integer or vice versa you can specify one of the following: 


```r
# converts integers to double-precision values
as.double(int_var)     
## [1]  1  6 10

# identical to as.double()
as.numeric(int_var)    
## [1]  1  6 10

# converts doubles to integers
as.integer()           
## integer(0)
```
