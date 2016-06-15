---
id: 1836
title: R Basics
date: 2016-06-10
author: Brad Boehmke
layout: page
permalink: /section2_basics
---

* [Installing R & RStudio](installation)
* [Getting help](getting_help)
* [Workspace](workspace)
* [Working with packages](packages)
* [Useful packages](https://support.rstudio.com/hc/en-us/articles/201057987-Quick-list-of-useful-R-packages)
* [Assignment & Evaluation](assignment): understand how to assign and evaluate expressions
* [Vectorization](#basics_vectorization): a wonderful simplification of functionality
* [Styling guide](style): use these generally accepted guidelines to start writing code that is easy to read, extend, and debug


- [Assignment & Evaluation](#basics_assignment): understand how to assign and evaluate expressions
- [Vectorization](#basics_vectorization): a wonderful simplification of functionality
- [Getting help](basics/getting_help/): leverage R's comprehensive and easily accessible help resources
- [Workspace](#basics_workspace): the basics for understanding, configuring and customizing your current R environment
- [Working with packages](#packages): the fundamental unit of sharing code
- [Styling guide](#style_guide): use these generally accepted guidelines to start writing code that is easy to read, extend, and debug  

<br>

## Assignment & Evaluation {#basics_assignment}
The first operator you'll run into is the assignment operator. The assignment operator is used to *assign* a value. For instance we can assign the value 3 to the variable `x` using the `<-` assignment operator.  We can then evaluate the variable by simply typing `x` at the command line which will return the value of `x`.  Note that prior to the value returned you'll see `## [1]` in the command line.  This simply implies that the output returned is the first output. Note that you can type any comments in your code by preceding the comment with the hashtag (`#`) symbol.  Any values, symbols, and texts following `#` will not be evaluated.


```r
# assignment
x <- 3

# evaluation
x
## [1] 3
```

Interestingly, R actually allows for five assignment operators:


```r
# leftward assignment
x <- value
x = value
x <<- value

# rightward assignment
value -> x
value ->> x
```

The original assignment operator in R was `<-` and has continued to be the preferred among R users.  The `=` assignment operator was [added in 2001](http://developer.r-project.org/equalAssign.html) primarily because it is the accepted assignment operator in many other languages and beginners to R coming from other languages were so prone to use it. However, R uses `=` to associate function arguments with values (i.e. f(x = 3) explicitly means to call function f and set the argument x to 3.  Consequently, most R programmers prefer to keep `=` reserved for argument association and use `<-` for assignment.

The operators `<<-` is normally only used in functions which we will not get into the details.  And the rightward assignment operators perform the same as their leftward counterparts, they just assign the value in an opposite direction.

Overwhelmed yet?  Don't be.  This is just meant to show you that there are options and you will likely come across them sooner or later.  My suggestion is to stick with the tried and true `<-` operator.  This is the most conventional assignment operator used and is what you will find in all the base R source code...which means it should be good enough for you. 

Lastly, note that R is a case sensitive programming language.  Meaning all variables, functions, and objects must be called by their exact spelling:


```r
x <- 1 
y <- 3 
z <- 4
x * y * z
## [1] 12

x * Y * z 
## Error in eval(expr, envir, enclos): object 'Y' not found
```

Let's move on.

<a href="#">Go to top</a>

<br>

## Vectorization {#basics_vectorization}
A key difference between R and many other languages is a topic known as vectorization. What does this mean? It means that many functions that are to be applied individually to each element in a vector of numbers require a *loop* assessment to evaluate; however, in R many of these functions have been coded in C to perform much faster than a `for` loop would perform.  For example, let's say you want to add the elements of two seperate vectors of numbers (`x` and `y`). 


```r
x <- c(1, 3, 4)
y <- c(1, 2, 4)

x
## [1] 1 3 4
y
## [1] 1 2 4
```

In other languages you might have to run a loop to add two vectors together. In this `for` loop I print each iteration to show that the loop calculates the sum for the first elements in each vector, then performs the sum for the second elements, etc.


```r
# empty vector 
z <- as.vector(NULL)

# `for` loop to add corresponding elements in each vector
for (i in seq_along(x)) {
        z[i] <- x[i] + y[i]
        print(z)
}
## [1] 2
## [1] 2 5
## [1] 2 5 8
```

Instead, in R, `+` is a vectorized function which can operate on entire vectors at once. So rather than creating `for` loops for many function, you can just use simple syntax:


```r
x + y
## [1] 2 5 8
x * y
## [1]  1  6 16
x > y
## [1] FALSE  TRUE FALSE
```

When performing vector operations in R, it is important to know about *recycling*. When performing an operation on two or more vectors of unequal length, R will recycle elements of the shorter vector(s) to match the longest vector. For example:


```r
long <- 1:10
short <- 1:5

long
##  [1]  1  2  3  4  5  6  7  8  9 10
short
## [1] 1 2 3 4 5

long + short
##  [1]  2  4  6  8 10  7  9 11 13 15
```

The elements of `long` and `short` are added together starting from the first element of both vectors. When R reaches the end of the `short` vector, it starts again at the first element of `short` and contines until it reaches the last element of the `long` vector. This functionality is very useful when you want to perform the same operation on every element of a vector. For example, say we want to multiply every element of our vector long by 3:


```r
long <- 1:10
c <- 3

long * c
##  [1]  3  6  9 12 15 18 21 24 27 30
```

Remember there are no scalars in R, so `c` is actually a vector of length 1; in order to add its value to every element of `long`, it is recycled to match the length of `long`.

When the length of the longer object is a multiple of the shorter object length, the recycling occurs silently. When the longer object length is not a multiple of the shorter object length, a warning is given:


```r
even_length <- 1:10
odd_length <- 1:3

even_length + odd_length
## Warning in even_length + odd_length: longer object length is not a multiple
## of shorter object length
##  [1]  2  4  6  5  7  9  8 10 12 11
```

<a href="#">Go to top</a>

<br>

## Getting help {#basics_help}
Learning any new language requires lots of help.  Luckily, the help documentation and support in R is comprehensive and easily accessible from the command line. To leverage general help resources you can use the following:  


```r
# provides general help links
help.start()   

# searches the help system for documentation matching a given character string
help.search("text")    
```
Note that the `help.search("some text here")` function requires a character string enclosed in quotation marks. So if you are in search of time series functions in R, using `help.search("time series")` will pull up a healthy list of vignettes and code demonstrations that illustrate packages and functions that work with time series data.


### Getting Help on Functions

For more direct help on functions that are installed on your computer:


```r
# provides details for specific function
help(functionname)      

# provides same information as help(functionname)
?functionname           

# provides examples for said function
example(functionname)   
```

Note that the `help()` and `?` function calls only work for functions within loaded packages.  If you want to see details on a function in a package that is installed on your computer but not loaded in the active R session you can use `help(functionname, package = "packagename")`.  Another alternative is to use the `::` operator as in `help(packagename::functionname)`.

### Getting Help from the Web
Typically, a problem you may be encountering is not new and others have faced, solved, and documented the same issue online.  The following resources can be used to search for online help.  Although, I typically just google the problem and find answers relatively quickly.

* `RSiteSearch("key phrase")`:  searches for the key phrase in help manuals and archived mailing lists on the [R Project website]("http://search.r-project.org/").
* [Stack Overflow](http://stackoverflow.com/): a searchable Q&A site oriented toward programming issues.  75% of my answers typically come from Stack Overflow.
* [Cross Validated](http://stats.stackexchange.com/): a searchable Q&A site oriented toward statistical analysis.
* [R-seek](http://rseek.org): a Google custom search that is focused on R-specific websites
* [R-bloggers](http://www.r-bloggers.com/): a central hub of content collected from over 500 bloggers who provide news and tutorials about R.

<a href="#">Go to top</a>

<br>

## Workspace {#basics_workspace}
The workspace is your current R working environment and includes any user-defined objects (vectors, matrices, data frames, lists, functions).  The following code provides the basics for understanding, configuring and customizing your current R environment.

### Working Directory
The *working directory* is the default location for all file inputs and outputs.  


```r
# returns path for the current working directory
getwd()                  

# set the working directory to a specified directory
setwd(directory_name)    
```

For example, if I call `getwd()` the file path "/Users/bradboehmke/Desktop/Personal/Data Wrangling" is returned.  If I want to set the working directory to the "Workspace" folder within the "Data Wrangling" directory I would use `setwd("Workspace")`.  Now if I call `getwd()` again it returns "/Users/bradboehmke/Desktop/Personal/Data Wrangling/Workspace".

### Environment Objects
To identify or remove the objects (i.e. vectors, data frames, user defined functions, etc.) in your current R environment:


```r
# list all objects
ls()              

# identify if an R object with a given name is present
exists("object_name")        

# remove defined object from the environment
rm("object_name")            

# you can remove multiple objects by using the `c()` function
rm(c("object1", "object2"))  

# basically removes everything in the working environment -- use with caution!
rm(list = ls())              
```



### Command History
You can view previous commands one at a time by simply pressing the up arrow on your keyboard or view a defined number of previous commands with:


```r
# default shows 25 most recent commands
history()        

# show 100 most recent commands
history(100)     

# show entire saved history
history(Inf)     
```


### Saving & Loading 
You can save and load your workspaces.  Saving your workspace will save all R files and objects within your workspace to a .RData file.


```r
# save all items in workspace to a .RData file
save.image()                                  

# save specified objects to a .RData file
save(object1, object2, file = "myfile.RData")    

# load workspace into current session
load("myfile.RData")                             
```

Note that saving the workspace without specifying the working directory will default to saving in the current directory.  You can further specify where to save the .RData by including the path: `save(object1, object2, file = "/users/name/folder/myfile.RData")`


### Workspace Options
You can view and set options for the current R session:


```r
# learn about available options
help(options)

# view current option settings
options()            

# change a specific option (i.e. number of digits to print on output)
options(digits=3)    
```


### Shortcuts
To access a menu displaying all the shortcuts in RStudio you can use option + shift + k.  Within RStudio you can also access them in the Help menu &#187; Keyboard Shortcuts.

<a href="#">Go to top</a>

<br>

## Working with packages {#packages}
In R, the fundamental unit of shareable code is the package.  A package bundles together code, data, documentation, and tests and provides an easy method to share with others[^hadley_R_Packages].  As of September 2015 there were over 7000 packages available on [CRAN](https://cran.r-project.org), 1000 on [Bioconductor](https://www.bioconductor.org), and countless more available through [GitHub](https://github.com).  This huge variety of packages is one of the reasons that R is so successful: chances are that someone has already solved a problem that you're working on, and you can benefit from their work by downloading their package.

### Installing Packages
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

### Loading Packages
Once the package is downloaded to your computer you can access the functions and resources provided by the package in two different ways:


```r
# load the package to use in the current R session
library(packagename)         

# use a particular function within a package without loading the package
packagename::functionname    
```
For instance, if you want to have full access to the tidyr package you would use `library(tidyr)`; however, if you just wanted to use the `gather()` function without loading the tidyr package you can use `tidyr::gather(function arguments)`.


### Getting Help on Packages
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


### Useful packages
There are thousands of helpful R packages for you to use, but navigating them all can be a challenge.  To help you out, RStudio compiled a [guide](https://support.rstudio.com/hc/en-us/articles/201057987-Quick-list-of-useful-R-packages) to some of the best packages for loading, manipulating, visualizing, analyzing, and reporting data.  In addition, their list captures packages that specialize in spatial data, time series and financial data, increasing spead and performance, and developing your own R packages. 

<a href="#">Go to top</a>

<br>




[^hadley_R_Packages]: [Wickham, H. (2015). *R packages.* "O'Reilly Media, Inc.".](http://r-pkgs.had.co.nz/)

[^character_length]: Go to *RStudio* on the menu bar then *Preferences* > *Code* > *Display* and you can select the "show margin" option and set the margin to 80.
