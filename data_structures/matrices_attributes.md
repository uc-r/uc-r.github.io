---
layout: tutorial
title: Adding Attributes to Matrices
permalink: /matrices_attributes
---

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
