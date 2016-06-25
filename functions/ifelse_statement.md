---
layout: tutorial
title: <code>if...else</code> Statement
permalink: /ifelse_statement
---

The conditional `if...else` statement is used to test an expression similar to the `if` statement.  However, rather than nothing happening if the `test_expression` is `FALSE`, the `else` part of the function will be evaluated. 


```r
# syntax of if...else statement
if (test_expression) {
        statement 1
} else {
        statement 2
}
```

The following extends the [previous example](http://uc-r.github.io/if_statement) illustrated for the `if` statement in which the `if` statement tests if any values in a vector are negative; if `TRUE` it produces one output and if `FALSE` it produces the `else` output.  


```r
# this test results in statement 1 being executed
x <- c(8, 3, -2, 5)

if(any(x < 0)){
        print("x contains negative numbers")
} else{
        print("x contains all positive numbers")
}
## [1] "x contains negative numbers"

# this test results in statement 2 (or the else statement) being executed
y <- c(8, 3, 2, 5)

if(any(y < 0)){
        print("y contains negative numbers")
} else{
        print("y contains all positive numbers")
}
## [1] "y contains all positive numbers"
```

Simple `if...else` statements, as above, in which only one line of code is being executed in the statements can be written in a simplified alternative manner.  These alternatives are only recommended for very short `if...else` code:


```r
x <- c(8, 3, 2, 5)

# alternative 1
if(any(x < 0)) print("x contains negative numbers") else print("x contains all positive numbers")
## [1] "x contains all positive numbers"

# alternative 2 using the ifelse function
ifelse(any(x < 0), "x contains negative numbers", "x contains all positive numbers")
## [1] "x contains all positive numbers"
```

We can also nest as many `if...else` statements as required (or desired).  For example:


```r
# this test results in statement 1 being executed
x <- 7

if(x >= 10){
        print("x exceeds acceptable tolerance levels")
} else if(x >= 0 & x < 10){
        print("x is within acceptable tolerance levels")
} else {
         print("x is negative")
}
## [1] "x is within acceptable tolerance levels"
```
