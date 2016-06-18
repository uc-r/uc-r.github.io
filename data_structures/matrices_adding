---
layout: tutorial
title: Adding on to Matrices
permalink: /matrices_adding
---

We can leverage the `cbind()` and `rbind()` functions for adding onto matrices as well.  Again, its important to keep in mind that the vectors that are being binded must be of equal length and mode to the pre-existing matrix.


```r
m1 <- cbind(v1, v2)
m1
##      v1 v2
## [1,]  1  5
## [2,]  2  6
## [3,]  3  7
## [4,]  4  8

# add a new column
cbind(m1, v3)
##      v1 v2 v3
## [1,]  1  5  9
## [2,]  2  6 10
## [3,]  3  7 11
## [4,]  4  8 12

# or add a new row
rbind(m1, c(4.1, 8.1))
##       v1  v2
## [1,] 1.0 5.0
## [2,] 2.0 6.0
## [3,] 3.0 7.0
## [4,] 4.0 8.0
## [5,] 4.1 8.1
```
