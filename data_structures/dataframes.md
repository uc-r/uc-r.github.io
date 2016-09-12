---
layout: page
title: Managing Data Frames
permalink: /dataframes
---

A data frame is the most common way of storing data in R and, generally, is the data structure most often used for data analyses. Under the hood, a data frame is a list of equal-length vectors. Each element of the list can be thought of as a column and the length of each element of the list is the number of rows. As a result, data frames can store different classes of objects in each column (i.e. numeric, character, factor). In essence, the easiest way to think of a data frame is as an Excel worksheet that contains columns of different types of data but are all of equal length rows.  In this section you will learn how to perform basic operations with a data frame to include:

* [Creating data frames](#creating_dataframes)
* [Adding on to data frames](#dataframes_adding)
* [Adding attributes to data frames](#dataframes_attributes)
* [Subsetting data frames](#dataframes_subsetting)

<br>

## Creating Data Frames {#creating_dataframes}
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

<br>

## Adding on to Data Frames {#dataframes_adding}
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
There are better ways to join data frames together than to use `cbind()` and `rbind()`.  These are covered later on in the transforming your data with [`dplyr` tutorial](http://uc-r.github.io/dplyr).


<br>

## Adding Attributes to Data Frames {#dataframes_attributes}
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


<br>

## Subsetting Data Frames {#dataframes_subsetting}
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


You can also subset data frames based on conditional statements.  To illustrate we'll use the built-in `mtcars` data frame:


```r
head(mtcars)
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

If we want to subset `mtcars` for all rows where `mpg` is greater than 20 we can perform this in two ways:


```r
# using brackets
mtcars[mtcars$mpg > 20, ]
##                 mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4      21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag  21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710     22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive 21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## Merc 240D      24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
## Merc 230       22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## Fiat 128       32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
## Honda Civic    30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
## Toyota Corolla 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
## Toyota Corona  21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
## Fiat X1-9      27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
## Porsche 914-2  26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
## Lotus Europa   30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
## Volvo 142E     21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2

# using the simplified subset function
subset(mtcars, mpg > 20)
##                 mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4      21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag  21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710     22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive 21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
## Merc 240D      24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
## Merc 230       22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
## Fiat 128       32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
## Honda Civic    30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
## Toyota Corolla 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
## Toyota Corona  21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
## Fiat X1-9      27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
## Porsche 914-2  26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
## Lotus Europa   30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
## Volvo 142E     21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
```


We can add on to the conditional statement if we want to filter for multiple conditions. You can see how the `subset()` function helps to simplify the process by only requiring you to state the data frame once and then directly call the variables to perform the condition on.


```r
# using brackets
mtcars[mtcars$mpg > 20 & mtcars$cyl == 6, ]
##                 mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4      21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag  21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Hornet 4 Drive 21.4   6  258 110 3.08 3.215 19.44  1  0    3    1

# using the simplified subset function
subset(mtcars, mpg > 20 & cyl == 6)
##                 mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4      21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag  21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Hornet 4 Drive 21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
```

And if we want to perform this filtering along with return only specified columns we simply state the columns we want to return.


```r
# using brackets
mtcars[mtcars$mpg > 20 & mtcars$cyl == 6, c("mpg", "cyl", "wt")]
##                 mpg cyl    wt
## Mazda RX4      21.0   6 2.620
## Mazda RX4 Wag  21.0   6 2.875
## Hornet 4 Drive 21.4   6 3.215

# using the simplified subset function
subset(mtcars, mpg > 20 & cyl == 6, c("mpg", "cyl", "wt"))
##                 mpg cyl    wt
## Mazda RX4      21.0   6 2.620
## Mazda RX4 Wag  21.0   6 2.875
## Hornet 4 Drive 21.4   6 3.215
```

[^preserve_simplify]: Its important to understand the difference between simplifying and preserving subsetting.  **Simplifying** subsets returns the simplest possible data structure that can represent the output. **Preserving** subsets keeps the structure of the output the same as the input.  See Hadley Wickham's section on [Simplifying vs. Preserving Subsetting](http://adv-r.had.co.nz/Subsetting.html#subsetting-operators) to learn more.
