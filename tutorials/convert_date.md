---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Dates](dates) &#187; Converting strings to dates

<br>

* <a href="#convert_to_dates">Convert strings to dates</a>
* <a href="#merge_to_dates">Create dates by merging data</a>

<br>

<a name="convert_to_dates"></a>

## Convert Strings to Dates
To convert a string that is already in a date format (YYYY-MM-DD) into a date object use `as.Date()`:

{% highlight r %}
x <- c("2015-07-01", "2015-08-01", "2015-09-01")

as.Date(x)
## [1] "2015-07-01" "2015-08-01" "2015-09-01"
{% endhighlight %}

Note that the defaul date format is YYYY-MM-DD; therefore, if your string is of different format you must incorporate the `format` argument:

{% highlight r %}
y <- c("07/01/2015", "07/01/2015", "07/01/2015")

as.Date(y, format = "%m/%d/%Y")
## [1] "2015-07-01" "2015-07-01" "2015-07-01"
{% endhighlight %}
&#9755; *For a complete list of formatting codes: `?strftime`*

<br>

If using the `lubridate` package:


{% highlight r %}
library(lubridate)
ymd(x)
## [1] "2015-07-01 UTC" "2015-08-01 UTC" "2015-09-01 UTC"

mdy(y)
## [1] "2015-07-01 UTC" "2015-07-01 UTC" "2015-07-01 UTC"
{% endhighlight %}

One of the many benefits of the `lubricate` package is that it automatically recognizes the common separators used when recording dates ("-", "/", ".", and "").  As a result, you only need to focus on specifying the order of the date elements to determine the parsing function applied:

<center>
<img src="/public/images/r_vocab/lubridate_parsing.png" alt="lubridate Parsing Functions">
</center>  

<br>

<a name="merge_to_dates"></a>

## Create Dates by Merging Data
Sometimes your date data are collected in separate elements.  To convert these separate data into one date object incorporate the `ISOdate()` function:

{% highlight r %}
yr <- c("2012", "2013", "2014", "2015")
mo <- c("1", "5", "7", "2")
day <- c("02", "22", "15", "28")

# ISOdate converts to a POSIXct object
ISOdate(year = yr, month = mo, day = day)
## [1] "2012-01-02 12:00:00 GMT" "2013-05-22 12:00:00 GMT"
## [3] "2014-07-15 12:00:00 GMT" "2015-02-28 12:00:00 GMT"

# truncate the unused time data by converting with as.Date
as.Date(ISOdate(year = yr, month = mo, day = day))
## [1] "2012-01-02" "2013-05-22" "2014-07-15" "2015-02-28"
{% endhighlight %}
Note that `ISODate()` also has arguments to accept data for hours, minutes, seconds, and time-zone if you need to merge all these separate components.


<small><a href="#">Go to top</a></small>
