---
layout: page
title: Managing Vectors
permalink: /vectors
---

The basic structure in R is the vector.  A vector is a sequence of data elements of the same basic type: [integer](http://uc-r.github.io/integer_double/), [double](http://uc-r.github.io/integer_double/), logical, or [character](http://uc-r.github.io/characters) (there are two additional vector types which I will not discuss - complex and raw). This tutorial provides you with the basics of managing vectors.

* [Creating vectors](#creating_vectors)
* [Adding on to vectors](#vectors_adding)
* [Adding attributes to vectors](#vectors_attributes)
* [Subsetting vectors](#vectors_subsetting)

<br>

## Creating Vectors {#creating_vectors}
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

<br>

## Adding on to Vectors {#vectors_adding}
To add additional elements to a pre-existing vector we can continue to leverage the `c()` function.  Also, note that vectors are always flat so nested `c()` functions will not add additional dimensions to the vector:

```r
v1 <- 8:17

c(v1, 18:22)
##  [1]  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22

# same as
c(v1, c(18, c(19, c(20, c(21:22)))))
##  [1]  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22
```

<br>

## Adding Attributes to Vectors {#vectors_attributes}
The attributes that you can add to vectors includes names and comments.  If we continue with our vector `v1` we can see that the vector currently has no attributes:


```r
attributes(v1)
## NULL
```

We can add names to vectors using two approaches. The first uses `names()` to assign names to each element of the vector. The second approach is to assign names when creating the vector.


```r
# assigning names to a pre-existing vector
names(v1) <- letters[1:length(v1)]
v1
##  a  b  c  d  e  f  g  h  i  j 
##  8  9 10 11 12 13 14 15 16 17
attributes(v1)
## $names
##  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j"

# adding names when creating vectors
v2 <- c(name1 = 1, name2 = 2, name3 = 3)
v2
## name1 name2 name3 
##     1     2     3
attributes(v2)
## $names
## [1] "name1" "name2" "name3"
```

We can also add comments to vectors to act as a note to the user.  This does not change how the vector behaves; rather, it simply acts as a form of metadata for the vector.


```r
comment(v1) <- "This is a comment on a vector"
v1
##  a  b  c  d  e  f  g  h  i  j 
##  8  9 10 11 12 13 14 15 16 17
attributes(v1)
## $names
##  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j"
## 
## $comment
## [1] "This is a comment on a vector"
```

<br>

## Subsetting Vectors {#vectors_subsetting}
The four main ways to subset a vector include combining square brackets [ ] with:

* [Positive integers](#vector_positive)
* [Negative integers](#vector_negative)
* [Logical values](#vector_logical)
* [Names](#vector_names)

You can also subset with double brackets `[[ ]]` for [simplifying](#vector_simplify) subsets.

### Subsetting with positive integers {#vector_positive}
Subsetting with positive integers returns the elements at the specified positions:


```r
v1
##  a  b  c  d  e  f  g  h  i  j 
##  8  9 10 11 12 13 14 15 16 17

v1[2]
## b 
## 9

v1[2:4]
##  b  c  d 
##  9 10 11

v1[c(2, 4, 6, 8)]
##  b  d  f  h 
##  9 11 13 15

# note that you can duplicate index positions
v1[c(2, 2, 4)]
##  b  b  d 
##  9  9 11
```

### Subsetting with negative integers {#vector_negative}
Subsetting with negative integers will omit the elements at the specified positions:


```r
v1[-1]
##  b  c  d  e  f  g  h  i  j 
##  9 10 11 12 13 14 15 16 17
```


```r
v1[-c(2, 4, 6, 8)]
##  a  c  e  g  i  j 
##  8 10 12 14 16 17
```

### Subsetting with logical values {#vector_logical}
Subsetting with logical values will select the elements where the corresponding logical value is `TRUE`:


```r
v1[c(TRUE, FALSE, TRUE, FALSE, TRUE, TRUE, TRUE, FALSE, FALSE, TRUE)]
##  a  c  e  f  g  j 
##  8 10 12 13 14 17

v1[v1 < 12]
##  a  b  c  d 
##  8  9 10 11

v1[v1 < 12 | v1 > 15]
##  a  b  c  d  i  j 
##  8  9 10 11 16 17

# if logical vector is shorter than the length of the vector being
# subsetted, it will be recycled to be the same length
v1[c(TRUE, FALSE)]
##  a  c  e  g  i 
##  8 10 12 14 16
```

### Subsetting with names {#vector_names}
Subsetting with names will return the elements with the matching names specified:


```r
v1["b"]
## b 
## 9

v1[c("a", "c", "h")]
##  a  c  h 
##  8 10 15
```

### Simplifying vs. Preserving {#vector_simplify}
Its also important to understand the difference between simplifying and preserving when subsetting.  **Simplifying** subsets returns the simplest possible data structure that can represent the output. **Preserving** subsets keeps the structure of the output the same as the input.[^preserve_simplify]

For vectors, subsetting with single brackets `[ ]` preserves while subsetting with double brackets `[[ ]]` simplifies.  The change you will notice when simplifying vectors is the removal of names.


```r
v1[1]
## a 
## 8

v1[[1]]
## [1] 8
```

[^preserve_simplify]: See Hadley Wickham's section on [Simplifying vs. Preserving Subsetting](http://adv-r.had.co.nz/Subsetting.html#subsetting-operators) to learn more.
