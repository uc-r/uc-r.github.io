---
layout: tutorial
title: Creating Data Frames
permalink: /creating_dataframes
---

Data frames are usually created by reading in a dataset using the `read.table()` or `read.csv()`; this will be covered in the importing and scraping data tutorials. However, data frames can also be created explicitly with the `data.frame()` function or they can be coerced from other types of objects like lists. In this case I'll create a simple data frame `df` and assess its basic structure:


```r
df <- data.frame(col1 = 1:3, 
                 col2 = c("this", "is", "text"), 
                 col3 = c(TRUE, FALSE, TRUE), 
                 col4 = c(2.5, 4.2, pi))

# assess the structure of a data frame
str(df)
## 'data.frame':	3 obs. of  4 variables:
##  $ col1: int  1 2 3
##  $ col2: Factor w/ 3 levels "is","text","this": 3 1 2
##  $ col3: logi  TRUE FALSE TRUE
##  $ col4: num  2.5 4.2 3.14

# number of rows
nrow(df)
## [1] 3

# number of columns
ncol(df)
## [1] 4
```

Note how `col2` in `df` was converted to a column of factors.  This is because there is a default setting in `data.frame()` that converts character columns to factors.  We can turn this off by setting the `stringsAsFactors = FALSE` argument:


```r
df <- data.frame(col1 = 1:3, 
                 col2 = c("this", "is", "text"), 
                 col3 = c(TRUE, FALSE, TRUE), 
                 col4 = c(2.5, 4.2, pi), 
                 stringsAsFactors = FALSE)

# note how col2 now is of a character class
str(df)
## 'data.frame':	3 obs. of  4 variables:
##  $ col1: int  1 2 3
##  $ col2: chr  "this" "is" "text"
##  $ col3: logi  TRUE FALSE TRUE
##  $ col4: num  2.5 4.2 3.14
```

We can also convert pre-existing structures to a data frame.  The following illustrates how we can turn multiple vectors, a list, or a matrix into a data frame:


```r
v1 <- 1:3
v2 <-c("this", "is", "text")
v3 <- c(TRUE, FALSE, TRUE)

# convert same length vectors to a data frame using data.frame()
data.frame(col1 = v1, col2 = v2, col3 = v3)
##   col1 col2  col3
## 1    1 this  TRUE
## 2    2   is FALSE
## 3    3 text  TRUE

# convert a list to a data frame using as.data.frame()
l <- list(item1 = 1:3, item2 = c("this", "is", "text"), item3 = c(2.5, 4.2, 5.1))
l
## $item1
## [1] 1 2 3
## 
## $item2
## [1] "this" "is"   "text"
## 
## $item3
## [1] 2.5 4.2 5.1

as.data.frame(l)
##   item1 item2 item3
## 1     1  this   2.5
## 2     2    is   4.2
## 3     3  text   5.1

# convert a matrix to a data frame using as.data.frame()
m1 <- matrix(1:12, nrow = 4, ncol = 3)
m1
##      [,1] [,2] [,3]
## [1,]    1    5    9
## [2,]    2    6   10
## [3,]    3    7   11
## [4,]    4    8   12

as.data.frame(m1)
##   V1 V2 V3
## 1  1  5  9
## 2  2  6 10
## 3  3  7 11
## 4  4  8 12
```
