---
layout: tutorial
title: Assignment & Evaluation
permalink: /assignment/
---

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



