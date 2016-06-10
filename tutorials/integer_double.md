---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Numbers](numbers) &#187; Integer vs. Double

<br>

The two most common numeric classes used in R are integer and double (for double precision floating point numbers).  R automatically converts between these two classes when needed for mathematical purposes.  As a result, it's feasible to use R and perform analyses for years without specifying these differences.

* <a href="#creating">Creating integer and double vectors</a> 
* <a href="#converting">Converting between integer and double values</a>
* <a href="#checking">Checking for numeric type</a>

<br>

<a name="creating"></a>

# Creating Integer and Double Vectors

{% highlight r %}
dbl_var <- c(1, 2.5, 4.5)    # create a string of double-precision values
int_var <- c(1L, 6L, 10L)    # placing an L after the values creates a string of integers
{% endhighlight %}

<br>

<a name="converting"></a>

# Converting Between Integer and Double Values
By default, if you read in data that has no decimal points or you [create numeric values](generating_sequence_numbers) using the `x <- 1:10` method the numeric values will be coded as integer.  If you want to change a double to an integer or vice versa: 


{% highlight r %}
as.double(int_var)     # converts integers to double-precision values
as.numeric(int_var)    # identical to as.double()
as.integer(dbl_var)    # converts doubles to integers
{% endhighlight %}
<br>

<a name="checking"></a>

# Checking for Numeric Type
To check whether a vector is made up of integer or double values:


{% highlight r %}
typeof(x)     # identifies the vector type (double, integer, logical, or character)
{% endhighlight %}

<br>

<small><a href="#">Go to top</a></small>
