---
layout: tutorial
title: Adding on to Vectors
permalink: /vectors_adding
---

To add additional elements to a pre-existing vector we can continue to leverage the `c()` function.  Also, note that vectors are always flat so nested `c()` functions will not add additional dimensions to the vector:

```r
v1 <- 8:17

c(v1, 18:22)
##  [1]  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22

# same as
c(v1, c(18, c(19, c(20, c(21:22)))))
##  [1]  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22
```
