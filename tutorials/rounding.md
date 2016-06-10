---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Numbers](numbers) &#187; Rounding

* <a href="#nearest">Round to the nearest integer</a> 
* <a href="#up">Round up</a>
* <a href="#down">Round down</a>
* <a href="#specified">Round to a specified decimal</a>

<br>

Lets assume <em>x = 1, 1.35, 1.7, 2.05, 2.4, 2.75, 3.1, 3.45, 3.8, 4.15, 4.5, 4.85, 5.2, 5.55, 5.9</em>


<a name="nearest"></a>

# Round to the Nearest Integer

{% highlight r %}
round(x)
##  [1] 1 1 2 2 2 3 3 3 4 4 4 5 5 6 6
{% endhighlight %}

<a name="up"></a>

# Round Up

{% highlight r %}
ceiling(x)
##  [1] 1 2 2 3 3 3 4 4 4 5 5 5 6 6 6
{% endhighlight %}

<a name="down"></a>

# Round Down

{% highlight r %}
floor(x)
##  [1] 1 1 1 2 2 2 3 3 3 4 4 4 5 5 5
{% endhighlight %}

<a name="specified"></a>

# Round to a Specified Decimal

{% highlight r %}
round(x, digits = 1)
##  [1] 1.0 1.4 1.7 2.0 2.4 2.8 3.1 3.4 3.8 4.2 4.5 4.8 5.2 5.5 5.9
{% endhighlight %}

<br>

<small><a href="#">Go to top</a></small>
