---
layout: page
title: Managing Matrices
permalink: /matrices
---

A matrix is a collection of data elements arranged in a two-dimensional rectangular layout.  In R, the elements that make up a matrix must be of a consistant mode (i.e. all elements must be numeric, or character, etc.).  Therefore, a matrix can be thought of as an atomic vector with a dimension attribute.  Furthermore, all rows of a matrix must be of same length.  In this section we cover the basics of managing matrices to include:

* [Creating matrices](#creating_matrices)
* [Adding on to matrices](#matrices_adding)
* [Adding attributes to matrices](#matrices_attributes)
* [Subsetting matrices](#matrices_subsetting)

<br>

## Creating Matrices {#creating_matrices}
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

<br>

## Adding on to Matrices {#matrices_adding}
We can leverage the `cbind()` and `rbind()` functions for adding onto matrices as well.  Again, its important to keep in mind that the vectors that are being binded must be of equal length and mode to the pre-existing matrix.


```r
m1 <- cbind(v1, v2)
m1
##      v1 v2
## [1,]  1  5
## [2,]  2  6
## [3,]  3  7
## [4,]  4  8

# add a new column
cbind(m1, v3)
##      v1 v2 v3
## [1,]  1  5  9
## [2,]  2  6 10
## [3,]  3  7 11
## [4,]  4  8 12

# or add a new row
rbind(m1, c(4.1, 8.1))
##       v1  v2
## [1,] 1.0 5.0
## [2,] 2.0 6.0
## [3,] 3.0 7.0
## [4,] 4.0 8.0
## [5,] 4.1 8.1
```

<br>

## Adding Attributes to Matrices {#matrices_attributes}
As previously mentioned, matrices by default will have a dimension attribute as illustrated in the following matrix `m2`.


```r
# basic matrix
m2 <- matrix(1:12, nrow = 4, ncol = 3)

m2
##      [,1] [,2] [,3]
## [1,]    1    5    9
## [2,]    2    6   10
## [3,]    3    7   11
## [4,]    4    8   12

# the dimension attribute shows this matrix has 4 rows and 3 columns
attributes(m2)
## $dim
## [1] 4 3
```

However, matrices can also have additional attributes such as row names, column names, and comments. Adding names can be done individually, meaning we can add row names or column names separately.


```r
# add row names as an attribute
rownames(m2) <- c("row1", "row2", "row3", "row4")

m2
##      [,1] [,2] [,3]
## row1    1    5    9
## row2    2    6   10
## row3    3    7   11
## row4    4    8   12

# attributes displayed will now show the dimension, list the row names
# and will show the column names as NULL
attributes(m2)
## $dim
## [1] 4 3
## 
## $dimnames
## $dimnames[[1]]
## [1] "row1" "row2" "row3" "row4"
## 
## $dimnames[[2]]
## NULL

# add column names
colnames(m2) <- c("col1", "col2", "col3")
m2
##      col1 col2 col3
## row1    1    5    9
## row2    2    6   10
## row3    3    7   11
## row4    4    8   12

attributes(m2)
## $dim
## [1] 4 3
## 
## $dimnames
## $dimnames[[1]]
## [1] "row1" "row2" "row3" "row4"
## 
## $dimnames[[2]]
## [1] "col1" "col2" "col3"
```

Another option is to use the `dimnames()` function. To add row names you assign the names to `dimnames(m2)[[1]]` and to add column names you assign the names to `dimnames(m2)[[2]]`.


```r
dimnames(m2)[[1]] <- c("row_1", "row_2", "row_3", "row_4")
m2
##       col1 col2 col3
## row_1    1    5    9
## row_2    2    6   10
## row_3    3    7   11
## row_4    4    8   12

# column names are contained in the second list item
dimnames(m2)[[2]] <- c("col_1", "col_2", "col_3")
m2
##       col_1 col_2 col_3
## row_1     1     5     9
## row_2     2     6    10
## row_3     3     7    11
## row_4     4     8    12
```


Lastly, similar to lists and vectors you can add a comment attribute to a list.


```r
comment(m2) <- "adding a comment to a matrix"

attributes(m2)
## $dim
## [1] 4 3
## 
## $dimnames
## $dimnames[[1]]
## [1] "row_1" "row_2" "row_3" "row_4"
## 
## $dimnames[[2]]
## [1] "col_1" "col_2" "col_3"
## 
## 
## $comment
## [1] "adding a comment to a matrix"
```


<br>

## Subsetting Matrices {#matrices_subsetting}
To subset matrices we use the `[` operator; however, since matrices have 2 dimensions we need to incorporate subsetting arguments for both row and column dimensions.  A generic form of matrix subsetting looks like: `matrix[rows, columns]`.  We can illustrate with matrix `m2`:


```r
m2
##       col_1 col_2 col_3
## row_1     1     5     9
## row_2     2     6    10
## row_3     3     7    11
## row_4     4     8    12
```

By using different values in the `rows` and `columns` argument of `m2[rows, columns]`, we can subset `m2` in multiple ways.


```r
# subset for rows 1 and 2 but keep all columns
m2[1:2, ]
##       col_1 col_2 col_3
## row_1     1     5     9
## row_2     2     6    10

# subset for columns 1 and 3 but keep all rows
m2[ , c(1, 3)]
##       col_1 col_3
## row_1     1     9
## row_2     2    10
## row_3     3    11
## row_4     4    12

# subset for both rows and columns
m2[1:2, c(1, 3)]
##       col_1 col_3
## row_1     1     9
## row_2     2    10

# use a vector to subset
v <- c(1, 2, 4)
m2[v, c(1, 3)]
##       col_1 col_3
## row_1     1     9
## row_2     2    10
## row_4     4    12

# use names to subset
m2[c("row_1", "row_3"), ]
##       col_1 col_2 col_3
## row_1     1     5     9
## row_3     3     7    11
```

Note that subsetting matrices with the `[` operator will simplify[^preserve_simplify] the results to the lowest possible dimension.  To avoid this you can introduce the `drop = FALSE` argument:


```r
# simplifying results in a named vector
m2[, 2]
## row_1 row_2 row_3 row_4 
##     5     6     7     8

# preserving results in a 4x1 matrix
m2[, 2, drop = FALSE]
##       col_2
## row_1     5
## row_2     6
## row_3     7
## row_4     8
```

[^preserve_simplify]: Its important to understand the difference between simplifying and preserving subsetting.  **Simplifying** subsets returns the simplest possible data structure that can represent the output. **Preserving** subsets keeps the structure of the output the same as the input.  See Hadley Wickham's section on [Simplifying vs. Preserving Subsetting](http://adv-r.had.co.nz/Subsetting.html#subsetting-operators) to learn more.
