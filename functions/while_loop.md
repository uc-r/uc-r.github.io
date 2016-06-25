---
layout: tutorial
title: <code>while</code> Loop
permalink: /while_loop
---

While loops begin by testing a condition. If it is true, then they execute the statement. Once the statement is executed, the condition is tested again, and so forth, until the condition is false, after which the loop exits.  It's considered a best practice to include a counter object to keep track of total iterations


```r
# syntax of while loop
counter <- 1

while(test_expression) {
        statement
        counter <- counter + 1
}
```

`while` loops can potentially result in infinite loops if not written properly; therefore, you must use them with care.  To provide a simple example to illustrate how similiar `for` and `while` loops are: 


```r
counter <- 1

while(counter <= 10) {
        print(counter)
        counter <- counter + 1
}

# this for loop provides the same output
counter <- vector(mode = "numeric", length = 10)

for(i in 1:length(counter)) {
        print(i)
}
```

The primary difference between a `for` loop and a `while` loop is:  a `for` loop is used when the number of iterations a code should be run is known where a `while` loop is used when the number of iterations is not known.  For instance, the following takes value `x` and adds or subtracts 1 from the value randomly until `x` exceeds the values in the test expression.  The output illustrates that the code runs 14 times until x exceeded the threshold with the value 9.


```r
counter <- 1
x <- 5
set.seed(3)

while(x >= 3 && x <= 8 ) {
        coin <- rbinom(1, 1, 0.5)
        
        if(coin == 1) { ## random walk
                x <- x + 1
        } else {
                x <- x - 1
        }
        cat("On iteration", counter, ", x =", x, '\n')
        counter <- counter + 1
}
## On iteration 1 , x = 4 
## On iteration 2 , x = 5 
## On iteration 3 , x = 4 
## On iteration 4 , x = 3 
## On iteration 5 , x = 4 
## On iteration 6 , x = 5 
## On iteration 7 , x = 4 
## On iteration 8 , x = 3 
## On iteration 9 , x = 4 
## On iteration 10 , x = 5 
## On iteration 11 , x = 6 
## On iteration 12 , x = 7 
## On iteration 13 , x = 8 
## On iteration 14 , x = 9
```
