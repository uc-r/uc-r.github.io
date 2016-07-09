---
layout: tutorial
title: Exporting to Text Files
permalink: /export_text_files
---

As mentioned in the [importing data section](http://uc-r.github.io/import), text files are a popular way to hold and exchange tabular data as almost any data application supports exporting data to the CSV (or other text file) formats.  Consequently, exporting data to a text file is a pretty standard operation. Plus, since you've already learned how to import text files you pretty much have the basics required to write to text files...we just use a slightly different naming convention. 

Similar to the examples provided in the importing text files section, the two main groups of functions that I will demonstrate to write to text files include [base R functions](#base) and [`readr` package functions](#readr).

- [Base R functions](#base)
- [`readr` package functions](#readr)

### Base R functions {#base}
`write.table()` is the multipurpose work-horse function in base R for exporting data.  The functions `write.csv()` and `write.delim()` are special cases of `write.table()` in which the defaults have been adjusted for efficiency.  To illustrate these functions let's work with a data frame that we wish to export to a CSV file in our working directory.


```r
df <- data.frame(var1 = c(10, 25, 8), 
                 var2 = c("beer", "wine", "cheese"), 
                          var3 = c(TRUE, TRUE, FALSE),
                 row.names = c("billy", "bob", "thornton"))

df
##          var1   var2  var3
## billy      10   beer  TRUE
## bob        25   wine  TRUE
## thornton    8 cheese FALSE
```

To export `df` to a CSV file we can use `write.csv()`. Additional arguments allow you to exclude row and column names, specify what to use for missing values, add or remove quotations around character strings, etc.  


```r
# write to a csv file
write.csv(df, file = "export_csv")

# write to a csv and save in a different directory
write.csv(df, file = "/folder/subfolder/subsubfolder/export_csv")

# write to a csv file with added arguments
write.csv(df, file = "export_csv", row.names = FALSE, na = "MISSING!")
```

In addition to CSV files, we can also write to other text files using `write.table` and `write.delim()`.


```r
# write to a tab delimited text files
write.delim(df, file = "export_txt")

# provides same results as read.delim
write.table(df, file = "export_txt", sep="\t")
```

### readr package {#readr}
The `readr` package uses write functions similar to base R. However, `readr` write functions are about twice as fast and they do not write row names. One thing to note, where base R write functions use the `file =` argument, `readr` write functions use `path =`.


```r
library(readr)

# write to a csv file
write_csv(df, path = "export_csv2")

# write to a csv and save in a different directory
write_csv(df, path = "/folder/subfolder/subsubfolder/export_csv2")

# write to a csv file without column names
write_csv(df, path = "export_csv2", col_names = FALSE)

# write to a txt file without column names
write_delim(df, path = "export_txt2", col_names = FALSE)
```
