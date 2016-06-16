---
layout: tutorial
title: Generating Sequence of Non-random Numbers
permalink: /generating_sequence_numbers/
---

There are a few R operators and functions that are especially useful for creating vectors of non-random numbers.  These functions provide multiple ways for generating sequences of numbers.

<br>

## Specifing Numbers within a Sequence {#seq1}

To explicitly specify numbers in a sequence you can use the colon `:` operator to specify all integers between two specified numbers or the combine `c()` function to explicity specify all numbers in the sequence.


```r
# create a vector of integers between 1 and 10
1:10         
##  [1]  1  2  3  4  5  6  7  8  9 10

# create a vector consisting of 1, 5, and 10
c(1, 5, 10)   
## [1]  1  5 10

# save the vector of integers between 1 and 10 as object x
x <- 1:10 
x
##  [1]  1  2  3  4  5  6  7  8  9 10
```

<br>

## Generating Regular Sequences {#seq2}

A generalization of `:` is the `seq()` function, which generates a sequence of numbers with a specified arithmetic progression.


```r
# generate a sequence of numbers from 1 to 21 by increments of 2
seq(from = 1, to = 21, by = 2)             
##  [1]  1  3  5  7  9 11 13 15 17 19 21

# generate a sequence of numbers from 1 to 21 that has 15 equal incremented 
# numbers
seq(0, 21, length.out = 15)    
##  [1]  0.0  1.5  3.0  4.5  6.0  7.5  9.0 10.5 12.0 13.5 15.0 16.5 18.0 19.5
## [15] 21.0
```

<br>

## Generating Repeated Sequences {#seq3}

The `rep()` function allows us to conveniently repeat specified constants into long vectors. This function allows for collated and non-collated repetitions.


```r
# replicates the values in x a specified number of times in a collated fashion
rep(1:4, times = 2)   
## [1] 1 2 3 4 1 2 3 4

# replicates the values in x in an uncollated fashion
rep(1:4, each = 2)    
## [1] 1 1 2 2 3 3 4 4
```
