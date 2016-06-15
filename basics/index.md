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
* [Assignment & Evaluation](assignment)
* [Vectorization](#basics_vectorization): a wonderful simplification of functionality
* [Styling guide](style): use these generally accepted guidelines to start writing code that is easy to read, extend, and debug






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



[^character_length]: Go to *RStudio* on the menu bar then *Preferences* > *Code* > *Display* and you can select the "show margin" option and set the margin to 80.
