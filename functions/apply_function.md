---
layout: tutorial
title: <code>apply</code> Function
permalink: /apply_function
---


The `apply()` function is most often used to apply a function to the rows or columns (margins) of matrices or data frames. However, it can be used with general arrays, for example, to take the average of an array of matrices. Using `apply()` is not faster than using a loop function, but it is highly compact and can be written in one line.

The syntax for `apply()` is as follows where 

- `x` is the matrix, dataframe or array
- `MARGIN` is a vector giving the subscripts which the function will be applied over. E.g., for a matrix 1 indicates rows, 2 indicates columns, c(1, 2) indicates rows and columns.
- `FUN` is the function to be applied
- `...` is for any other arguments to be passed to the function


```r
# syntax of apply function
apply(x, MARGIN, FUN, ...)
```

To provide examples let's use the `mtcars` data set provided in R:


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

# get the mean of each column 
apply(mtcars, 2, mean)
##        mpg        cyl       disp         hp       drat         wt 
##  20.090625   6.187500 230.721875 146.687500   3.596563   3.217250 
##       qsec         vs         am       gear       carb 
##  17.848750   0.437500   0.406250   3.687500   2.812500

# get the sum of each row (not really relevant for this data
# but it illustrates the capability)
apply(mtcars, 1, sum)
##           Mazda RX4       Mazda RX4 Wag          Datsun 710 
##             328.980             329.795             259.580 
##      Hornet 4 Drive   Hornet Sportabout             Valiant 
##             426.135             590.310             385.540 
##          Duster 360           Merc 240D            Merc 230 
##             656.920             270.980             299.570 
##            Merc 280           Merc 280C          Merc 450SE 
##             350.460             349.660             510.740 
##          Merc 450SL         Merc 450SLC  Cadillac Fleetwood 
##             511.500             509.850             728.560 
## Lincoln Continental   Chrysler Imperial            Fiat 128 
##             726.644             725.695             213.850 
##         Honda Civic      Toyota Corolla       Toyota Corona 
##             195.165             206.955             273.775 
##    Dodge Challenger         AMC Javelin          Camaro Z28 
##             519.650             506.085             646.280 
##    Pontiac Firebird           Fiat X1-9       Porsche 914-2 
##             631.175             208.215             272.570 
##        Lotus Europa      Ford Pantera L        Ferrari Dino 
##             273.683             670.690             379.590 
##       Maserati Bora          Volvo 142E 
##             694.710             288.890

# get column quantiles (notice the quantile percents as row names)
apply(mtcars, 2, quantile, probs = c(0.10, 0.25, 0.50, 0.75, 0.90))
##        mpg cyl    disp    hp  drat      wt    qsec vs am gear carb
## 10% 14.340   4  80.610  66.0 3.007 1.95550 15.5340  0  0    3    1
## 25% 15.425   4 120.825  96.5 3.080 2.58125 16.8925  0  0    3    2
## 50% 19.200   6 196.300 123.0 3.695 3.32500 17.7100  0  0    4    2
## 75% 22.800   8 326.000 180.0 3.920 3.61000 18.9000  1  1    4    4
## 90% 30.090   8 396.000 243.5 4.209 4.04750 19.9900  1  1    5    4
```
