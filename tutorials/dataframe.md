---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Data Structures](data_structures) &#187; Data frame

<br>

A data frame is the most common way of storing data in R and, generally, is the data structure most often used for data analyses.  Under the hood, a data frame is a list of equal-length vectors.  Each element of the list can be thought of as a column and the length of each element of the list is the number of rows.  As a result, data frames can store different classes of objects in each column (i.e. numeric, character, factor).  This tutorial provides you with the basics for managing data frames.

* <a href="#creating">Creating</a>
* <a href="#adding">Adding on to</a>
* <a href="#attributes">Adding attributes</a>
* <a href="#subsetting">Subsetting</a>

<br>

<a name="creating"></a>

# Creating
Data frames are usually created by reading in a dataset using the `read.table()` or `read.csv()`. However, data frames can also be created explicitly with the `data.frame()` function or they can be coerced from other types of objects like lists:

{% highlight r %}
df <- data.frame(col1 = 1:3, 
                 col2 = c("this", "is", "text"), 
                 col3 = c(TRUE, FALSE, TRUE), 
                 col4 = c(2.5, 4.2, pi))

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
{% endhighlight %}

Note how col2 in 'df' was converted to a column of factors.  This is because their is a default setting in `data.frame()` that converts character columns to factors.  We can turn this off by setting the `stringsAsFactors = FALSE` argument:


{% highlight r %}
df <- data.frame(col1 = 1:3, 
                 col2 = c("this", "is", "text"), 
                 col3 = c(TRUE, FALSE, TRUE), 
                 col4 = c(2.5, 4.2, pi), 
                 stringsAsFactors = FALSE)

str(df)
## 'data.frame':	3 obs. of  4 variables:
##  $ col1: int  1 2 3
##  $ col2: chr  "this" "is" "text"
##  $ col3: logi  TRUE FALSE TRUE
##  $ col4: num  2.5 4.2 3.14
{% endhighlight %}

We can also convert items to a data frame:

{% highlight r %}
v1 <- 1:3
v2 <-c("this", "is", "text")
v3 <- c(TRUE, FALSE, TRUE)

# convert same length vectors to a data frame
data.frame(col1 = v1, col2 = v2, col3 = v3)
##   col1 col2  col3
## 1    1 this  TRUE
## 2    2   is FALSE
## 3    3 text  TRUE

# convert a list to a data frame
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

# convert a matrix to a data frame
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
{% endhighlight %}

<br>

<a name="adding"></a>

# Adding on to
We can leverage the `cbind()` function for adding columns to a data frame.  Note that one of the objects being combined must already be a data frame otherwise `cbind()` could produce a matrix.

{% highlight r %}
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
{% endhighlight %}

We can also use the `rbind()` function to add data frame rows together.  However, severe caution should be taken because this can cause changes in the classes of the columns:

{% highlight r %}
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

# if we attempt to add a row using the c() function it converts all columns
# to a character class
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

# to add rows on, we need to convert the items being added to a data frame
# and make sure the columns are the same class as the original data frame
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
{% endhighlight %}
&#9755; *There are better ways to join data frames together than to use `cbind()` and `rbind()`.  These are covered in the `dplyr` section in Data Wrangling.*

<br>

<a name="attributes"></a>

# Adding attributes
Similar to matrices, data frames will have a dimension attribute.  In addition, data frames can also have additional attributes such as row names, column names, and comments:

{% highlight r %}
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

# add column names
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

# can also change column names with the `names()` function
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
{% endhighlight %}

<br>

<a name="subsetting"></a>

# Subsetting
Data frames possess the characteristics of both lists and matrices: if you subset with a single vector, they behave like lists; if you subset with two vectors, they behave like matrices:

{% highlight r %}
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
{% endhighlight %}

Note that subsetting data frames with the`[` operator will simplify<sup><a href="#fn1" id="ref1">1</a></sup> the results to the lowest possible dimension.  To avoid this you can introduce the `drop = FALSE` argument:

{% highlight r %}
# simplifying results in a named vector
df[, 2]
## [1] "this" "is"   "text"

# preserving results in a 3x1 data frame
df[, 2, drop = FALSE]
##      col.2
## row1  this
## row2    is
## row3  text
{% endhighlight %}

<br>

<small><a href="#">Go to top</a></small>

<br>
<P CLASS="footnote" style="line-height:0.75">
<sup id="fn1">1. Its important to understand the difference between simplifying and preserving subsetting.  **Simplifying** subsets returns the simplest possible data structure that can represent the output. **Preserving** subsets keeps the structure of the output the same as the input.  See Hadley Wickham's section on <a href="http://adv-r.had.co.nz/Subsetting.html#subsetting-operators">Simplifying vs. Preserving Subsetting</a> to learn more.<a href="#ref1" title="Jump back to footnote 1 in the text.">"&#8617;"</a><sup>
</P>
