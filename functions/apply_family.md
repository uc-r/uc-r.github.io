---
layout: page
title: Apply Family
permalink: /apply_family
---

The apply family consists of vectorized functions which minimize your need to explicitly create loops. These functions will apply a specified function to a data object and their primary difference is in the object class in which the function is applied to (list vs. matrix, etc) and the object class that will be returned from the function. The following presents the most common forms of apply functions that I use for data analysis but realize that additional functions exist (`mapply`, `rapply`, & `vapply`) which are not covered here.

- [`apply()`](#apply_function) for matrices and data frames
- [`lapply()`](#lapply_function) for lists…output as list
- [`sapply()`](#sapply_function) for lists…output simplified
- [`tapply()`](#tapply_function) for vectors
- Other useful ["apply-like" functions](#loop_like)

<br>

## `apply()` Function {#apply_function}
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

<br>

## `lapply()` Function {#lapply_function}
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

<br>

## `sapply()` Function {#sapply_function}
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


<br>

## `tapply()` Function {#tapply_function}
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


<br>

## Other Useful "apply-like" Functions {#loop_like}
In addition to the [`apply` family](#apply_family) which provide vectorized functions that minimize your need to explicitly create loops, there are also a few commonly applied `apply` functions that have been further simplified.  These include the calculation of column and row sums, means, medians, standard deviations, variances, and summary quantiles across the entire data set.

The most common apply functions that have been include calculating the sums and means of columns and rows.  For instance, to calculate the sum of columns across a data frame or matrix you could do the following:


```r

# illustrate with the mtcars data set
head(mtcars)
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1

apply(mtcars, 2, sum)
##      mpg      cyl     disp       hp     drat       wt     qsec       vs 
##  642.900  198.000 7383.100 4694.000  115.090  102.952  571.160   14.000 
##       am     gear     carb 
##   13.000  118.000   90.000
```

However, you can perform the same function with the shorter `colSums()` function, plus it performs faster:


```r
colSums(mtcars)
##      mpg      cyl     disp       hp     drat       wt     qsec       vs 
##  642.900  198.000 7383.100 4694.000  115.090  102.952  571.160   14.000 
##       am     gear     carb 
##   13.000  118.000   90.000
```

To illustrate the speed difference we can compare the performance of using the `apply()` function versus the `colSums()` function on a matrix with 100 million values (10K x 10K).  You can see that the speed of `colSums()` is significantly faster.


```r
# develop a 10,000 x 10,000 matrix
mat = matrix(sample(1:10, size=100000000, replace=TRUE), nrow=10000)

system.time(apply(mat, 2, sum))
##    user  system elapsed 
##   1.544   0.329   1.879

system.time(colSums(mat))
##    user  system elapsed 
##   0.126   0.000   0.127
```

Base R provides the following simplified `apply` functions:

* `colSums (x, na.rm = FALSE)`
* `rowSums (x, na.rm = FALSE)`
* `colMeans(x, na.rm = FALSE)`
* `rowMeans(x, na.rm = FALSE)`

In addition, the following functions are provided through the specified packages:

* [`miscTools` package](https://cran.r-project.org/web/packages/mixtools/index.html) (note that these functions will work on data frames)
    * `colMedians()` 
    * `rowMedians()` 
* [`matrixStats` package](https://cran.r-project.org/web/packages/matrixStats/index.html) (note that these functions only operate on matrices)
    * `colMedians()` & `rowMedians()`
    * `colSds()` & `rowSds()`
    * `colVar()` & `rowVar()`
    * `colRanges()` & `rowRanges()`
    *  `colQuantiles()` & `rowQuantiles()`
    * along with several additional summary statistic functions
  
In addition, the `summary()` function will provide relevant summary statistics over each column of data frames and matrices.  Note in the the example that follows that for the first four columns of the `iris` data set the summary statistics include min, med, mean, max, and 1st & 3rd quantiles.  Whereas the last column (`Species`) only provides the total count since this is a factor variable.


```r
summary(iris)
##   Sepal.Length    Sepal.Width     Petal.Length    Petal.Width  
##  Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100  
##  1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300  
##  Median :5.800   Median :3.000   Median :4.350   Median :1.300  
##  Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199  
##  3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800  
##  Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500  
##        Species  
##  setosa    :50  
##  versicolor:50  
##  virginica :50  

```
