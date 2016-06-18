---
layout: tutorial
title: Identifying the Structure
permalink: /identify_structure
---


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
