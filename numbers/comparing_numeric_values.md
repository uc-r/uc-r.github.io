---
layout: tutorial
title: Comparing Numeric Values
permalink: /comparing_numeric_values/
---

There are multiple ways to compare numeric values and vectors.  This includes [logical operators](#numeric_comparison) along with testing for [exact equality](#numeric_exact) and also [near equality](#numeric_near).

<br>

{#numeric_comparison}
## Comparison Operators
The normal binary operators allow you to compare numeric values and provides the answer in logical form:

{linenos=off}
```r
x < y     # is x less than y
x > y     # is x greater than y
x <= y    # is x less than or equal to y
x >= y    # is x greater than or equal to y
x == y    # is x equal to y
x != y    # is x not equal to y
```

These operations can be used for single number comparison:

{linenos=off}
```r
x <- 9
y <- 10

x == y
## [1] FALSE
```

and also for comparison of numbers within vectors:

{linenos=off}
```r
x <- c(1, 4, 9, 12)
y <- c(4, 4, 9, 13)

x == y
## [1] FALSE  TRUE  TRUE FALSE
```

Note that logical values `TRUE` and `FALSE` equate to 1 and 0 respectively.  So if you want to identify the number of equal values in two vectors you can wrap the operation in the `sum()` function:

{linenos=off}
```r
# How many pairwise equal values are in vectors x and y
sum(x == y)    
## [1] 2
```

If you need to identify the location of pairwise equalities in two vectors you can wrap the operation in the `which()` function:

{linenos=off}
```r
# Where are the pairwise equal values located in vectors x and y
which(x == y)    
## [1] 2 3
```

{#numeric_exact}
### Exact Equality
To test if two objects are exactly equal:

{linenos=off}
```r
x <- c(4, 4, 9, 12)
y <- c(4, 4, 9, 13)

identical(x, y)
## [1] FALSE
```

{linenos=off}
```r
x <- c(4, 4, 9, 12)
y <- c(4, 4, 9, 12)

identical(x, y)
## [1] TRUE
```

### Floating Point Comparison
Sometimes you wish to test for 'near equality'.  The `all.equal()` function allows you to test for equality with a difference tolerance of 1.5e-8.

{linenos=off}
```r
x <- c(4.00000005, 4.00000008)
y <- c(4.00000002, 4.00000006)

all.equal(x, y)
## [1] TRUE
```

If the difference is greater than the tolerance level the function will return the mean relative difference:

{linenos=off}
```r
x <- c(4.005, 4.0008)
y <- c(4.002, 4.0006)

all.equal(x, y)
## [1] "Mean relative difference: 0.0003997102"
```
