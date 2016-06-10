---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Character Strings](characters) &#187; [Regular Expressions](regex) &#187; [Regex Functions](regex_functions) &#187; Main regex functions

* <a href="#finding">Pattern finding functions</a>
* <a href="#replacement">Pattern replacement functions</a>
* <a href="#splitting">Splitting character vectors</a>

<br>

<a name="finding"></a>

## Pattern Finding Functions
There are five functions that provide pattern matching capabilities.  The three functions that I provide examples for are ones that are most common.  The two other functions which I do not illustrate are `gregexpr()` and `regexec()` which provide similar capabilities as `regexpr()` but with the output in list form.

* <a href="#grep">Pattern matching with values or indices as outputs</a>
* <a href="#grepl">Pattern matching with logical (TRUE/FALSE) outputs</a>
* <a href="#regexpr">Identifying the location in the string where the patter exists</a>

<a name="grep"></a>

### grep()
To find a pattern in a character vector and to have the element values or indices as the output use `grep()`:

{% highlight r %}
# use the built in data set `state.division`
head(as.character(state.division))
## [1] "East South Central" "Pacific"            "Mountain"          
## [4] "West South Central" "Pacific"            "Mountain"


# find the elements which match the patter
grep("North", state.division)
##  [1] 13 14 15 16 22 23 25 27 34 35 41 49


# use 'value = TRUE' to show the element value
grep("North", state.division, value = TRUE)
##  [1] "East North Central" "East North Central" "West North Central"
##  [4] "West North Central" "East North Central" "West North Central"
##  [7] "West North Central" "West North Central" "West North Central"
## [10] "East North Central" "West North Central" "East North Central"


# can use the 'invert' argument to show the non-matching elements
grep("North | South", state.division, invert = TRUE)
##  [1]  2  3  5  6  7  8  9 10 11 12 19 20 21 26 28 29 30 31 32 33 37 38 39
## [24] 40 44 45 46 47 48 50
{% endhighlight %}

<br>

<a name="grepl"></a>

### grepl()
To find a pattern in a character vector and to have logical (TRUE/FALSE) outputs use `grep()`:

{% highlight r %}
grepl("North | South", state.division)
##  [1]  TRUE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
## [12] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE  TRUE
## [23]  TRUE  TRUE  TRUE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
## [34]  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE FALSE
## [45] FALSE FALSE FALSE FALSE  TRUE FALSE

# wrap in sum() to get the count of matches
sum(grepl("North | South", state.division))
## [1] 20
{% endhighlight %}

<br>

<a name="regexpr"></a>

### regexpr()
To find exactly where the pattern exists in a string use `regexpr()`:

{% highlight r %}
x <- c("v.111", "0v.11", "00v.1", "000v.", "00000")

regexpr("v.", x)
## [1]  1  2  3  4 -1
## attr(,"match.length")
## [1]  2  2  2  2 -1
## attr(,"useBytes")
## [1] TRUE
{% endhighlight %}

The output of `regexpr()` can be interepreted as follows.  The first element provides the starting position of the match in each element.  Note that the value **-1** means there is no match.  The second element (attribute "match length") provides the length of the match.  The third element (attribute "useBytes") has a value TRUE meaning matching was done byte-by-byte rather than character-by-character.

<br>

<a name="replacement"></a>

## Pattern Replacement Functions
In addition to finding patterns in character vectors, its also common to want to replace a pattern in a string with a new patter.  There are two options for this:

* <a href="#sub">Replace the first occurrence</a>
* <a href="#gsub">Replace all occurrences</a>


<a name="sub"></a>

### sub()
To replace the **first** matching occurrence of a pattern use `sub()`:

{% highlight r %}
new <- c("New York", "new new York", "New New New York")
new
## [1] "New York"         "new new York"     "New New New York"

# Default is case sensitive
sub("New", replacement = "Old", new)
## [1] "Old York"         "new new York"     "Old New New York"

# use 'ignore.case = TRUE' to perform the obvious
sub("New", replacement = "Old", new, ignore.case = TRUE)
## [1] "Old York"         "Old new York"     "Old New New York"
{% endhighlight %}

<br>

<a name="gsub"></a>

### gsub()
To replace **all** matching occurrences of a pattern use `gsub()`:


{% highlight r %}
# Default is case sensitive
gsub("New", replacement = "Old", new)
## [1] "Old York"         "new new York"     "Old Old Old York"

# use 'ignore.case = TRUE' to perform the obvious
gsub("New", replacement = "Old", new, ignore.case = TRUE)
## [1] "Old York"         "Old Old York"     "Old Old Old York"
{% endhighlight %}

<br>

<a name="splitting"></a>

## Splitting Character Vectors
To split the elements of a character string use `strsplit()`:

{% highlight r %}
x <- paste(state.name[1:10], collapse = " ")

# output will be a list
strsplit(x, " ")
## [[1]]
##  [1] "Alabama"     "Alaska"      "Arizona"     "Arkansas"    "California" 
##  [6] "Colorado"    "Connecticut" "Delaware"    "Florida"     "Georgia"

# output as a vector rather than a list
unlist(strsplit(x, " "))
##  [1] "Alabama"     "Alaska"      "Arizona"     "Arkansas"    "California" 
##  [6] "Colorado"    "Connecticut" "Delaware"    "Florida"     "Georgia"
{% endhighlight %}



<br>

<small><a href="#">Go to top</a></small>

