---
layout: tutorial
title: Subsetting Data Frames
permalink: /dataframes_subsetting
---

Data frames possess the characteristics of both lists and matrices: if you subset with a single vector, they behave like lists and will return the selected columns with all rows; if you subset with two vectors, they behave like matrices and can be subset by row and column:


```r
df
##      col.1 col.2 col.3    col.4
## row1     1  this  TRUE 2.500000
## row2     2    is FALSE 4.200000
## row3     3  text  TRUE 3.141593

# subsetting by row numbers
df[2:3, ]
##      col.1 col.2 col.3    col.4
## row2     2    is FALSE 4.200000
## row3     3  text  TRUE 3.141593

# subsetting by row names
df[c("row2", "row3"), ]
##      col.1 col.2 col.3    col.4
## row2     2    is FALSE 4.200000
## row3     3  text  TRUE 3.141593

# subsetting columns like a list
df[c("col.2", "col.4")]
##      col.2    col.4
## row1  this 2.500000
## row2    is 4.200000
## row3  text 3.141593

# subsetting columns like a matrix
df[ , c("col.2", "col.4")]
##      col.2    col.4
## row1  this 2.500000
## row2    is 4.200000
## row3  text 3.141593

# subset for both rows and columns
df[1:2, c(1, 3)]
##      col.1 col.3
## row1     1  TRUE
## row2     2 FALSE

# use a vector to subset
v <- c(1, 2, 4)
df[ , v]
##      col.1 col.2    col.4
## row1     1  this 2.500000
## row2     2    is 4.200000
## row3     3  text 3.141593
```

Note that subsetting data frames with the `[` operator will simplify[^preserve_simplify] the results to the lowest possible dimension.  To avoid this you can introduce the `drop = FALSE` argument:


```r
# simplifying results in a named vector
df[, 2]
## [1] "this" "is"   "text"

# preserving results in a 3x1 data frame
df[, 2, drop = FALSE]
##      col.2
## row1  this
## row2    is
## row3  text
```

[^preserve_simplify]: Its important to understand the difference between simplifying and preserving subsetting.  **Simplifying** subsets returns the simplest possible data structure that can represent the output. **Preserving** subsets keeps the structure of the output the same as the input.  See Hadley Wickham's section on [Simplifying vs. Preserving Subsetting](http://adv-r.had.co.nz/Subsetting.html#subsetting-operators) to learn more.
