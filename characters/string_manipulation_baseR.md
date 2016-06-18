---
layout: tutorial
title: String Manipulation with Base R
permalink: /string_manipulation_baseR/
---

Basic string manipulation typically inludes case conversion, simple character, abbreviating, substring replacement, adding/removing whitespace, and performing set operations to compare similarities and differences between two character vectors.  These operations can all be performed with base R functions; however, some operations (or at least their syntax) are greatly simplified with the `stringr` package.  This section illustrates base R string manipulation for [case conversion](#h1), [simple character replacement](#h2), [abbreviating](#h3), and [substring replacement](#h4). Many of the other fundamental string manipulation tasks will be covered in the [String manipulation with stringr](http://uc-r.github.io/string_manipulation_stringR/) and [Set operatons for character strings](http://uc-r.github.io/set_operations/) tutorials.

<br>

## Case conversion {#h1}
To convert all upper case characters to lower case use `tolower()`:

```r
x <- "Learning To MANIPULATE strinGS in R"

tolower(x)
## [1] "learning to manipulate strings in r"
```

To convert all lower case characters to upper case use `toupper()`:


```r
toupper(x)
## [1] "LEARNING TO MANIPULATE STRINGS IN R"
```
<br>

## Simple Character Replacement {#h2}
To replace a character (or multiple characters) in a string you can use `chartr()`:


```r
# replace 'A' with 'a'
x <- "This is A string."
chartr(old = "A", new = "a", x)
## [1] "This is a string."

# multiple character replacements
# replace any 'd' with 't' and any 'z' with 'a'
y <- "Tomorrow I plzn do lezrn zbout dexduzl znzlysis."
chartr(old = "dz", new = "ta", y)
## [1] "Tomorrow I plan to learn about textual analysis."
```

Note that `chartr()` replaces every identified letter for replacement so the only time I use it is when I am certain that I want to change every possible occurence of a letter.

<br>

## String Abbreviations {#h3}
To abbreviate strings you can use `abbreviate()`:


```r
streets <- c("Main", "Elm", "Riverbend", "Mario", "Frederick")

# default abbreviations
abbreviate(streets)
##      Main       Elm Riverbend     Mario Frederick 
##    "Main"     "Elm"    "Rvrb"    "Mari"    "Frdr"

# set minimum length of abbreviation
abbreviate(streets, minlength = 2)
##      Main       Elm Riverbend     Mario Frederick 
##      "Mn"      "El"      "Rv"      "Mr"      "Fr"
```

Note that if you are working with U.S. states, R already has a pre-built vector with state names (`state.name`).  Also, there is a pre-built vector of abbreviated state names (`state.abb`).

<br>

## Extract/Replace Substrings {#h4}
To extract or replace substrings in a character vector there are three primary base R functions to use: `substr()`, `substring()`, and `strsplit()`.  The purpose of `substr()` is to extract and replace substrings with specified starting and stopping characters:


```r
alphabet <- paste(LETTERS, collapse = "")

# extract 18th character in string
substr(alphabet, start = 18, stop = 18)
## [1] "R"

# extract 18-24th characters in string
substr(alphabet, start = 18, stop = 24)
## [1] "RSTUVWX"

# replace 1st-17th characters with `R`
substr(alphabet, start = 19, stop = 24) <- "RRRRRR"
alphabet
## [1] "ABCDEFGHIJKLMNOPQRRRRRRRYZ"
```

The purpose of `substring()` is to extract and replace substrings with only a specified starting point.  `substring()` also allows you to extract/replace in a recursive fashion:


```r
alphabet <- paste(LETTERS, collapse = "")

# extract 18th through last character
substring(alphabet, first = 18)
## [1] "RSTUVWXYZ"

# recursive extraction; specify start position only
substring(alphabet, first = 18:24)
## [1] "RSTUVWXYZ" "STUVWXYZ"  "TUVWXYZ"   "UVWXYZ"    "VWXYZ"     "WXYZ"     
## [7] "XYZ"

# recursive extraction; specify start and stop positions
substring(alphabet, first = 1:5, last = 3:7)
## [1] "ABC" "BCD" "CDE" "DEF" "EFG"
```

To split the elements of a character string use `strsplit()`:


```r
z <- "The day after I will take a break and drink a beer."
strsplit(z, split = " ")
## [[1]]
##  [1] "The"   "day"   "after" "I"     "will"  "take"  "a"     "break"
##  [9] "and"   "drink" "a"     "beer."

a <- "Alabama-Alaska-Arizona-Arkansas-California"
strsplit(a, split = "-")
## [[1]]
## [1] "Alabama"    "Alaska"     "Arizona"    "Arkansas"   "California"
```

Note that the output of `strsplit()` is a list.  To convert the output to a simple atomic vector simply wrap in `unlist()`:


```r
unlist(strsplit(a, split = "-"))
## [1] "Alabama"    "Alaska"     "Arizona"    "Arkansas"   "California"
```
