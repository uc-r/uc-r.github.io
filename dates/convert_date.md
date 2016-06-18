---
layout: tutorial
title: Converting Strings to Dates
permalink: /convert_date/
---

When date and time data are imported into R they will often default to a character string.  This requires us to [convert strings to dates](#date_convert_strings).  We may also have multiple strings that we want to [merge to create a date variable](#date_merge_strings).  


<br>

## Convert Strings to Dates {#date_convert_strings}
To convert a string that is already in a date format (YYYY-MM-DD) into a date object use `as.Date()`:


```r
x <- c("2015-07-01", "2015-08-01", "2015-09-01")

as.Date(x)
## [1] "2015-07-01" "2015-08-01" "2015-09-01"
```

Note that the default date format is YYYY-MM-DD; therefore, if your string is of different format you must incorporate the `format` argument.  There are multiple formats that dates can be in; for a complete list of formatting code options in R type `?strftime` in your console.


```r
y <- c("07/01/2015", "07/01/2015", "07/01/2015")

as.Date(y, format = "%m/%d/%Y")
## [1] "2015-07-01" "2015-07-01" "2015-07-01"
```


If using the `lubridate` package:


```r
library(lubridate)
ymd(x)
## [1] "2015-07-01 UTC" "2015-08-01 UTC" "2015-09-01 UTC"

mdy(y)
## [1] "2015-07-01 UTC" "2015-07-01 UTC" "2015-07-01 UTC"
```

One of the many benefits of the `lubridate` package is that it automatically recognizes the common separators used when recording dates ("-", "/", ".", and "").  As a result, you only need to focus on specifying the order of the date elements to determine the parsing function applied:


<center>
<img src="/public/images/r_vocab/lubridate_parsing.png" alt="lubridate Parsing Functions">
</center>  


<br>

## Create Dates by Merging Data {#date_merge_strings}
Sometimes your date data are collected in separate elements.  To convert these separate data into one date object incorporate the `ISOdate()` function:


```r
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
```
Note that `ISODate()` also has arguments to accept data for hours, minutes, seconds, and time-zone if you need to merge all these separate components.
