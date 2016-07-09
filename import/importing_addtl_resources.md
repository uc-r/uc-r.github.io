---
layout: tutorial
title: Additional Resources
permalink: /importing_addtl_resources
---

In addition to text and Excel files, there are multiple other ways that data are stored and exchanged.  Commercial statistical software such as SPSS, SAS, Stata, and Minitab often have the option to store data in a specific format for that software.  In addition, analysts commonly use databases to store large quantities of data.  R has good support to work with these additional options which we did not cover here.  The following provides a list of additional resources to learn about data importing for these specific cases:

* [R data import/export manual](https://cran.r-project.org/doc/manuals/R-data.html)
* [Working with databases](https://cran.r-project.org/doc/manuals/R-data.html#Relational-databases)
    * [MySQL](https://cran.r-project.org/web/packages/RMySQL/index.html)
    * [Oracle](https://cran.r-project.org/web/packages/ROracle/index.html)
    * [PostgreSQL](https://cran.r-project.org/web/packages/RPostgreSQL/index.html)
    * [SQLite](https://cran.r-project.org/web/packages/RSQLite/index.html)
    * [Open Database Connectivity databases](https://cran.rstudio.com/web/packages/RODBC/)
* [Importing data from commercial software](https://cran.r-project.org/doc/manuals/R-data.html#Importing-from-other-statistical-systems)
    * The [`foreign`](http://www.rdocumentation.org/packages/foreign) package provides functions that help you load data files from other programs such as [SPSS](http://www.r-bloggers.com/how-to-open-an-spss-file-into-r/), [SAS](http://rconvert.com/sas-vs-r-code-compare/5-ways-to-convert-sas-data-to-r/), [Stata](http://www.r-bloggers.com/how-to-read-and-write-stata-data-dta-files-into-r/), and others into R.
