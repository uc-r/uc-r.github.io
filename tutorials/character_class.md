---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Character Strings](characters) &#187; [Regular Expressions](regex) &#187; [Regex Syntax](regex_syntax) &#187; Character classes

<br>

To match one of several characters in a specified set we can enclose the characters of concern with square brackets [ ].  In addition, to match any characters **not** in a specified character set we can include the caret ^ at the beginning of the set within the brackets.  The following displays the general syntax for common character classes but these can be altered easily as shown in the examples that follow:

<center>
<img src="/public/images/r_vocab/character_class.png" alt="Character Classes" vspace="25">
</center>     


The following provides examples to show how to use the anchor syntax to match character classes:


{% highlight r %}
x <- c("RStudio", "v.0.99.484", "2015", "09-22-2015", "grep vs. grepl")

grep(pattern = "[0-9]", x, value = TRUE)
## [1] "v.0.99.484" "2015"       "09-22-2015"

grep(pattern = "[6-9]", x, value = TRUE)
## [1] "v.0.99.484" "09-22-2015"

grep(pattern = "[Rr]", x, value = TRUE)
## [1] "RStudio"        "grep vs. grepl"

grep(pattern = "[^0-9a-zA-Z]", x, value = TRUE)
## [1] "v.0.99.484"     "09-22-2015"     "grep vs. grepl"
{% endhighlight %}
&#9755; *For information on the `grep` function visit the [main regex functions page](http://bradleyboehmke.github.io/tutorials/main_regex_functions).*
