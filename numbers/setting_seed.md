---
layout: tutorial
title: Setting the seed for reproducible random numbers
permalink: /setting_seed/
---

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
