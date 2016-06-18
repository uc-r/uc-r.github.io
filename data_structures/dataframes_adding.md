---
layout: tutorial
title: Adding on to Data Frames
permalink: /dataframes_adding
---

We can leverage the `cbind()` function for adding columns to a data frame.  Note that one of the objects being combined must already be a data frame otherwise `cbind()` could produce a matrix.


```r
df
##   col1 col2  col3     col4
## 1    1 this  TRUE 2.500000
## 2    2   is FALSE 4.200000
## 3    3 text  TRUE 3.141593

# add a new column
v4 <- c("A", "B", "C")

cbind(df, v4)
##   col1 col2  col3     col4 v4
## 1    1 this  TRUE 2.500000  A
## 2    2   is FALSE 4.200000  B
## 3    3 text  TRUE 3.141593  C
```

We can also use the `rbind()` function to add data frame rows together.  However, severe caution should be taken because this can cause changes in the classes of the columns. For instance, our data frame `df` currently consists of an integer, character, logical, and numeric variables.


```r
df
##   col1 col2  col3     col4
## 1    1 this  TRUE 2.500000
## 2    2   is FALSE 4.200000
## 3    3 text  TRUE 3.141593

str(df)
## 'data.frame':	3 obs. of  4 variables:
##  $ col1: int  1 2 3
##  $ col2: chr  "this" "is" "text"
##  $ col3: logi  TRUE FALSE TRUE
##  $ col4: num  2.5 4.2 3.14
```

If we attempt to add a row using `rbind()` and `c()` it converts all columns to a character class. This is because all elements in the vector created by `c()` must be of the same class so they are all coerced to the character class which coerces all the variables in the data frame to the character class.


```r
df2 <- rbind(df, c(4, "R", F, 1.1))

df2
##   col1 col2  col3             col4
## 1    1 this  TRUE              2.5
## 2    2   is FALSE              4.2
## 3    3 text  TRUE 3.14159265358979
## 4    4    R FALSE              1.1

str(df2)
## 'data.frame':	4 obs. of  4 variables:
##  $ col1: chr  "1" "2" "3" "4"
##  $ col2: chr  "this" "is" "text" "R"
##  $ col3: chr  "TRUE" "FALSE" "TRUE" "FALSE"
##  $ col4: chr  "2.5" "4.2" "3.14159265358979" "1.1"
```

To add rows appropriately, we need to convert the items being added to a data frame and make sure the columns are the same class as the original data frame.


```r
adding_df <- data.frame(col1 = 4, col2 = "R", col3 = FALSE, col4 = 1.1, 
                 stringsAsFactors = FALSE)

df3 <- rbind(df, adding_df)

df3
##   col1 col2  col3     col4
## 1    1 this  TRUE 2.500000
## 2    2   is FALSE 4.200000
## 3    3 text  TRUE 3.141593
## 4    4    R FALSE 1.100000

str(df3)
## 'data.frame':	4 obs. of  4 variables:
##  $ col1: num  1 2 3 4
##  $ col2: chr  "this" "is" "text" "R"
##  $ col3: logi  TRUE FALSE TRUE FALSE
##  $ col4: num  2.5 4.2 3.14 1.1
```
There are better ways to join data frames together than to use `cbind()` and `rbind()`.  These are covered later on in the transforming your data with `dplyr` tutorial.

