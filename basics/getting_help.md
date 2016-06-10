---
layout: page
title: NULL
permalink: /tutorials/basics/getting_help/
---

[R Vocab Topics](http://bradleyboehmke.github.io/tutorials/) &#187; [Basics](http://bradleyboehmke.github.io/tutorials/basics/) &#187; Getting help

<br>

The help documentation and support in R is comprehensive and easily accessible from the command line.  

# General Help
To leverage general help resources you can use:  


{% highlight r %}
help.start()           # provides general help links
help.search("text")    # searches the help system for documentation matching a given character string
{% endhighlight %}

Note that the `help.search("some text here")` function requires a character string enclosed in quotation marks.

<br>

# Getting Help on Packages

For more direct help on packages that are installed on your computer:


{% highlight r %}
help(package = "packagename")      # provides details regarding contents of a package
vignette(package = "packagename")  # list vignettes available for a specific package
vignette("vignettename")           # view specific vignette
vignette()                         # view all vignettes on your computer
{% endhighlight %}

Note that some packages will have multiple vignettes.  For instance `vignette(package = "grid")` will list the 13 vignettes available for the grid package.  To access one of the specific vignettes you simply use `vignette("vignettename")`.  

<br>

# Getting Help on Functions

For more direct help on functions that are installed on your computer:


{% highlight r %}
help(functionname)      # provides details for specific function
?functionname           # provides same information as help(functionname) 
example(functionname)   # provides examples for said function
{% endhighlight %}

Note that the `help()` and `?` function calls only work for functions within loaded packages.  If you want to see details on a function in a package that is installed on your computer but not loaded in the active R session you can use `help(functionname, package = "packagename")`.  Another alternative is to use the `::` operator as in `help(packagename::functionname)`.

<br>

# Getting Help from the Web
Typically, a problem you may be encountering is not new and others have faced, solved, and documented the same issue online.  The following resources can be used to search for online help.  Although, I typically just google the problem and find answers relatively quickly.

* `RSiteSearch("key phrase")`:  searches for the key phrase in help manuals and archived mailing lists on the [R Project website]("http://search.r-project.org/").
* [Stack Overflow](http://stackoverflow.com/): a searchable Q&A site oriented toward programming issues.  75% of my answers typically come from Stack Overflow.
* [Cross Validated](http://stats.stackexchange.com/): a searchable Q&A site oriented toward statistical analysis.
* [R-seek](http://rseek.org): a Google custom search that is focused on R-specific websites
* [R-bloggers](http://www.r-bloggers.com/): a central hub of content collected from over 500 bloggers who provide news and tutorials about R.

<small><a href="#">Go to top</a></small>
