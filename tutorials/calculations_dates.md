---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Dates](dates) &#187; Calculations with dates

<br>

* <a href="#arithmetic">Arithmetic with dates and times</a>
* <a href="#durations">Dealing with date/time durations</a>

<br>

<a name="arithmetic"></a>

## Arithmetic with Dates and Times

Simple mathematical operations can be used on dates and times as well.  This includes +, -, ==, <=, etc.

{% highlight r %}
x <- Sys.Date()
x
## [1] "2015-09-26"

y <- as.Date("2015-09-11")

x > y
## [1] TRUE

x - y
## Time difference of 15 days
{% endhighlight %}

The nice thing about the date/time classes is that they keep track of leap years, leap seconds, daylight savings, and time zones.

{% highlight r %}
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
{% endhighlight %}
&#9755; *Use `OlsonNames()` for a full list of acceptable time zone specifications.*


<br>

or with `lubridate`:

{% highlight r %}
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
{% endhighlight %}

<br>

<a name="durations"></a>

## Dealing with Date/Time Durations

We can easily deal with time spans by using the duration functions in `lubridate`:

{% highlight r %}
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
{% endhighlight %}

<br>

<small><a href="#">Go to top</a></small>
