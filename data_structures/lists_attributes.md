---
layout: tutorial
title: Adding Attributes to Lists
permalink: /lists_attributes
---

The attributes that you can add to lists include names, general comments, and specific list item comments. Currently, our `l1` list has no attributes:


```r
attributes(l1)
## NULL
```

We can add names to lists in two ways. First, we can use `names()` to assign names to list items in a pre-existing list. Second, we can add names to a list when we are creating a list.


```r
# adding names to a pre-existing list
names(l1) <- c("item1", "item2", "item3")

str(l1)
## List of 3
##  $ item1: int [1:6] 1 2 3 4 5 6
##  $ item2: chr [1:4] "a" "dding" "to a" "list"
##  $ item3: logi [1:3] TRUE FALSE TRUE

attributes(l1)
## $names
## [1] "item1" "item2" "item3"

# adding names when creating lists
l2 <- list(item1 = 1:3, item2 = letters[1:5], item3 = c(T, F, T, T))

str(l2)
## List of 3
##  $ item1: int [1:3] 1 2 3
##  $ item2: chr [1:5] "a" "b" "c" "d" ...
##  $ item3: logi [1:4] TRUE FALSE TRUE TRUE

attributes(l2)
## $names
## [1] "item1" "item2" "item3"
```

We can also add comments to lists. As previously mentioned, comments act as a note to the user without changing how the object behaves. With lists, we can add a general comment to the list using `comment()` and we can also add comments to specific list items with `attr()`.


```r
# adding a general comment to list l2 with comment()
comment(l2) <- "This is a comment on a list"

str(l2)
## List of 3
##  $ item1: int [1:3] 1 2 3
##  $ item2: chr [1:5] "a" "b" "c" "d" ...
##  $ item3: logi [1:4] TRUE FALSE TRUE TRUE
##  - attr(*, "comment")= chr "This is a comment on a list"

attributes(l2)
## $names
## [1] "item1" "item2" "item3"
## 
## $comment
## [1] "This is a comment on a list"

# adding a comment to a specific list item with attr() 
attr(l2, "item2") <- "Comment for item2"

str(l2)
## List of 3
##  $ item1: int [1:3] 1 2 3
##  $ item2: chr [1:5] "a" "b" "c" "d" ...
##  $ item3: logi [1:4] TRUE FALSE TRUE TRUE
##  - attr(*, "comment")= chr "This is a comment on a list"
##  - attr(*, "item2")= chr "Comment for item2"

attributes(l2)
## $names
## [1] "item1" "item2" "item3"
## 
## $comment
## [1] "This is a comment on a list"
## 
## $item2
## [1] "Comment for item2"
```
