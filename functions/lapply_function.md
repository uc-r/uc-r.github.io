---
layout: tutorial
title: <code>lapply</code> Function
permalink: /lapply_function
---

The `lapply()` function does the following simple series of operations:

1. it loops over a list, iterating over each element in that list
2. it applies a function to each element of the list (a function that you specify) 
3. and returns a list (the l is for "list").

The syntax for `lapply()` is as follows where 

- `x` is the list
- `FUN` is the function to be applied
- `...` is for any other arguments to be passed to the function


```r
# syntax of lapply function
lapply(x, FUN, ...)
```

To provide examples we'll generate a list of four items:


```r
data <- list(item1 = 1:4, 
             item2 = rnorm(10), 
             item3 = rnorm(20, 1), 
             item4 = rnorm(100, 5))

# get the mean of each list item 
lapply(data, mean)
## $item1
## [1] 2.5
## 
## $item2
## [1] 0.5529324
## 
## $item3
## [1] 1.193884
## 
## $item4
## [1] 5.013019
```

The above provides a simple example where each list item is simply a vector of numeric values.  However, consider the case where you have a list that contains data frames and you would like to loop through each list item and perform a function to the data frame.  In this case we can embed an `apply` function within an `lapply` function.  

For example, the following creates a list for R's built in beaver data sets.  The `lapply` function loops through each of the two list items and uses `apply` to calculate the mean of the columns in both list items. Note that I wrap the apply function with `round` to provide an easier to read output.


```r
# list of R's built in beaver data
beaver_data <- list(beaver1 = beaver1, 
                    beaver2 = beaver2)

# get the mean of each list item 
lapply(beaver_data, function(x) round(apply(x, 2, mean), 2))
## $beaver1
##     day    time    temp   activ 
##  346.20 1312.02   36.86    0.05 
## 
## $beaver2
##     day    time    temp   activ 
##  307.13 1446.20   37.60    0.62
```
