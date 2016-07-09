---
layout: tutorial
title: Exporting Data
permalink: /export
---

Although getting data into R is essential, getting data out of R can be just as important. Whether you need to export data or analytic results simply to store, share, or feed into another system it is generally a straight forward process. This section will cover how to export data to [text files](#export_txt), [Excel files](#export_excel) (along with some additional formatting capabilities), and [save to R data objects](#save_object). In addition to the the commonly used base R functions to perform data importing, I will also cover functions from the popular `readr` and `xlsx` packages along with a lesser known but useful `r2excel` package for Excel formatting.
