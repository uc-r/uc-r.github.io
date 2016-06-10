---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Character Strings](characters) &#187; [String manipulation](string_manipulation) &#187; Set operations

* <a href="#union">Set union</a>
* <a href="#intersect">Set intersection</a>
* <a href="#setdiff">Identifying different elements</a>
* <a href="#equality">Testing for element equality</a>
* <a href="#exact_equality">Testing for *exact* equality</a>
* <a href="#in_element">Identifying if elements are contained in a string</a>
* <a href="#sort">Sorting a string</a>

<br>


<a name="union"></a>

# Set Union
To obtain the elements of the union between two character vectors use `union()`:

{% highlight r %}
set_1 <- c("lagunitas", "bells", "dogfish", "summit", "odell")
set_2 <- c("sierra", "bells", "harpoon", "lagunitas", "founders")

union(set_1, set_2)
## [1] "lagunitas" "bells"     "dogfish"   "summit"    "odell"     "sierra"   
## [7] "harpoon"   "founders"
{% endhighlight %}

<br>

<a name="intersect"></a>

# Set Intersection
To obtain the common elements of two character vectors use `intersect()`:

{% highlight r %}
intersect(set_1, set_2)
## [1] "lagunitas" "bells"
{% endhighlight %}

<br>

<a name="setdiff"></a>

# Identifying Different Elements
To obtain the non-common elements, or the difference, of two character vectors use `setdiff()`:

{% highlight r %}
# returns elements in set_1 not in set_2
setdiff(set_1, set_2)
## [1] "dogfish" "summit"  "odell"

# returns elements in set_2 not in set_1
setdiff(set_2, set_1)
## [1] "sierra"   "harpoon"  "founders"
{% endhighlight %}

<br>

<a name="equality"></a>

# Testing for Element Equality
To test if two vectors contain the same elements regardless of order use `setequal()`:

{% highlight r %}
set_3 <- c("woody", "buzz", "rex")
set_4 <- c("woody", "andy", "buzz")
set_5 <- c("andy", "buzz", "woody")

setequal(set_3, set_4)
## [1] FALSE

setequal(set_4, set_5)
## [1] TRUE
{% endhighlight %}

<br>

<a name="exact_equality"></a>

# Testing for *Exact* Equality
To test if two character vectors are equal in content and order use `identical()`:

{% highlight r %}
set_6 <- c("woody", "andy", "buzz")
set_7 <- c("andy", "buzz", "woody")
set_8 <- c("woody", "andy", "buzz")

identical(set_6, set_7)
## [1] FALSE

identical(set_6, set_8)
## [1] TRUE
{% endhighlight %}

<br>

<a name="in_element"></a>

# Identifying if Elements are Contained in a String
To test if an element is contained within a character vector use `is.element()` or `%in%`:

{% highlight r %}
good <- "andy"
bad <- "sid"

is.element(good, set_8)
## [1] TRUE

good %in% set_8
## [1] TRUE

bad %in% set_8
## [1] FALSE
{% endhighlight %}

<br>

<a name="sort"></a>

# Sorting a String
To sort a character vector use `sort()`:

{% highlight r %}
sort(set_8)
## [1] "andy"  "buzz"  "woody"

sort(set_8, decreasing = TRUE)
## [1] "woody" "buzz"  "andy"
{% endhighlight %}

<br>

<small><a href="#">Go to top</a></small>
