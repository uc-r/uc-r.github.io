---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Importing, Scraping, and exporting data](data_inputs_outputs) &#187; Importing data

<br>

The first step to any data analysis process is to *get* the data.  Data can come from many sources but two of the most common include text & Excel files.  This section covers how to import data into R by reading data from common text files and Excel spreadsheets.  In addition, I cover how to load data from saved R object files, which is the preferred method for holding data that has been processed in R.  In addition to the the commonly used base R functions to perform data importing, I will also cover functions from the popular [`readr`](https://cran.rstudio.com/web/packages/readr/), [`xlsx`](https://cran.rstudio.com/web/packages/xlsx/), and [`readxl`](https://cran.rstudio.com/web/packages/readxl/) packages.  

* <a href="#csv">Reading data from text files</a>
* <a href="#excel">Reading data from Excel files</a>
* <a href="#robject">Load data from saved R object files</a>
* <a href="#importing_resources">Additional resources</a>

<br>

<a name="csv"></a>

## Reading data from text files
Text files are a popular way to hold and exchange tabular data as almost any data application supports exporting data to the CSV (or other text file) formats.  Text file formats use delimiters to separate the different elements in a line, and each line of data is in its own line in the text file.  Therefore, importing different text kinds of text files can follow a fairly consistent process once you've identified the delimiter.

There are two main groups of functions that we can use to read in text files:

* <a href="#base_text_import">Base R functions</a>
* <a href="#readr_text_import">`readr` package functions</a>

<br>

<a name="base_text_import"></a>

### Base R functions
`read.table()` is a multipurpose work-horse function in base R for importing data.  The functions `read.csv()` and `read.delim()` are special cases of `read.table()` in which the defaults have been adjusted for efficiency.  To illustrate these functions let's work with a CSV file that is saved in our working directory which looks like:


{% highlight r %}
variable 1,variable 2,variable 3
10,beer,TRUE
25,wine,TRUE
8,cheese,FALSE
{% endhighlight %}

To read in the CSV file we can use `read.csv()`.  Note that when we assess the structure of the data set that we read in, `variable.2` is automatically coerced to a factor variable and `variable.3` is automatically coerced to a logical variable.  Furthermore, any whitespace in the column names are replaced with a ".". 


{% highlight r %}
mydata = read.csv("mydata.csv")
mydata
##   variable.1 variable.2 variable.3
## 1         10       beer       TRUE
## 2         25       wine       TRUE
## 3          8     cheese      FALSE

str(mydata)
## 'data.frame':	3 obs. of  3 variables:
##  $ variable.1: int  10 25 8
##  $ variable.2: Factor w/ 3 levels "beer","cheese",..: 1 3 2
##  $ variable.3: logi  TRUE TRUE FALSE
{% endhighlight %}

For many reasons we may want to read in `variable.2` as a character variable rather then a factor.  We can take care of this by changing the `stringsAsFactors` argument.  The default has `stringsAsFactors = TRUE`; however, setting it equal to `FALSE` will read in the variable as a character variable.


{% highlight r %}
mydata_2 = read.csv("mydata.csv", stringsAsFactors = FALSE)
mydata_2
##   variable.1 variable.2 variable.3
## 1         10       beer       TRUE
## 2         25       wine       TRUE
## 3          8     cheese      FALSE

str(mydata_2)
## 'data.frame':	3 obs. of  3 variables:
##  $ variable.1: int  10 25 8
##  $ variable.2: chr  "beer" "wine" "cheese"
##  $ variable.3: logi  TRUE TRUE FALSE
{% endhighlight %}

As previously stated `read.csv` is just a wrapper for `read.table` but with adjusted default arguments.  Therefore, we can use `read.table` to read in this same data.  The two arguments we need to be aware of are the field separator (`sep`) and the argument indicating whether the file contains the names of the variables as its first line (`header`).  In `read.table` the defaults are `sep = ""` and `header = FALSE` whereas in `read.csv` the defaults are `sep = ","` and `header = TRUE`.  There are multiple other arguments we can use for certain situations which we illustrate below:


{% highlight r %}
# provides same results as read.csv above
read.table("mydata.csv", sep=",", header = TRUE, stringsAsFactors = FALSE)
##   variable.1 variable.2 variable.3
## 1         10       beer       TRUE
## 2         25       wine       TRUE
## 3          8     cheese      FALSE

# set column and row names
read.table("mydata.csv", sep=",", header = TRUE, stringsAsFactors = FALSE,
           col.names = c("Var 1", "Var 2", "Var 3"),
           row.names = c("Row 1", "Row 2", "Row 3"))
##       Var.1  Var.2 Var.3
## Row 1    10   beer  TRUE
## Row 2    25   wine  TRUE
## Row 3     8 cheese FALSE

# manually set the classes of the columns 
set_classes <- read.table("mydata.csv", sep=",", header = TRUE,
                          colClasses = c("numeric", "character", "character"))
str(set_classes)
## 'data.frame':	3 obs. of  3 variables:
##  $ variable.1: num  10 25 8
##  $ variable.2: chr  "beer" "wine" "cheese"
##  $ variable.3: chr  "TRUE" "TRUE" "FALSE"

# limit the number of rows to read in
read.table("mydata.csv", sep=",", header = TRUE, nrows = 2)
##   variable.1 variable.2 variable.3
## 1         10       beer       TRUE
## 2         25       wine       TRUE
{% endhighlight %}

In addition to CSV files, there are other text files that `read.table` works with.  The primary difference is what separates the elements.  For example, tab delimited text files typically end with the `.txt` extension.  You can also use the `read.delim()` function as, similiar to `read.csv()`, `read.delim()` is a wrapper of `read.table()` with defaults set specifically for tab delimited files.


{% highlight r %}
# reading in tab delimited text files
read.delim("mydata.txt")
##   variable.1 variable.2 variable.3
## 1         10       beer       TRUE
## 2         25       wine       TRUE
## 3          8     cheese      FALSE

# provides same results as read.delim
read.table("mydata.txt", sep="\t", header = TRUE)
##   variable.1 variable.2 variable.3
## 1         10       beer       TRUE
## 2         25       wine       TRUE
## 3          8     cheese      FALSE
{% endhighlight %}

<br>

<a name="readr_text_import"></a>

### readr package
Compared to the equivalent base functions, [`readr`](https://cran.rstudio.com/web/packages/readr/) functions are around 10x faster. They bring consistency to importing functions, they produce data frames in a `data.table` format which are easier to view for large data sets, the default settings removes the "hassels" of `stringsAsFactors`, and they have a more flexible column specification. 

To illustrate, we can use `read_csv()` which is equivalent to base R's `read.csv()` function.  However, note that `read_csv()` maintains the full variable name (whereas `read.csv` eliminates any spaces in variable names and fills it with '.').  Also, `read_csv()` automatically sets `stringsAsFactors = FALSE`, which can be a [controversial topic](http://simplystatistics.org/2015/07/24/stringsasfactors-an-unauthorized-biography/).  


{% highlight r %}
library(readr)
mydata_3 = read_csv("mydata.csv")
mydata_3
##   variable 1 variable 2 variable 3
## 1         10       beer       TRUE
## 2         25       wine       TRUE
## 3          8     cheese      FALSE

str(mydata_3)
## Classes 'tbl_df', 'tbl' and 'data.frame':	3 obs. of  3 variables:
##  $ variable 1: int  10 25 8
##  $ variable 2: chr  "beer" "wine" "cheese"
##  $ variable 3: logi  TRUE TRUE FALSE
{% endhighlight %}

`read_csv` also offers many additional arguments for making adjustments to your data as you read it in:


{% highlight r %}
# specify the column class using col_types
read_csv("mydata.csv", col_types = list(col_double(), 
                                        col_character(), 
                                        col_character()))
##   variable 1 variable 2 variable 3
## 1         10       beer       TRUE
## 2         25       wine       TRUE
## 3          8     cheese      FALSE

# we can also specify column classes with a string
# in this example d = double, _ skips column, c = character
read_csv("mydata.csv", col_types = "d_c")
##   variable 1 variable 3
## 1         10       TRUE
## 2         25       TRUE
## 3          8      FALSE

# set column names
read_csv("mydata.csv", col_names = c("Var 1", "Var 2", "Var 3"), skip = 1)
##   Var 1  Var 2 Var 3
## 1    10   beer  TRUE
## 2    25   wine  TRUE
## 3     8 cheese FALSE

# set the maximum number of lines to read in
read_csv("mydata.csv", n_max = 2)
##   variable 1 variable 2 variable 3
## 1         10       beer       TRUE
## 2         25       wine       TRUE
{% endhighlight %}

Similar to base R, `readr` also offers functions to import .txt files (`read_delim()`), fixed-width files (`read_fwf()`), general text files (`read_table()`), and more. 

These examples provide the basics for reading in text files. However, sometimes even text files can offer unanticipated difficulties with their formatting.  Both the base R and `readr` functions offer many arguments to deal with different formatting issues and I suggest you take time to look at the help files for these functions to learn more (i.e. `?read.table`).  Also, you will find more resources at the end of this chapter for importing files.<sup><a href="#fn1" id="ref1">1</a></sup>

<br>

<a name="excel"></a>

## Reading data from Excel files
With Excel still being the spreadsheet software of choice its important to be able to efficiently import and export data from these files.  Often, R users will simply resort to exporting the Excel file as a CSV file and then import into R using `read.csv`; however, this is far from efficient.  This section will teach you how to eliminate the CSV step and to import data directly from Excel using two different packages:

* <a href="#xlsx_import">`xlsx` package</a>
* <a href="#readxl_import">`readxl` package</a>

Note that there are several packages available to connect R with Excel (i.e. `gdata`, `RODBC`, `XLConnect`, `RExcel`, etc.); however, I am only going to cover the two main packages that I use which provide all the fundamental requirements I've needed for dealing with Excel.

<br>

<a name="xlsx_import"></a>

### xlsx package
The [`xlsx`](https://cran.rstudio.com/web/packages/xlsx/) package provides tools neccessary to interact with Excel 2007 (and older) files from R. Many of the benefits of the `xlsx` come from being able to *export* and *format* Excel files from R.  Some of these capabilities will be covered in the [Exporting Data](exporting_data) chapter; however, in this section we will simply cover *importing* data from Excel with the `xlsx` package.

To illustrate, we'll use similar data from the <a href="#base_text_import">previous section</a>; however, saved as an .xlsx file in our working director.  To import the Excel data we simply use the `read.xlsx()` function:


{% highlight r %}
library(xlsx)

# read in first worksheet using an sheet index or name
read.xlsx("mydata.xlsx", sheetName = "Sheet1")
##   variable.1 variable.2 variable.3
## 1         10       beer       TRUE
## 2         25       wine       TRUE
## 3          8     cheese      FALSE

read.xlsx("mydata.xlsx", sheetIndex = 1)
##   variable.1 variable.2 variable.3
## 1         10       beer       TRUE
## 2         25       wine       TRUE
## 3          8     cheese      FALSE

# read in second worksheet
read.xlsx("mydata.xlsx", sheetName = "Sheet2")
##   variable.4 variable.5
## 1     Dayton     johnny
## 2   Columbus      amber
## 3  Cleveland       tony
## 4 Cincinnati      alice
{% endhighlight %}

Since Excel is such a flexible spreadsheet software, people often make notes, comments, headers, etc. at the beginning or end of the files which we may not want to include.  If we want to read in data that starts further down in the Excel worksheet we can include the `startRow` argument.  If we have a specific range of rows (or columns) to include we can use the `rowIndex` (or `colIndex`) argument.


{% highlight r %}
# a worksheet with comments in the first two lines
read.xlsx("mydata.xlsx", sheetName = "Sheet3")
##                                         HEADER..COMPANY.A        NA.
## 1 What if we want to disregard header text in Excel file?       <NA>
## 2                                              variable 6 variable 7
## 3                                                     200       Male
## 4                                                     225     Female
## 5                                                     400     Female
## 6                                                     310       Male

# read in all data below the second line
read.xlsx("mydata.xlsx", sheetName = "Sheet3", startRow = 3)
##   variable.6 variable.7
## 1        200       Male
## 2        225     Female
## 3        400     Female
## 4        310       Male

# read in a range of rows
read.xlsx("mydata.xlsx", sheetName = "Sheet3", rowIndex = 3:5)
##   variable.6 variable.7
## 1        200       Male
## 2        225     Female
{% endhighlight %}

We can also change the class type of the columns when we read them in:

{% highlight r %}
# read in all data below the second line
mydata_sheet1.1 <- read.xlsx("mydata.xlsx", sheetName = "Sheet1")

str(mydata_sheet1.1)
## 'data.frame':	3 obs. of  3 variables:
##  $ variable.1: num  10 25 8
##  $ variable.2: Factor w/ 3 levels "beer","cheese",..: 1 3 2
##  $ variable.3: logi  TRUE TRUE FALSE

mydata_sheet1.2 <- read.xlsx("mydata.xlsx", sheetName = "Sheet1",
                             stringsAsFactors = FALSE,
                             colClasses = c("double", "character", "logical"))

str(mydata_sheet1.2)
## 'data.frame':	3 obs. of  3 variables:
##  $ variable.1: num  10 25 8
##  $ variable.2: chr  "beer" "wine" "cheese"
##  $ variable.3: logi  TRUE TRUE FALSE
{% endhighlight %}

Another useful argument is `keepFormulas` which allows to see the text of any formulas in the Excel spreadsheet:

{% highlight r %}
# by default keepFormula is set to FALSE so only
# the formula output will be read in
read.xlsx("mydata.xlsx", sheetName = "Sheet4")
##   Future.Value  Rate Periods Present.Value
## 1          500 0.065      10      266.3630
## 2          600 0.085       6      367.7671
## 3          750 0.080      11      321.6621
## 4         1000 0.070      16      338.7346

# changing the keepFormula to TRUE will display the equations
read.xlsx("mydata.xlsx", sheetName = "Sheet4", keepFormulas = TRUE)
##   Future.Value  Rate Periods Present.Value
## 1          500 0.065      10  A2/(1+B2)^C2
## 2          600 0.085       6  A3/(1+B3)^C3
## 3          750 0.080      11  A4/(1+B4)^C4
## 4         1000 0.070      16  A5/(1+B5)^C5
{% endhighlight %}

<br>

<a name="readxl_import"></a>

### readxl package
[`readxl`](https://cran.rstudio.com/web/packages/readxl/) is one of the newest packages for accessing Excel data with R and was developed by [Hadley Wickham](https://twitter.com/hadleywickham) and the [RStudio](https://www.rstudio.com/) team who also developed the `readr` package.  This package works with both legacy .xls formats and the modern xml-based .xlsx format.  Similar to `readr` the `readxl` functions are based on a C++ library so they are extremely fast. Unlike most other packages that deal with Excel, `readxl` has no external dependencies, so you can use it to read Excel data on just about any platform.  Additional benefits `readxl` provides includes the ability to load dates and times as POSIXct formatted dates, automatically drops blank columns, and returns outputs as data.table formatted which provides easier viewing for large data sets.

To read in Excel data with `readxl` you use the `read_excel()` function which has very similar operations and arguments as `xlsx`.  A few important differences you will see below include: `readxl` will automatically convert date and date-time variables to POSIXct formatted variables, character variables will not be coerced to factors, and logical variables will be read in as integers.


{% highlight r %}
library(readxl)

mydata <- read_excel("mydata.xlsx", sheet = "Sheet5")
mydata
##   variable 1 variable 2 variable 3 variable 4          variable 5
## 1         10       beer          1 2015-11-20 2015-11-20 13:30:00
## 2         25       wine          1       <NA> 2015-11-21 16:30:00
## 3          8       <NA>          0 2015-11-22 2015-11-22 14:45:00

str(mydata)
## Classes 'tbl_df', 'tbl' and 'data.frame':	3 obs. of  5 variables:
##  $ variable 1: num  10 25 8
##  $ variable 2: chr  "beer" "wine" NA
##  $ variable 3: num  1 1 0
##  $ variable 4: POSIXct, format: "2015-11-20" NA ...
##  $ variable 5: POSIXct, format: "2015-11-20 13:30:00" "2015-11-21 16:30:00" ...
{% endhighlight %}

The available arguments allow you to change the data as you import it.  Some examples are provided:


{% highlight r %}
library(readxl)

# change variable names by skipping the first row
# and using col_names to set the new names
read_excel("mydata.xlsx", sheet = "Sheet5", skip = 1, 
           col_names = paste("Var", 1:5))
##   Var 1 Var 2 Var 3 Var 4               Var 5
## 1    10  beer     1 42328 2015-11-20 13:30:00
## 2    25  wine     1    NA 2015-11-21 16:30:00
## 3     8  <NA>     0 42330 2015-11-22 14:45:00

# sometimes missing values are set as a sentinel value
# rather than just left blank - (i.e. "999")
read_excel("mydata.xlsx", sheet = "Sheet6")
##   variable 1 variable 2 variable 3 variable 4
## 1         10       beer          1      42328
## 2         25       wine          1        999
## 3          8        999          0      42330

# we can change these to missing values with na argument
read_excel("mydata.xlsx", sheet = "Sheet6", na = "999")
##   variable 1 variable 2 variable 3 variable 4
## 1         10       beer          1      42328
## 2         25       wine          1         NA
## 3          8       <NA>          0      42330
{% endhighlight %}

One unique difference between `readxl` and `xlsx` is how to deal with column types.  Whereas `read.xlsx()` allows you to change the column types to integer, double, numeric, character, or logical; `read_excel()` restricts you to changing column types to blank, numeric, date, or text.  The "blank" option allows you to skip columns; however, to change variable 3 to a logical `TRUE`/`FALSE` variable requires a second step.


{% highlight r %}

mydata_ex <- read_excel("mydata.xlsx", sheet = "Sheet5",
                        col_types = c("numeric", "blank", "numeric", "date", "blank"))
mydata_ex
##   variable 1 variable 3 variable 4
## 1         10          1 2015-11-20
## 2         25          1       <NA>
## 3          8          0 2015-11-22

# change variable 3 to a logical variable
mydata_ex$`variable 3` <- as.logical(mydata_ex$`variable 3`)
mydata_ex
##   variable 1 variable 3 variable 4
## 1         10       TRUE 2015-11-20
## 2         25       TRUE       <NA>
## 3          8      FALSE 2015-11-22
{% endhighlight %}


<br>

<a name="robject"></a>

## Load data from saved R object files
Sometimes you may need to save data or other R objects outside of your workspace.  You may want to share R data/objects with co-workers, transfer between projects or computers, or simply archive them.  There are three primary ways that people tend to save R data/objects: as .RData, .rda, or as .rds files.  The differences behind when you use each will be covered in the [Saving data as an R object file](exporting_data#Robject) section.  This section will simply shows how to load these data/object forms.


{% highlight r %}
load("mydata.RData")

load(file = "mydata.rda")

name <- readRDS("mydata.rds")
{% endhighlight %}

<br>

<a name="importing_resources"></a>

## Additional resources
In addition to text and Excel files, there are multiple other ways in which data is stored and exchanged.  Commercial statistical software such as SPSS, SAS, Stata, and Minitab often have the option to store data in a specific format for that software.  In addition, analysts commonly use databases to store large quantities of data.  R has good support to work with these additional options which we did not cover here.  The following provides a list of additional resources to learn about data importing for these specific cases:

* [R data import/export manual](https://cran.r-project.org/doc/manuals/R-data.html)
* [Working with databases](https://cran.r-project.org/doc/manuals/R-data.html#Relational-databases)
    * [MySQL](https://cran.r-project.org/web/packages/RMySQL/index.html)
    * [Oracle](https://cran.r-project.org/web/packages/ROracle/index.html)
    * [PostgreSQL](https://cran.r-project.org/web/packages/RPostgreSQL/index.html)
    * [SQLite](https://cran.r-project.org/web/packages/RSQLite/index.html)
    * [Open Database Connectivity databases](https://cran.rstudio.com/web/packages/RODBC/)
* [Importing data from commercial software](https://cran.r-project.org/doc/manuals/R-data.html#Importing-from-other-statistical-systems)
    * The [`foreign`](http://www.rdocumentation.org/packages/foreign) package provides functions that help you load data files from other programs such as [SPSS](http://www.r-bloggers.com/how-to-open-an-spss-file-into-r/), [SAS](http://rconvert.com/sas-vs-r-code-compare/5-ways-to-convert-sas-data-to-r/), [Stata](http://www.r-bloggers.com/how-to-read-and-write-stata-data-dta-files-into-r/), and others into R.


<small><a href="#">Go to top</a></small>

<br>
<P CLASS="footnote" style="line-height:0.75">
<sup id="fn1">1. These same arguments can be used in <code>read.table</code>, <code>read.csv</code>, and <code>read.delim</code><a href="#ref1" title="Jump back to footnote 1 in the text.">"&#8617;"</a><sup>
</P>
