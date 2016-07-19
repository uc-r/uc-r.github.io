---
layout: page
title: Managing Lists
permalink: /lists
---

A list is an R structure that allows you to combine elements of different types, including lists embedded in a list, and length.  Many statistical outputs are provided as a list as well; therefore, its critical to understand how to work with lists.  In this section I will guide you throught the basics of managing lists to include:

* [Creating lists](#creating_lists)
* [Adding on to lists](#lists_adding)
* [Adding attributes to lists](#lists_attributes)
* [Subsetting lists](#lists_subsetting)

<br>

## Creating Lists {#creating_lists}
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

<br>

## Adding on to Lists {#lists_adding}
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

To add individual elements to a specific list component we need to introduce some subsetting which is further discussed in the [subsetting lists section](#lists_subsetting).  We'll continue with our original `l1` list:


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

<br>

## Adding Attributes to Lists {#lists_attributes}
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


<br>

## Subsetting Lists {#lists_subsetting}

> *"If list x is a train carrying objects, then x[[5]] is the object in car 5; x[4:6] is a train of cars 4-6"*  - @RLangTip

To subset lists we can utilize the single bracket `[ ]`, double brackets `[[ ]]`, and dollar sign `$` operators.  Each approach provides a specific purpose and can be combined in different ways to achieve the following subsetting objectives:

* [Subset list and preserve output as a list](#list_subset_preserve)
* [Subset list and simplify output](#list_subset_simplify)
* [Subset list to get elements out of a list](#list_subset_out)
* [Subset list with a nested list](#list_subset_nested)

### Subset list and preserve output as a list {#list_subset_preserve}

To extract one or more list items while **preserving**[^preserve_simplify] the output in list format use the `[ ]` operator:


```r
# extract first list item
l2[1]
## $item1
## [1] 1 2 3

# same as above but using the item's name
l2["item1"]
## $item1
## [1] 1 2 3

# extract multiple list items
l2[c(1,3)]
## $item1
## [1] 1 2 3
## 
## $item3
## [1]  TRUE FALSE  TRUE  TRUE

# same as above but using the items' names
l2[c("item1", "item3")]
## $item1
## [1] 1 2 3
## 
## $item3
## [1]  TRUE FALSE  TRUE  TRUE
```

### Subset list and simplify output {#list_subset_simplify}

To extract one or more list items while **simplifying**[^preserve_simplify] the output use the `[[ ]]`  or `$` operator:


```r
# extract first list item and simplify to a vector
l2[[1]]
## [1] 1 2 3

# same as above but using the item's name
l2[["item1"]]
## [1] 1 2 3

# same as above but using the `$` operator
l2$item1
## [1] 1 2 3
```

One thing that differentiates the `[[` operator from the `$` is that the `[[` operator can be used with computed indices. The `$` operator can only be used with literal names.


### Subset list to get elements out of a list {#list_subset_out}

To extract individual elements out of a specific list item combine the `[[` (or `$`) operator with the `[` operator:


```r
# extract third element from the second list item
l2[[2]][3]
## [1] "c"

# same as above but using the item's name
l2[["item2"]][3]
## [1] "c"

# same as above but using the `$` operator
l2$item2[3]
## [1] "c"
```


### Subset list with a nested list {#list_subset_nested}

If you have nested lists you can expand the ideas above to extract items and elements. We'll use the following list `l3` which has a nested list in item 2.


```r
l3 <- list(item1 = 1:3, 
           item2 = list(item2a = letters[1:5], 
                        item3b = c(T, F, T, T)))
str(l3)
## List of 2
##  $ item1: int [1:3] 1 2 3
##  $ item2:List of 2
##   ..$ item2a: chr [1:5] "a" "b" "c" "d" ...
##   ..$ item3b: logi [1:4] TRUE FALSE TRUE TRUE
```

If the goal is to subset `l3` to extract the nested list item `item2a` from `item2`, we can perform this multiple ways.


```r
# preserve the output as a list
l3[[2]][1]
## $item2a
## [1] "a" "b" "c" "d" "e"

# same as above but simplify the output
l3[[2]][[1]]
## [1] "a" "b" "c" "d" "e"

# same as above with names
l3[["item2"]][["item2a"]]
## [1] "a" "b" "c" "d" "e"

# same as above with `$` operator
l3$item2$item2a
## [1] "a" "b" "c" "d" "e"

# extract individual element from a nested list item
l3[[2]][[1]][3]
## [1] "c"
```

[^preserve_simplify]: Its important to understand the difference between simplifying and preserving subsetting.  **Simplifying** subsets returns the simplest possible data structure that can represent the output. **Preserving** subsets keeps the structure of the output the same as the input.  See Hadley Wickham's section on [Simplifying vs. Preserving Subsetting](http://adv-r.had.co.nz/Subsetting.html#subsetting-operators) to learn more.

