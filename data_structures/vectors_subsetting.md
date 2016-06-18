---
layout: tutorial
title: Subsetting Vectors
permalink: /vectors_subsetting
---

The four main ways to subset a vector include combining square brackets [ ] with:

* [Positive integers](#vector_positive)
* [Negative integers](#vector_negative)
* [Logical values](#vector_logical)
* [Names](#vector_names)

You can also subset with double brackets `[[ ]]` for [simplifying](#vector_simplify) subsets.

<br>

## Subsetting with positive integers {#vector_positive}
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

<br>

## Subsetting with negative integers {#vector_negative}
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

<br>

## Subsetting with logical values {#vector_logical}
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

<br>

## Subsetting with names {#vector_names}
Subsetting with names will return the elements with the matching names specified:


```r
v1["b"]
## b 
## 9

v1[c("a", "c", "h")]
##  a  c  h 
##  8 10 15
```

<br>

## Simplifying vs. Preserving {#vector_simplify}
Its also important to understand the difference between simplifying and preserving when subsetting.  **Simplifying** subsets returns the simplest possible data structure that can represent the output. **Preserving** subsets keeps the structure of the output the same as the input.

For vectors, subsetting with single brackets `[ ]` preserves while subsetting with double brackets `[[ ]]` simplifies.  The change you will notice when simplifying vectors is the removal of names.


```r
v1[1]
## a 
## 8

v1[[1]]
## [1] 8

```
