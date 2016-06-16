---
layout: tutorial
title: Working with Packages
permalink: /packages/
---

In R, the fundamental unit of shareable code is the package.  A package bundles together code, data, documentation, and tests and provides an easy method to share with others[^hadley_R_Packages].  As of June 2016 there were over 8000 packages available on [CRAN](https://cran.r-project.org), 1000 on [Bioconductor](https://www.bioconductor.org), and countless more available through [GitHub](https://github.com).  This huge variety of packages is one of the reasons that R is so successful: chances are that someone has already solved a problem that you're working on, and you can benefit from their work by downloading their package.

<br>

## Installing Packages {#install}

To install packages: 


```r
# install packages from CRAN
install.packages("packagename")   
```

As previously stated, packages are also available through Bioconductor and GitHub.  To download Bioconductor packages:


```r
# link to Bioconductor URL
source("http://bioconductor.org/biocLite.R")  

# install core Bioconductor packages
biocLite()                                    

# install specific Bioconductor package
biocLite("packagename")                       
```

And to download GitHub packages:


```r
# the devtools package provides a simply function to download GitHub packages
install.packages("devtools")                      

# install package which exists at github.com/username/packagename
devtools::install_github("username/packagename")  
```
<br>

## Loading Packages {#load}

Once the package is downloaded to your computer you can access the functions and resources provided by the package in two different ways:


```r
# load the package to use in the current R session
library(packagename)         

# use a particular function within a package without loading the package
packagename::functionname    
```
For instance, if you want to have full access to the tidyr package you would use `library(tidyr)`; however, if you just wanted to use the `gather()` function without loading the tidyr package you can use `tidyr::gather(function arguments)`.

<br>

## Getting Help on Packages {#help}

For help on packages that are installed on your computer:


```r
# provides details regarding contents of a package
help(package = "packagename")

# see all packages installed
library()                          

# see packages currently loaded
search()                           

# list vignettes available for a specific package
vignette(package = "packagename")  

# view specific vignette
vignette("vignettename")           

# view all vignettes on your computer
vignette()                         
```

Note that some packages will have multiple vignettes.  For instance `vignette(package = "grid")` will list the 13 vignettes available for the grid package.  To access one of the specific vignettes you simply use `vignette("vignettename")`.

<br>

## Useful packages
There are thousands of helpful R packages for you to use, but navigating them all can be a challenge.  To help you out, RStudio compiled a [guide](https://support.rstudio.com/hc/en-us/articles/201057987-Quick-list-of-useful-R-packages) to some of the best packages for loading, manipulating, visualizing, analyzing, and reporting data.  In addition, their list captures packages that specialize in spatial data, time series and financial data, increasing spead and performance, and developing your own R packages. 

<br>

[^hadley_R_Packages]: [Wickham, H. (2015). *R packages.* "O'Reilly Media, Inc.".](http://r-pkgs.had.co.nz/)
