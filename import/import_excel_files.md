---
layout: tutorial
title: Importing Excel Files
permalink: /import_excel_files
---

With Excel still being the spreadsheet software of choice its important to be able to efficiently import and export data from these files.  Often, R users will simply resort to exporting the Excel file as a CSV file and then import into R using `read.csv`; however, this is far from efficient.  This section will teach you how to eliminate the CSV step and to import data directly from Excel using two different packages:

* [`xlsx` package](#xlsx_import)
* [`readxl` package](#readxl_import)

Note that there are several packages available to connect R with Excel (i.e. `gdata`, `RODBC`, `XLConnect`, `RExcel`, etc.); however, I am only going to cover the two main packages that I use which provide all the fundamental requirements I've needed for dealing with Excel.

### xlsx package {#xlsx_import}
The [`xlsx`](https://cran.rstudio.com/web/packages/xlsx/) package provides tools neccessary to interact with Excel 2007 (and older) files from R. Many of the benefits of the `xlsx` come from being able to *export* and *format* Excel files from R.  Some of these capabilities will be covered in the [Exporting Excel Data](http://uc-r.github.io/export_excel_files) section; however, in this section we will simply cover *importing* data from Excel with the `xlsx` package.

To illustrate, we'll use similar data from the [previous section](http://uc-r.github.io/import_text_files); however, saved as an .xlsx file in our working director.  To import the Excel data we simply use the `read.xlsx()` function:


```r
library(xlsx)

# read in first worksheet using a sheet index or name
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
```

Since Excel is such a flexible spreadsheet software, people often make notes, comments, headers, etc. at the beginning or end of the files which we may not want to include.  If we want to read in data that starts further down in the Excel worksheet we can include the `startRow` argument.  If we have a specific range of rows (or columns) to include we can use the `rowIndex` (or `colIndex`) argument.


```r
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
```
We can also change the class type of the columns when we read them in:


```r
# read in data without changing class type
mydata_sheet1.1 <- read.xlsx("mydata.xlsx", sheetName = "Sheet1")

str(mydata_sheet1.1)
## 'data.frame':	3 obs. of  3 variables:
##  $ variable.1: num  10 25 8
##  $ variable.2: Factor w/ 3 levels "beer","cheese",..: 1 3 2
##  $ variable.3: logi  TRUE TRUE FALSE

# read in data and change class type
mydata_sheet1.2 <- read.xlsx("mydata.xlsx", sheetName = "Sheet1",
                             stringsAsFactors = FALSE,
                             colClasses = c("double", "character", "logical"))

str(mydata_sheet1.2)
## 'data.frame':	3 obs. of  3 variables:
##  $ variable.1: num  10 25 8
##  $ variable.2: chr  "beer" "wine" "cheese"
##  $ variable.3: logi  TRUE TRUE FALSE
```

Another useful argument is `keepFormulas` which allows you to see the text of any formulas in the Excel spreadsheet:


```r
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
```


### readxl package {#readxl_import}
[`readxl`](https://cran.rstudio.com/web/packages/readxl/) is one of the newest packages for accessing Excel data with R and was developed by [Hadley Wickham](https://twitter.com/hadleywickham) and the [RStudio](https://www.rstudio.com/) team who also developed the `readr` package.  This package works with both legacy .xls formats and the modern xml-based .xlsx format.  Similar to `readr` the `readxl` functions are based on a C++ library so they are extremely fast. Unlike most other packages that deal with Excel, `readxl` has no external dependencies, so you can use it to read Excel data on just about any platform.  Additional benefits `readxl` provides includes the ability to load dates and times as POSIXct formatted dates, automatically drops blank columns, and returns outputs as data.table formatted which provides easier viewing for large data sets.

To read in Excel data with `readxl` you use the `read_excel()` function which has very similar operations and arguments as `xlsx`.  A few important differences you will see below include: `readxl` will automatically convert date and date-time variables to POSIXct formatted variables, character variables will not be coerced to factors, and logical variables will be read in as integers.


```r
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
```

The available arguments allow you to change the data as you import it.  Some examples are provided:


```r
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
```

One unique difference between `readxl` and `xlsx` is how to deal with column types.  Whereas `read.xlsx()` allows you to change the column types to integer, double, numeric, character, or logical; `read_excel()` restricts you to changing column types to blank, numeric, date, or text.  The "blank" option allows you to skip columns; however, to change variable 3 to a logical `TRUE`/`FALSE` variable requires a second step.


```r

mydata_ex <- read_excel("mydata.xlsx", sheet = "Sheet5",
                        col_types = c("numeric", "blank", "numeric", 
                                      "date", "blank"))
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
```
