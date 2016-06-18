---
layout: tutorial
title: Set Operations for Character Strings
permalink: /set_operations/
---

There are also base R functions that allows for assessing the set [union](#h1), [intersection](#h2), [difference](#h3), [equality](#h4), and [membership](#h6) of two vectors. I also cover [sorting](#h7) character strings. 

<br>

## Set Union {#h1}
To obtain the elements of the union between two character vectors use `union()`:


```r
set_1 <- c("lagunitas", "bells", "dogfish", "summit", "odell")
set_2 <- c("sierra", "bells", "harpoon", "lagunitas", "founders")

union(set_1, set_2)
## [1] "lagunitas" "bells"     "dogfish"   "summit"    "odell"     "sierra"   
## [7] "harpoon"   "founders"
```

<br>

## Set Intersection {#h2}
To obtain the common elements of two character vectors use `intersect()`:


```r
intersect(set_1, set_2)
## [1] "lagunitas" "bells"
```

### Identifying Different Elements {#h3}
To obtain the non-common elements, or the difference, of two character vectors use `setdiff()`:


```r
# returns elements in set_1 not in set_2
setdiff(set_1, set_2)
## [1] "dogfish" "summit"  "odell"

# returns elements in set_2 not in set_1
setdiff(set_2, set_1)
## [1] "sierra"   "harpoon"  "founders"
```

<br>

## Testing for Element Equality {#h4}
To test if two vectors contain the same elements regardless of order use `setequal()`:


```r
set_3 <- c("woody", "buzz", "rex")
set_4 <- c("woody", "andy", "buzz")
set_5 <- c("andy", "buzz", "woody")

setequal(set_3, set_4)
## [1] FALSE

setequal(set_4, set_5)
## [1] TRUE
```

<br>

## Testing for *Exact* Equality {#h5}
To test if two character vectors are equal in content and order use `identical()`:


```r
set_6 <- c("woody", "andy", "buzz")
set_7 <- c("andy", "buzz", "woody")
set_8 <- c("woody", "andy", "buzz")

identical(set_6, set_7)
## [1] FALSE

identical(set_6, set_8)
## [1] TRUE
```

<br>

## Identifying if Elements are Contained in a String {#h6}
To test if an element is contained within a character vector use `is.element()` or `%in%`:


```r
good <- "andy"
bad <- "sid"

is.element(good, set_8)
## [1] TRUE

good %in% set_8
## [1] TRUE

bad %in% set_8
## [1] FALSE
```

<br>

## Sorting a String {#h7}
To sort a character vector use `sort()`:

```r
sort(set_8)
## [1] "andy"  "buzz"  "woody"

sort(set_8, decreasing = TRUE)
## [1] "woody" "buzz"  "andy"
```
