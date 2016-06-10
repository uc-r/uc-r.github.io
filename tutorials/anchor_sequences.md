---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Character Strings](characters) &#187; [Regular Expressions](regex) &#187; [Regex Syntax](regex_syntax) &#187; Sequences

<br>

To match a sequence of characters we can apply short-hand notation which captures the fundamental types of sequences.  The following displays the general syntax for these common sequences:

<center>
<img src="/public/images/r_vocab/anchor_sequence.png" alt="Anchor Sequences" vspace="25">
</center>     

The following provides examples to show how to use the anchor syntax to find and replace sequences:


{% highlight r %}
gsub(pattern = "\\d", "_", "I'm working in RStudio v.0.99.484")
## [1] "I'm working in RStudio v._.__.___"

gsub(pattern = "\\D", "_", "I'm working in RStudio v.0.99.484")
## [1] "_________________________0_99_484"

gsub(pattern = "\\s", "_", "I'm working in RStudio v.0.99.484")
## [1] "I'm_working_in_RStudio_v.0.99.484"

gsub(pattern = "\\w", "_", "I'm working in RStudio v.0.99.484")
## [1] "_'_ _______ __ _______ _._.__.___"
{% endhighlight %}
&#9755; *For information on the `gsub` function visit the [main regex functions page](http://bradleyboehmke.github.io/tutorials/main_regex_functions).* 
