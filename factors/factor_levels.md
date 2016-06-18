---
layout: tutorial
title: Ordering, Revaluing, & Dropping Factor Levels
permalink: /factor_levels/
---

<br>



## Ordering Levels
When creating a factor we can control the ordering of the levels by using the `levels` argument:

```r
# when not specified the default puts order as alphabetical
gender <- factor(c("male", "female", "female", "male", "female"))
gender
## [1] male   female female male   female
## Levels: female male

# specifying order
gender <- factor(c("male", "female", "female", "male", "female"), 
                 levels = c("male", "female"))
gender
## [1] male   female female male   female
## Levels: male female
```

We can also create ordinal factors in which a specific order is desired by using the `ordered = TRUE` argument.  This will be reflected in the output of the levels as shown below in which `low < middle < high`:

```r
ses <- c("low", "middle", "low", "low", "low", "low", "middle", "low", "middle",
    "middle", "middle", "middle", "middle", "high", "high", "low", "middle",
    "middle", "low", "high")

# create ordinal levels
ses <- factor(ses, levels = c("low", "middle", "high"), ordered = TRUE)
ses
##  [1] low    middle low    low    low    low    middle low    middle middle
## [11] middle middle middle high   high   low    middle middle low    high  
## Levels: low < middle < high

# you can also reverse the order of levels if desired
factor(ses, levels=rev(levels(ses)))
##  [1] low    middle low    low    low    low    middle low    middle middle
## [11] middle middle middle high   high   low    middle middle low    high  
## Levels: high < middle < low
```

<br>

<a name="value"></a>

## Revalue Levels
To recode factor levels I usually use the `revalue()` function from the `plyr` package.  

```r
plyr::revalue(ses, c("low" = "small", "middle" = "medium", "high" = "large"))
##  [1] small  medium small  small  small  small  medium small  medium medium
## [11] medium medium medium large  large  small  medium medium small  large 
## Levels: small < medium < large
```
&#9755; *Using the `::` notation allows you to access the `revalue()` function without having to fully load the `plyr` package.*

<br>

<a name="drop"></a>

## Dropping Levels
When you want to drop unused factor levels, use `droplevels()`:

```r
ses2 <- ses[ses != "middle"]

# lets say you have no observations in one level
summary(ses2)
##    low middle   high 
##      8      0      3

# you can drop that level if desired
droplevels(ses2)
##  [1] low  low  low  low  low  low  high high low  low  high
## Levels: low < high
```
