---
layout: tutorial
title: <code>repeat</code> Loop
permalink: /repeat_loop
---

A `repeat` loop is used to iterate over a block of code multiple number of times. There is test expression in a repeat loop to end or exit the loop. Rather, we must put a condition statement explicitly inside the body of the loop and use the `break` function to exit the loop. Failing to do so will result into an infinite loop.


```r
# syntax of repeat loop
counter <- 1

repeat {
        statement
        
        if(test_expression){
                break
        }
        counter <- counter + 1
}
```

For example ,say we want to randomly draw values from a uniform distribution between 1 and 25.  Furthermore, we want to continue to draw values randomly until our sample contains at least each integer value between 1 and 25; however, we do not care if we've drawn a particular value multiple times.  The following code repeats the random draws of values between 1 and 25 (in which we round).  We then include an `if` statement to check if all values between 1 and 25 are present in our sample.  If so, we use the [`break`](#break) statement to exit the loop.  If not, we add to our counter and let the loop repeat until the conditional `if` statement is found to be true.  We can then check the `counter` object to assess how many iterations were required to reach our conditional requirement.  


```r
counter <- 1
x <- NULL

repeat {
        x <- c(x, round(runif(1, min = 1, max = 25)))
        
        if(all(1:25 %in% x)){
                break
        }
                
        counter <- counter + 1
}

counter
## [1] 75
```
