---
layout: tutorial
title: <code>sapply</code> Function
permalink: /sapply_function
---

The `sapply()` function behaves similarly to `lapply()`; the only real difference is in the return value. `sapply()` will try to simplify the result of `lapply()` if possible. Essentially, `sapply()` calls `lapply()` on its input and then applies the following algorithm:

- If the result is a list where every element is length 1, then a vector is returned
- If the result is a list where every element is a vector of the same length (> 1), a matrix is
returned.
- If neither of the above simplifications can be performed then a list is returned

To illustrate the differences we can use the previous example using a list with the beaver data and compare the `sapply` and `lapply` outputs:


```r
# list of R's built in beaver data
beaver_data <- list(beaver1 = beaver1, 
                    beaver2 = beaver2)

# get the mean of each list item and return as a list
lapply(beaver_data, function(x) round(apply(x, 2, mean), 2))
## $beaver1
##     day    time    temp   activ 
##  346.20 1312.02   36.86    0.05 
## 
## $beaver2
##     day    time    temp   activ 
##  307.13 1446.20   37.60    0.62

# get the mean of each list item and simplify the output
sapply(beaver_data, function(x) round(apply(x, 2, mean), 2))
##       beaver1 beaver2
## day    346.20  307.13
## time  1312.02 1446.20
## temp    36.86   37.60
## activ    0.05    0.62
```
