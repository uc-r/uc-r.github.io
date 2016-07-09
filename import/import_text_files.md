---
layout: tutorial
title: Importing Text Files
permalink: /import_text_files
---

Text files are a popular way to hold and exchange tabular data as almost any data application supports exporting data to the CSV (or other text file) formats.  Text file formats use delimiters to separate the different elements in a line, and each line of data is in its own line in the text file.  Therefore, importing different kinds of text files can follow a fairly consistent process once you've identified the delimiter.

There are two main groups of functions that we can use to read in text files:

* [Base R functions](#base_text_import)
* [`readr` package functions](#readr_text_import)


### Base R functions {#base_text_import}
`read.table()` is a multipurpose work-horse function in base R for importing data.  The functions `read.csv()` and `read.delim()` are special cases of `read.table()` in which the defaults have been adjusted for efficiency.  To illustrate these functions let's work with a CSV file that is saved in our working directory which looks like:


```r
variable 1,variable 2,variable 3
10,beer,TRUE
25,wine,TRUE
8,cheese,FALSE
```

To read in the CSV file we can use `read.csv()`.  Note that when we assess the structure of the data set that we read in, `variable.2` is automatically coerced to a factor variable and `variable.3` is automatically coerced to a logical variable.  Furthermore, any whitespace in the column names are replaced with a ".". 


```r
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
```

However, we may want to read in `variable.2` as a character variable rather then a factor.  We can take care of this by changing the `stringsAsFactors` argument.  The default has `stringsAsFactors = TRUE`; however, setting it equal to `FALSE` will read in the variable as a character variable.


```r
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
```

As previously stated `read.csv` is just a wrapper for `read.table` but with adjusted default arguments.  Therefore, we can use `read.table` to read in this same data.  The two arguments we need to be aware of are the field separator (`sep`) and the argument indicating whether the file contains the names of the variables as its first line (`header`).  In `read.table` the defaults are `sep = ""` and `header = FALSE` whereas in `read.csv` the defaults are `sep = ","` and `header = TRUE`.  There are multiple other arguments we can use for certain situations which we illustrate below:


```r
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
```

In addition to CSV files, there are other text files that `read.table` works with.  The primary difference is what separates the elements.  For example, tab delimited text files typically end with the `.txt` extension.  You can also use the `read.delim()` function as, similiar to `read.csv()`, `read.delim()` is a wrapper of `read.table()` with defaults set specifically for tab delimited files.


```r
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
```

### readr package {#readr_text_import}
Compared to the equivalent base functions, [`readr`](https://cran.rstudio.com/web/packages/readr/) functions are around 10x faster. They bring consistency to importing functions, they produce data frames in a `data.table` format which are easier to view for large data sets, the default settings removes the "hassels" of `stringsAsFactors`, and they have a more flexible column specification. 

To illustrate, we can use `read_csv()` which is equivalent to base R's `read.csv()` function.  However, note that `read_csv()` maintains the full variable name (whereas `read.csv` eliminates any spaces in variable names and fills it with '.').  Also, `read_csv()` automatically sets `stringsAsFactors = FALSE`, which can be a [controversial topic](http://simplystatistics.org/2015/07/24/stringsasfactors-an-unauthorized-biography/).


```r
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

These examples provide the basics for reading in text files. However, sometimes even text files can offer unanticipated difficulties with their formatting.  Both the base R and `readr` functions offer many arguments to deal with different formatting issues and I suggest you take time to look at the help files for these functions to learn more (i.e. `?read.table`).
