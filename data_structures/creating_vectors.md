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
