---
layout: tutorial
title: Subsetting Lists
permalink: /lists_subsetting
---

> *"If list x is a train carrying objects, then x[[5]] is the object in car 5; x[4:6] is a train of cars 4-6"*  - @RLangTip

To subset lists we can utilize the single bracket `[ ]`, double brackets `[[ ]]`, and dollar sign `$` operators.  Each approach provides a specific purpose and can be combined in different ways to achieve the following subsetting objectives:

* [Subset list and preserve output as a list](#list_subset_preserve)
* [Subset list and simplify output](#list_subset_simplify)
* [Subset list to get elements out of a list](#list_subset_out)
* [Subset list with a nested list](#list_subset_nested)

<br>

## Subset list and preserve output as a list {#list_subset_preserve}

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

<br>

## Subset list and simplify output {#list_subset_simplify}

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


<br>

## Subset list to get elements out of a list {#list_subset_out}

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


<br>

## Subset list with a nested list {#list_subset_nested}

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
