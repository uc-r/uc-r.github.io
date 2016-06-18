---
layout: tutorial
title: Getting Current Date & Time
permalink: /current_date_time/
---



To get current date and time information:


```r
Sys.timezone()
## [1] "America/New_York"

Sys.Date()
## [1] "2015-09-24"

Sys.time()
## [1] "2015-09-24 15:08:57 EDT"
```


If using the `lubridate` package:


```r
library(lubridate)

now()
## [1] "2015-09-24 15:08:57 EDT"
```
