---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Data Structures](data_structures) &#187; Matrix


<br>

* <a href="#creating">Creating</a>
* <a href="#adding">Adding on to</a>
* <a href="#attributes">Adding attributes</a>
* <a href="#subsetting">Subsetting</a>

<br>

<a name="creating"></a>

# Creating
Matrices are simply vectors with a dimension attribute.  Matrices are constructed column-wise, so entries can be thought of starting in the “upper left” corner and running down the columns.  We can create a matrix using the `matrix()` function:

{% highlight r %}
# numeric matrix
m1 <- matrix(1:6, nrow = 2, ncol = 3)
m1
##      [,1] [,2] [,3]
## [1,]    1    3    5
## [2,]    2    4    6

# structure of m1 is simply integer vector with an added
# dimension attribute
str(m1)
##  int [1:2, 1:3] 1 2 3 4 5 6
attributes(m1)
## $dim
## [1] 2 3

# can also create a character matrix
m2 <- matrix(letters[1:6], nrow = 2, ncol = 3)
m2
##      [,1] [,2] [,3]
## [1,] "a"  "c"  "e" 
## [2,] "b"  "d"  "f"

# structure of m2 is simply character vector with dimensions
str(m2)
##  chr [1:2, 1:3] "a" "b" "c" "d" "e" "f"
attributes(m2)
## $dim
## [1] 2 3
{% endhighlight %}

Matrices can also be created using the column-bind `cbind()` and row-bind `rbind()` functions:

{% highlight r %}
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
{% endhighlight %}


<br>

<a name="adding"></a>

# Adding on to
We can leverage the `cbind()` and `rbind()` functions for adding onto matrices as well:

{% highlight r %}
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
{% endhighlight %}



<br>

<a name="attributes"></a>

# Adding attributes
As previously mentioned, matrices by default will have a dimension attribute.  However, matrices can also have additional attributes such as row names, column names, and comments:

{% highlight r %}
# basic matrix
m2 <- matrix(1:12, nrow = 4, ncol = 3)
m2
##      [,1] [,2] [,3]
## [1,]    1    5    9
## [2,]    2    6   10
## [3,]    3    7   11
## [4,]    4    8   12
attributes(m2)
## $dim
## [1] 4 3

# add row names
rownames(m2) <- c("row1", "row2", "row3", "row4")
m2
##      [,1] [,2] [,3]
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

# another option is to use the `dimnames()` function
# row names are contained in the first list item
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

# adding a comment attribute
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
{% endhighlight %}

<br>

<a name="subsetting"></a>

# Subsetting
To subset matrices we use the `[` operator; however, since matrices have 2 dimensions we need to incorporate subsetting arguments for both dimensions.  A generic form of matrix subsetting looks like: `matrix[rows, columns]`.  The primary differences in matrix subsetting is what we use for the 'rows' and 'columns' arguments.

{% highlight r %}
m2
##       col_1 col_2 col_3
## row_1     1     5     9
## row_2     2     6    10
## row_3     3     7    11
## row_4     4     8    12

# subset for rows 1 and 2 but get all columns
m2[1:2, ]
##       col_1 col_2 col_3
## row_1     1     5     9
## row_2     2     6    10

# subset for columns 1 and 3 but get all rows
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
{% endhighlight %}

Note that subsetting matrices with the`[` operator will simplify<sup><a href="#fn1" id="ref1">1</a></sup> the results to the lowest possible dimension.  To avoid this you can introduce the `drop = FALSE` argument:

{% highlight r %}
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
{% endhighlight %}

<br>

<small><a href="#">Go to top</a></small>

<br>

<P CLASS="footnote" style="line-height:0.75">
<sup id="fn1">1. Its also important to understand the difference between simplifying and preserving subsetting.  <em>Simplifying</em> subsets returns the simplest possible data structure that can represent the output. <em>Preserving</em> subsets keeps the structure of the output the same as the input.  See Hadley Wickham's section on <a href="http://adv-r.had.co.nz/Subsetting.html#subsetting-operators">Simplifying vs. Preserving Subsetting</a> to learn more.<a href="#ref1" title="Jump back to footnote 1 in the text.">"&#8617;"</a><sup>
</P>
