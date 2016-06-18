---
layout: tutorial
title: Creating Vectors
permalink: /creating_vectors
---

There are four main ways to create a vector: `:, c(), seq(), rep()`. The colon `:` operator can be used to create a vector of integers between two specified numbers or the `c()` function can be used to create vectors of objects by concatenating elements together:


```r
# integer vector
w <- 8:17
w
##  [1]  8  9 10 11 12 13 14 15 16 17

# double vector
x <- c(0.5, 0.6, 0.2)
x
## [1] 0.5 0.6 0.2

# logical vector
y1 <- c(TRUE, FALSE, FALSE)
y1
## [1]  TRUE FALSE FALSE

# logical vector in shorthand
y2 <- c(T, F, F) 
y2
## [1]  TRUE FALSE FALSE

# Character vector
z <- c("a", "b", "c") 
z
## [1] "a" "b" "c"
```

The `seq()` function can be used to generates a vector sequence of numbers (or [dates](http://uc-r.github.io/date_sequences/)) with a specified arithmetic progression. And the `rep()` function allows us to conveniently repeat specified constants into long vectors in a collated or non-collated manner.


```r
# generate a sequence of numbers from 1 to 21 by increments of 2
seq(from = 1, to = 21, by = 2)             
##  [1]  1  3  5  7  9 11 13 15 17 19 21

# generate a sequence of numbers from 1 to 21 that has 15 equal incremented 
# numbers
seq(0, 21, length.out = 15)    
##  [1]  0.0  1.5  3.0  4.5  6.0  7.5  9.0 10.5 12.0 13.5 15.0 16.5 18.0 19.5
## [15] 21.0


# replicates the values in x a specified number of times in a collated fashion
rep(1:4, times = 2)   
## [1] 1 2 3 4 1 2 3 4

# replicates the values in x in an uncollated fashion
rep(1:4, each = 2)    
## [1] 1 1 2 2 3 3 4 4
```

You can also use the `as.vector()` function to initialize vectors or change the vector type:


```r
v <- as.vector(8:17)
v
##  [1]  8  9 10 11 12 13 14 15 16 17

# turn numerical vector to character
as.vector(v, mode = "character")
##  [1] "8"  "9"  "10" "11" "12" "13" "14" "15" "16" "17"
```

All elements of a vector must be the same type, so when you attempt to combine different types of elements they will be coerced to the most flexible type possible:


```r
# numerics are turned to characters
str(c("a", "b", "c", 1, 2, 3))
##  chr [1:6] "a" "b" "c" "1" "2" "3"

# logical are turned to numerics...
str(c(1, 2, 3, TRUE, FALSE))
##  num [1:5] 1 2 3 1 0

# or character
str(c("A", "B", "C", TRUE, FALSE))
##  chr [1:5] "A" "B" "C" "TRUE" "FALSE"
```
