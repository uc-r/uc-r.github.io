---
layout: tutorial
title: Adding Attributes to Data Frames
permalink: /dataframes_attributes
---

Similar to matrices, data frames will have a dimension attribute.  In addition, data frames can also have additional attributes such as row names, column names, and comments. We can illustrate with data frame `df`.


```r
# basic matrix
df
##   col1 col2  col3     col4
## 1    1 this  TRUE 2.500000
## 2    2   is FALSE 4.200000
## 3    3 text  TRUE 3.141593

dim(df)
## [1] 3 4

attributes(df)
## $names
## [1] "col1" "col2" "col3" "col4"
## 
## $row.names
## [1] 1 2 3
## 
## $class
## [1] "data.frame"
```

Currently `df` does not have row names but we can add them with `rownames()`:


```r
# add row names
rownames(df) <- c("row1", "row2", "row3")

df
##      col1 col2  col3     col4
## row1    1 this  TRUE 2.500000
## row2    2   is FALSE 4.200000
## row3    3 text  TRUE 3.141593

attributes(df)
## $names
## [1] "col1" "col2" "col3" "col4"
## 
## $row.names
## [1] "row1" "row2" "row3"
## 
## $class
## [1] "data.frame"
```

We can also also change the existing column names by using `colnames()` or `names()`:


```r
# add/change column names with colnames()
colnames(df) <- c("col_1", "col_2", "col_3", "col_4")

df
##      col_1 col_2 col_3    col_4
## row1     1  this  TRUE 2.500000
## row2     2    is FALSE 4.200000
## row3     3  text  TRUE 3.141593

attributes(df)
## $names
## [1] "col_1" "col_2" "col_3" "col_4"
## 
## $row.names
## [1] "row1" "row2" "row3"
## 
## $class
## [1] "data.frame"

# add/change column names with names()
names(df) <- c("col.1", "col.2", "col.3", "col.4")

df
##      col.1 col.2 col.3    col.4
## row1     1  this  TRUE 2.500000
## row2     2    is FALSE 4.200000
## row3     3  text  TRUE 3.141593

attributes(df)
## $names
## [1] "col.1" "col.2" "col.3" "col.4"
## 
## $row.names
## [1] "row1" "row2" "row3"
## 
## $class
## [1] "data.frame"
```

Lastly, just like vectors, lists, and matrices, we can add a comment to a data frame without affecting how it operates.


```r
# adding a comment attribute
comment(df) <- "adding a comment to a data frame"

attributes(df)
## $names
## [1] "col.1" "col.2" "col.3" "col.4"
## 
## $row.names
## [1] "row1" "row2" "row3"
## 
## $class
## [1] "data.frame"
## 
## $comment
## [1] "adding a comment to a data frame"
```
