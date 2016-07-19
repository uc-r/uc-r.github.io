---
id: 1836
title: Dealing with Numbers
date: 2016-06-10
author: Brad Boehmke
layout: page
permalink: /section3_numbers/
---

In this section you will learn the basics of working with numbers in R.  This includes understanding

* [How to manage the numeric type (integer vs. double)](#integer_vs_double)
* [The different ways of generating non-random numbers](#generating_sequence_numbers)
* [The different ways of generating random numbers](#generating_random_numbers)
* [How to set seed values for reproducible random number generation](#setting_seed)
* [The different ways to compare numbers](#compare_numeric_values)
* [How to round numeric values](#round_numbers)

<br>

## Numeric Types (integer vs. double) {#integer_vs_double}
The two most common numeric classes used in R are integer and double (for double precision floating point numbers). R automatically converts between these two classes when needed for mathematical purposes. As a result, it's feasible to use R and perform analyses for years without specifying these differences. 


### Creating Integer and Double Vectors {#integer}
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


### Checking for Numeric Type {#type}
To check whether a vector is made up of integer or double values:

```r
# identifies the vector type (double, integer, logical, or character)
typeof(dbl_var)
## [1] "double"

typeof(int_var)
## [1] "integer"
```


### Converting Between Integer and Double Values {#convert}
By default, if you read in data that has no decimal points or you [create numeric values](#generating_sequence_numbers) using the `x <- 1:10` method the numeric values will be coded as integer.  If you want to change a double to an integer or vice versa you can specify one of the following: 


```r
# converts integers to double-precision values
as.double(int_var)     
## [1]  1  6 10

# identical to as.double()
as.numeric(int_var)    
## [1]  1  6 10

# converts doubles to integers
as.integer(dbl_var)         
## [1] 1 2 4
```

<br>


## Generating Non-random Numbers {#generating_sequence_numbers}
There are a few R operators and functions that are especially useful for creating vectors of non-random numbers.  These functions provide multiple ways for generating sequences of numbers.

### Specifing Numbers within a Sequence {#seq1}

To explicitly specify numbers in a sequence you can use the colon `:` operator to specify all integers between two specified numbers or the combine `c()` function to explicity specify all numbers in the sequence.


```r
# create a vector of integers between 1 and 10
1:10         
##  [1]  1  2  3  4  5  6  7  8  9 10

# create a vector consisting of 1, 5, and 10
c(1, 5, 10)   
## [1]  1  5 10

# save the vector of integers between 1 and 10 as object x
x <- 1:10 
x
##  [1]  1  2  3  4  5  6  7  8  9 10
```

### Generating Regular Sequences {#seq2}

A generalization of `:` is the `seq()` function, which generates a sequence of numbers with a specified arithmetic progression.


```r
# generate a sequence of numbers from 1 to 21 by increments of 2
seq(from = 1, to = 21, by = 2)             
##  [1]  1  3  5  7  9 11 13 15 17 19 21

# generate a sequence of numbers from 1 to 21 that has 15 equal incremented 
# numbers
seq(0, 21, length.out = 15)    
##  [1]  0.0  1.5  3.0  4.5  6.0  7.5  9.0 10.5 12.0 13.5 15.0 16.5 18.0 19.5
## [15] 21.0
```


### Generating Repeated Sequences {#seq3}

The `rep()` function allows us to conveniently repeat specified constants into long vectors. This function allows for collated and non-collated repetitions.


```r
# replicates the values in x a specified number of times in a collated fashion
rep(1:4, times = 2)   
## [1] 1 2 3 4 1 2 3 4

# replicates the values in x in an uncollated fashion
rep(1:4, each = 2)    
## [1] 1 1 2 2 3 3 4 4
```

<br>


## Generating Random Numbers {#generating_random_numbers}
Simulation is a common practice in data analysis. Sometimes your analysis requires the implementation of a statistical procedure that requires random number generation or sampling (i.e. Monte Carlo simulation, bootstrap sampling, etc).  R comes with a set of pseudo-random number generators that allow you to simulate the most common probability distributions such as:

- [Uniform](#uniform)
- [Normal](#normal)
- [Binomial](#binomial)
- [Poisson](#poisson)
- [Exponential](#exponential)
- [Gamma](#gamma)

### Uniform numbers {#uniform}
To generate random numbers from a uniform distribution you can use the `runif()` function.  Alternatively, you can use `sample()` to take a random sample using with or without replacements.


```r
# generate n random numbers between the default values of 0 and 1
runif(n)            

# generate n random numbers between 0 and 25
runif(n, min = 0, max = 25)       

# generate n random numbers between 0 and 25 (with replacement)
sample(0:25, n, replace = TRUE)   

# generate n random numbers between 0 and 25 (without replacement)
sample(0:25, n, replace = FALSE)  
```

For example, to generate 25 random numbers between the values 0 and 10:


```r
runif(25, min = 0, max = 10) 
##  [1] 9.2494720 1.0276421 9.6061007 7.4582455 8.3666868 0.8090925 7.5638221
##  [8] 4.2810155 2.5850736 9.7962788 6.1705894 0.7037997 9.5056240 4.7589622
## [15] 7.9750129 5.3932881 5.1624935 1.2704098 8.7064680 8.6649293 0.1049461
## [22] 1.4827342 2.7337917 7.5236131 3.9803653
```

For each non-uniform probability distribution there are four primary functions available to generate random numbers, density (aka probability mass function), cumulative density, and quantiles.  The prefixes for these functions are:

- `r`: random number generation
- `d`: density or probability mass function
- `p`: cumulative distribution
- `q`: quantiles

### Normal Distribution Numbers {#normal}
The normal (or Gaussian) distribution is the most common and well know distribution.  Within R, the normal distribution functions are written as <prefix>`norm()`.


```r
# generate n random numbers from a normal distribution with given mean & st. dev.
rnorm(n, mean = 0, sd = 1)    

# generate CDF probabilities for value(s) in vector q 
pnorm(q, mean = 0, sd = 1)    

# generate quantile for probabilities in vector p
qnorm(p, mean = 0, sd = 1)    

# generate density function probabilites for value(s) in vector x
dnorm(x, mean = 0, sd = 1)    
```

For example, to generate 25 random numbers from a normal distribution with `mean = 100` and
`standard deviation = 15`:


```r
x <- rnorm(25, mean = 100, sd = 15) 
x
##  [1] 107.84214 101.10742  73.67151 113.94035 108.47938  77.48445  73.02016
##  [8]  81.02323 101.64169 112.67715 105.28478  92.35393  85.96284 108.83169
## [15]  88.71057 115.13657 141.69830  99.91198 118.69664 110.61667  83.20282
## [22] 113.91008 109.10879  93.45276 109.01996

summary(x)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   73.02   88.71  105.30  101.10  110.60  141.70
```

You can also pass a vector of values.  For instance, say you want to know the CDF probabilities for each value in the vector `x` created above:


```r
pnorm(x, mean = 100, sd = 15) 
##  [1] 0.69944664 0.52942643 0.03960976 0.82364789 0.71406244 0.06667308
##  [7] 0.03603657 0.10291447 0.54357552 0.80098468 0.63770038 0.30511760
## [13] 0.17468526 0.72199534 0.22583658 0.84353778 0.99728111 0.49765904
## [19] 0.89369904 0.76045844 0.13139693 0.82312464 0.72815841 0.33124331
## [25] 0.72619004
```

### Binomial Distribution Numbers {#binomial}
This is conventionally interpreted as the number of successes in `size = x` trials and with `prob = p` probability of success:


```r
# generate a vector of length n displaying the number of successes from a trial 
# size = 100 with a probabilty of success = 0.5
rbinom(n, size = 100, prob = 0.5)  

# generate CDF probabilities for value(s) in vector q
pbinom(q, size = 100, prob = 0.5) 

# generate quantile for probabilities in vector p
qbinom(p, size = 100, prob = 0.5) 

# generate density function probabilites for value(s) in vector x
dbinom(x, size = 100, prob = 0.5)  
```

### Poisson Distribution Numbers {#poisson}
The Poisson distribution is a discrete probability distribution that expresses the probability of a given number of events occuring in a fixed interval of time and/or space if these events occur with a known average rate and independently of the time since the last event.


```r
# generate a vector of length n displaying the random number of events occuring 
# when lambda (mean rate) equals 4.
rpois(n, lambda = 4)  

# generate CDF probabilities for value(s) in vector q when lambda (mean rate) 
# equals 4.
ppois(q, lambda = 4)  

# generate quantile for probabilities in vector p when lambda (mean rate) 
# equals 4.
qpois(p, lambda = 4)  

# generate density function probabilites for value(s) in vector x when lambda 
# (mean rate) equals 4.
dpois(x, lambda = 4)  
```

### Exponential Distribution Numbers {#exponential}
The Exponential probability distribution describes the time between events in a Poisson process.


```r
# generate a vector of length n with rate = 1
rexp(n, rate = 1)   

# generate CDF probabilities for value(s) in vector q when rate = 4.
pexp(q, rate = 1)   

# generate quantile for probabilities in vector p when rate = 4.
qexp(p, rate = 1)   

# generate density function probabilites for value(s) in vector x when rate = 4.
dexp(x, rate = 1)   
```

### Gamma Distribution Numbers {#gamma}
The Gamma probability distribution is related to the Beta distribution and arises naturally in processes for which the waiting times between Poisson distributed events are relevant.


```r
# generate a vector of length n with shape parameter = 1
rgamma(n, shape = 1)   

# generate CDF probabilities for value(s) in vector q when shape parameter = 1.
pgamma(q, shape = 1)   

# generate quantile for probabilities in vector p when shape parameter = 1.
qgamma(p, shape = 1)   

# generate density function probabilites for value(s) in vector x when shape 
# parameter = 1.
dgamma(x, shape = 1)   
```

<br>


## Setting Seed Values {#setting_seed}

If you want to generate a sequence of random numbers and then be able to reproduce that same sequence of random numbers later you can set the random number seed generator with `set.seed()`.  This is a critical aspect of [reproducible research](https://en.wikipedia.org/wiki/Reproducibility).

For example, we can reproduce a random generation of 10 values from a normal distribution:


```r
set.seed(197)
rnorm(n = 10, mean = 0, sd = 1)
##  [1]  0.6091700 -1.4391423  2.0703326  0.7089004  0.6455311  0.7290563
##  [7] -0.4658103  0.5971364 -0.5135480 -0.1866703


set.seed(197)
rnorm(n = 10, mean = 0, sd = 1)
##  [1]  0.6091700 -1.4391423  2.0703326  0.7089004  0.6455311  0.7290563
##  [7] -0.4658103  0.5971364 -0.5135480 -0.1866703
```

<br>


## Comparing Numeric Values {#compare_numeric_values}

There are multiple ways to compare numeric values and vectors.  This includes [logical operators](#numeric_comparison) along with testing for [exact equality](#numeric_exact) and also [near equality](#numeric_near).

### Comparison Operators {#numeric_comparison}
The normal binary operators allow you to compare numeric values and provides the answer in logical form:


```r
x < y     # is x less than y
x > y     # is x greater than y
x <= y    # is x less than or equal to y
x >= y    # is x greater than or equal to y
x == y    # is x equal to y
x != y    # is x not equal to y
```

These operations can be used for single number comparison:


```r
x <- 9
y <- 10

x == y
## [1] FALSE
```

and also for comparison of numbers within vectors:


```r
x <- c(1, 4, 9, 12)
y <- c(4, 4, 9, 13)

x == y
## [1] FALSE  TRUE  TRUE FALSE
```

Note that logical values `TRUE` and `FALSE` equate to 1 and 0 respectively.  So if you want to identify the number of equal values in two vectors you can wrap the operation in the `sum()` function:


```r
# How many pairwise equal values are in vectors x and y
sum(x == y)    
## [1] 2
```

If you need to identify the location of pairwise equalities in two vectors you can wrap the operation in the `which()` function:


```r
# Where are the pairwise equal values located in vectors x and y
which(x == y)    
## [1] 2 3
```

### Exact Equality {#numeric_exact}
To test if two objects are exactly equal:


```r
x <- c(4, 4, 9, 12)
y <- c(4, 4, 9, 13)

identical(x, y)
## [1] FALSE
```


```r
x <- c(4, 4, 9, 12)
y <- c(4, 4, 9, 12)

identical(x, y)
## [1] TRUE
```

### Floating Point Comparison {#numeric_near}
Sometimes you wish to test for 'near equality'.  The `all.equal()` function allows you to test for equality with a difference tolerance of 1.5e-8.


```r
x <- c(4.00000005, 4.00000008)
y <- c(4.00000002, 4.00000006)

all.equal(x, y)
## [1] TRUE
```

If the difference is greater than the tolerance level the function will return the mean relative difference:


```r
x <- c(4.005, 4.0008)
y <- c(4.002, 4.0006)

all.equal(x, y)
## [1] "Mean relative difference: 0.0003997102"
```

<br>


## Rounding numeric Values {#round_numbers}

There are many ways of rounding to the nearest integer, up, down, or toward a specified decimal place.  Assuming we have the following vector `x`:

```r
x <- (1, 1.35, 1.7, 2.05, 2.4, 2.75, 3.1, 3.45, 3.8, 4.15, 4.5, 4.85, 5.2, 5.55, 5.9)
```

The following illustrates the common ways to round `x`:

```r
# Round to the nearest integer
round(x)
##  [1] 1 1 2 2 2 3 3 3 4 4 4 5 5 6 6

# Round up
ceiling(x)
##  [1] 1 2 2 3 3 3 4 4 4 5 5 5 6 6 6
 
# Round down
floor(x)
##  [1] 1 1 1 2 2 2 3 3 3 4 4 4 5 5 5
 
# Round to a specified decimal
round(x, digits = 1)
##  [1] 1.0 1.4 1.7 2.0 2.4 2.8 3.1 3.4 3.8 4.2 4.5 4.8 5.2 5.5 5.9
```

