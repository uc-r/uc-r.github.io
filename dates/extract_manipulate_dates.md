---
layout: tutorial
title: Extract & Manipulate Parts of Dates
permalink: /extract_manipulate_dates/
---

To extract and manipulate individual elements of a date I typically use the `lubridate` package due to its simplistic function syntax.  The functions provided by `lubridate` to perform extraction and manipulation of dates include:

<p>
<center>
<img src="/public/images/r_vocab/lubridate_accessors.png" alt="lubridate Accessor Functions" vspace="25">
</center> 
</p>

To extract an individual element of the date variable you simply use the accessor function desired.  Note that the accessor variables have additional arguments that can be used to show the name of the date element in full or abbreviated form.


```r
library(lubridate)

x <- c("2015-07-01", "2015-08-01", "2015-09-01")

year(x)
## [1] 2015 2015 2015

# default is numerical value
month(x)
## [1] 7 8 9

# show abbreviated name
month(x, label = TRUE)
## [1] Jul Aug Sep
## 12 Levels: Jan < Feb < Mar < Apr < May < Jun < Jul < Aug < Sep < ... < Dec

# show unabbreviated name
month(x, label = TRUE, abbr = FALSE)
## [1] July      August    September
## 12 Levels: January < February < March < April < May < June < ... < December


wday(x, label = TRUE, abbr = FALSE)
## [1] Wednesday Saturday  Tuesday  
## 7 Levels: Sunday < Monday < Tuesday < Wednesday < Thursday < ... < Saturday
```

To manipulate or change the values of date elements we simply use the accessor function to extract the element of choice and then use the assignment function to assign a new value.


```r
# convert to date format
x <- ymd(x)
x
## [1] "2015-07-01 UTC" "2015-08-01 UTC" "2015-09-01 UTC"

# change the days for the dates
mday(x)
## [1] 1 1 1

mday(x) <- c(3, 10, 22)
x
## [1] "2015-07-03 UTC" "2015-08-10 UTC" "2015-09-22 UTC"

# can also use 'update()' function
update(x, year = c(2013, 2014, 2015), month = 9)
## [1] "2013-09-03 UTC" "2014-09-10 UTC" "2015-09-22 UTC"

# can also add/subtract units
x + years(1) - days(c(2, 9, 21))
## [1] "2016-07-01 UTC" "2016-08-01 UTC" "2016-09-01 UTC"
```
