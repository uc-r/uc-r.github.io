---
layout: tutorial
title: Adding on to Lists
permalink: /lists_adding
---

To add additional list components to a list we can leverage the `list()` and `append()` functions. We can illustrate with the following list.


```r
l1 <- list(1:3, "a", c(TRUE, FALSE, TRUE))
str(l1)
## List of 3
##  $ : int [1:3] 1 2 3
##  $ : chr "a"
##  $ : logi [1:3] TRUE FALSE TRUE
```

If we add the new elements with `list()` it will create a list of two components, component 1 will be a nested list of the original list and component 2 will be the new elements added: 


```r
l2 <- list(l1, c(2.5, 4.2))
str(l2)
## List of 2
##  $ :List of 3
##   ..$ : int [1:3] 1 2 3
##   ..$ : chr "a"
##   ..$ : logi [1:3] TRUE FALSE TRUE
##  $ : num [1:2] 2.5 4.2
```

To simply add a 4th list component without creating nested lists we use the `append()` function:


```r
l3 <- append(l1, list(c(2.5, 4.2)))
str(l3)
## List of 4
##  $ : int [1:3] 1 2 3
##  $ : chr "a"
##  $ : logi [1:3] TRUE FALSE TRUE
##  $ : num [1:2] 2.5 4.2
```

Alternatively, we can also add a new list component by utilizing the '$' sign and naming the new item:


```r
l3$item4 <- "new list item"
str(l3)
## List of 5
##  $      : int [1:3] 1 2 3
##  $      : chr "a"
##  $      : logi [1:3] TRUE FALSE TRUE
##  $      : num [1:2] 2.5 4.2
##  $ item4: chr "new list item"
```

To add individual elements to a specific list component we need to introduce some subsetting which is further discussed in the [subsetting lists section](http://uc-r.github.io/lists_subsetting).  We'll continue with our original `l1` list:


```r
str(l1)
## List of 3
##  $ : int [1:3] 1 2 3
##  $ : chr "a"
##  $ : logi [1:3] TRUE FALSE TRUE
```

To add additional values to a list item you need to subset for that specific list item and then you can use the `c()` function to add
the additional elements to that list item:


```r
l1[[1]] <- c(l1[[1]], 4:6)
str(l1)
## List of 3
##  $ : int [1:6] 1 2 3 4 5 6
##  $ : chr "a"
##  $ : logi [1:3] TRUE FALSE TRUE

l1[[2]] <- c(l1[[2]], c("dding", "to a", "list"))
str(l1)
## List of 3
##  $ : int [1:6] 1 2 3 4 5 6
##  $ : chr [1:4] "a" "dding" "to a" "list"
##  $ : logi [1:3] TRUE FALSE TRUE
```
