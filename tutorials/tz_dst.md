---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Dates](dates) &#187; Dealing with time zones & daylight savings

<br>

* <a href="#time_zones">Time zones</a>
* <a href="#daylight_savings">Daylight savings</a>

<br>

<a name="time_zones"></a>

## Time zones

To change the time zone for a date/time we can use the `with_tz()` function which will also update the clock time to align with the updated time zone:

{% highlight r %}
library(lubridate)

time <- now()
time
## [1] "2015-09-26 10:30:32 EDT"

with_tz(time, tzone = "MST")
## [1] "2015-09-26 07:30:32 MST"
{% endhighlight %}

If the time zone is incorrect or for some reason you need to change the time zone without changing the clock time you can force it with `force_tz()`:


{% highlight r %}
time
## [1] "2015-09-26 10:30:32 EDT"

force_tz(time, tzone = "MST")
## [1] "2015-09-26 10:30:32 MST"
{% endhighlight %}

<br>

<a name="daylight_savings"></a>

## Daylight Savings
We can easily work with daylight savings times to eliminate impacts on date/time calculations:


{% highlight r %}
# most recent daylight savings time
ds <- ymd_hms("2015-03-08 01:59:59", tz = "US/Eastern")

# if we add a duration of 1 sec we gain an extra hour
ds + dseconds(1)
## [1] "2015-03-08 03:00:00 EDT"

# add a duration of 2 hours will reflect actual daylight savings clock time 
# that occured 2 hours after 01:59:59 on 2015-03-08
ds + dhours(2)
## [1] "2015-03-08 04:59:59 EDT"

# add a period of two hours will reflect clock time that normally occurs after
# 01:59:59 and is not influenced by daylight savings time.
ds + hours(2)
## [1] "2015-03-08 03:59:59 EDT"
{% endhighlight %}


<br>

<small><a href="#">Go to top</a></small>

