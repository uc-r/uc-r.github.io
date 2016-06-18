---
layout: tutorial
title: Creating Matrices
permalink: /creating_matrices
---

Matrices are constructed column-wise, so entries can be thought of starting in the "upper left" corner and running down the columns.  We can create a matrix using the `matrix()` function and specifying the values to fill in the matrix and the number of rows and columns to make the matrix.


```r
# numeric matrix
m1 <- matrix(1:6, nrow = 2, ncol = 3)

m1
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6
```

The underlying structure of this matrix is simply an integer vector with an added 2x3 dimension attribute.


```r
str(m1)
##  int [1:2, 1:3] 1 2 3 4 5 6

attributes(m1)
## $dim
## [1] 2 3
```

Matrices can also contain character values. Whether a matrix contains data that are of numeric or character type, all the elements must be of the same class.


```r
# a character matrix
m2 <- matrix(letters[1:6], nrow = 2, ncol = 3)

m2
##      [,1] [,2] [,3]
## [1,] "a"  "c"  "e" 
## [2,] "b"  "d"  "f"

# structure of m2 is simply character vector with 2x3 dimension
str(m2)
##  chr [1:2, 1:3] "a" "b" "c" "d" "e" "f"

attributes(m2)
## $dim
## [1] 2 3
```

Matrices can also be created using the column-bind `cbind()` and row-bind `rbind()` functions.  However, keep in mind that the vectors that are being binded must be of equal length and mode.


```r
v1 <- 1:4
v2 <- 5:8

cbind(v1, v2)
##      v1 v2
## [1,]  1  5
## [2,]  2  6
## [3,]  3  7
## [4,]  4  8

rbind(v1, v2)
##    [,1] [,2] [,3] [,4]
## v1    1    2    3    4
## v2    5    6    7    8

# bind several vectors together
v3 <- 9:12

cbind(v1, v2, v3)
##      v1 v2 v3
## [1,]  1  5  9
## [2,]  2  6 10
## [3,]  3  7 11
## [4,]  4  8 12
```
