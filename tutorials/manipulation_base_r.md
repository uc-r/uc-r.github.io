---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Character Strings](characters) &#187; [String manipulation](string_manipulation) &#187; Manipulation with base R

* <a href="#lower_case">Convert to lower case</a>
* <a href="#upper_case">Convert to upper case</a>
* <a href="#simple_replacement">Simple character replacement</a>
* <a href="#abbreviation">String abbreviations</a>
* <a href="#substrings">Extract/Replace substrings</a>

<br>

<a name="lower_case"></a>

# Convert to Lower Case
To convert all upper case characters to lower case use `tolower()`:

{% highlight r %}
x <- "Learning To MANIPULATE strinGS in R"

tolower(x)
## [1] "learning to manipulate strings in r"
{% endhighlight %}

<br>

<a name="upper_case"></a>

# Convert to Upper Case
To convert all lower case characters to upper case use `toupper()`:

{% highlight r %}
toupper(x)
## [1] "LEARNING TO MANIPULATE STRINGS IN R"
{% endhighlight %}

<br>

<a name="simple_replacement"></a>

# Simple Character Replacement
To replace a character (or multiple characters) in a string you can use `chartr()`:

{% highlight r %}
# replace 'A' with 'a'
x <- "This is A string."
chartr(old = "A", new = "a", x)
## [1] "This is a string."

# multiple character replacements
# replace any 'd' with 't' and any 'z' with 'a'
y <- "Tomorrow I plzn do lezrn zbout dexduzl znzlysis."
chartr(old = "dz", new = "ta", y)
## [1] "Tomorrow I plan to learn about textual analysis."
{% endhighlight %}

Note that `chartr()` replaces every identified letter for replacement so the only time I use it is when I am certain that I want to change every possible occurence of a letter.

<br>

<a name="abbreviation"></a>

# String Abbreviations
To abbreviate strings you can use `abbreviate()`:

{% highlight r %}
streets <- c("Main", "Elm", "Riverbend", "Mario", "Frederick")

# default abbreviations
abbreviate(streets)
##      Main       Elm Riverbend     Mario Frederick 
##    "Main"     "Elm"    "Rvrb"    "Mari"    "Frdr"

# set minimum length of abbreviation
abbreviate(streets, minlength = 2)
##      Main       Elm Riverbend     Mario Frederick 
##      "Mn"      "El"      "Rv"      "Mr"      "Fr"
{% endhighlight %}

Note that if you are working with U.S. states, R already has a pre-built vector with state names (`state.name`).  Also, there is a pre-built vector of abbreviated state names (`state.abb`).

<br>

<a name="substrings"></a>

# Extract/Replace Substrings
To extract or replace substrings in a character vector use `substr()`, `substring()`, and `strsplit()`:

Extract and replace substrings with specified starting and stopping characters with `substr()`:

{% highlight r %}
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
{% endhighlight %}

<br>

Extract and replace substrings with only a specified starting point with `substr()`.  Also allows you to extract/replace in a recursive fashion:

{% highlight r %}
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
{% endhighlight %}

<br>

To split the elements of a character string use `strsplit()`:

{% highlight r %}
z <- "The day after I will take a break and drink a beer."
strsplit(z, split = " ")
## [[1]]
##  [1] "The"   "day"   "after" "I"     "will"  "take"  "a"     "break"
##  [9] "and"   "drink" "a"     "beer."

a <- "Alabama-Alaska-Arizona-Arkansas-California"
strsplit(a, split = "-")
## [[1]]
## [1] "Alabama"    "Alaska"     "Arizona"    "Arkansas"   "California"
{% endhighlight %}

Note that the output of `strsplit()` is a list.  To convert the output to a simple atomic vector simply wrap in `unlist()`:

{% highlight r %}
unlist(strsplit(a, split = "-"))
## [1] "Alabama"    "Alaska"     "Arizona"    "Arkansas"   "California"
{% endhighlight %}

<br>

<small><a href="#">Go to top</a></small>
