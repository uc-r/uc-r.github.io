---
title: NULL
layout: page
---

[R Vocab Topics](index) &#187; [Importing, Scraping, and exporting data](data_inputs_outputs) &#187; [Scraping data](scraping_data) &#187; Importing tabular and Excel files stored online

<br>

The most basic form of getting data from online is to import tabular (i.e. .txt, .csv) or Excel files that are being hosted online. This is often not considered *web scraping*<sup><a href="#fn1" id="ref1">1</a></sup>; however, I think its a good place to start introducing the user to interacting with the web for obtaining data. Importing tabular data is especially common for the many types of government data available online.  A quick perusal of [Data.gov](https://www.data.gov/) illustrates nearly 188,510 examples. In fact, we can provide our first example of importing online tabular data by downloading the Data.gov CSV file that lists all the federal agencies that supply data to Data.gov. 


{% highlight r %}
# the url for the online CSV
url <- "https://www.data.gov/media/federal-agency-participation.csv"

# use read.csv to import
data_gov <- read.csv(url, stringsAsFactors = FALSE)

# for brevity I only display first 6 rows
data_gov[1:6,c(1,3:4)]
##                                      Agency.Name Datasets Last.Entry
## 1           Commodity Futures Trading Commission        3 01/12/2014
## 2           Consumer Financial Protection Bureau        2 09/26/2015
## 3           Consumer Financial Protection Bureau        2 09/26/2015
## 4 Corporation for National and Community Service        3 01/12/2014
## 5 Court Services and Offender Supervision Agency        1 01/12/2014
## 6                      Department of Agriculture      698 12/01/2015
{% endhighlight %}


Downloading Excel spreadsheets hosted online can be performed just as easily.  Recall that there is not a base R function for importing Excel data; however, several packages exist to handle this capability.  One package that works smoothly with pulling Excel data from urls is [`gdata`](https://cran.r-project.org/web/packages/gdata/index.html).  With `gdata` we can use `read.xls()` to download this [Fair Market Rents for Section 8 Housing](http://catalog.data.gov/dataset/fair-market-rents-for-the-section-8-housing-assistance-payments-program) Excel file from the given url. 


{% highlight r %}
library(gdata)

# the url for the online Excel file
url <- "http://www.huduser.org/portal/datasets/fmr/fmr2015f/FY2015F_4050_Final.xls"

# use read.xls to import
rents <- read.xls(url)

rents[1:6, 1:10]
##    fips2000  fips2010 fmr2 fmr0 fmr1 fmr3 fmr4 county State CouSub
## 1 100199999 100199999  788  628  663 1084 1288      1     1  99999
## 2 100399999 100399999  762  494  643 1123 1318      3     1  99999
## 3 100599999 100599999  670  492  495  834  895      5     1  99999
## 4 100799999 100799999  773  545  652 1015 1142      7     1  99999
## 5 100999999 100999999  773  545  652 1015 1142      9     1  99999
## 6 101199999 101199999  599  481  505  791 1061     11     1  99999
{% endhighlight %}

Note that many of the arguments covered in the [Importing Data tutorial](http://bradleyboehmke.github.io/tutorials/importing_data#excel) (i.e. specifying sheets to read from, skipping lines) also apply to `read.xls()`. In addition, `gdata` provides some useful functions (`sheetCount()` and `sheetNames()`) for identifying if multiple sheets exist prior to downloading.

Another common form of file storage is using zip files.  For instance, the [Bureau of Labor Statistics](http://www.bls.gov/home.htm) (BLS) stores their [public-use microdata](http://www.bls.gov/cex/pumdhome.htm) for the [Consumer Expenditure Survey](http://www.bls.gov/cex/home.htm) in .zip files.  We can use `download.file()` to download the file to your working directory and then work with this data as desired.


{% highlight r %}
url <- "http://www.bls.gov/cex/pumd/data/comma/diary14.zip"

# download .zip file and unzip contents
download.file(url, dest="dataset.zip", mode="wb") 
unzip ("dataset.zip", exdir = "./")

# assess the files contained in the .zip file which
# unzips as a folder named "diary14"
list.files("diary14")
##  [1] "dtbd141.csv" "dtbd142.csv" "dtbd143.csv" "dtbd144.csv" "dtid141.csv"
##  [6] "dtid142.csv" "dtid143.csv" "dtid144.csv" "expd141.csv" "expd142.csv"
## [11] "expd143.csv" "expd144.csv" "fmld141.csv" "fmld142.csv" "fmld143.csv"
## [16] "fmld144.csv" "memd141.csv" "memd142.csv" "memd143.csv" "memd144.csv"

# alternatively, if we know the file we want prior to unzipping
# we can extract the file without unzipping using unz():
zip_data <- read.csv(unz("dataset.zip", "diary14/expd141.csv"))
zip_data[1:5, 1:10]
##     NEWID ALLOC COST GIFT PUB_FLAG    UCC EXPNSQDY EXPN_QDY EXPNWKDY   EXPN_KDY
## 1 2825371     0 6.26    2        2 190112        1        D        3        D
## 2 2825371     0 1.20    2        2 190322        1        D        3        D
## 3 2825381     0 0.98    2        2  20510        3        D        2        D
## 4 2825381     0 0.98    2        2  20510        3        D        2        D
## 5 2825381     0 2.50    2        2  20510        3        D        2        D

{% endhighlight %}

The .zip archive file format is meant to compress files and are typically used on files of significant size.  For instance, the Consumer Expenditure Survey data we downloaded in the previous example is over 10MB.  Obviously there may be times in which we want to get specific data in the .zip file to analyze but not always permanently store the entire .zip file contents. In these instances we can use the following [process](http://stackoverflow.com/questions/3053833/using-r-to-download-zipped-data-file-extract-and-import-data) proposed by [Dirk Eddelbuettel](https://twitter.com/eddelbuettel) to temporarily download the .zip file, extract the desired data, and then discard the .zip file.


{% highlight r %}
# Create a temp. file name
temp <- tempfile()

# Use download.file() to fetch the file into the temp. file
download.file("http://www.bls.gov/cex/pumd/data/comma/diary14.zip",temp)

# Use unz() to extract the target file from temp. file
zip_data2 <- read.csv(unz(temp, "diary14/expd141.csv"))

# Remove the temp file via unlink()
unlink(temp)

zip_data2[1:5, 1:10]
##     NEWID ALLOC COST GIFT PUB_FLAG    UCC EXPNSQDY EXPN_QDY EXPNWKDY   EXPN_KDY
## 1 2825371     0 6.26    2        2 190112        1        D        3        D
## 2 2825371     0 1.20    2        2 190322        1        D        3        D
## 3 2825381     0 0.98    2        2  20510        3        D        2        D
## 4 2825381     0 0.98    2        2  20510        3        D        2        D
## 5 2825381     0 2.50    2        2  20510        3        D        2        D
{% endhighlight %}

One last common scenario I'll cover when importing spreadsheet data from online is when we identify multiple data sets that we'd like to download but are not centrally stored in a .zip format or the like. As a simple example lets look at the [average consumer price data](http://www.bls.gov/data/#prices) from the BLS. The BLS holds multiple data sets for different types of commodities within one [url](http://download.bls.gov/pub/time.series/ap/); however, there are separate links for each individual data set.  More complicated cases of this will have the links to tabular data sets scattered throughout a webpage<sup><a href="#fn2" id="ref2">2</a></sup>. The [`XML`](https://cran.r-project.org/web/packages/XML/index.html) package provides the useful `getHTMLLinks()` function to identify these links.


{% highlight r %}
library(XML)

# url hosting multiple links to data sets
url <- "http://download.bls.gov/pub/time.series/ap/"

# identify the links available
links <- getHTMLLinks(url)

links
##  [1] "/pub/time.series/"                           
##  [2] "/pub/time.series/ap/ap.area"                 
##  [3] "/pub/time.series/ap/ap.contacts"             
##  [4] "/pub/time.series/ap/ap.data.0.Current"       
##  [5] "/pub/time.series/ap/ap.data.1.HouseholdFuels"
##  [6] "/pub/time.series/ap/ap.data.2.Gasoline"      
##  [7] "/pub/time.series/ap/ap.data.3.Food"          
##  [8] "/pub/time.series/ap/ap.footnote"             
##  [9] "/pub/time.series/ap/ap.item"                 
## [10] "/pub/time.series/ap/ap.period"               
## [11] "/pub/time.series/ap/ap.series"               
## [12] "/pub/time.series/ap/ap.txt"
{% endhighlight %}

This allows us to assess which files exist that may be of interest.  In this case the links that we are primarily interested in are the ones that contain "data" in their name (links 4-7 listed above).  We can use the [`stringr`](https://cran.r-project.org/web/packages/stringr/index.html) package to extract these desired links which we will use to download the data.


{% highlight r %}
library(stringr)

# extract names for desired links and paste to url
links_data <- links[str_detect(links, "data")]

# paste url to data links to have full url for data sets
# use str_sub and regexpr to paste links at appropriate 
# starting point
filenames <- paste0(url, str_sub(links_data, start = regexpr("ap.data", links_data)))

filenames
## [1] "http://download.bls.gov/pub/time.series/ap/ap.data.0.Current"       
## [2] "http://download.bls.gov/pub/time.series/ap/ap.data.1.HouseholdFuels"
## [3] "http://download.bls.gov/pub/time.series/ap/ap.data.2.Gasoline"      
## [4] "http://download.bls.gov/pub/time.series/ap/ap.data.3.Food"
{% endhighlight %}

We can now proceed to develop a simple `for` loop function to download each data set. We store the results in a list which contains 4 items, one item for each data set.  Each list item contains the url in which the data was extracted from and the dataframe containing the downloaded data.  We're now ready to analyze these data sets as necessary. 


{% highlight r %}
# create empty list to dump data into
data_ls <- list()

for(i in 1:length(filenames)){
        url <- filenames[i]
        data <- read.delim(url)
        data_ls[[length(data_ls) + 1]] <- list(url=filenames[i], data=data)
}

str(data_ls)
## List of 4
##  $ :List of 2
##   ..$ url : chr "http://download.bls.gov/pub/time.series/ap/ap.data.0.Current"
##   ..$ data:'data.frame':	144712 obs. of  5 variables:
##   .. ..$ series_id     : Factor w/ 878 levels "APU0000701111    ",..: 1 1 1 1 1 1 1 1 1 1 ...
##   .. ..$ year          : int [1:144712] 1995 1995 1995 1995 1995 1995 1995 1995 1995 1995 ...
##   .. ..$ period        : Factor w/ 12 levels "M01","M02","M03",..: 1 2 3 4 5 6 7 8 9 10 ...
##   .. ..$ value         : num [1:144712] 0.238 0.242 0.242 0.236 0.244 0.244 0.248 0.255 0.256 0.254 ...
##   .. ..$ footnote_codes: logi [1:144712] NA NA NA NA NA NA ...
##  $ :List of 2
##   ..$ url : chr "http://download.bls.gov/pub/time.series/ap/ap.data.1.HouseholdFuels"
##   ..$ data:'data.frame':	90339 obs. of  5 variables:
##   .. ..$ series_id     : Factor w/ 343 levels "APU000072511     ",..: 1 1 1 1 1 1 1 1 1 1 ...
##   .. ..$ year          : int [1:90339] 1978 1978 1979 1979 1979 1979 1979 1979 1979 1979 ...
##   .. ..$ period        : Factor w/ 12 levels "M01","M02","M03",..: 11 12 1 2 3 4 5 6 7 8 ...
##   .. ..$ value         : num [1:90339] 0.533 0.545 0.555 0.577 0.605 0.627 0.656 0.709 0.752 0.8 ...
##   .. ..$ footnote_codes: logi [1:90339] NA NA NA NA NA NA ...
##  $ :List of 2
##   ..$ url : chr "http://download.bls.gov/pub/time.series/ap/ap.data.2.Gasoline"
##   ..$ data:'data.frame':	69357 obs. of  5 variables:
##   .. ..$ series_id     : Factor w/ 341 levels "APU000074712     ",..: 1 1 1 1 1 1 1 1 1 1 ...
##   .. ..$ year          : int [1:69357] 1973 1973 1973 1974 1974 1974 1974 1974 1974 1974 ...
##   .. ..$ period        : Factor w/ 12 levels "M01","M02","M03",..: 10 11 12 1 2 3 4 5 6 7 ...
##   .. ..$ value         : num [1:69357] 0.402 0.418 0.437 0.465 0.491 0.528 0.537 0.55 0.556 0.558 ...
##   .. ..$ footnote_codes: logi [1:69357] NA NA NA NA NA NA ...
##  $ :List of 2
##   ..$ url : chr "http://download.bls.gov/pub/time.series/ap/ap.data.3.Food"
##   ..$ data:'data.frame':	122302 obs. of  5 variables:
##   .. ..$ series_id     : Factor w/ 648 levels "APU0000701111    ",..: 1 1 1 1 1 1 1 1 1 1 ...
##   .. ..$ year          : int [1:122302] 1980 1980 1980 1980 1980 1980 1980 1980 1980 1980 ...
##   .. ..$ period        : Factor w/ 12 levels "M01","M02","M03",..: 1 2 3 4 5 6 7 8 9 10 ...
##   .. ..$ value         : num [1:122302] 0.203 0.205 0.211 0.206 0.207 0.21 0.214 0.215 0.214 0.212 ...
##   .. ..$ footnote_codes: logi [1:122302] NA NA NA NA NA NA ...
{% endhighlight %}


<small><a href="#">Go to top</a></small>

<br>
<P CLASS="footnote" style="line-height:0.75">
<sup id="fn1">1. In <a href="http://www.amazon.com/Automated-Data-Collection-Practical-Scraping/dp/111883481X/ref=pd_sim_14_1?ie=UTF8&dpID=51Tm7FHxWBL&dpSrc=sims&preST=_AC_UL160_SR108%2C160_&refRID=1VJ1GQEY0VCPZW7VKANX">Automated Data Collection with R</a> Munzert et al. state that "[t]he first way to get data from the web is almost too banal to be considered here and actually not a case of web scraping in the narrower sense."<a href="#ref1" title="Jump back to footnote 1 in the text.">"&#8617;"</a><sup>
</P>
<P CLASS="footnote" style="line-height:0.75">
<sup id="fn2">2. An example is provided in <a href="http://www.amazon.com/Automated-Data-Collection-Practical-Scraping/dp/111883481X/ref=pd_sim_14_1?ie=UTF8&dpID=51Tm7FHxWBL&dpSrc=sims&preST=_AC_UL160_SR108%2C160_&refRID=1VJ1GQEY0VCPZW7VKANX">Automated Data Collection with R</a> in which they use a similar approach to extract desired CSV files scattered throughout the <a href="http://www.elections.state.md.us/elections/2012/election_data/index.html">Maryland State Board of Elections website</a>.<a href="#ref2" title="Jump back to footnote 2 in the text.">"&#8617;"</a><sup>
</P>
