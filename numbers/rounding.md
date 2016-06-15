---
layout: tutorial
title: Rounding Numbers
permalink: /rounding/
---

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
