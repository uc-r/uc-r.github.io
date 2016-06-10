---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Importing, Scraping, and exporting data](data_inputs_outputs) &#187; [Scraping data](scraping_data) &#187; Scraping HTML table data

<br>

In this tutorial I cover how to scrape data from another common structure of data storage on the Web - HTML tables. This tutorial reiterates some of the information from the [previous tutorial](scraping_data_html_text); however, we focus solely on scraping data from HTML tables. The simplest approach to scraping HTML table data directly into R is by using either the <a href="#rvest">`rvest` package</a> or the <a href="#xml">`XML` package</a>.    To illustrate, I will focus on the [BLS employment statistics webpage](http://www.bls.gov/web/empsit/cesbmart.htm) which contains multiple HTML tables from which we can scrape data. 

<br>

<a name="rvest"></a>

## Scraping HTML tables with rvest

Recall that HTML elements are written with a start tag, an end tag, and with the content in between: `<tagname>content</tagname>`. HTML tables are contained within `<table>` tags; therefore, to extract the tables from the BLS employment statistics webpage we first use the `html_nodes()` function to select the `<table>` nodes.  In this case we are interested in all table nodes that exist on the webpage. In this example, `html_nodes` captures 15 HTML tables. This includes data from the 10 data tables seen on the webpage but also includes data from a few additional tables used to format parts of the page (i.e. table of contents, table of figures, advertisements).


{% highlight r %}
library(rvest)

webpage <- read_html("http://www.bls.gov/web/empsit/cesbmart.htm")

tbls <- html_nodes(webpage, "table")

head(tbls)
## {xml_nodeset (6)}
## [1] <table id="main-content-table">&#13;\n\t<tr>&#13;\n\t\t<td id="secon ...
## [2] <table id="Table1" class="regular" cellspacing="0" cellpadding="0" x ...
## [3] <table id="Table2" class="regular" cellspacing="0" cellpadding="0" x ...
## [4] <table id="Table3" class="regular" cellspacing="0" cellpadding="0" x ...
## [5] <table id="Table4" class="regular" cellspacing="0" cellpadding="0" x ...
## [6] <table id="Exhibit1" class="regular" cellspacing="0" cellpadding="0" ...
{% endhighlight %}

Remember that `html_nodes()` does not parse the data; rather, it acts as a CSS selector. To parse the HTML table data we use `html_table()`, which would create a list containing 15 data frames.  However, rarely do we need to scrape *every* HTML table from a page, especially since some HTML tables don't catch any information we are likely interested in (i.e. table of contents, table of figures, footers). 

More often than not we want to parse specific tables. Lets assume we want to parse the second and third tables on the webpage:

1. Table 2. Nonfarm employment benchmarks by industry, March 2014 (in thousands) and
2. Table 3. Net birth/death estimates by industry supersector, April – December 2014 (in thousands) 

This can be accomplished two ways. First, we can assess the previous `tbls` list and try to identify the table(s) of interest. In this example it appears that `tbls` list items 3 and 4 correspond with Table 2 and Table 3, respectively. We can then subset the list of table nodes prior to parsing the data with `html_table()`. This results in a list of two data frames containing the data of interest.


{% highlight r %}
tbls_ls <- webpage %>%
        html_nodes("table") %>%
        .[3:4] %>%
        html_table(fill = TRUE)

str(tbls_ls)
## List of 2
##  $ :'data.frame':	147 obs. of  6 variables:
##   ..$ CES Industry Code : chr [1:147] "Amount" "00-000000" "05-000000" "06-000000" ...
##   ..$ CES Industry Title: chr [1:147] "Percent" "Total nonfarm" "Total private" "Goods-producing" ...
##   ..$ Benchmark         : chr [1:147] NA "137,214" "114,989" "18,675" ...
##   ..$ Estimate          : chr [1:147] NA "137,147" "114,884" "18,558" ...
##   ..$ Differences       : num [1:147] NA 67 105 117 -50 -12 -16 -2.8 -13.2 -13.5 ...
##   ..$ NA                : chr [1:147] NA "(1)" "0.1" "0.6" ...
##  $ :'data.frame':	11 obs. of  12 variables:
##   ..$ CES Industry Code : chr [1:11] "10-000000" "20-000000" "30-000000" "40-000000" ...
##   ..$ CES Industry Title: chr [1:11] "Mining and logging" "Construction" "Manufacturing" "Trade, transportation, and utilities" ...
##   ..$ Apr               : int [1:11] 2 35 0 21 0 8 81 22 82 12 ...
##   ..$ May               : int [1:11] 2 37 6 24 5 8 22 13 81 6 ...
##   ..$ Jun               : int [1:11] 2 24 4 12 0 4 5 -14 86 6 ...
##   ..$ Jul               : int [1:11] 2 12 -3 7 -1 3 35 7 62 -2 ...
##   ..$ Aug               : int [1:11] 1 12 4 14 3 4 19 21 23 3 ...
##   ..$ Sep               : int [1:11] 1 7 1 9 -1 -1 -12 12 -33 -2 ...
##   ..$ Oct               : int [1:11] 1 12 3 28 6 16 76 35 -17 4 ...
##   ..$ Nov               : int [1:11] 1 -10 2 10 3 3 14 14 -22 1 ...
##   ..$ Dec               : int [1:11] 0 -21 0 4 0 10 -10 -3 4 1 ...
##   ..$ CumulativeTotal   : int [1:11] 12 108 17 129 15 55 230 107 266 29 ...
{% endhighlight %}

An alternative approach, which is more explicit, is to use the [element selector process described in the text scraping tutorial](scraping_data_html_text#specific_nodes) to call the table ID name. 


{% highlight r %}
# empty list to add table data to
tbls2_ls <- list()

# scrape Table 2. Nonfarm employment...
tbls2_ls$Table1 <- webpage %>%
        html_nodes("#Table2") %>% 
        html_table(fill = TRUE) %>%
        .[[1]]

# Table 3. Net birth/death...
tbls2_ls$Table2 <- webpage %>%
        html_nodes("#Table3") %>% 
        html_table() %>%
        .[[1]]

str(tbls2_ls)
## List of 2
##  $ Table1:'data.frame':	147 obs. of  6 variables:
##   ..$ CES Industry Code : chr [1:147] "Amount" "00-000000" "05-000000" "06-000000" ...
##   ..$ CES Industry Title: chr [1:147] "Percent" "Total nonfarm" "Total private" "Goods-producing" ...
##   ..$ Benchmark         : chr [1:147] NA "137,214" "114,989" "18,675" ...
##   ..$ Estimate          : chr [1:147] NA "137,147" "114,884" "18,558" ...
##   ..$ Differences       : num [1:147] NA 67 105 117 -50 -12 -16 -2.8 -13.2 -13.5 ...
##   ..$ NA                : chr [1:147] NA "(1)" "0.1" "0.6" ...
##  $ Table2:'data.frame':	11 obs. of  12 variables:
##   ..$ CES Industry Code : chr [1:11] "10-000000" "20-000000" "30-000000" "40-000000" ...
##   ..$ CES Industry Title: chr [1:11] "Mining and logging" "Construction" "Manufacturing" "Trade, transportation, and utilities" ...
##   ..$ Apr               : int [1:11] 2 35 0 21 0 8 81 22 82 12 ...
##   ..$ May               : int [1:11] 2 37 6 24 5 8 22 13 81 6 ...
##   ..$ Jun               : int [1:11] 2 24 4 12 0 4 5 -14 86 6 ...
##   ..$ Jul               : int [1:11] 2 12 -3 7 -1 3 35 7 62 -2 ...
##   ..$ Aug               : int [1:11] 1 12 4 14 3 4 19 21 23 3 ...
##   ..$ Sep               : int [1:11] 1 7 1 9 -1 -1 -12 12 -33 -2 ...
##   ..$ Oct               : int [1:11] 1 12 3 28 6 16 76 35 -17 4 ...
##   ..$ Nov               : int [1:11] 1 -10 2 10 3 3 14 14 -22 1 ...
##   ..$ Dec               : int [1:11] 0 -21 0 4 0 10 -10 -3 4 1 ...
##   ..$ CumulativeTotal   : int [1:11] 12 108 17 129 15 55 230 107 266 29 ...
{% endhighlight %}

One issue to note is when using `rvest`'s `html_table()` to read a table with split column headings as in *Table 2. Nonfarm employment...*.  `html_table` will cause split headings to be included and can cause the first row to include parts of the headings.  We can see this with Table 2.  This requires a little clean up.


{% highlight r %}

head(tbls2_ls[[1]], 4)
##   CES Industry Code CES Industry Title Benchmark Estimate Differences   NA
## 1            Amount            Percent      <NA>     <NA>          NA <NA>
## 2         00-000000      Total nonfarm   137,214  137,147          67  (1)
## 3         05-000000      Total private   114,989  114,884         105  0.1
## 4         06-000000    Goods-producing    18,675   18,558         117  0.6

# remove row 1 that includes part of the headings
tbls2_ls[[1]] <- tbls2_ls[[1]][-1,]

# rename table headings
colnames(tbls2_ls[[1]]) <- c("CES_Code", "Ind_Title", "Benchmark",
                            "Estimate", "Amt_Diff", "Pct_Diff")

head(tbls2_ls[[1]], 4)
##    CES_Code         Ind_Title Benchmark Estimate Amt_Diff Pct_Diff
## 2 00-000000     Total nonfarm   137,214  137,147       67      (1)
## 3 05-000000     Total private   114,989  114,884      105      0.1
## 4 06-000000   Goods-producing    18,675   18,558      117      0.6
## 5 07-000000 Service-providing   118,539  118,589      -50      (1)
{% endhighlight %}

<br>

<a name="xml"></a>

## Scraping HTML tables with XML 
An alternative to `rvest` for table scraping is to use the [`XML`](https://cran.r-project.org/web/packages/XML/index.html) package. The XML package provides a convenient `readHTMLTable()` function to extract data from HTML tables in HTML documents.  By passing the URL to `readHTMLTable()`, the data in each table is read and stored as a data frame.  In a situation like our running example where multiple tables exists, the data frames will be stored in a list similar to `rvest`'s `html_table`.


{% highlight r %}
library(XML)

url <- "http://www.bls.gov/web/empsit/cesbmart.htm"

# read in HTML data
tbls_xml <- readHTMLTable(url)

typeof(tbls_xml)
## [1] "list"

length(tbls_xml)
## [1] 15
{% endhighlight %}

You can see that `tbls_xml` captures the same 15 `<table>` nodes that `html_nodes` captured. To capture the same tables of interest we previously discussed (*Table 2. Nonfarm employment...* and *Table 3. Net birth/death...*) we can use a couple approaches. First, we can assess `str(tbls_xml)` to identify the tables of interest and perform normal [list subsetting](list#subsetting). In our example list items 3 and 4 correspond with our tables of interest.


{% highlight r %}
head(tbls_xml[[3]])
##          V1                        V2      V3      V4  V5   V6
## 1 00-000000             Total nonfarm 137,214 137,147  67  (1)
## 2 05-000000             Total private 114,989 114,884 105  0.1
## 3 06-000000           Goods-producing  18,675  18,558 117  0.6
## 4 07-000000         Service-providing 118,539 118,589 -50  (1)
## 5 08-000000 Private service-providing  96,314  96,326 -12  (1)
## 6 10-000000        Mining and logging     868     884 -16 -1.8

head(tbls_xml[[4]], 3)
##   CES Industry Code CES Industry Title Apr May Jun Jul Aug Sep Oct Nov Dec   CumulativeTotal
## 1         10-000000 Mining and logging   2   2   2   2   1   1   1   1   0                12
## 2         20-000000       Construction  35  37  24  12  12   7  12 -10 -21               108
## 3         30-000000      Manufacturing   0   6   4  -3   4   1   3   2   0                17
{% endhighlight %}

Second, we can use the `which` argument in `readHTMLTable()` which restricts the data importing to only those tables specified numerically.


{% highlight r %}
# only parse the 3rd and 4th tables
emp_ls <- readHTMLTable(url, which = c(3, 4))

str(emp_ls)
## List of 2
##  $ Table2:'data.frame':	145 obs. of  6 variables:
##   ..$ V1: Factor w/ 145 levels "00-000000","05-000000",..: 1 2 3 4 5 6 7 8 9 10 ...
##   ..$ V2: Factor w/ 143 levels "Accommodation",..: 130 131 52 116 102 74 67 73 90 75 ...
##   ..$ V3: Factor w/ 145 levels "1,010.3","1,048.3",..: 40 35 48 37 145 140 109 135 51 65 ...
##   ..$ V4: Factor w/ 145 levels "1,008.4","1,052.3",..: 41 34 48 36 144 142 109 136 66 65 ...
##   ..$ V5: Factor w/ 123 levels "-0.3","-0.4",..: 113 68 71 48 9 19 29 11 12 43 ...
##   ..$ V6: Factor w/ 56 levels "-0.1","-0.2",..: 30 31 36 30 30 16 28 14 29 22 ...
##  $ Table3:'data.frame':	11 obs. of  12 variables:
##   ..$ CES Industry Code : Factor w/ 11 levels "10-000000","20-000000",..: 1 2 3 4 5 6 7 8 9 10 ...
##   ..$ CES Industry Title: Factor w/ 11 levels "263","Construction",..: 8 2 7 11 5 4 10 3 6 9 ...
##   ..$ Apr               : Factor w/ 10 levels "0","12","2","204",..: 3 7 1 5 1 8 9 6 10 2 ...
##   ..$ May               : Factor w/ 10 levels "129","13","2",..: 3 6 8 5 7 9 4 2 10 8 ...
##   ..$ Jun               : Factor w/ 10 levels "-14","0","12",..: 5 6 7 3 2 7 8 1 10 9 ...
##   ..$ Jul               : Factor w/ 10 levels "-1","-2","-3",..: 6 5 3 10 1 7 8 10 9 2 ...
##   ..$ Aug               : Factor w/ 9 levels "-19","1","12",..: 2 3 9 4 8 9 5 6 7 8 ...
##   ..$ Sep               : Factor w/ 9 levels "-1","-12","-2",..: 5 8 5 9 1 1 2 6 4 3 ...
##   ..$ Oct               : Factor w/ 10 levels "-17","1","12",..: 2 3 6 5 9 4 10 7 1 8 ...
##   ..$ Nov               : Factor w/ 8 levels "-10","-15","-22",..: 4 1 7 5 8 8 6 6 3 4 ...
##   ..$ Dec               : Factor w/ 8 levels "-10","-21","-3",..: 4 2 4 7 4 6 1 3 7 5 ...
##   ..$ CumulativeTotal   : Factor w/ 10 levels "107","108","12",..: 3 2 6 4 5 10 7 1 8 9 ...
{% endhighlight %}

The third option involves explicitly naming the tables to parse.  This process uses the [element selector process described in the text scraping tutorial](scraping_data_html_text#specific_nodes) to call the table by name. We use `getNodeSet()` to select the specified tables of interest. However, a key difference here is rather than copying the table ID names you want to copy the XPath.  You can do this with the following: After you've highlighted the table element of interest with the element selector, right click the highlighted element in the developer tools window and select Copy XPath. From here we just use `readHTMLTable()` to convert to data frames and we have our desired tables.


{% highlight r %}
library(RCurl)

# parse url
url_parsed <- htmlParse(getURL(url), asText = TRUE)

# select table nodes of interest
tableNodes <- getNodeSet(url_parsed, c('//*[@id="Table2"]', '//*[@id="Table3"]'))

# convert HTML tables to data frames
bls_table2 <- readHTMLTable(tableNodes[[1]])
bls_table3 <- readHTMLTable(tableNodes[[2]])

head(bls_table2)
##          V1                        V2      V3      V4  V5   V6
## 1 00-000000             Total nonfarm 137,214 137,147  67  (1)
## 2 05-000000             Total private 114,989 114,884 105  0.1
## 3 06-000000           Goods-producing  18,675  18,558 117  0.6
## 4 07-000000         Service-providing 118,539 118,589 -50  (1)
## 5 08-000000 Private service-providing  96,314  96,326 -12  (1)
## 6 10-000000        Mining and logging     868     884 -16 -1.8

head(bls_table3, 3)
##   CES Industry Code CES Industry Title Apr May Jun Jul Aug Sep Oct Nov Dec   CumulativeTotal
## 1         10-000000 Mining and logging   2   2   2   2   1   1   1   1   0                12
## 2         20-000000       Construction  35  37  24  12  12   7  12 -10 -21               108
## 3         30-000000      Manufacturing   0   6   4  -3   4   1   3   2   0                17
{% endhighlight %}

A few benefits of `XML`'s `readHTMLTable` that are routinely handy include:

- We can specify names for the column headings
- We can specify the classes for each column
- We can specify rows to skip

For instance, if you look at `bls_table2` above notice that because of the split column headings on *Table 2. Nonfarm employment...* `readHTMLTable` stripped and replaced the headings with generic names because R does not know which variable names should align with each column. We can correct for this with the following:


{% highlight r %}
bls_table2 <- readHTMLTable(tableNodes[[1]], 
                            header = c("CES_Code", "Ind_Title", "Benchmark",
                            "Estimate", "Amt_Diff", "Pct_Diff"))

head(bls_table2)
##    CES_Code                 Ind_Title Benchmark Estimate Amt_Diff Pct_Diff
## 1 00-000000             Total nonfarm   137,214  137,147       67      (1)
## 2 05-000000             Total private   114,989  114,884      105      0.1
## 3 06-000000           Goods-producing    18,675   18,558      117      0.6
## 4 07-000000         Service-providing   118,539  118,589      -50      (1)
## 5 08-000000 Private service-providing    96,314   96,326      -12      (1)
## 6 10-000000        Mining and logging       868      884      -16     -1.8
{% endhighlight %}

Also, for `bls_table3` note that the net birth/death values parsed have been converted to factor levels.  We can use the `colClasses` argument to correct this.  


{% highlight r %}
str(bls_table3)
## 'data.frame':	11 obs. of  12 variables:
##  $ CES Industry Code : Factor w/ 11 levels "10-000000","20-000000",..: 1 2 3 4 5 6 7 8 9 10 ...
##  $ CES Industry Title: Factor w/ 11 levels "263","Construction",..: 8 2 7 11 5 4 10 3 6 9 ...
##  $ Apr               : Factor w/ 10 levels "0","12","2","204",..: 3 7 1 5 1 8 9 6 10 2 ...
##  $ May               : Factor w/ 10 levels "129","13","2",..: 3 6 8 5 7 9 4 2 10 8 ...
##  $ Jun               : Factor w/ 10 levels "-14","0","12",..: 5 6 7 3 2 7 8 1 10 9 ...
##  $ Jul               : Factor w/ 10 levels "-1","-2","-3",..: 6 5 3 10 1 7 8 10 9 2 ...
##  $ Aug               : Factor w/ 9 levels "-19","1","12",..: 2 3 9 4 8 9 5 6 7 8 ...
##  $ Sep               : Factor w/ 9 levels "-1","-12","-2",..: 5 8 5 9 1 1 2 6 4 3 ...
##  $ Oct               : Factor w/ 10 levels "-17","1","12",..: 2 3 6 5 9 4 10 7 1 8 ...
##  $ Nov               : Factor w/ 8 levels "-10","-15","-22",..: 4 1 7 5 8 8 6 6 3 4 ...
##  $ Dec               : Factor w/ 8 levels "-10","-21","-3",..: 4 2 4 7 4 6 1 3 7 5 ...
##  $ CumulativeTotal   : Factor w/ 10 levels "107","108","12",..: 3 2 6 4 5 10 7 1 8 9 ...

bls_table3 <- readHTMLTable(tableNodes[[2]], 
                            colClasses = c("character","character", 
                                           rep("integer", 10)))

str(bls_table3)
## 'data.frame':	11 obs. of  12 variables:
##  $ CES Industry Code : Factor w/ 11 levels "10-000000","20-000000",..: 1 2 3 4 5 6 7 8 9 10 ...
##  $ CES Industry Title: Factor w/ 11 levels "263","Construction",..: 8 2 7 11 5 4 10 3 6 9 ...
##  $ Apr               : int  2 35 0 21 0 8 81 22 82 12 ...
##  $ May               : int  2 37 6 24 5 8 22 13 81 6 ...
##  $ Jun               : int  2 24 4 12 0 4 5 -14 86 6 ...
##  $ Jul               : int  2 12 -3 7 -1 3 35 7 62 -2 ...
##  $ Aug               : int  1 12 4 14 3 4 19 21 23 3 ...
##  $ Sep               : int  1 7 1 9 -1 -1 -12 12 -33 -2 ...
##  $ Oct               : int  1 12 3 28 6 16 76 35 -17 4 ...
##  $ Nov               : int  1 -10 2 10 3 3 14 14 -22 1 ...
##  $ Dec               : int  0 -21 0 4 0 10 -10 -3 4 1 ...
##  $ CumulativeTotal   : int  12 108 17 129 15 55 230 107 266 29 ...
{% endhighlight %}

Between `rvest` and `XML`, scraping HTML tables is relatively easy once you get fluent with the syntax and the available options.  This tutorial covers just the basics of both these packages to get you moving forward with scraping tables. In the next tutorial we move on to working with application program interfaces (APIs) to get data from the web.

<small><a href="#">Go to top</a></small>
