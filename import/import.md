---
layout: page
title: Importing Data
permalink: /import
---

The first step to any data analysis process is to *get* the data.  Data can come from many sources but two of the most common include text and Excel files.  This section covers how to import data from common files.  I also cover how to load data from saved R object files for holding or transferring data that has been processed in R.  In addition to the the commonly used base R functions to perform data importing, I will also cover functions from the popular [`readr`](https://cran.rstudio.com/web/packages/readr/) and [`readxl`](https://cran.rstudio.com/web/packages/readxl/) packages.

- [Importing text files](#import_text_files)
- [Importing Excel files](#import_excel_files)
- [Importing R object files](#import_r_objects)
- [Additional Resources](#importing_addtl_resources)

<br>

## Importing Text Files {#import_text_files}
Text files are a popular way to hold and exchange tabular data as almost any data application supports exporting data to the .csv (or other text file) format.  Text file formats use delimiters to separate the different elements in a line, and each line of data is in its own line in the text file.  Therefore, importing different kinds of text files can follow a fairly consistent process once you've identified the delimiter.

There are three main groups of functions that we can use to read in text files:

* [Base R functions](#base_text_import)
* [`readr` package functions](#readr_text_import)
* [`data.table` package functions](#fread)

All three functions will import a tabular file (.csv, .tsv, .txt, etc.) and convert it to a [data frame](dataframes) in R.


### Base R functions {#base_text_import}
`read.table()` is a multipurpose work-horse function in base R for importing data.  The functions `read.csv()` and `read.delim()` are special cases of `read.table()` in which the defaults have been adjusted for efficiency.  To illustrate these functions let's work with this [.csv file](https://www.dropbox.com/s/63wgqkmd7b3o3wd/mydata.csv?dl=1) which looks like (be sure to save this file in your working directory):


```r
variable 1,variable 2,variable 3
10,beer,TRUE
25,wine,TRUE
8,cheese,FALSE
```

To read in the CSV file we can use `read.csv()`.  

```r
mydata <- read.csv("mydata.csv")
```

Once you have imported the data there are several ways to get an initial view of this data prior to performing any analysis.  First, you can view it in your console by evaluating the `mydata` object you just created. Alternatively, you can use RStudio’s built-in data viewer to get a scroll-able view of the complete data set using `View` or use `str` to assess the **str**ucture of the data.  Try the following:

```r
View(mydata)
str(mydata)
```

Note that when we assess the structure of the data set, `variable.2` is automatically coerced to a factor variable and `variable.3` is automatically coerced to a logical variable.  If you are unfamiliar with data types in R you can learn about them in the *Data Types* section of this website or, if you're in one of my classes, we will cover these concepts later. Furthermore, any whitespace in the column names are replaced with a ".". 


```r
str(mydata)
## 'data.frame':	3 obs. of  3 variables:
##  $ variable.1: int  10 25 8
##  $ variable.2: Factor w/ 3 levels "beer","cheese",..: 1 3 2
##  $ variable.3: logi  TRUE TRUE FALSE
```

However, we may want to read in `variable.2` as a character variable rather then a factor.  We can take care of this by changing the `stringsAsFactors` argument.  The default has `stringsAsFactors = TRUE`; however, setting it equal to `FALSE` will read in the variable as a character variable.


```r
mydata_2 <- read.csv("mydata.csv", stringsAsFactors = FALSE)
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
```

As previously stated `read.csv` is just a wrapper function for `read.table` but with adjusted default arguments.  Therefore, we can use `read.table` to read in this same data.  The two arguments we need to be aware of are the field separator (`sep`) and the argument indicating whether the file contains the names of the variables as its first line (`header`).  In `read.table` the defaults are `sep = ""` and `header = FALSE` whereas in `read.csv` the defaults are `sep = ","` and `header = TRUE`.  There are multiple other arguments we can use for certain situations which we illustrate below:


```r
# provides same results as read.csv above
read.table("mydata.csv", sep = ",", header = TRUE, stringsAsFactors = FALSE)
##   variable.1 variable.2 variable.3
## 1         10       beer       TRUE
## 2         25       wine       TRUE
## 3          8     cheese      FALSE

# set column and row names
read.table("mydata.csv", sep = ",", header = TRUE, stringsAsFactors = FALSE,
           col.names = c("Var 1", "Var 2", "Var 3"),
           row.names = c("Row 1", "Row 2", "Row 3"))
##       Var.1  Var.2 Var.3
## Row 1    10   beer  TRUE
## Row 2    25   wine  TRUE
## Row 3     8 cheese FALSE

# manually set the classes of the columns 
set_classes <- read.table("mydata.csv", sep = ",", header = TRUE,
                          colClasses = c("numeric", "character", "character"))
str(set_classes)
## 'data.frame':	3 obs. of  3 variables:
##  $ variable.1: num  10 25 8
##  $ variable.2: chr  "beer" "wine" "cheese"
##  $ variable.3: chr  "TRUE" "TRUE" "FALSE"

# limit the number of rows to read in
read.table("mydata.csv", sep = ",", header = TRUE, nrows = 2)
##   variable.1 variable.2 variable.3
## 1         10       beer       TRUE
## 2         25       wine       TRUE
```

In addition to .csv files, there are other text files that `read.table` works with.  The primary difference is what separates the elements.  For example, tab delimited text files typically end with the .txt and .tsv extensions.  You can also use the `read.delim()` function as, similiar to `read.csv()`, `read.delim()` is a wrapper of `read.table()` with defaults set specifically for tab delimited files. We can read in this [.txt file](https://www.dropbox.com/s/35vbtblzfx3gkna/mydata.txt?dl=1) with the following:

```r
# reading in tab delimited text files
read.delim("mydata.txt")
##   variable.1 variable.2 variable.3
## 1         10       beer       TRUE
## 2         25       wine       TRUE
## 3          8     cheese      FALSE

# provides same results as read.delim
read.table("mydata.txt", sep = "\t", header = TRUE)
##   variable.1 variable.2 variable.3
## 1         10       beer       TRUE
## 2         25       wine       TRUE
## 3          8     cheese      FALSE
```

### readr package {#readr_text_import}
Compared to the equivalent base functions, [`readr`](https://cran.rstudio.com/web/packages/readr/) functions are around 10x faster. They bring consistency to importing functions, they produce data frames in a `data.table` format which are easier to view for large data sets, the default settings removes the "hassels" of `stringsAsFactors`, and they have a more flexible column specification. 

To illustrate, we can use `read_csv()` which is equivalent to base R's `read.csv()` function.  However, note that `read_csv()` maintains the full variable name (whereas `read.csv` eliminates any spaces in variable names and fills it with '.').  Also, `read_csv()` automatically sets `stringsAsFactors = FALSE`, which can be a [controversial topic](http://simplystatistics.org/2015/07/24/stringsasfactors-an-unauthorized-biography/).


```r
library(readr)
mydata_3 <- read_csv("mydata.csv")
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
```

`read_csv` also offers many additional arguments for making adjustments to your data as you read it in:


```r
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
```

Similar to base R, `readr` also offers functions to import .txt files (`read_delim()`), fixed-width files (`read_fwf()`), general text files (`read_table()`), and more. 

### data.table package functions {#fread}

The base R (`read.csv`) and readr (`read_csv`) functions work great for everyday, "normal" sized data sets.  However, as analysts we also need to be able to quickly import and analyze large data sets.  Although the `readr` functions are about 10x faster than base R importing functions, importing large data sets can still be a bit slow.  

For example, check out the [train_1.csv web traffic data set](https://www.kaggle.com/c/web-traffic-time-series-forecasting/data) provided by Kaggle. This data set has 145,063 observations and 551 variables which equates to 79,929,713 elements and 265.1 MB. Importing this data with base R `read.csv` takes about 60 seconds and importing with readr's `read_csv` takes 9 seconds.  

```r
# time to import with base R
system.time(df0 <- read.csv("train_1.csv"))
##    user  system elapsed 
##  60.153   2.137  63.446

# time to import with readr
system.time(df1 <- read_csv("train_1.csv"))
##   user  system elapsed 
##  8.985   0.926   9.875
```

However, reading this in with data.table's `fread` function is much faster.  The syntax for `fread` is similar to `read.csv` and `read_csv`.  We supply `fread` with the path to the file, similar to our previous examples, and the output is a data frame.  

```r
library(data.table)
fread("mydata.csv")
##    variable 1 variable 2 variable 3
## 1:         10       beer       TRUE
## 2:         25       wine       TRUE
## 3:          8     cheese      FALSE
```

Similar to `read_csv`, `fread` maintains the white space in the variable names and the default sets `stringsAsFactors = FALSE` so all character variables will be imported as characters rather than factors.  You can specify the `sep` argument; however, a benefit of `fread` is that it will identify the delimiter automatically so you should not have to change the default setting.  Also, like the other functions you set parameters to skip lines, change variable names and types, drop columns, etc.  Just check out `?fread` for all the options.

So how much faster is `fread` than `read.csv` and `read_csv`?  It imports the train_1.csv file in under 3 seconds, which is 3x faster than `read_csv` and 20x faster than `read.csv`:

```r
system.time(df2 <- fread("train_1.csv"))
##   user  system elapsed 
##  2.717   0.229   2.973
```

These examples provide the basics for reading in text files. However, sometimes even text files can offer unanticipated difficulties with their formatting.  The base R, `readr`, and `data.table` functions offer many arguments to deal with different formatting issues and I suggest you take time to look at the help files for these functions to learn more (i.e. `?read.table`).

### Exercises

1. Download and read in this [*flights.csv* file](https://www.dropbox.com/s/jtkdultbfp2a6sk/flights.csv?dl=1).
2. Compare the time it takes to read in this file with `read.csv`, `read_csv`, and `fread`.
3. Can you figure out how to read in the first line to see the titles? Try read in the first 1,000 lines and only the first 6 columns (check out the help file at `?read_csv`. 
4. What functions could you use to read in a .tsv file? See if you are correct by downloading and reading in this [*facebook.tsv* file](https://www.dropbox.com/s/bpmgrke55lcw13g/facebook.tsv?dl=1).
5. What functions and settings could you use to read a file where fields were separated with "&#124;"?



<br>

## Importing Excel Files {#import_excel_files}
With Excel still being the spreadsheet software of choice its important to be able to efficiently import and export data from these files.  Often, R users will simply resort to exporting the Excel file as a CSV file and then import into R using `read.csv`; however, this is far from efficient.  This section will teach you how to eliminate the CSV step and to import data directly from Excel using the [`readxl` package](#readxl_import)

Note that there are several packages available to connect R with Excel (i.e. `gdata`, `RODBC`, `XLConnect`, `RExcel`, etc.); however, `readxl` provides all the fundamental requirements typically needed for dealing with Excel.

### readxl package {#readxl_import}
[`readxl`](https://cran.rstudio.com/web/packages/readxl/) is one of the newest packages for accessing Excel data with R and was developed by [Hadley Wickham](https://twitter.com/hadleywickham) and the [RStudio](https://www.rstudio.com/) team who also developed the `readr` package.  This package works with both legacy .xls formats and the modern xml-based .xlsx format.  Similar to `readr` the `readxl` functions are based on a C++ library so they are extremely fast. Unlike most other packages that deal with Excel, `readxl` has no external dependencies, so you can use it to read Excel data on just about any platform.  Additional benefits `readxl` provides includes the ability to load dates and times as POSIXct formatted dates, automatically drops blank columns, and returns outputs as data.table formatted which provides easier viewing for large data sets.

To read in Excel data with `readxl` you will commonly use the `excel_sheets()` and `read_excel()` functions.  `excel_sheets()` allows you to read the names of the different worksheets in the Excel workbook. You can then use `read_excel()` to import the data.  `read_excel()` will auto detect the format from the file extension (.xls vs. .xlsx) so you need not worry about the extensions. Furthermore, `read_excel()` will automatically convert date and date-time variables to POSIXct formatted variables, character variables will not be coerced to factors, and white spacing in variable names will not be removed.

The following illustrates how to use `readxl` to import Excel data and you can tag along using [this data](https://www.dropbox.com/s/arrlv8kmyihfukh/mydata.xlsx?dl=1).

```r
library(readxl)

excel_sheets("mydata.xlsx")
## [1] "PICK_ME_FIRST!" "Sheet2"         "extra_header"   "functions"     
## [5] "date_time"      "unique_NA"

mydata <- read_excel("mydata.xlsx", sheet = "PICK_ME_FIRST!")
mydata
## # A tibble: 3 x 3
##   `variable 1` `variable 2` `variable 3`
##          <dbl>        <chr>        <lgl>
## 1           10         beer         TRUE
## 2           25         wine         TRUE
## 3            8       cheese        FALSE

str(mydata)
## Classes 'tbl_df', 'tbl' and 'data.frame':	3 obs. of  3 variables:
##  $ variable 1: num  10 25 8
##  $ variable 2: chr  "beer" "wine" "cheese"
##  $ variable 3: logi  TRUE TRUE FALSE
```


The available arguments allow you to change the data as you import it.  Some examples are provided:


```r
# change variable names by skipping the first row
# and using col_names to set the new names
read_excel("mydata.xlsx", sheet = "extra_header", skip = 3, 
           col_names = c("Value", "Gender"))
## # A tibble: 4 x 2
##   Value Gender
##   <dbl>  <chr>
## 1   200   Male
## 2   225 Female
## 3   400 Female
## 4   310   Male

# sometimes missing values are set as a sentinel value
# rather than just left blank - (i.e. "999")
read_excel("mydata.xlsx", sheet = "unique_NA")
## # A tibble: 3 x 4
##   `variable 1` `variable 2` `variable 3` `variable 4`
##          <dbl>        <chr>        <lgl>        <dbl>
## 1           10         beer         TRUE        42328
## 2           25         wine         TRUE          999
## 3            8          999        FALSE        42330


# we can change these to missing values with na argument
read_excel("mydata.xlsx", sheet = "unique_NA", na = "999")
## # A tibble: 3 x 4
##   `variable 1` `variable 2` `variable 3` `variable 4`
##          <dbl>        <chr>        <lgl>       <dttm>
## 1           10         beer         TRUE   2015-11-20
## 2           25         wine         TRUE           NA
## 3            8         <NA>        FALSE   2015-11-22
```

`read_excel()` allows you to change column types. these options: "skip", "guess", "logical", "numeric", "date", "text" or "list".  Here I use skip to not import the 2nd and 5th columns and to change the logical variable (variable 3) to a numeric data type.


```r
read_excel("mydata.xlsx", sheet = "date_time",
           col_types = c("numeric", "skip", "numeric",
                         "date", "skip"))
## # A tibble: 3 x 3
##   `variable 1` `variable 3` `variable 4`
##          <dbl>        <dbl>       <dttm>
## 1           10            1   2015-11-20
## 2           25            1           NA
## 3            8            0   2015-11-22
```

### Exercises

1. What spreadsheets are in this [*mydata.xlsx*](https://www.dropbox.com/s/mbmy3u36u6un463/mydata.xlsx?dl=1) file? Practice reading in the different spreadsheets.
2. What spreadsheets are in this [*PEW Middle Class Data.xlsx*](https://www.dropbox.com/s/p6pcqf52acfktcp/PEW%20Middle%20Class%20Data.xlsx?dl=1) file?  Can you read in the *3.Median HH income, metro* spreadsheet (hint: you'll need to skip a few lines)?
3. What spreadsheets are in this [*Supermarket Transactions.xlsx*](https://www.dropbox.com/s/aoub0lfvo2s1zen/Supermarket%20Transactions.xlsx?dl=1) file? Read in the spreadsheet containing the data.


<br>

## Importing R Object Files {#import_r_objects}
Sometimes you may need to save data or other R objects outside of your workspace.  You may want to share R data/objects with co-workers, transfer between projects or computers, or simply archive them.  There are three primary ways that people tend to save R data/objects: as .RData, .rda, or as .rds files.  The differences behind when you use each will be covered in the [Saving data as an R object file](http://uc-r.github.io/exporting#export_r_objects) section.  This section simply shows how to load these data/object forms. 


```r
load("mydata.RData")

load(file = "mydata.rda")

readRDS("mydata.rds")

readr::read_rds("mydata.rds")
```

### Exercises

1. Import this [mydata.rds file](https://www.dropbox.com/s/s4ix9d2fx479pyt/mydata.rds?dl=1).
2. Import this [sheets1and2.RData file](https://www.dropbox.com/s/nrbztk6dtfpk8aa/sheets1and2.RData?dl=1). 
3. How many objects did exercise 1 and 2 import into your global environment?


<br>

## Additional Resources {#importing_addtl_resources}
In addition to text and Excel files, there are multiple other ways that data are stored and exchanged.  Commercial statistical software such as SPSS, SAS, Stata, and Minitab often have the option to store data in a specific format for that software.  In addition, analysts commonly use databases to store large quantities of data.  R has good support to work with these additional options which we did not cover here.  The following provides a list of additional resources to learn about data importing for these specific cases:

* [R data import/export manual](https://cran.r-project.org/doc/manuals/R-data.html)
* See what's new in the `readxl` package with this [RStudio webinar](https://www.rstudio.com/resources/webinars/whats-new-with-readxl/)
* [Working with databases](https://cran.r-project.org/doc/manuals/R-data.html#Relational-databases)
    * [MySQL](https://cran.r-project.org/web/packages/RMySQL/index.html)
    * [Oracle](https://cran.r-project.org/web/packages/ROracle/index.html)
    * [PostgreSQL](https://cran.r-project.org/web/packages/RPostgreSQL/index.html)
    * [SQLite](https://cran.r-project.org/web/packages/RSQLite/index.html)
    * [Open Database Connectivity databases](https://cran.rstudio.com/web/packages/RODBC/)
* [Importing data from commercial software](https://cran.r-project.org/doc/manuals/R-data.html#Importing-from-other-statistical-systems)
    * The [`foreign`](http://www.rdocumentation.org/packages/foreign) package provides functions that help you load data files from other programs such as [SPSS](http://www.r-bloggers.com/how-to-open-an-spss-file-into-r/), [SAS](http://rconvert.com/sas-vs-r-code-compare/5-ways-to-convert-sas-data-to-r/), [Stata](http://www.r-bloggers.com/how-to-read-and-write-stata-data-dta-files-into-r/), and others into R.

