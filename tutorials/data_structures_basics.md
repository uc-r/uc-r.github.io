---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Data Structures](data_structures) &#187; Basics

<br>

* <a href="#types">Data structure types</a>
* <a href="#structure">Identify the structure</a>
* <a href="#attributes">Attributes</a>

<br>

<a name="types"></a>

# Data Structure Types
The basic data structures in R can be organized by their dimensionality (1D, 2D, ..., *n*D) and their "likeness" (homogenous vs. heterogeneous).  This results in five data structure types most often used in data analysis; and almost all other objects in R are built from these foundational types:

<center>
<img src="/public/images/r_vocab/data_structure_types.png" alt="Data Structure Types" vspace="25">
</center>  

I have not had the need to use multi-dimensional arrays, therefore, the topics I will go into details on will include the vector, list, matrix, and data frame.  These types represent the most commonly used data structures for day-to-day analyses.

<br>

<a name="structure"></a>

# Identifying the Structure
Given an object, the best way to understand what data structure it is composed of is to use the structure function `str()`:

{% highlight r %}
# different data structures
vector <- 1:10
list <- list(item1 = 1:10, item2 = LETTERS[1:18])
matrix <- matrix(1:12, nrow = 4)   
df <- data.frame(item1 = 1:18, item2 = LETTERS[1:18])

# identify the structure of each object
str(vector)
##  int [1:10] 1 2 3 4 5 6 7 8 9 10

str(list)
## List of 2
##  $ item1: int [1:10] 1 2 3 4 5 6 7 8 9 10
##  $ item2: chr [1:18] "A" "B" "C" "D" ...

str(matrix)
##  int [1:4, 1:3] 1 2 3 4 5 6 7 8 9 10 ...

str(df)
## 'data.frame':	18 obs. of  2 variables:
##  $ item1: int  1 2 3 4 5 6 7 8 9 10 ...
##  $ item2: Factor w/ 18 levels "A","B","C","D",..: 1 2 3 4 5 6 7 8 9 10 ...
{% endhighlight %}

<br>

<a name="attribures"></a>

# Attributes
R objects can have attributes, which are like metadata for the object. These metadata can be very useful in that they help to describe the object. For example, column names on a data frame help to tell us what data are contained in each of the columns. Some examples of R object attributes are:

* names, dimnames
* dimensions (e.g. matrices, arrays)
* class (e.g. integer, numeric)
* length
* other user-defined attributes/metadata

Attributes of an object (if any) can be accessed using the `attributes()` function. Not all R objects contain attributes, in which case the `attributes()` function returns NULL.


{% highlight r %}
# assess attributes of an object
attributes(df)
## $names
## [1] "item1" "item2"
## 
## $row.names
##  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18
## 
## $class
## [1] "data.frame"

attributes(matrix)
## $dim
## [1] 4 3

# assess names of an object
names(df)
## [1] "item1" "item2"

# assess the dimensions of an object
dim(matrix)
## [1] 4 3

# assess the class of an object
class(list)
## [1] "list"

# access the length of an object
length(vector)
## [1] 10

# note that length will measure the number of items in
# a list or number of columns in a data frame
length(list)
## [1] 2

length(df)
## [1] 2
{% endhighlight %}
&#9755; *This section only shows you functions to assess these attributes.  More details are provided on how to create attributes within each data structure type page.*


<br>

<small><a href="#">Go to top</a></small>




