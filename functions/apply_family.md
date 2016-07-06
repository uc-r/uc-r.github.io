---
layout: tutorial
title: Apply Family
permalink: /apply_family
---

The apply family consists of vectorized functions which minimize your need to explicitly create loops. These functions will apply a specified function to a data object and their primary difference is in the object class in which the function is applied to (list vs. matrix, etc) and the object class that will be returned from the function. The following presents the most common forms of apply functions that I use for data analysis but realize that additional functions exist (`mapply`, `rapply`, & `vapply`) which are not covered here.

- [`apply()`](http://uc-r.github.io/apply_function) for matrices and data frames
- [`lapply()`](http://uc-r.github.io/lapply_function) for lists…output as list
- [`sapply()`](http://uc-r.github.io/sapply_function) for lists…output simplified
- [`tapply()`](http://uc-r.github.io/tapply_function) for vectors
- Other useful ["loop-like" functions](http://uc-r.github.io/loop_like)
