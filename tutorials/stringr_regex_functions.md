---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Character Strings](characters) &#187; [Regular Expressions](regex) &#187; [Regex Functions](regex_functions) &#187; regex functions in stringr

* <a href="#install">Install `stringr` package</a>
* <a href="#detect">Detecting patterns</a>
* <a href="#locate">Locating patterns</a>
* <a href="#extract">Extracting matches</a>
* <a href="#replace">Replacing matches</a>
* <a href="#split">String splitting</a>

<br>

<a name="install"></a>

## Install stringr Package
To install and load the `stringr` package


{% highlight r %}
# install stringr package
install.packages("stringr")

# load package
library(stringr)
{% endhighlight %}



<br>

<a name="detect"></a>

## Detecting Patterns
To detecting whether a pattern is present (or absent) in a string vector use the `str_detect()`. 

{% highlight r %}
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
{% endhighlight %}
&#9755; *This function is a wraper of [`grepl()`](main_regex_functions#grepl)*


<br>

<a name="locate"></a>

## Locating Patterns
To *locate* the occurences of patterns stringr offers two options:

* <a href="#locate_first">Locate first match</a>
* <a href="#locate_all">Locate all matches</a>

<br>

<a name="locate_first"></a>

### Locate First Match
To locate the position of the first occurrence of a pattern in a string vector use `str_locate()`:

{% highlight r %}
x <- c("abcd", "a22bc1d", "ab3453cd46", "a1bc44d")

# locate 1st sequence of 1 or more consecutive numbers
str_locate(x, "[0-9]+")
##      start end
## [1,]    NA  NA
## [2,]     2   3
## [3,]     3   6
## [4,]     2   2
{% endhighlight %}
&#9755; *To understand the regex syntax used for this pattern visit the [Regex syntax page](regex_syntax)*

The output provides the starting and ending position of the first match found within each element.

<br>

<a name="locate_all"></a>

### Locate All Matches
To locate the positions of all pattern match occurrences in a character vector use `str_locate_all()`:

{% highlight r %}
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
{% endhighlight %}
&#9755; *To understand the regex syntax used for this pattern visit the [Regex syntax page](regex_syntax)*

The output provides a list the same length as the number of elements in the vector.  Each list item will provide the starting and ending positions for each pattern match occurrence in its respective element.

<br>

<a name="extract"></a>

## Extracting Patterns
For extracting a string containing a pattern, stringr offers two primary options: 

* <a href="#extract_first">Extract first match</a>
* <a href="#extract_all">Extract all matches</a>

<br>

<a name="extract_first"></a>

### Extract First Match
To extract first occurrence of a pattern in a character vector use `str_extract()`:

{% highlight r %}
y <- c("I use R #useR2014", "I use R and love R #useR2015", "Beer")

str_extract(y, pattern = "R")
## [1] "R" "R" NA
{% endhighlight %}
Output is same length as string and if no match is found output is NA for that element.

<br>

<a name="extract_all"></a>

### Extract All Matches
To extract all occurrences of a pattern in a character vector use `str_extract_all()`:

{% highlight r %}
str_extract_all(y, pattern = "[[:punct:]]*[a-zA-Z0-9]*R[a-zA-Z0-9]*")
## [[1]]
## [1] "R"         "#useR2014"
## 
## [[2]]
## [1] "R"         "R"         "#useR2015"
## 
## [[3]]
## character(0)
{% endhighlight %}
&#9755; *To understand the regex syntax used for this pattern visit the [Regex syntax page](regex_syntax)*

The output provides a list the same length as the number of elements in the vector.  Each list item will provide the matching pattern occurrence within that relative vector element.



<br>

<a name="replace"></a>

## Replacing Patterns
For extracting a string containing a pattern, stringr offers two options:

* <a href="#replace_first">Replace first match</a>
* <a href="#replace_all">Replace all matches</a>

<br>

<a name="replace_first"></a>

### Replace First Match
To extract first occurrence of a pattern in a character vector use `str_replace()`:

{% highlight r %}
cities <- c("New York", "new new York", "New New New York")
cities
## [1] "New York"         "new new York"     "New New New York"

# case sensitive
str_replace(cities, pattern = "New", replacement = "Old")
## [1] "Old York"         "new new York"     "Old New New York"

# to deal with case sensitivities use Regex syntax in the 'pattern' argument
str_replace(cities, pattern = "[N]*[n]*ew", replacement = "Old")
## [1] "Old York"         "Old new York"     "Old New New York"
{% endhighlight %}
&#9755; *This function is a wraper of [`sub()`](main_regex_functions#replacement)*

&#9755; *For more information on the pattern argument applied read about character classes and quantifiers at the [Regex syntax page](regex_syntax)*

<br>

<a name="replace_all"></a>

### Replace All Matches
To extract all occurrences of a pattern in a character vector use `str_replace_all()`:

{% highlight r %}
str_replace_all(cities, pattern = "[N]*[n]*ew", replacement = "Old")
## [1] "Old York"         "Old Old York"     "Old Old Old York"
{% endhighlight %}
&#9755; *This function is a wraper of [`gsub()`](main_regex_functions#replacement)*

<br>

<a name="split"></a>

## String Splitting
To split the elements of a character string use `str_split()`:

{% highlight r %}
z <- "The day after I will take a break and drink a beer."
str_split(z, pattern = " ")
## [[1]]
##  [1] "The"   "day"   "after" "I"     "will"  "take"  "a"     "break"
##  [9] "and"   "drink" "a"     "beer."

a <- "Alabama-Alaska-Arizona-Arkansas-California"
str_split(a, pattern = "-")
## [[1]]
## [1] "Alabama"    "Alaska"     "Arizona"    "Arkansas"   "California"
{% endhighlight %}

Note that the output of `strs_plit()` is a list.  To convert the output to a simple atomic vector simply wrap in `unlist()`:

{% highlight r %}
unlist(str_split(a, pattern = "-"))
## [1] "Alabama"    "Alaska"     "Arizona"    "Arkansas"   "California"
{% endhighlight %}
&#9755; *This function is a wraper of [`strsplit()`](http://bradleyboehmke.github.io/tutorials/main_regex_functions#splitting)*




<br>

<small><a href="#">Go to top</a></small>
