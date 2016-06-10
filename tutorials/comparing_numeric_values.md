---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Numbers](numbers) &#187; Comparing numeric values

<br>

* <a href="#a">Comparison operators</a> 
* <a href="#b">Exact equality</a>
* <a href="#c">Floating point comparison</a>

<br>

<a name="a"></a>

# Comparison Operators
The normal binary operators allow you to compare numeric values and provides the answer in logical form:

{% highlight r %}
x < y     # is x less than y
x > y     # is x greater than y
x <= y    # is x less than or equal to y
x >= y    # is x greater than or equal to y
x == y    # is x equal to y
x != y    # is x not equal to y
{% endhighlight %}

These operations can be used for single number comparison:

{% highlight r %}
x <- 9
y <- 10

x == y
## [1] FALSE
{% endhighlight %}

and also for comparison of numbers within vectors:

{% highlight r %}
x <- c(1, 4, 9, 12)
y <- c(4, 4, 9, 13)

x == y
## [1] FALSE  TRUE  TRUE FALSE
{% endhighlight %}

Note that logical values `TRUE` and `FALSE` equate to 1 and 0 respectively.  So if you want to identify the number of equal values in two vectors you can wrap the operation in the `sum()` function:

{% highlight r %}
sum(x == y)    # How many pairwise equal values are in vectors x and y
## [1] 2
{% endhighlight %}

If you need to identify the location of pairwise equalities in two vectors you can wrap the operation in the `which()` function:

{% highlight r %}
which(x == y)    # Where are the pairwise equal values located in vectors x and y
## [1] 2 3
{% endhighlight %}


<br>

<a name="b"></a>

# Exact Equality
To test if two objects are exactly equal:

{% highlight r %}
x <- c(4, 4, 9, 12)
y <- c(4, 4, 9, 13)

identical(x, y)
## [1] FALSE
{% endhighlight %}



{% highlight r %}
x <- c(4, 4, 9, 12)
y <- c(4, 4, 9, 12)

identical(x, y)
## [1] TRUE
{% endhighlight %}

<br>

<a name="c"></a>

# Floating Point Comparison
Sometimes you wish to test for 'near equality'.  The `all.equal()` function allows you to test for equality with a difference tolerance of 1.5e-8.

{% highlight r %}
x <- c(4.00000005, 4.00000008)
y <- c(4.00000002, 4.00000006)

all.equal(x, y)
## [1] TRUE
{% endhighlight %}

If the difference is greater than the tolerance level the function will return the mean relative difference:

{% highlight r %}
x <- c(4.005, 4.0008)
y <- c(4.002, 4.0006)

all.equal(x, y)
## [1] "Mean relative difference: 0.0003997102"
{% endhighlight %}



<br>

<small><a href="#">Go to top</a></small>
