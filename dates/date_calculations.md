---
layout: tutorial
title: Calculations with Dates
permalink: /date_calculations/
---

Since R stores date and time objects as numbers, this allows you to perform various calculations such as logical comparisons, addition, subtraction, and working with durations.



```r
x <- Sys.Date()
x
## [1] "2015-09-26"

y <- as.Date("2015-09-11")

x > y
## [1] TRUE

x - y
## Time difference of 15 days
```

The nice thing about the date/time classes is that they keep track of leap years, leap seconds, daylight savings, and time zones.  Use `OlsonNames()` for a full list of acceptable time zone specifications.


```r
# last leap year
x <- as.Date("2012-03-1")
y <- as.Date("2012-02-28")

x - y
## Time difference of 2 days


# example with time zones
x <- as.POSIXct("2015-09-22 01:00:00", tz = "US/Eastern")
y <- as.POSIXct("2015-09-22 01:00:00", tz = "US/Pacific")

y == x
## [1] FALSE

y - x
## Time difference of 3 hours
```

Similarly, the same functionality exists with the `lubridate` package with the only difference being the accessor function(s) used.


```r
library(lubridate)

x <- now()
x
## [1] "2015-09-26 10:08:18 EDT"

y <- ymd("2015-09-11")

x > y
## [1] TRUE

x - y
## Time difference of 15.5891 days

y + days(4)
## [1] "2015-09-15 UTC"

x - hours(4)
## [1] "2015-09-26 06:08:18 EDT"
```

We can also deal with time spans by using the duration functions in `lubridate`.  Durations simply measure the time span between start and end dates. Using base R date functions for duration calculations is tedious and often results in wrong measurements.  `lubridate` provides simplistic syntax to calculate durations with the desired measurement (seconds, minutes, hours, etc.).


```r
# create new duration (represented in seconds)
new_duration(60)
## [1] "60s"

# create durations for minutes, hours, years
dminutes(1)
## [1] "60s"

dhours(1)
## [1] "3600s (~1 hours)"

dyears(1)
## [1] "31536000s (~365 days)"

# add/subtract durations from date/time object
x <- ymd_hms("2015-09-22 12:00:00")

x + dhours(10)
## [1] "2015-09-22 22:00:00 UTC"

x + dhours(10) + dminutes(33) + dseconds(54)
## [1] "2015-09-22 22:33:54 UTC"
```
