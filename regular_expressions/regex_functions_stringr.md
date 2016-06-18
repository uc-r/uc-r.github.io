---
layout: tutorial
title: Regular Expression Functions in <code>stringr</code>
permalink: /regex_functions_stringr
---

Similar to basic string manipulation, the `stringr` package also offers regex functionality.  In some cases the `stringr` performs the same functions as certain base R functions but with more consistent syntax.  In other cases `stringr` offers additional functionality that is not available in the base R functions.  The `stringr` functions we'll cover focus on [detecting](#h1), [locating](#h2), [extracting](#h3), and [replacing patterns](#h4) along with string [splitting](#h5).

```r
# install stringr package
install.packages("stringr")

# load package
library(stringr)
```

<br>

## Detecting Patterns {#h1}
To *detect* whether a pattern is present (or absent) in a string vector use the `str_detect()`. This function is a wrapper for [`grepl()`](regex_functions_base#grepl).


```r
# use the built in data set 'state.name'
head(state.name)
## [1] "Alabama"    "Alaska"     "Arizona"    "Arkansas"   "California"
## [6] "Colorado"

str_detect(state.name, pattern = "New")
##  [1] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [12] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [23] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE FALSE
## [34] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [45] FALSE FALSE FALSE FALSE FALSE FALSE

# count the total matches by wrapping with sum
sum(str_detect(state.name, pattern = "New"))
## [1] 4
```

<br>

## Locating Patterns {#h2}
To *locate* the occurrences of patterns `stringr` offers two options: *i*) locate the first matching occurrence or *ii*) locate all occurrences.  To locate the position of the first occurrence of a pattern in a string vector use `str_locate()`. The output provides the starting and ending position of the first match found within each element.


```r
x <- c("abcd", "a22bc1d", "ab3453cd46", "a1bc44d")

# locate 1st sequence of 1 or more consecutive numbers
str_locate(x, "[0-9]+")
##      start end
## [1,]    NA  NA
## [2,]     2   3
## [3,]     3   6
## [4,]     2   2
```


To locate the positions of all pattern match occurrences in a character vector use `str_locate_all()`.  The output provides a list the same length as the number of elements in the vector.  Each list item will provide the starting and ending positions for each pattern match occurrence in its respective element.


```r
# locate all sequences of 1 or more consecutive numbers
str_locate_all(x, "[0-9]+")
## [[1]]
##      start end
## 
## [[2]]
##      start end
## [1,]     2   3
## [2,]     6   6
## 
## [[3]]
##      start end
## [1,]     3   6
## [2,]     9  10
## 
## [[4]]
##      start end
## [1,]     2   2
## [2,]     5   6
```

<br>

## Extracting Patterns {#h3}
For extracting a string containing a pattern, `stringr` offers two primary options: *i*) extract the first matching occurrence or *ii*) extract all occurrences.  To extract the first occurrence of a pattern in a character vector use `str_extract()`. The output will be the same length as the string and if no match is found the output will be `NA` for that element.


```r
y <- c("I use R #useR2014", "I use R and love R #useR2015", "Beer")

str_extract(y, pattern = "R")
## [1] "R" "R" NA
```

To extract all occurrences of a pattern in a character vector use `str_extract_all()`.  The output provides a list the same length as the number of elements in the vector.  Each list item will provide the matching pattern occurrence within that relative vector element.


```r
str_extract_all(y, pattern = "[[:punct:]]*[a-zA-Z0-9]*R[a-zA-Z0-9]*")
## [[1]]
## [1] "R"         "#useR2014"
## 
## [[2]]
## [1] "R"         "R"         "#useR2015"
## 
## [[3]]
## character(0)
```

<br>

## Replacing Patterns {#h4}
For extracting a string containing a pattern, `stringr` offers two options: *i*) replace the first matching occurrence or *ii*) replace all occurrences.  To replace the first occurrence of a pattern in a character vector use `str_replace()`. This function is a wrapper for [`sub()`](regex_functions_base#sub).


```r
cities <- c("New York", "new new York", "New New New York")
cities
## [1] "New York"         "new new York"     "New New New York"

# case sensitive
str_replace(cities, pattern = "New", replacement = "Old")
## [1] "Old York"         "new new York"     "Old New New York"

# to deal with case sensitivities use Regex syntax in the 'pattern' argument
str_replace(cities, pattern = "[N]*[n]*ew", replacement = "Old")
## [1] "Old York"         "Old new York"     "Old New New York"
```

To extract all occurrences of a pattern in a character vector use `str_replace_all()`.  This function is a wrapper for [`gsub()`](regex_functions_base#gsub).


```r
str_replace_all(cities, pattern = "[N]*[n]*ew", replacement = "Old")
## [1] "Old York"         "Old Old York"     "Old Old Old York"
```

<br>

## String Splitting {#h5}
To split the elements of a character string use `str_split()`. This function is a wrapper for [`strsplit()`](regex_functions_base#splitting).


```r
z <- "The day after I will take a break and drink a beer."
str_split(z, pattern = " ")
## [[1]]
##  [1] "The"   "day"   "after" "I"     "will"  "take"  "a"     "break"
##  [9] "and"   "drink" "a"     "beer."

a <- "Alabama-Alaska-Arizona-Arkansas-California"
str_split(a, pattern = "-")
## [[1]]
## [1] "Alabama"    "Alaska"     "Arizona"    "Arkansas"   "California"
```

Note that the output of `strs_plit()` is a list.  To convert the output to a simple atomic vector simply wrap in `unlist()`:


```r
unlist(str_split(a, pattern = "-"))
## [1] "Alabama"    "Alaska"     "Arizona"    "Arkansas"   "California"
```
