---
layout: page
title: NULL
permalink: /tutorials/basics/packages/
---

[R Vocab Topics](http://bradleyboehmke.github.io/tutorials/) &#187; [Basics](http://bradleyboehmke.github.io/tutorials/basics/) &#187; Working with packages

<br>

In R, the fundamental unit of shareable code is the package.  A package bundles together code, data, documentation, and tests and provides an easy method to share with others.<sup><a href="#fn1" id="ref1">1</a></sup>  As of September 2015 there were over 7000 packages available on [CRAN](https://cran.r-project.org), 1000 on [Bioconductor](https://www.bioconductor.org), and countless more available through [GitHub](https://github.com).  This huge variety of packages is one of the reasons that R is so successful: chances are that someone has already solved a problem that you're working on, and you can benefit from their work by downloading their package.

<br>

# Installing Packages
To install packages: 

{% highlight r %}
install.packages("packagename")   # install packages from CRAN
{% endhighlight %}

As previously stated, packages are also available through Bioconductor and GitHub.  To download Bioconductor packages:

{% highlight r %}
source("http://bioconductor.org/biocLite.R")  # link to Bioconductor URL
biocLite()                                    # install core Bioconductor packages
biocLite("packagename")                       # install specific Bioconductor package
{% endhighlight %}

And to download GitHub packages:

{% highlight r %}
install.packages("devtools")                      # the devtools package provides a simply function to download GitHub packages
devtools::install_github("username/packagename")  # install package which exists at github.com/username/packagename
{% endhighlight %}

<br>

# Loading Packages
Once the package is downloaded to your computer you can access the functions and resources provided by the package in two different ways:

{% highlight r %}
library(packagename)         # load the package to use in the current R session
packagename::functionname    # use a particular function within a package without loading the package
{% endhighlight %}

For instance, if you want to have full access to the tidyr package you would use `library(tidyr)`; however, if you just wanted to use the `gather()` function without loading the tidyr package you can use `tidyr::gather(function arguments)`.

<br>

# Getting Help on Packages
For help on packages that are installed on your computer:


{% highlight r %}
help(package = "packagename")      # provides details regarding contents of a package
library()                          # see all packages installed 
search()                           # see packages currently loaded
vignette(package = "packagename")  # list vignettes available for a specific package
vignette("vignettename")           # view specific vignette
vignette()                         # view all vignettes on your computer
{% endhighlight %}

Note that some packages will have multiple vignettes.  For instance `vignette(package = "grid")` will list the 13 vignettes available for the grid package.  To access one of the specific vignettes you simply use `vignette("vignettename")`. 

<br>

<small><a href="#">Go to top</a></small>

<br>
<br>
<br><br>
<sup id="fn1">1. [[Wickham, H. (2015). *R packages.* "O'Reilly Media, Inc.".](http://r-pkgs.had.co.nz/)]<a href="#ref1" title="Jump back to footnote 1 in the text.">"&#8617;"</a><sup>
