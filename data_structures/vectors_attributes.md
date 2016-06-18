---
layout: tutorial
title: Adding Attributes to Vectors
permalink: /vectors_attributes
---

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
