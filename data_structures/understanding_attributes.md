---
layout: tutorial
title: Understanding Data Structure Attributes
permalink: /understanding_attributes
---


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
This tutorial only shows you functions to assess these attributes.  In the data structure tutorials that follow, more details are provided on how to view and create attributes for each type of data structure.
