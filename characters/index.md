---
id: 1836
title: Dealing with Characters
date: 2016-06-10
author: Brad Boehmke
layout: page
permalink: /characters
---

Dealing with character strings is often under-emphasized in data analysis training.  The focus typically remains on numeric values; however, the growth in data collection is also resulting in greater bits of information embedded in character strings.  Consequently, handling, cleaning and processing character strings is becoming a prerequisite in daily data analysis.  This section is meant to give you the foundation of working with characters by covering:

- [Character string basics](#character_basics)
- [String manipulation with base R](#string_manipulation_baseR)
- [String manipulation with stringr](#string_manipulation_stringR)
- [Set operatons for character strings](#set_operations)

<br>

## Character string basics {#character_basics}
Character string basics includes how to [create](#create), [convert](#convert) and [print](#print) character strings along with how to [count the number of elements and characters](#count) in a string.

### Creating Strings {#create}

The most basic way to create strings is to use quotation marks and assign a string to an object similar to creating number sequences.


```r
a <- "learning to create"    # create string a
b <- "character strings"     # create string b
```

The `paste()` function provides a versatile means for creating and building strings. It takes one or more R objects, converts them to "character", and then it concatenates (pastes) them to form one or several character strings.


```r
# paste together string a & b
paste(a, b)                      
## [1] "learning to create character strings"

# paste character and number strings (converts numbers to character class)
paste("The life of", pi)           
## [1] "The life of 3.14159265358979"

# paste multiple strings
paste("I", "love", "R")            
## [1] "I love R"

# paste multiple strings with a separating character
paste("I", "love", "R", sep = "-")  
## [1] "I-love-R"

# use paste0() to paste without spaces btwn characters
paste0("I", "love", "R")            
## [1] "IloveR"

# paste objects with different lengths
paste("R", 1:5, sep = " v1.")       
## [1] "R v1.1" "R v1.2" "R v1.3" "R v1.4" "R v1.5"
```

### Converting to Strings {#convert}

Test if strings are characters with `is.character()` and convert strings to character with `as.character()` or with `toString()`.


```r
a <- "The life of"    
b <- pi

is.character(a)
## [1] TRUE

is.character(b)
## [1] FALSE

c <- as.character(b)
is.character(c)
## [1] TRUE

toString(c("Aug", 24, 1980))
## [1] "Aug, 24, 1980"
```

### Printing Strings {#print}

The common printing methods include:

- `print()`: generic printing
- `noquote()`: print with no quotes
- `cat()`: concatenate and print with no quotes
- `sprintf()`: a wrapper for the C function `sprintf`, that returns a character vector containing a formatted combination of text and variable values

The primary printing function in R is `print()`


```r
x <- "learning to print strings"    

# basic printing
print(x)                
## [1] "learning to print strings"

# print without quotes
print(x, quote = FALSE)  
## [1] learning to print strings
```

An alternative to printing a string without quotes is to use `noquote()`


```r
noquote(x)
## [1] learning to print strings
```

Another very useful function is `cat()` which allows us to concatenate objects and print them either on screen or to a file.  The output result is very similar to `noquote()`; however, `cat()` does not print the numeric line indicator.  As a result, `cat()` can be useful for printing nicely formated responses to users.


```r
# basic printing (similar to noquote)
cat(x)                   
## learning to print strings

# combining character strings
cat(x, "in R")           
## learning to print strings in R

# basic printing of alphabet
cat(letters)             
## a b c d e f g h i j k l m n o p q r s t u v w x y z

# specify a seperator between the combined characters
cat(letters, sep = "-")  
## a-b-c-d-e-f-g-h-i-j-k-l-m-n-o-p-q-r-s-t-u-v-w-x-y-z

# collapse the space between the combine characters
cat(letters, sep = "")   
## abcdefghijklmnopqrstuvwxyz
```

You can also format the line width for printing long strings using the `fill` argument:


```r
x <- "Today I am learning how to print strings."
y <- "Tomorrow I plan to learn about textual analysis."
z <- "The day after I will take a break and drink a beer."

cat(x, y, z, fill = 0)
## Today I am learning how to print strings. Tomorrow I plan to learn about textual analysis. The day after I will take a break and drink a beer.

cat(x, y, z, fill = 5)
## Today I am learning how to print strings. 
## Tomorrow I plan to learn about textual analysis. 
## The day after I will take a break and drink a beer.
```

`sprintf()` is a useful printing function for precise control of the output. It is a wrapper for the C function `sprintf` and returns a character vector containing a formatted combination of text and variable values.

To substitute in a string or string variable, use `%s`:


```r
x <- "print strings"

# substitute a single string/variable
sprintf("Learning to %s in R", x)    
## [1] "Learning to print strings in R"

# substitute multiple strings/variables
y <- "in R"
sprintf("Learning to %s %s", x, y)   
## [1] "Learning to print strings in R"
```

For integers, use `%d` or a variant:


```r
version <- 3

# substitute integer
sprintf("This is R version:%d", version)
## [1] "This is R version:3"

# print with leading spaces
sprintf("This is R version:%4d", version)   
## [1] "This is R version:   3"

# can also lead with zeros
sprintf("This is R version:%04d", version)   
## [1] "This is R version:0003"
```


For floating-point numbers, use `%f` for standard notation, and `%e` or `%E` for exponential notation:


```r
sprintf("%f", pi)         # '%f' indicates 'fixed point' decimal notation
## [1] "3.141593"

sprintf("%.3f", pi)       # decimal notation with 3 decimal digits
## [1] "3.142"

sprintf("%1.0f", pi)      # 1 integer and 0 decimal digits
## [1] "3"

sprintf("%5.1f", pi)      # decimal notation with 5 total decimal digits and 
## [1] "  3.1"            # only 1 to the right of the decimal point

sprintf("%05.1f", pi)     # same as above but fill empty digits with zeros
## [1] "003.1"

sprintf("%+f", pi)        # print with sign (positive)
## [1] "+3.141593"

sprintf("% f", pi)        # prefix a space
## [1] " 3.141593"

sprintf("%e", pi)         # exponential decimal notation 'e'
## [1] "3.141593e+00"

sprintf("%E", pi)         # exponential decimal notation 'E'
## [1] "3.141593E+00"
```

### Counting string elements and characters {#count}

To count the number of elements in a string use `length()`:


```r
length("How many elements are in this string?")
## [1] 1

length(c("How", "many", "elements", "are", "in", "this", "string?"))
## [1] 7
```

To count the number of characters in a string use `nchar()`:


```r
nchar("How many characters are in this string?")
## [1] 39

nchar(c("How", "many", "characters", "are", "in", "this", "string?"))
## [1]  3  4 10  3  2  4  7
```

<br>

## String manipulation with base R {#string_manipulation_baseR}
Basic string manipulation typically inludes case conversion, simple character, abbreviating, substring replacement, adding/removing whitespace, and performing set operations to compare similarities and differences between two character vectors.  These operations can all be performed with base R functions; however, some operations (or at least their syntax) are greatly simplified with the `stringr` package.  This section illustrates base R string manipulation for [case conversion](#h1), [simple character replacement](#h2), [abbreviating](#h3), and [substring replacement](#h4). Many of the other fundamental string manipulation tasks will be covered in the [String manipulation with stringr](#string_manipulation_stringR) and [Set operatons for character strings](#set_operations) sections that follow.

### Case conversion {#h1}
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

### Simple Character Replacement {#h2}
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

### String Abbreviations {#h3}
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

### Extract/Replace Substrings {#h4}
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

<br>

## String manipulation with stringr {#string_manipulation_stringR}
The [`stringr`](http://cran.r-project.org/web/packages/stringr/index.html) package was developed by Hadley Wickham to act as simple wrappers that make R's string functions more consistent, simple, and easier to use.  To replicate the functions in this section you will need to install and load the `stringr` package:


```r
# install stringr package
install.packages("stringr")

# load package
library(stringr)
```

### Basic Operations 

There are three string functions that are closely related to their base R equivalents, but with a few enhancements:

* Concatenate with `str_c()`
* Number of characters with `str_length()`
* Substring with `str_sub()`


`str_c()` is equivalent to the [`paste()`](#create) functions: 


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


`str_length()` is similiar to the [`nchar()`](#count) function; however, `str_length()` behaves more appropriately with missing ('NA') values: 


```r
# some text with NA
text = c("Learning", "to", NA, "use", "the", NA, "stringr", "package")

# compare `str_length()` with `nchar()`
nchar(text)
## [1] 8 2 2 3 3 2 7 7

str_length(text)
## [1]  8  2 NA  3  3 NA  7  7
```


`str_sub()` is similar to [`substr()`](#h4); however, it returns a zero length vector if any of its inputs are zero length, and otherwise expands each argument to match the longest. It also accepts negative positions, which are calculated from the left of the last character.


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

### Duplicate Characters within a String 

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

### Remove Leading and Trailing Whitespace 

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

### Pad a String with Whitespace 

To add whitespace, or to *pad* a string, use `str_pad()`.  You can also use `str_pad()` to pad a string with specified characters.


```r
str_pad("beer", width = 10, side = "left")
## [1] "      beer"

str_pad("beer", width = 10, side = "both")
## [1] "   beer   "

str_pad("beer", width = 10, side = "right", pad = "!")
## [1] "beer!!!!!!"
```


<br>

## Set operatons for character strings {#set_operations}
There are also base R functions that allows for assessing the set [union](#seth1), [intersection](#seth2), [difference](#seth3), [equality](#seth4), and [membership](#seth6) of two vectors. I also cover [sorting](#seth7) character strings. 

### Set Union {#seth1}
To obtain the elements of the union between two character vectors use `union()`:


```r
set_1 <- c("lagunitas", "bells", "dogfish", "summit", "odell")
set_2 <- c("sierra", "bells", "harpoon", "lagunitas", "founders")

union(set_1, set_2)
## [1] "lagunitas" "bells"     "dogfish"   "summit"    "odell"     "sierra"   
## [7] "harpoon"   "founders"
```

### Set Intersection {#seth2}
To obtain the common elements of two character vectors use `intersect()`:


```r
intersect(set_1, set_2)
## [1] "lagunitas" "bells"
```

### Identifying Different Elements {#seth3}
To obtain the non-common elements, or the difference, of two character vectors use `setdiff()`:


```r
# returns elements in set_1 not in set_2
setdiff(set_1, set_2)
## [1] "dogfish" "summit"  "odell"

# returns elements in set_2 not in set_1
setdiff(set_2, set_1)
## [1] "sierra"   "harpoon"  "founders"
```

### Testing for Element Equality {#seth4}
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

### Testing for *Exact* Equality {#seth5}
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

### Identifying if Elements are Contained in a String {#seth6}
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

### Sorting a String {#seth7}
To sort a character vector use `sort()`:

```r
sort(set_8)
## [1] "andy"  "buzz"  "woody"

sort(set_8, decreasing = TRUE)
## [1] "woody" "buzz"  "andy"
```
