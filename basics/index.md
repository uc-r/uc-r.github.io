---
id: 1836
title: R Basics
date: 2016-06-10
author: Brad Boehmke
layout: page
permalink: /section2_basics
---

> *"Programming is like kicking yourself in the face, sooner or later your nose will bleed."* - Kyle Woodbury


A computer language is described by its *syntax* and *semantics*; where syntax is about the the grammar of the language and semantics the meaning behind the sentence. And jumping into a new programming language correlates to visiting a foreign country with only that 9th grade Spanish 101 class under your belt; there is no better way to learn than to immerse yourself in the environment! Although it'll be painful early on and your nose will surely bleed, eventually you'll learn the dialect and the quircks that come along with it. 

Throughout this website you'll learn much of the fundamental syntax and semantics of the R programming language; and hopefully with minimal face kicking involved. However, this section serves to introduce you to many of the basics of R to get you comfortable.  This includes

* [Installing R & RStudio](#installation)
* [Understanding the Console](#workspace)
* [Getting help](#getting_help)
* [Working with packages](#packages)
* [Assignment & Evaluation](#assignment)
* [R as a calculator](#calculator)
* [Vectorization](#vectorization)
* [Styling guide](#style)

<br>

## Installing R & RStudio {#installation}


### <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/R_logo.svg/724px-R_logo.svg.png" style="width:50px;height:50px;">
Download and install R, [a free software environment for statistical computing and graphics](https://www.r-project.org/) from [CRAN](https://cran.rstudio.com/), the Comprehensive R Archive Network. It is highly recommended to install a precompiled binary distribution for your operating system; follow these instructions:

1. Go to [https://cran.r-project.org/](https://cran.r-project.org/)
2. Click "Download R for Mac/Windows"
3. Download the appropriate file:
    - Windows users click Base, and download the installer for the latest R version
    - Mac users select the file R-3.X.X.pkg that aligns with your OS version
4. Follow the instructions of the installer.

### <img src="https://upload.wikimedia.org/wikipedia/en/f/f0/RStudio_logo.png" style="width:15%;height:15%;">
Install RStudio's IDE (stands for integrated development environment), a powerful user interface for R. RStudio includes a text editor, so you do not have to install another stand-alone editor. Follow these instructions:

1. Go to RStudio for desktop [https://www.rstudio.com/products/rstudio/download/](https://www.rstudio.com/products/rstudio/download/)
2. Select the install file for your OS
3. Follow the instructions of the installer.

There are other R IDE's available: [Emacs](https://www.gnu.org/software/emacs/), [Microsoft R Open](http://revolutionanalytics.com/microsoft-r-open), [Notepad++](https://notepad-plus-plus.org/), etc; however, I have found RStudio to be my preferred route. When you are done installing RStudio click on the icon that looks like:

<center>
<img src="https://www.rstudio.com/wp-content/uploads/2014/06/RStudio-Ball.png" style="width:150px;height:150px;">
</center>

and you should get a window that looks like the following:

<center>
<img src="https://www.safaribooksonline.com/library/view/getting-started-with/9781449314798/httpatomoreillycomsourceoreillyimages1135858.png">
</center>

You are now ready to start programming!

<br>

## Understanding the Console {#workspace}
The RStudio console is where all the action happens. There are four fundamental windows in the console, each with their own purpose. I discuss each briefly below but I highly suggest [this tutorial](http://dss.princeton.edu/training/RStudio101.pdf) for a thorough understanding of the console. 

<center>
<img src="/public/images/RStudio_console.png">
</center>

### Script Editor
The top left window is where your script files will display. There are multiple forms of script files but the basic one to start with is the .R file. To create a new file you use the **File -> New File** menu. To open an existing file you use either the **File -> Open File...** menu or the **Recent Files** menu to select from recently opened files. RStudio's source editor includes a variety of productivity enhancing features including syntax highlighting, code completion, multiple-file editing, and find/replace. A good introduction to the script editor can be found [here](https://support.rstudio.com/hc/en-us/articles/200484448-Editing-and-Executing-Code).

### Workspace Environment
The top right window is the workspace environment which captures much of your your current R working environment and includes any user-defined objects (vectors, matrices, data frames, lists, functions).  When saving your R working session, these are the components along with the script files that will be saved in your working directory, which is the default location for all file inputs and outputs.  To get or set your working directory so you can direct where your files are saved:

```r
# returns path for the current working directory
getwd()                  

# set the working directory to a specified directory
setwd(directory_name)    
```

For example, if I call `getwd()` the file path "/Users/bradboehmke/Desktop/Personal/Data Wrangling" is returned.  If I want to set the working directory to the "Workspace" folder within the "Data Wrangling" directory I would use `setwd("Workspace")`.  Now if I call `getwd()` again it returns "/Users/bradboehmke/Desktop/Personal/Data Wrangling/Workspace".

The workspace environment will also list your user defined objects such as vectors, matrices, data frames, lists, and functions. To identify or remove the objects (i.e. vectors, data frames, user defined functions, etc.) in your current R environment:

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

You can also view previous commands in the workspace environment by clicking the **History** tab, by simply pressing the up arrow on your keyboard, or by typing into the console:


```r
# default shows 25 most recent commands
history()        

# show 100 most recent commands
history(100)     

# show entire saved history
history(Inf)     
```

You can also save and load your workspaces.  Saving your workspace will save all R files and objects within your workspace to a .RData file in your working directory and loading your workspace will load any .RData files in your working directory.


```r
# save all items in workspace to a .RData file
save.image()                                  

# save specified objects to a .RData file
save(object1, object2, file = "myfile.RData")    

# load workspace into current session
load("myfile.RData")                             
```

Note that saving the workspace without specifying the working directory will default to saving in the current directory.  You can further specify where to save the .RData by including the path: `save(object1, object2, file = "/users/name/folder/myfile.RData")`

### Console
The bottom left window contains the console. You can code directly in this window but it will not save your code. It is best to use this window when you are simply wanting to perform calculator type functions.  This is also where your outputs will be presented when you run code in your script.

### Misc. Displays
The bottom right window contains multiple tabs. The **Files** tab allows you to see which files are available in your working directory. The **Plots** tab will display any plots/graphics that are produced by your code. The **Packages** tab will list all packages downloaded to your computer and also the ones that are loaded (more on this later). And the **Help** tab allows you to search for topics you need help on and will also display any help responses (more on this later as well).

### Workspace Options & Shortcuts {#options}
There are multiple options available for you to set and customize your console. You can view and set options for the current R session:

```r
# learn about available options
help(options)

# view current option settings
options()            

# change a specific option (i.e. number of digits to print on output)
options(digits=3)    
```

For a thorough tutorial regarding the RStudio console and how to customize different components check out [this tutorial](http://dss.princeton.edu/training/RStudio101.pdf). You can also find the RStudio console cheatsheet shown below [here](https://www.rstudio.com/wp-content/uploads/2016/01/rstudio-IDE-cheatsheet.pdf) or by going to Help menu &#187; Cheatsheets.  As with most computer programs, there are numerous keyboard shortcuts for working with the console. To access a menu displaying all the shortcuts in RStudio you can use option + shift + k.  Within RStudio you can also access them in the Help menu &#187; Keyboard Shortcuts.

<center>
<img src="/public/images/RStudio Cheatsheet.png">
</center>


<br>

## Getting Help {#getting_help}

The help documentation and support in R is comprehensive and easily accessible from the command line.  

### General Help {#general_help}
To leverage general help resources you can use:  

```r
help.start()           # provides general help links
help.search("text")    # searches the help system for documentation matching a given character string
```

Note that the `help.search("some text here")` function requires a character string enclosed in quotation marks.


### Getting Help on Packages

For more direct help on packages that are installed on your computer:


```r
help(package = "packagename")      # provides details regarding contents of a package
vignette(package = "packagename")  # list vignettes available for a specific package
vignette("vignettename")           # view specific vignette
vignette()                         # view all vignettes on your computer
```

Note that some packages will have multiple vignettes.  For instance `vignette(package = "grid")` will list the 13 vignettes available for the grid package.  To access one of the specific vignettes you simply use `vignette("vignettename")`.  


### Getting Help on Functions

For more direct help on functions that are installed on your computer:


```r
help(functionname)      # provides details for specific function
?functionname           # provides same information as help(functionname) 
example(functionname)   # provides examples for said function
```

Note that the `help()` and `?` function calls only work for functions within loaded packages.  If you want to see details on a function in a package that is installed on your computer but not loaded in the active R session you can use `help(functionname, package = "packagename")`.  Another alternative is to use the `::` operator as in `help(packagename::functionname)`.


### Getting Help from the Web
Typically, a problem you may be encountering is not new and others have faced, solved, and documented the same issue online.  The following resources can be used to search for online help.  Although, I typically just google the problem and find answers relatively quickly.

* `RSiteSearch("key phrase")`:  searches for the key phrase in help manuals and archived mailing lists on the [R Project website]("http://search.r-project.org/").
* [Stack Overflow](http://stackoverflow.com/): a searchable Q&A site oriented toward programming issues.  75% of my answers typically come from Stack Overflow.
* [Cross Validated](http://stats.stackexchange.com/): a searchable Q&A site oriented toward statistical analysis.
* [R-seek](http://rseek.org): a Google custom search that is focused on R-specific websites
* [R-bloggers](http://www.r-bloggers.com/): a central hub of content collected from over 500 bloggers who provide news and tutorials about R.

<br>


## Working with packages {#packages}

In R, the fundamental unit of shareable code is the package.  A package bundles together code, data, documentation, and tests and provides an easy method to share with others[^hadley_R_Packages].  As of June 2016 there were over 8000 packages available on [CRAN](https://cran.r-project.org), 1000 on [Bioconductor](https://www.bioconductor.org), and countless more available through [GitHub](https://github.com).  This huge variety of packages is one of the reasons that R is so successful: chances are that someone has already solved a problem that you're working on, and you can benefit from their work by downloading their package.


### Installing Packages {#install}

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

### Loading Packages {#load}

Once the package is downloaded to your computer you can access the functions and resources provided by the package in two different ways:


```r
# load the package to use in the current R session
library(packagename)         

# use a particular function within a package without loading the package
packagename::functionname    
```

For instance, if you want to have full access to the tidyr package you would use `library(tidyr)`; however, if you just wanted to use the `gather()` function without loading the tidyr package you can use `tidyr::gather(function arguments)`.


### Getting Help on Packages {#help}

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


<br>

## Assignment & Evaluation {#assignment}
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

<br>

## R as a Calculator {#calculator}
At its most basic function R can be used as a calculator.  When applying basic arithmetic, the PEMBDAS order of operations applies: **p**arentheses first followed by **e**xponentiation, **m**ultiplication and **d**ivision, and final **a**ddition and **s**ubtraction.


```r
8 + 9 / 5 ^ 2
## [1] 8.36

8 + 9 / (5 ^ 2)
## [1] 8.36

8 + (9 / 5) ^ 2
## [1] 11.24

(8 + 9) / 5 ^ 2
## [1] 0.68
```

By default R will display seven digits but this can be changed using `options()` as previously outlined.


```r
1 / 7
## [1] 0.1428571

options(digits = 3)
1 / 7
## [1] 0.143
```

Also, large numbers will be expressed in scientific notation which can also be adjusted using `options()`.


```r
888888 * 888888
## [1] 7.9e+11

options(digits = 10)
888888 * 888888
## [1] 790121876544
```

Note that the largest number of digits that can be displayed is 22.  Requesting any larger number of digits will result in an error message.


```r
pi
## [1] 3.141592654

options(digits = 22)
pi
## [1] 3.141592653589793115998

options(digits = 23)
## Error in options(digits = 23): invalid 'digits' parameter, allowed 0...22
pi
## [1] 3.141592653589793115998
```

When performing undefined calculations R will produce `Inf` and `NaN` outputs.


```r
1 / 0           # infinity
## [1] Inf

Inf - Inf       # infinity minus infinity
## [1] NaN

-1 / 0          # negative infinity
## [1] -Inf

0 / 0           # not a number
## [1] NaN

sqrt(-9)        # square root of -9
## Warning in sqrt(-9): NaNs produced
## [1] NaN
```

The last two functions to mention are the integer divide (`%/%`) and modulo (`%%`) functions.  The integer divide function will give the integer part of a fraction while the modulo will provide the remainder.


```r
42 / 4          # regular division
## [1] 10.5

42 %/% 4        # integer division
## [1] 10

42 %% 4         # modulo (remainder)
## [1] 2
```

<br>

## Vectorization {#vectorization}
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

<br>

## Styling guide {#style}

> *"Good coding style is like using correct punctuation. You can manage without it, but it sure makes things easier to read."* - Hadley Wickham 

As a medium of communication, its important to realize that the readability of code does in fact make a difference. Well styled code has many benefits to include making it easy to *i*) read, *ii*) extend, and *iii*) debug. Unfortunately, R does not come with official guidelines for code styling but such is an inconvenient truth of most open source software. However, this should not lead you to believe there is no style to be followed and over time implicit guidelines for proper code styling have been documented. What follows are guidelines that have been widely accepted as good practice in the R community and are based on [Google's](https://google.github.io/styleguide/Rguide.xml) and [Hadley Wickham's](http://adv-r.had.co.nz/Style.html) R style guides. 


### Notation and naming
File names should be meaningful and end with a `.R` extension.


```r
# Good
weather-analysis.R
emerson-text-analysis.R

# Bad
basic-stuff.r
detail.r
```

If files need to be run in sequence, prefix them with numbers:


```r
0-download.R
1-preprocessing.R
2-explore.R
3-fit-model.R
```

In R, naming conventions for variables and function are famously muddled. They include the following:


```r
namingconvention        # all lower case; no separator
naming.convention       # period separator
naming_convention       # underscore separator
namingConvention        # lower camel case
NamingConvention        # upper camel case
```

Historically, there has been no clearly preferred approach with multiple naming styles sometimes used within a single package. Bottom line, your naming convention will be driven by your preference but the ultimate goal should be consistency.

My personal preference is to use all lowercase with an underscore (_) to separate words within a name. This follows Hadley Wickham's suggestions in his style guide. Furthermore, variable names should be nouns and function names should be verbs to help distinguish their purpose. Also, refrain from using existing names of functions (i.e. mean, sum, true).


### Organization
Organization of your code is also important.  There's nothing like trying to decipher 2,000 lines of code that has no organization. The easiest way to achieve organization is to comment your code.  The general commenting scheme I use is the following.

I break up principal sections of my code that have a common purpose with:


```r
#################
# Download Data #
#################
lines of code here

###################
# Preprocess Data #
###################
lines of code here

########################
# Exploratory Analysis #
########################
lines of code here
```

Then comments for specific lines of code can be done as follows:


```r
code_1  # short comments can be placed to the right of code 
code_2  # blah
code_3  # blah

# or comments can be placed above a line of code
code_4

# Or extremely long lines of commentary that go beyond the suggested 80 
# characters per line can be broken up into multiple lines. Just don't forget
# to use the hash on each.
code_5
```


### Syntax

The maximum number of characters on a single line of code should be 80 or less. If you are using RStudio you can have a margin displayed so you know when you need to break to a new line.[^character_length]  This allows your code to be printed on a normal 8.5 x 11 page with a reasonably sized font.  Also, when indenting your code use two spaces rather than using tabs.  The only exception is if a line break occurs inside parentheses. In this case align the wrapped line with the first character inside the parenthesis:


```r
super_long_name <- seq(ymd_hm("2015-1-1 0:00"), 
                       ymd_hm("2015-1-1 12:00"), 
                       by = "hour")
```

Proper spacing within your code also helps with readability.  The following pulls straight from [Hadley Wickham's suggestions](http://adv-r.had.co.nz/Style.html). Place spaces around all infix operators (`=`, `+`, `-`, `<-`, etc.). The same rule applies when using `=` in function calls. Always put a space after a comma, and never before.


```r
# Good
average <- mean(feet / 12 + inches, na.rm = TRUE)

# Bad
average<-mean(feet/12+inches,na.rm=TRUE)
```

There's a small exception to this rule: `:`, `::` and `:::` don't need spaces around them.


```r
# Good
x <- 1:10
base::get

# Bad
x <- 1 : 10
base :: get
```

It is important to think about style when communicating any form of language. Writing code is no exception and is especially important if your code will be read by others. Following these basic style guides will get you on the right track for writing code that can be easily communicated to others. 


[^character_length]: Go to *RStudio* on the menu bar then *Preferences* > *Code* > *Display* and you can select the "show margin" option and set the margin to 80.
[^hadley_R_Packages]: [Wickham, H. (2015). *R packages.* "O'Reilly Media, Inc.".](http://r-pkgs.had.co.nz/)
