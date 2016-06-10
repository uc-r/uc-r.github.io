---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Dates](dates) &#187; Creating date sequences

<br>

* <a href="#date_seq">Date sequences</a>
* <a href="#time_seq">Time sequences</a>

<br>

<a name="date_seq"></a>

## Date Sequences

To create a sequence of dates we can leverage the [`seq()`](generating_sequence_numbers) function:

{% highlight r %}
seq(as.Date("2010-1-1"), as.Date("2015-1-1"), by = "years")
## [1] "2010-01-01" "2011-01-01" "2012-01-01" "2013-01-01" "2014-01-01"
## [6] "2015-01-01"

seq(as.Date("2015/1/1"), as.Date("2015/12/30"), by = "quarter")
## [1] "2015-01-01" "2015-04-01" "2015-07-01" "2015-10-01"

seq(as.Date('2015-09-15'), as.Date('2015-09-30'), by = "2 days")
## [1] "2015-09-15" "2015-09-17" "2015-09-19" "2015-09-21" "2015-09-23"
## [6] "2015-09-25" "2015-09-27" "2015-09-29"
{% endhighlight %}

<br>

Or in lubridate:

{% highlight r %}
library(lubridate)

seq(ymd("2010-1-1"), ymd("2015-1-1"), by = "years")
## [1] "2010-01-01 UTC" "2011-01-01 UTC" "2012-01-01 UTC" "2013-01-01 UTC"
## [5] "2014-01-01 UTC" "2015-01-01 UTC"

seq(ymd("2015/1/1"), ymd("2015/12/30"), by = "quarter")
## [1] "2015-01-01 UTC" "2015-04-01 UTC" "2015-07-01 UTC" "2015-10-01 UTC"

seq(ymd('2015-09-15'), ymd('2015-09-30'), by = "2 days")
## [1] "2015-09-15 UTC" "2015-09-17 UTC" "2015-09-19 UTC" "2015-09-21 UTC"
## [5] "2015-09-23 UTC" "2015-09-25 UTC" "2015-09-27 UTC" "2015-09-29 UTC"
{% endhighlight %}

<br>

<a name="time_seq"></a>

## Time Sequences

Creating sequences with time is very similar; however, we need to make sure our date object is POSIXct rather than just a Date object (as produced by `as.Date`):

{% highlight r %}
seq(as.POSIXct("2015-1-1 0:00"), as.POSIXct("2015-1-1 12:00"), by = "hour")
##  [1] "2015-01-01 00:00:00 EST" "2015-01-01 01:00:00 EST"
##  [3] "2015-01-01 02:00:00 EST" "2015-01-01 03:00:00 EST"
##  [5] "2015-01-01 04:00:00 EST" "2015-01-01 05:00:00 EST"
##  [7] "2015-01-01 06:00:00 EST" "2015-01-01 07:00:00 EST"
##  [9] "2015-01-01 08:00:00 EST" "2015-01-01 09:00:00 EST"
## [11] "2015-01-01 10:00:00 EST" "2015-01-01 11:00:00 EST"
## [13] "2015-01-01 12:00:00 EST"

# with lubridate
seq(ymd_hm("2015-1-1 0:00"), ymd_hm("2015-1-1 12:00"), by = "hour")
##  [1] "2015-01-01 00:00:00 UTC" "2015-01-01 01:00:00 UTC"
##  [3] "2015-01-01 02:00:00 UTC" "2015-01-01 03:00:00 UTC"
##  [5] "2015-01-01 04:00:00 UTC" "2015-01-01 05:00:00 UTC"
##  [7] "2015-01-01 06:00:00 UTC" "2015-01-01 07:00:00 UTC"
##  [9] "2015-01-01 08:00:00 UTC" "2015-01-01 09:00:00 UTC"
## [11] "2015-01-01 10:00:00 UTC" "2015-01-01 11:00:00 UTC"
## [13] "2015-01-01 12:00:00 UTC"
{% endhighlight %}


<br>

<small><a href="#">Go to top</a></small>
