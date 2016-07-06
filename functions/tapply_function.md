---
layout: tutorial
title: <code>tapply</code> Function
permalink: /tapply_function
---

`tapply()` is used to apply a function over subsets of a vector.  It is primarily used when we have the following circumstances:

1. A dataset that can be broken up into groups (via categorical variables - aka factors)
2. We desire to break the dataset up into groups
3. Within each group, we want to apply a function

The arguments to `tapply()` are as follows:

- `x` is a vector
- `INDEX` is a factor or a list of factors (or else they are coerced to factors) 
- `FUN` is a function to be applied
- `...` contains other arguments to be passed FUN
- `simplify`, should we simplify the result?


```r
# syntax of tapply function
tapply(x, INDEX, FUN, ..., simplify = TRUE)
```

To provide an example we'll use the built in mtcars dataset and calculate the mean of the `mpg` variable grouped by the `cyl` variable.


```r
# show first few rows of mtcars
head(mtcars)
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1

# get the mean of the mpg column grouped by cylinders 
tapply(mtcars$mpg, mtcars$cyl, mean)
##        4        6        8 
## 26.66364 19.74286 15.10000
```

Now let's say you want to calculate the mean for *each* column in the mtcars dataset grouped by the cylinder categorical variable.  To do this you can embed the `tapply` function within the `apply` function.  


```r
# get the mean of all columns grouped by cylinders 
apply(mtcars, 2, function(x) tapply(x, mtcars$cyl, mean))
##        mpg cyl     disp        hp     drat       wt     qsec        vs
## 4 26.66364   4 105.1364  82.63636 4.070909 2.285727 19.13727 0.9090909
## 6 19.74286   6 183.3143 122.28571 3.585714 3.117143 17.97714 0.5714286
## 8 15.10000   8 353.1000 209.21429 3.229286 3.999214 16.77214 0.0000000
##          am     gear     carb
## 4 0.7272727 4.090909 1.545455
## 6 0.4285714 3.857143 3.428571
## 8 0.1428571 3.285714 3.500000
```
