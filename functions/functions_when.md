---
layout: tutorial
title: When to Write Functions
permalink: /functions_when
---

*Note: this section is taken directly from [R for Data Science](http://r4ds.had.co.nz/) by Garrett Grolemund and Hadley Wickham*

You should consider writing a function whenever you’ve copied and pasted a block of code more than twice (i.e. you now have three copies of the same code). For example, take a look at this code. What does it do?

```r
df <- data.frame(
  a = rnorm(10),
  b = rnorm(10),
  c = rnorm(10),
  d = rnorm(10)
)

df$a <- (df$a - min(df$a, na.rm = TRUE)) / 
  (max(df$a, na.rm = TRUE) - min(df$a, na.rm = TRUE))
df$b <- (df$b - min(df$b, na.rm = TRUE)) / 
  (max(df$a, na.rm = TRUE) - min(df$b, na.rm = TRUE))
df$c <- (df$c - min(df$c, na.rm = TRUE)) / 
  (max(df$c, na.rm = TRUE) - min(df$c, na.rm = TRUE))
df$d <- (df$d - min(df$d, na.rm = TRUE)) / 
  (max(df$d, na.rm = TRUE) - min(df$d, na.rm = TRUE))
```
  
  You might be able to puzzle out that this rescales each column to have a range from 0 to 1. But did you spot the mistake? I made an error when copying-and-pasting the code for `df$b`: I forgot to change an `a` to a `b`. Extracting repeated code out into a function is a good idea because it prevents you from making this type of mistake.

To write a function you need to first analyse the code. How many inputs does it have?

```r
(df$a - min(df$a, na.rm = TRUE)) /
  (max(df$a, na.rm = TRUE) - min(df$a, na.rm = TRUE))
```

This code only has one input: `df$a`. (It’s a little suprisingly that `TRUE` is not an input: you can explore why in the exercise below). To make the single input more clear, it’s a good idea to rewrite the code using temporary variables with a general name. Here this function only takes one vector of input, so I’ll call it `x`:

```r
x <- 1:10
(x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
##  [1] 0.000 0.111 0.222 0.333 0.444 0.556 0.667 0.778 0.889 1.000
```

There is some duplication in this code. We’re computing the range of the data three times, but it makes sense to do it in one step:

```r
rng <- range(x, na.rm = TRUE)
(x - rng[1]) / (rng[2] - rng[1])
##  [1] 0.000 0.111 0.222 0.333 0.444 0.556 0.667 0.778 0.889 1.000
```

Pulling out intermediate calculations into named variables is a good practice because it makes it more clear what the code is doing. Now that I’ve simplified the code, and checked that it still works, I can turn it into a function:

```r
rescale01 <- function(x) {
  rng <- range(x, na.rm = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}

rescale01(c(0, 5, 10))
## [1] 0.0 0.5 1.0
```

Turn learn more about developing functions move on to the [next section](http://uc-r.github.io/understanding_functions).





