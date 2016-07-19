---
layout: page
title: Data Structure Basics
permalink: /structure_basics
---

> *"Smart data structures and dumb code works a lot better than the other way around"* - Eric S. Raymond

In the prior sections I illustrated how to work with different types of data; however, we primarily focused on data in a one-dimensional structure.  In typical data analyses you often need more than one dimension.  Many datasets can contain variables of different length and or types of values (i.e. numeric vs character).  Furthermore, many statistical and mathematical calculations are based on matrices.  R provides multiple types of data structures to deal with these different needs.

The basic data structures in R can be organized by their dimensionality (1D, 2D, ..., *n*D) and their "likeness" (homogenous vs. heterogeneous).  This results in five data structure types most often used in data analysis; and almost all other objects in R are built from these foundational types:

<p>
<center>
<img src="/public/images/r_vocab/data_structure_types.png" alt="Data Structure Types" vspace="25">
</center>  
</p>

In the data structure tutorials that follow I will cover the basics of these data structures.  But prior to jumping into the data structures, it's beneficial to understand two components of data structures - the structure and attributes.  

- [Identifying the structure](#identify_structure)
- [Understanding attributes](#understanding_attributes)


<br>

## Identifying the Data Structure {#identify_structure}
Given an object, the best way to understand what data structure it represents is to use the structure function `str()`.  `str()` stands for structure and provides a compact display of the internal **str**ucture of an R object.


```r
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
```

<br>

## Understanding Attributes {#understanding_attributes}
R objects can have attributes, which are like metadata for the object. These metadata can be very useful in that they help to describe the object. For example, column names on a data frame help to tell us what data are contained in each of the columns. Some examples of R object attributes are:

* names, dimnames
* dimensions (e.g. matrices, arrays)
* class (e.g. integer, numeric)
* length
* other user-defined attributes/metadata

Attributes of an object (if any) can be accessed using the `attributes()` function. Not all R objects contain attributes, in which case the `attributes()` function returns NULL.


```r
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
```
This tutorial only shows you functions to assess these attributes.  In the other data structure tutorials, more details are provided on how to view and create attributes for each type of data structure.


