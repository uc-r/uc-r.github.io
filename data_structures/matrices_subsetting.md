---
layout: tutorial
title: Subsetting Matrices
permalink: /matrices_subsetting
---

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
