---
layout: tutorial
title: <code>if</code> Statement
permalink: /if_statement
---

The conditional `if` statement is used to test an expression.  If the `test_expression` is `TRUE`, the `statement` gets executed. But if it's `FALSE`, nothing happens. 


```r
# syntax of if statement
if (test_expression) {
        statement
}
```

The following is an example that tests if any values in a vector are negative.  Notice there are two ways to write this `if` statement; since the body of the statement is only one line you can write it with or without curly braces.  I recommend getting in the habit of using curly braces, that way if you build onto if statements with additional functions in the body or add an `else` statement later you will not run into issues with unexpected code procedures.


```r
x <- c(8, 3, -2, 5)

# without curly braces
if(any(x < 0)) print("x contains negative numbers")
## [1] "x contains negative numbers"

# with curly braces produces same result
if(any(x < 0)){
        print("x contains negative numbers")
}
## [1] "x contains negative numbers"

# an if statement in which the test expression is FALSE
# does not produce any output
y <- c(8, 3, 2, 5)

if(any(y < 0)){
        print("y contains negative numbers")
}
```
