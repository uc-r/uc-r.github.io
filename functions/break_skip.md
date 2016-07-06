---
layout: tutorial
title: <code>break</code> and <code>next</code> Arguments
permalink: /break_skip
---


The `break` argument is used to exit a loop immediately, regardless of what iteration the loop may be on.  `break` arguments are typically embedded in an `if` statement in which a condition is assessed, if TRUE `break` out of the loop, if FALSE continue on with the loop.  In a nested looping situation, where there is a loop inside another loop, this statement exits from the innermost loop that is being evaluated.

In this example, the `for` loop will iterate for each element in `x`; however, when it gets to the element that equals 3 it will break out and end the `for` loop process.


```r
x <- 1:5

for (i in x) {
        if (i == 3){
                break
                }
        print(i)
}
## [1] 1
## [1] 2
```


The `next` argument is useful when we want to skip the current iteration of a loop without terminating it. On encountering `next`, the R parser skips further evaluation and starts the next iteration of the loop. In this example, the `for` loop will iterate for each element in `x`; however, when it gets to the element that equals 3 it will skip the `for` loop execution of printing the element and simply jump to the next iteration.

```r
x <- 1:5

for (i in x) {
        if (i == 3){
                next
                }
        print(i)
}
## [1] 1
## [1] 2
## [1] 4
## [1] 5
```
