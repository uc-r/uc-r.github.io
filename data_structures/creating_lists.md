---
layout: tutorial
title: Creating Lists
permalink: /creating_lists
---

To create a list we can use the `list()` function. Note how each of the four list items are of different classes (integer, character, logical, and numeric) and different length.

```r
l <- list(1:3, "a", c(TRUE, FALSE, TRUE), c(2.5, 4.2))
str(l)
## List of 4
##  $ : int [1:3] 1 2 3
##  $ : chr "a"
##  $ : logi [1:3] TRUE FALSE TRUE
##  $ : num [1:2] 2.5 4.2

# a list containing a list
l <- list(1:3, list(letters[1:5], c(TRUE, FALSE, TRUE)))
str(l)
## List of 2
##  $ : int [1:3] 1 2 3
##  $ :List of 2
##   ..$ : chr [1:5] "a" "b" "c" "d" ...
##   ..$ : logi [1:3] TRUE FALSE TRUE
```


