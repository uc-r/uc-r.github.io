---
layout: tutorial
title: String Manipulation with <code>stringr</code>
permalink: /string_manipulation_stringR/
---

The [`stringr`](http://cran.r-project.org/web/packages/stringr/index.html) package was developed by Hadley Wickham to act as simple wrappers that make R's string functions more consistent, simple, and easier to use.  To replicate the functions in this section you will need to install and load the `stringr` package:


```r
# install stringr package
install.packages("stringr")

# load package
library(stringr)
```
<i class="fa fa-external-link" style="font-size:1em"></i> *For more information on getting help with packages visit the [working with packages section](http://uc-r.github.io/packages/).*

<br>

## Basic Operations {#h1}

There are three string functions that are closely related to their base R equivalents, but with a few enhancements:

* Concatenate with `str_c()`
* Number of characters with `str_length()`
* Substring with `str_sub()`


`str_c()` is equivalent to the [`paste()`](http://uc-r.github.io/character_basics/#create) functions: 


```r
# same as paste0()
str_c("Learning", "to", "use", "the", "stringr", "package")
## [1] "Learningtousethestringrpackage"

# same as paste()
str_c("Learning", "to", "use", "the", "stringr", "package", sep = " ")
## [1] "Learning to use the stringr package"

# allows recycling 
str_c(letters, " is for", "...")
##  [1] "a is for..." "b is for..." "c is for..." "d is for..." "e is for..."
##  [6] "f is for..." "g is for..." "h is for..." "i is for..." "j is for..."
## [11] "k is for..." "l is for..." "m is for..." "n is for..." "o is for..."
## [16] "p is for..." "q is for..." "r is for..." "s is for..." "t is for..."
## [21] "u is for..." "v is for..." "w is for..." "x is for..." "y is for..."
## [26] "z is for..."
```


`str_length()` is similiar to the [`nchar()`](http://uc-r.github.io/character_basics/#count) function; however, `str_length()` behaves more appropriately with missing ('NA') values: 


```r
# some text with NA
text = c("Learning", "to", NA, "use", "the", NA, "stringr", "package")

# compare `str_length()` with `nchar()`
nchar(text)
## [1] 8 2 2 3 3 2 7 7

str_length(text)
## [1]  8  2 NA  3  3 NA  7  7
```


`str_sub()` is similar to [`substr()`](http://uc-r.github.io/string_manipulation_baseR/#h4); however, it returns a zero length vector if any of its inputs are zero length, and otherwise expands each argument to match the longest. It also accepts negative positions, which are calculated from the left of the last character.


```r
x <- "Learning to use the stringr package"

# alternative indexing
str_sub(x, start = 1, end = 15)
## [1] "Learning to use"

str_sub(x, end = 15)
## [1] "Learning to use"

str_sub(x, start = 17)
## [1] "the stringr package"

str_sub(x, start = c(1, 17), end = c(15, 35))
## [1] "Learning to use"     "the stringr package"

# using negative indices for start/end points from end of string
str_sub(x, start = -1)
## [1] "e"

str_sub(x, start = -19)
## [1] "the stringr package"

str_sub(x, end = -21)
## [1] "Learning to use"

# Replacement
str_sub(x, end = 15) <- "I know how to use"
x
## [1] "I know how to use the stringr package"
```

<br>

## Duplicate Characters within a String {#h2}

A new functionality that stringr provides in which base R does not have a specific function for is character duplication:


```r
str_dup("beer", times = 3)
## [1] "beerbeerbeer"

str_dup("beer", times = 1:3)
## [1] "beer"         "beerbeer"     "beerbeerbeer"


# use with a vector of strings
states_i_luv <- state.name[c(6, 23, 34, 35)]
str_dup(states_i_luv, times = 2)
## [1] "ColoradoColorado"         "MinnesotaMinnesota"      
## [3] "North DakotaNorth Dakota" "OhioOhio"
```

<br>

## Remove Leading and Trailing Whitespace {#h3}

A common task of string processing is that of parsing text into individual words.  Often, this results in words having blank spaces (whitespaces) on either end of the word. The `str_trim()` can be used to remove these spaces:


```r
text <- c("Text ", "  with", " whitespace ", " on", "both ", " sides ")

# remove whitespaces on the left side
str_trim(text, side = "left")
## [1] "Text "       "with"        "whitespace " "on"          "both "      
## [6] "sides "

# remove whitespaces on the right side
str_trim(text, side = "right")
## [1] "Text"        "  with"      " whitespace" " on"         "both"       
## [6] " sides"

# remove whitespaces on both sides
str_trim(text, side = "both")
## [1] "Text"       "with"       "whitespace" "on"         "both"      
## [6] "sides"
```

<br>

## Pad a String with Whitespace {#h4}

To add whitespace, or to *pad* a string, use `str_pad()`.  You can also use `str_pad()` to pad a string with specified characters.


```r
str_pad("beer", width = 10, side = "left")
## [1] "      beer"

str_pad("beer", width = 10, side = "both")
## [1] "   beer   "

str_pad("beer", width = 10, side = "right", pad = "!")
## [1] "beer!!!!!!"
```
