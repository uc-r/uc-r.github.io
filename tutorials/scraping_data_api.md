---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Importing, Scraping, and exporting data](data_inputs_outputs) &#187; [Scraping data](scraping_data) &#187; Working with APIs

<br>

In this tutorial I cover how to scrape data via APIs. I first provide some explanation about what APIs are followed by some prerequisites for working with APIs. I then cover a few pre-existing R API packages to demonstrate how they typically function.  I then cover the `httr` package to work with APIs in which an R package has not already been built to simplify interaction with.

<br>


<a name="what_api"></a>

## What's an API?
An [application-programming interface (API)](https://en.wikipedia.org/wiki/Application_programming_interface) in a nutshell is a method of communication between software programs.  APIs allow programs to interact and use each other's functions by acting as a middle man. Why is this useful? Lets say you want to pull weather data from the [NOAA](http://www.ncdc.noaa.gov/cdo-web/webservices).  You have a few options: 

- You could query the data and download the spreadsheet or manually cut-n-paste the desired data and then import into R. Doesn't get you any coolness points. 
- You could use some webscraping techniques previously covered [here](http://bradleyboehmke.github.io/2015/12/scraping-tabular-and-excel-files-stored-online.html), [here](http://bradleyboehmke.github.io/2015/12/scraping-html-text.html), and [here](http://bradleyboehmke.github.io/2015/12/scraping-html-tables.html) to parse the desired data. Golf clap. The downfall of this strategy is if NOAA changes their website structure down the road your code will need to be adjusted.
- Or, you can use the [`rnoaa`](https://ropensci.org/tutorials/rnoaa_tutorial.html) package which allows you to send specific instructions to the NOAA API via R, the API will then perform the action requested and return the desired information. The benefit of this strategy is if the NOAA changes its website structure it won't impact the API data retreival structure which means no impact to your code. Standing ovation!

Consequently, APIs provide consistency in data retrieval processes which can be essential for recurring analyses. Luckily, the use of APIs by organizations that collect data are [growing exponentially](http://www.programmableweb.com/api-research). This is great for you and I as more and more data continues to be at our finger tips.  

So what do you need to get started?


<small><a href="#">Go to top</a></small>

<br>

<a name="needs_api"></a>

## Prerequisites
Each API is unique; however, there are a few fundamental pieces of information you'll need to work with an API.  First, the reason you're using an API is to request specific types of data from a specific data set from a specific organization. You at least need to know a little something about each one of these:

<ol>
  <li>The URL for the organization and data you are pulling. Most pre-built API packages already have this connection established but when using <code>httr</code> you'll need to specify.</li>
  <li>The data set you are trying to pull from. Most organizations have numerous data sets to peruse so you need to make yourself familiar with the names of the available data sets.</li>
  <li>The data content. You'll need to specify the specific data variables you want the API to retrieve so you'll need to be familiar with, or have access to, the data library.</li>
</ol>

In addition to these key components you will also, typically, need to provide a form of identification and/or authorization.  This is done via:

<ol start="4">
  <li>API key (aka token). A key is used to identify the user along with track and control how the API is being used (guard against malicious use). A key is often obtained by supplying basic information (i.e. name, email) to the organization and in return they give you a multi-digit key.</li>
  <li><a href="http://oauth.net/">OAuth</a>. OAuth is an authorization framework that provides credentials as proof for access to certain information. Multiple forms of credentials exist and OAuth can actually be a fairly confusing topic; however, the <code>httr</code> package has simplified this greatly which we demonstrate <a href="#httr_api">later</a> in this post.</li>
</ol>

Rather than dwell on these components, they'll likely become clearer as we progress through examples. So, let's move on to the fun stuff. 


<small><a href="#">Go to top</a></small>

<br>

<a name="existing_api"></a>

## Existing API Packages
Like everything else you do in R, when looking to work with an API your first question should be "Is there a package for that?" R has an extensive list of packages in which API data feeds have been hooked into R. You can find a slew of them scattered throughout the [CRAN Task View: Web Technologies and Services](https://cran.r-project.org/web/views/WebTechnologies.html) web page, on the [rOpenSci](https://ropensci.org/packages/) web page, and some more [here](http://stats.stackexchange.com/questions/12670/data-apis-feeds-available-as-packages-in-r). 

To give you a taste for how these packages typically work, I'll quickly cover three packages:

- <a href="#blsAPI">`blsAPI`</a> for pulling U.S. Bureau of Labor Statistics data
- <a href="#rnoaa">`rnoaa`</a> for pulling NOAA climate data
- <a href="#rtimes">`rtimes`</a> for pulling data from multiple APIs offered by the New York Times 

<a name="blsAPI"></a>

### blsAPI
The [`blsAPI`](https://cran.r-project.org/web/packages/blsAPI/index.html) allows users to request data for one or multiple series through the U.S. Bureau of Labor Statistics API. To use the `blsAPI` app you only need knowledge on the data; no key or OAuth are required. I lllustrate by pulling [Mass Layoff Statistics](http://www.bls.gov/mls/mlsover.htm) data but you will find all the available data sets and their series code information [here](http://www.bls.gov/help/hlpforma.htm). 

The key information you will be concerned about is contained in the series identifier.  For the Mass Layoff data the the series ID code  is MLUMS00NN0001003. Each component of this series code has meaning and can be adjusted to get specific Mass Layoff data.  The BLS provides this [breakdown](http://www.bls.gov/help/hlpforma.htm#ML) for what each component means along with the available list of codes for this data set.  For instance, the **S00** (MLUM**S00**NN0001003) component represents the [division/state](http://download.bls.gov/pub/time.series/ml/ml.srd). S00 will pull for all states but I could change to D30 to pull data for the Midwest or S39 to pull for Ohio. The **N0001** (MLUMS00N**N0001**003) component represents the [industry/demographics](http://download.bls.gov/pub/time.series/ml/ml.irc). N0001 pulls data for all industries but I could change to N0008 to pull data for the food industry or C00A2 for all persons age 30-44. 

I simply call the series identifier in the `blsAPI()` function which pulls the JSON data object.  We can then use the `fromJSON()` function from the `rjson` package to convert to an R data object (a list in this case). You can see that the raw data pull provides a list of 4 items.  The first three provide some metadata info (status, response time, and message if applicable). The data we are concerned about is in the 4th (Results&#36;series&#36;data) list item which contains 31 observations.


{% highlight r %}
library(rjson)
library(blsAPI)

# supply series identifier to pull data (initial pull is in JSON data)
layoffs_json <- blsAPI('MLUMS00NN0001003') 

# convert from JSON into R object
layoffs <- fromJSON(layoffs_json)                   

List of 4
 $ status      : chr "REQUEST_SUCCEEDED"
 $ responseTime: num 38
 $ message     : list()
 $ Results     :List of 1
  ..$ series:List of 1
  .. ..$ :List of 2
  .. .. ..$ seriesID: chr "MLUMS00NN0001003"
  .. .. ..$ data    :List of 31
  .. .. .. ..$ :List of 5
  .. .. .. .. ..$ year      : chr "2013"
  .. .. .. .. ..$ period    : chr "M05"
  .. .. .. .. ..$ periodName: chr "May"
  .. .. .. .. ..$ value     : chr "1383"
{% endhighlight %}

One of the inconveniences of an API is we do not get to specify how the data we receive is formatted. This is a minor price to pay considering all the other benefits APIs provide. Once we understand the received data format we can typically re-format using a little subsetting and looping.


{% highlight r %}

# create empty data frame to fill  
layoff_df <- data.frame(NULL)

# extract data of interest from each nested year-month list  
for(i in seq_along(layoffs$Results$series[[1]]$data)) {
        df <- data.frame(layoffs$Results$series[[1]]$data[i][[1]][1:4])
        layoff_df <- rbind(layoff_df, df)
}

head(layoff_df)
##   year period periodName value
## 1 2013    M05        May  1383
## 2 2013    M04      April  1174
## 3 2013    M03      March  1132
## 4 2013    M02   February   960
## 5 2013    M01    January  1528
## 6 2012    M13     Annual 17080
{% endhighlight %}

`blsAPI` also allows you to pull multiple data series and has optional arguments (i.e. start year, end year, etc.). You can see other options at `help(package = blsAPI)`.

<a name="rnoaa"></a>

### rnoaa
The [`rnoaa`](https://ropensci.org/tutorials/rnoaa_tutorial.html) package allows users to request climate data from multiple data sets through the [National Climatic Data Center API](http://www.ncdc.noaa.gov/cdo-web/webservices/v2). Unlike `blsAPI`, the `rnoaa` app requires you to have an API key.  To request a key go [here](http://www.ncdc.noaa.gov/cdo-web/token) and provide your email; a key will immediately be emailed to you. 




{% highlight r %}
key <- "vXTdwNoAVx..." # truncated 
{% endhighlight %}

With the key in hand, we can begin pulling data.  The NOAA provides a comprehensive [metadata library](http://www.ncdc.noaa.gov/homr/reports) to familiarize yourself with the data available. Let's start by pulling all the available NOAA climate stations near my residence. I live in Montgomery county Ohio so we can find all the stations in this county by inserting the [FIPS code](http://www.census.gov/geo/reference/codes/cou.html). Furthermore, I'm interested in stations that provide data for the [`GHCND` data set](https://www.ncdc.noaa.gov/oa/climate/ghcn-daily/) which contains records on numerous daily variables such as "maximum and minimum temperature, total daily precipitation, snowfall, and snow depth; however, about two thirds of the stations report precipitation only." See `?ncdc_stations` for other data sets available via `rnoaa`.


{% highlight r %}
library(rnoaa)

stations <- ncdc_stations(datasetid='GHCND', 
              locationid='FIPS:39113',
              token = key)

stations$data
## Source: local data frame [23 x 9]
## 
##    elevation    mindate    maxdate latitude
##        (dbl)      (chr)      (chr)    (dbl)
## 1      294.1 2009-02-09 2014-06-25  39.6314
## 2      251.8 2009-03-01 2016-01-16  39.6807
## 3      295.7 2009-03-25 2012-09-08  39.6252
## 4      298.1 2009-08-24 2012-07-20  39.8070
## 5      304.5 2010-04-02 2016-01-12  39.6949
## 6      283.5 2012-07-01 2016-01-16  39.7373
## 7      301.4 2012-07-29 2016-01-16  39.8795
## 8      317.3 2012-09-08 2016-01-12  39.8329
## 9      298.1 2012-09-07 2016-01-15  39.6247
## 10     250.5 2012-09-11 2016-01-08  39.7180
## ..       ...        ...        ...      ...
## Variables not shown: name (chr), datacoverage (dbl), id (chr),
##   elevationUnit (chr), longitude (dbl)
{% endhighlight %}

So we see that several stations are available from which to pull data. To actually pull data from one of these stations we need the station ID.  The station I want to pull data from is the Dayton International Airport station.  We can see that this station provides data from 1948-present and I can get the station ID as illustrated.


{% highlight r %}
library(dplyr)

stations$data %>% 
        filter(name == "DAYTON INTERNATIONAL AIRPORT, OH US") %>% 
        select(mindate, maxdate, id)
## Source: local data frame [1 x 3]
## 
##      mindate    maxdate                id
##        (chr)      (chr)             (chr)
## 1 1948-01-01 2016-01-15 GHCND:USW00093815
{% endhighlight %}

To pull all available GHCND data from this station we'll use `ncdc()`.  We simply supply the data to pull, the start and end dates (`ncdc` restricts you to a one year limit), station ID, and your key. We can see that this station provides a full range of data types.


{% highlight r %}
climate <- ncdc(datasetid='GHCND', 
            startdate = '2015-01-01', 
            enddate = '2016-01-01', 
            stationid='GHCND:USW00093815',
            token = key)

climate$data
## Source: local data frame [25 x 8]
## 
##                   date datatype           station value  fl_m  fl_q
##                  (chr)    (chr)             (chr) (int) (chr) (chr)
## 1  2015-01-01T00:00:00     AWND GHCND:USW00093815    72            
## 2  2015-01-01T00:00:00     PRCP GHCND:USW00093815     0            
## 3  2015-01-01T00:00:00     SNOW GHCND:USW00093815     0            
## 4  2015-01-01T00:00:00     SNWD GHCND:USW00093815     0            
## 5  2015-01-01T00:00:00     TAVG GHCND:USW00093815   -38     H      
## 6  2015-01-01T00:00:00     TMAX GHCND:USW00093815    28            
## 7  2015-01-01T00:00:00     TMIN GHCND:USW00093815   -71            
## 8  2015-01-01T00:00:00     WDF2 GHCND:USW00093815   240            
## 9  2015-01-01T00:00:00     WDF5 GHCND:USW00093815   240            
## 10 2015-01-01T00:00:00     WSF2 GHCND:USW00093815   130            
## ..                 ...      ...               ...   ...   ...   ...
## Variables not shown: fl_so (chr), fl_t (chr)
{% endhighlight %}

Since we recently had some snow here let's pull data on snow fall for 2015. We adjust the limit argument (by default `ncdc` limits results to 25) and identify the data type we want.  By sorting we see what days experienced the greatest snowfall (don't worry, the results are reported in mm!).


{% highlight r %}
snow <- ncdc(datasetid='GHCND', 
            startdate = '2015-01-01', 
            enddate = '2015-12-31', 
            limit = 365,
            stationid='GHCND:USW00093815',
            datatypeid = 'SNOW',
            token = key)

snow$data %>% 
        arrange(desc(value))
## Source: local data frame [365 x 8]
## 
##                   date datatype           station value  fl_m  fl_q
##                  (chr)    (chr)             (chr) (int) (chr) (chr)
## 1  2015-03-01T00:00:00     SNOW GHCND:USW00093815   114            
## 2  2015-02-21T00:00:00     SNOW GHCND:USW00093815   109            
## 3  2015-01-25T00:00:00     SNOW GHCND:USW00093815    71            
## 4  2015-01-06T00:00:00     SNOW GHCND:USW00093815    66            
## 5  2015-02-16T00:00:00     SNOW GHCND:USW00093815    30            
## 6  2015-02-18T00:00:00     SNOW GHCND:USW00093815    25            
## 7  2015-02-14T00:00:00     SNOW GHCND:USW00093815    23            
## 8  2015-01-26T00:00:00     SNOW GHCND:USW00093815    20            
## 9  2015-02-04T00:00:00     SNOW GHCND:USW00093815    20            
## 10 2015-02-12T00:00:00     SNOW GHCND:USW00093815    20            
## ..                 ...      ...               ...   ...   ...   ...
## Variables not shown: fl_so (chr), fl_t (chr)
{% endhighlight %}

This is just an intro to `rnoaa` as the package offers a slew of data sets to pull from and functions to apply.  It even offers built in plotting functions. Use `help(package = "rnoaa")` to see all that `rnoaa` has to offer.

<a name="rtimes"></a>

### rtimes
The [`rtimes`](https://cran.r-project.org/web/packages/rtimes/index.html) package provides an interface to Congress, Campaign Finance, Article Search, and Geographic APIs offered by the New York Times. The data libraries and documentation for the several APIs available can be found [here](http://developer.nytimes.com/docs/). To use the Times' API you'll need to get an API key [here](http://developer.nytimes.com/apps/register).




{% highlight r %}
article_key <- "4f23572d8..."     # truncated
cfinance_key <- "ee0b7cef..."     # truncated
congress_key <- "57b3e8a3..."     # truncated
{% endhighlight %}

Lets start by searching NY Times articles. With the presendential elections upon us, we can illustrate by searching the least controversial candidate...Donald Trump. We can see that there are 4,566 article hits for the term "Trump". We can get more information on a particular article by subsetting.


{% highlight r %}
library(rtimes)

# article search for the term 'Trump'
articles <- as_search(q = "Trump", 
                 begin_date = "20150101", 
                 end_date = '20160101',
                 key = article_key)

# summary
articles$meta
##   hits time offset
## 1 4565   28      0

# pull info on 3rd article
articles$data[3]
## [[1]]
## <NYTimes article>Donald Trump’s Strongest Supporters: A Certain Kind of Democrat
##   Type: News
##   Published: 2015-12-31T00:00:00Z
##   Word count: 1469
##   URL: http://www.nytimes.com/2015/12/31/upshot/donald-trumps-strongest-supporters-a-certain-kind-of-democrat.html
##   Snippet: In a survey, he also excels among low-turnout voters and among the less affluent and the less educated, so the question is: Will they show up to vote?
{% endhighlight %}

We can use the campaign finance API and functions to gain some insight into Trumps compaign income and expenditures. The only special data you need is the [FEC ID](http://www.fec.gov/finance/disclosure/candcmte_info.shtml?tabIndex=2) for the candidate of interest.


{% highlight r %}
trump <- cf_candidate_details(campaign_cycle = 2016, 
                     fec_id = 'P80001571',
                     key = cfinance_key)

# pull summary data
trump$meta
##          id            name party
## 1 P80001571 TRUMP, DONALD J   REP
##                                             fec_uri
## 1 http://docquery.fec.gov/cgi-bin/fecimg/?P80001571
##                    committee  mailing_address mailing_city
## 1 /committees/C00580100.json 725 FIFTH AVENUE     NEW YORK
##   mailing_state mailing_zip status total_receipts
## 1            NY       10022      O     1902410.45
##   total_from_individuals total_from_pacs total_contributions
## 1               92249.33               0            96298.97
##   candidate_loans total_disbursements begin_cash  end_cash
## 1      1804747.23          1414674.29          0 487736.16
##   total_refunds debts_owed date_coverage_from date_coverage_to
## 1             0 1804747.23         2015-04-02       2015-06-30
##   independent_expenditures coordinated_expenditures
## 1                1644396.8                        0
{% endhighlight %}

`rtimes` also allows us to gain some insight into what our locally elected officials are up to with the Congress API. First, I can get some informaton on my Senator and then use that information to see if he's supporting my interest. For instance, I can pull the most recent bills that he is co-sponsoring.


{% highlight r %}
# pull info on OH senator
senator <- cg_memberbystatedistrict(chamber = "senate", 
                                    state = "OH", 
                                    key = congress_key)
senator$meta
##        id           name               role gender party
## 1 B000944 Sherrod  Brown Senator, 1st Class      M     D
##   times_topics_url      twitter_id       youtube_id seniority
## 1                  SenSherrodBrown SherrodBrownOhio         9
##   next_election
## 1          2018
##                                                                               api_url
## 1 http://api.nytimes.com/svc/politics/v3/us/legislative/congress/members/B000944.json

# use member ID to pull recent bill sponsorship
bills <- cg_billscosponsor(memberid = "B000944", 
                           type = "cosponsored", 
                           key = congress_key)
head(bills$data)
## Source: local data frame [6 x 11]
## 
##   congress    number
##      (chr)     (chr)
## 1      114    S.2098
## 2      114    S.2096
## 3      114    S.2100
## 4      114    S.2090
## 5      114 S.RES.267
## 6      114 S.RES.269
## Variables not shown: bill_uri (chr), title (chr), cosponsored_date
##   (chr), sponsor_id (chr), introduced_date (chr), cosponsors (chr),
##   committees (chr), latest_major_action_date (chr),
##   latest_major_action (chr)
{% endhighlight %}

It looks like the most recent bill Sherrod is co-sponsoring is S.2098 - Student Right to Know Before You Go Act.  Maybe I'll do a NY Times article search with `as_search()` to find out more about this bill...an exercise for another time.

So this gives you some flavor of how these API packages work.  You typically need to know the data sets and variables requested along with an API key. But once you get these basics its pretty straight forward on requesting the data.  Your next question may be, what if the API that I want to get data from does not yet have an R package developed for it?


<small><a href="#">Go to top</a></small>

<br>



<a name="httr_api"></a>

## httr for All Things Else
Although numerous R API packages are available, and cover a wide range of data, you may eventually run into a situation where you want to leverage an organization's API but an R package does not exist. Enter [`httr`](https://cran.r-project.org/web/packages/httr/index.html).  `httr` was developed by Hadley Wickham to easily work with web APIs. It offers multiple functions (i.e. `HEAD()`, `POST()`, `PATCH()`, `PUT()` and `DELETE()`); however, the function we are most concerned with today is `Get()`. We use the `Get()` function to access an API, provide it some request parameters, and receive an output. 

To give you a taste for how the `httr` package works, I'll quickly cover how to use it for a basic key-only API and an OAuth-required API:

- <a href="#key_only">`Key-only API`</a> is illustrated by pulling U.S. Department of Education data available on [data.gov](https://api.data.gov/docs/)
- <a href="#oauth">`OAuth-required API`</a> is illustrated by pulling tweets from my personal Twitter feed

<a name="key_only"></a>

### Key-only API
To demonstrate how to use the `httr` package for accessing a key-only API, I'll illustrate with the [College Scorecard API](https://api.data.gov/docs/ed/) provided by the Department of Education. First, you'll need to [request your API key](https://api.data.gov/signup/). 




{% highlight r %}
edu_key <- "fd783wmS3Z..."     # truncated
{% endhighlight %}

We can now proceed to use `httr` to request data from the API with the `GET()` function.  I went to North Dakota State University (NDSU) for my undergrad so I'm interested in pulling some data for this school. I can use the provided [data library](https://collegescorecard.ed.gov/data/documentation/) and [query explanation](https://github.com/18F/open-data-maker/blob/api-docs/API.md) to determine the parameters required.  In this example, the `URL` includes the primary path ("https://api.data.gov/ed/collegescorecard/"), the API version ("v1"), and the endpoint ("schools"). The question mark ("?") at the end of the URL is included to begin the list of query parameters, which only includes my API key and the school of interest.


{% highlight r %}
library(httr)

URL <- "https://api.data.gov/ed/collegescorecard/v1/schools?"

# import all available data for NDSU
ndsu_req <- GET(URL, query = list(api_key = edu_key,
                                  school.name = "North Dakota State University"))
{% endhighlight %}

This request provides me with every piece of information collected by the U.S. Department of Education for NDSU. To retrieve the contents of this request I use the `content()` function which will output the data as an R object (a list in this case).  The data is segmented into two main components: *metadata* and *results*. I'm primarily interested in the results.

The results branch of this list provides information on lat-long location, school identifier codes, some basic info on the school (city, number of branches, school website, accreditor, etc.), and then student data for the years 1997-2013. 


{% highlight r %}
ndsu_data <- content(ndsu_req)

names(ndsu_data)
## [1] "metadata" "results"

names(ndsu_data$results[[1]])
##  [1] "2008"     "2009"     "2006"     "ope6_id"  "2007"     "2004"    
##  [7] "2013"     "2005"     "location" "2002"     "2003"     "id"      
## [13] "1996"     "1997"     "school"   "1998"     "2012"     "2011"    
## [19] "2010"     "ope8_id"  "1999"     "2001"     "2000"
{% endhighlight %}

To see what kind of student data categories are offered we can assess a single year. You can see that available data includes earnings, academics, student info/demographics, admissions, costs, etc. With such a large data set, which includes many embedded lists, sometimes the easiest way to learn the data structure is to peruse names at different levels. 


{% highlight r %}
# student data categories available by year
names(ndsu_data$results[[1]]$`2013`)
## [1] "earnings"   "academics"  "student"    "admissions" "repayment" 
## [6] "aid"        "cost"       "completion"

# cost categories available by year
names(ndsu_data$results[[1]]$`2013`$cost)
## [1] "title_iv"      "avg_net_price" "attendance"    "tuition"      
## [5] "net_price"

# Avg net price cost categories available by year
names(ndsu_data$results[[1]]$`2013`$cost$avg_net_price)
## [1] "other_academic_year" "overall"             "program_year"       
## [4] "public"              "private"
{% endhighlight %}

So if I'm interested in comparing the rise in cost versus the rise in student debt I can simply pull this data once I've identified its location and naming structure.  


{% highlight r %}
library(magrittr)

# subset list for annual student data only
ndsu_yr <- ndsu_data$results[[1]][c(as.character(1996:2013))]

# extract median debt data for each year
ndsu_yr %>%
        sapply(function(x) x$aid$median_debt$completers$overall) %>% 
        unlist()
##    1997    1998    1999    2000    2001    2002    2003    2004 
## 13388.0 13856.0 14500.0 15125.0 15507.0 15639.0 16251.0 16642.5 
##    2005    2006    2007    2008    2009    2010    2011    2012 
## 17125.0 17125.0 17125.0 17250.0 19125.0 21500.0 23000.0 24954.5 
##    2013 
## 25050.0

# extract net price for each year
ndsu_yr %>% 
        sapply(function(x) x$cost$avg_net_price$overall) %>% 
        unlist()
##  2009  2010  2011  2012  2013 
## 13474 12989 13808 15113 14404
{% endhighlight %}

Quite simple isn't it...at least once you've learned how the query requests are formatted for a particular API. 


<a name="oauth"></a>

### OAuth-required API
At the outset I mentioned how OAuth is an authorization framework that provides credentials as proof for access. Many APIs are open to the public and only require an API key; however, some APIs require authorization to account data (think personal Facebook & Twitter accounts). To access these accounts we must provide proper credentials and OAuth authentication allows us to do this. This post is not meant to explain the details of OAuth (for that see [this](http://hueniverse.com/2007/09/05/explaining-oauth/), [this](https://en.wikipedia.org/wiki/OAuth), and [this](http://hueniverse.com/oauth/)) but, rather, how to use `httr` in times when OAuth is required.

I'll demonstrate by accessing the Twitter API using my Twitter account. The first thing we need to do is identify the OAuth endpoints used to request access and authorization. To do this we can use `oauth_endpoint()` which typically requires a *request* URL, *authorization* URL, and *access* URL. `httr` also included some baked-in endpoints to include LinkedIn, Twitter, Vimeo, Google, Facebook, and GitHub. We can see the Twitter endpoints using the following:


{% highlight r %}
twitter_endpts <- oauth_endpoints("twitter")
twitter_endpts
## <oauth_endpoint>
##  request:   https://api.twitter.com/oauth/request_token
##  authorize: https://api.twitter.com/oauth/authenticate
##  access:    https://api.twitter.com/oauth/access_token
{% endhighlight %}

Next, I register my application at [https://apps.twitter.com/](https://apps.twitter.com/).  One thing to note is during the registration process, it will ask you for the *callback url*; be sure to use "http://127.0.0.1:1410". Once registered, Twitter will provide you with keys and access tokens. The two we are concerned about are the API key and API Secret.




{% highlight r %}
twitter_key <- "BZgukbCol..."   # truncated
twitter_secret <- "YpB8Xy..."   # truncated
{% endhighlight %}

We can then bundle the consumer key and secret into one object with `oauth_app()`. The first argument, `appname` is simply used as a local identifier; it does not need to match the name you gave the Twitter app you developed at https://apps.twitter.com/.



We are now ready to ask for access credentials. Since Twitter uses OAuth 1.0 we use `oauth1.0_token()` function and incorporate the endpoints identified and the `oauth_app` object we previously named `twitter_app`.


{% highlight r %}
twitter_token <- oauth1.0_token(endpoint = twitter_endpts, twitter_app)

Waiting for authentication in browser...
Press Esc/Ctrl + C to abort
Authentication complete.
{% endhighlight %}

Once authentication is complete we can now use the API. I can pull all the tweets that show up on my personal timeline using the `GET()` function and the access cridentials I stored in `twitter_token`.  I then use `content()` to convert to a list and I can start to analyze the data.

In this case each tweet is saved as an individual list item and a full range of data are provided for each tweet (i.e. id, text, user, geo location, favorite count, etc). For instance, we can see that the first tweet was by [FiveThirtyEight](http://fivethirtyeight.com/) concerning American politics and, at the time of this analysis, has been favorited by 3 people.


{% highlight r %}
# request Twitter data
req <- GET("https://api.twitter.com/1.1/statuses/home_timeline.json",
           config(token = twitter_token))

# convert to R object
tweets <- content(req)

# available data for first tweet on my timeline
names(tweets[[1]])
 [1] "created_at"                    "id"                           
 [3] "id_str"                        "text"                         
 [5] "source"                        "truncated"                    
 [7] "in_reply_to_status_id"         "in_reply_to_status_id_str"    
 [9] "in_reply_to_user_id"           "in_reply_to_user_id_str"      
[11] "in_reply_to_screen_name"       "user"                         
[13] "geo"                           "coordinates"                  
[15] "place"                         "contributors"                 
[17] "is_quote_status"               "retweet_count"                
[19] "favorite_count"                "entities"                     
[21] "extended_entities"             "favorited"                    
[23] "retweeted"                     "possibly_sensitive"           
[25] "possibly_sensitive_appealable" "lang" 

# further analysis of first tweet on my timeline
tweets[[1]]$user$name
[1] "FiveThirtyEight"

tweets[[1]]$text
[1] "\U0001f3a7 A History Of Data In American Politics (Part 1): William Jennings Bryan to Barack Obama https://t.co/oCKzrXuRHf  https://t.co/6CvKKToxoH"

tweets[[1]]$favorite_count
[1] 3
{% endhighlight %}

This provides a fairly simple example of incorporating OAuth authorization. The `httr` provides several examples of accessing common social network APIs that require OAuth. I recommend you go through several of these examples to get familiar with using OAuth authorization; see them at `demo(package = "httr")`. The most difficult aspect of creating your own connections with APIs is gaining an understanding of the API and the arguments they leverage.  This obviously requires time and energy devoted to digging into the API documentation and data library. Next its just a matter of trial and error (likely more the latter than the former) to learn how to translate these arguments into `httr` function calls to pull the data of interest.

Also, note that `httr` provides several other useful functions not covered here for communicating with APIs (i.e. `POST()`, `BROWSE()`). For more on these other `httr` capabilities see this [quickstart vignette](https://cran.r-project.org/web/packages/httr/vignettes/quickstart.html).


<small><a href="#">Go to top</a></small>

<br>


## Wrapping Up
As the growth in publicly available data continues, APIs appear to be the preferred medium for access. This will require analysts to become more familiar with interacting with APIs and the prerequisites they often require. R API packages are being developed quickly and should be your first search when looking to request data via an API. As illustrated, these packages tend to be very easy to work with. However, when you want to leverage an organization's API that has not been integrated into an R package, the `httr` package provides a convenient way to request data.

<small><a href="#">Go to top</a></small>
