---
layout: tutorial
title: Other Useful "Apply-like" Functions
permalink: /loop_like
---

In addition to the [`apply` family](http://uc-r.github.io/apply_family) which provide vectorized functions that minimize your need to explicitly create loops, there are also a few commonly applied `apply` functions that have been further simplified.  These include the calculation of column and row sums, means, medians, standard deviations, variances, and summary quantiles across the entire data set.

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
