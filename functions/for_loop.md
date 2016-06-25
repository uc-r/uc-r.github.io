---
layout: tutorial
title: <code>for</code> Loop
permalink: /for_loop
---

The `for` loop is used to execute repetitive code statements for a particular number of times.  The general syntax is provided below where `i` is the counter and as `i` assumes each sequential value defined (1 through 100 in this example) the code in the body will be performed for that ith value.


```r
# syntax of for loop
for(i in 1:100) {
        <do stuff here with i>
}
```

An important lesson to learn is that R is not efficient at *growing* data objects.  As a result, it is more efficient to create an empty data object and *fill* it with the `for` loop outputs.  For example, if you want to create a vector in which 5 values are randomly drawn from a poisson distribution with mean 5, it is less efficient to perform the first example in the following code chunk than to perform the second example.  Although this inefficiency is not noticed in this small example, when you perform larger repetitions it will become noticable so you might as well get in the habit of *filling* rather than *growing*. 


```r
# not advised
for(i in 5){
        x <- rpois(5, lambda = 5)
        print(x)
}
## [1] 11  5  8  8  7

# advised
x <- vector(mode = "numeric", length = 5)

for(i in 5){
        x <- rpois(5, lambda = 5)
        print(x)
}
## [1] 5 8 9 5 4
```

Another example in which we create an empty matrix with 5 rows and 5 columns.  The `for` loop then iterates over each column (note how *i* takes on the values 1 through the number of columns in the `my.mat` matrix) and takes a random draw of 5 values from a poisson distribution with mean *i* in column *i*:


```r
my.mat <- matrix(NA, nrow = 5, ncol = 5)

for(i in 1:ncol(my.mat)){
        my.mat[, i] <- rpois(5, lambda = i)
}
my.mat
##      [,1] [,2] [,3] [,4] [,5]
## [1,]    0    2    1    7    1
## [2,]    1    2    2    3    9
## [3,]    2    1    5    6    6
## [4,]    2    1    5    2   10
## [5,]    0    2    2    2    4
```
