---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Data Structures](data_structures) &#187; List

<style>
<!-- .footnote {line-height:75%; "font-size:8px"} -->
</style>


<br>

A list is an R structure that allows you to combine elements of different types, including lists.  This tutorial covers the basics of managing lists.

* <a href="#creating">Creating</a>
* <a href="#adding">Adding on to</a>
* <a href="#attributes">Adding attributes</a>
* <a href="#subsetting">Subsetting</a>

<br>

<a name="creating"></a>

## Creating
To create a list we can use the `list()` function:

{% highlight r %}
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
{% endhighlight %}

<br>

<a name="adding"></a>

## Adding on to
To add additional list components to a list we can leverage the `list()` and `append()` functions:

{% highlight r %}
l1 <- list(1:3, "a", c(TRUE, FALSE, TRUE))
str(l1)
## List of 3
##  $ : int [1:3] 1 2 3
##  $ : chr "a"
##  $ : logi [1:3] TRUE FALSE TRUE

# if we add the new elements with list() it will create a list of two
# components, component 1 will be a nested list of the original list 
# and component 2 will be the new elements added 
l2 <- list(l1, c(2.5, 4.2))
str(l2)
## List of 2
##  $ :List of 3
##   ..$ : int [1:3] 1 2 3
##   ..$ : chr "a"
##   ..$ : logi [1:3] TRUE FALSE TRUE
##  $ : num [1:2] 2.5 4.2

# to simply add a 4th list component without creating nested lists
l3 <- append(l1, list(c(2.5, 4.2)))
str(l3)
## List of 4
##  $ : int [1:3] 1 2 3
##  $ : chr "a"
##  $ : logi [1:3] TRUE FALSE TRUE
##  $ : num [1:2] 2.5 4.2

# we can also add a new list component by utilizing the '$' sign and
# naming the new item:
l3$item4 <- "new list item"
str(l3)
## List of 5
##  $      : int [1:3] 1 2 3
##  $      : chr "a"
##  $      : logi [1:3] TRUE FALSE TRUE
##  $      : num [1:2] 2.5 4.2
##  $ item4: chr "new list item"
{% endhighlight %}

To add individual elements to a specific list component we need to introduce some subsetting which is further discussed the <a href="#subsetting">Subsetting section</a> below.

{% highlight r %}
str(l1)
## List of 3
##  $ : int [1:3] 1 2 3
##  $ : chr "a"
##  $ : logi [1:3] TRUE FALSE TRUE

# to add additional values to the first list item you need to subset
# for the first list item and then you can use the c() function to add
# the additional elements to that list item
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
{% endhighlight %}

<br>

<a name="attributes"></a>

## Adding attributes
The attributes that you can add to lists include names, general comments, and specific list item comments:

{% highlight r %}
# currently no attributes exist for list l1
attributes(l1)
## NULL

# we can add names to lists
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

# adding comments to lists acts as a note to the user
# without changing how the list behaves
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

# to add a comment to a specific list item we can use
# attr() function and assignment
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
{% endhighlight %}

<br>

<a name="subsetting"></a>

## Subsetting
To subset lists we can utilize the single bracket`[ ]`, double brackets `[[ ]]`, and dollar sign `$`. 

> *"If list x is a train carrying objects, then x[[5]] is the object in car 5; x[4:6] is a train of cars 4-6"*  - @RLangTip

* <a href="#preserve">Subset list - preserving output as a list</a>
* <a href="#simplify">Subset list - simplify output</a>
* <a href="#elements">Subset list - get elements out of a list</a>
* <a href="#nested">Subset list - dealing with nested lists</a>

<a name="preserve"></a>

### Subset List - Preserving Output as a List
To extract one or more list items while **preserving**<sup><a href="#fn1" id="ref1">1</a></sup> the output in list format use the `[ ]` operator:

{% highlight r %}
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
{% endhighlight %}

<a name="simplify"></a>

### Subset List - Simplify Output
To extract one or more list items and **simplifying**<sup><a href="#fn1" id="ref1">1</a></sup> the output use the `[ ]`  or `$` operator:

{% highlight r %}
# extract first list item and simplify to a vector
l2[[1]]
## [1] 1 2 3

# same as above but using the item's name
l2[["item1"]]
## [1] 1 2 3

# same as above but using the `$` operator
l2$item1
## [1] 1 2 3
{% endhighlight %}
&#9755; *One thing that differentiates the [[ operator from the $ is that the [[ operator can be used with computed indices. The $ operator can only be used with literal names.*

<a name="elements"></a>

### Subset List - Get Elements Out of a List
To extract individual elements out of a specific list item combine the `[[` (or `$`) operator with the `[` operator:

{% highlight r %}
# extract third element from the second list item
l2[[2]][3]
## [1] "c"

# same as above but using the item's name
l2[["item2"]][3]
## [1] "c"

# same as above but using the `$` operator
l2$item2[3]
## [1] "c"
{% endhighlight %}

<a name="nested"></a>

### Subset List - Dealing with Nested Lists
If you have nested lists you can expand the ideas above to extract items and elements:

{% highlight r %}
l3 <- list(item1 = 1:3, item2 = list(item2a = letters[1:5], item3b = c(T, F, T, T)))
str(l3)
## List of 2
##  $ item1: int [1:3] 1 2 3
##  $ item2:List of 2
##   ..$ item2a: chr [1:5] "a" "b" "c" "d" ...
##   ..$ item3b: logi [1:4] TRUE FALSE TRUE TRUE

# get the 1st item ('item2a') of the nested list ('item2') and
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
{% endhighlight %}


<br>

<small><a href="#">Go to top</a></small>

<br>

<P CLASS="footnote" style="line-height:0.75">
<sup id="fn1">1. Its also important to understand the difference between simplifying and preserving subsetting.  <em>Simplifying</em> subsets returns the simplest possible data structure that can represent the output. <em>Preserving</em> subsets keeps the structure of the output the same as the input.  See Hadley Wickham's section on <a href="http://adv-r.had.co.nz/Subsetting.html#subsetting-operators">Simplifying vs. Preserving Subsetting</a> to learn more.<a href="#ref1" title="Jump back to footnote 1 in the text.">"&#8617;"</a><sup>
</P>
