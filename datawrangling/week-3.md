---
layout: tutorial
title: Week 3 (October 23-29)
permalink: data_wrangling/week-3
---

So last week we started to import data. However, data by themselves are pretty useless so we need to start doing some basic care and feeding of the data we've imported. This week we investigate good practices for when we get a new data set. Spending a little time up front to understand your data will help speed up your analysis later on. Thus, this week we are going to focus on three objectives that we should have when we first open up a new data set:

1. Review the codebook
2. Learn about the data
3. Visualize the data

## Tutorials & Resources

Please work through the following tutorials prior to Saturday’s class. The skills and functions introduced in these tutorials will be necessary to complete your assignment, which is due at the beginning of Saturday’s class, and will also be used in Saturday’s in-class small group work.

__1. Review the codebook:__ Understanding the source data is crucial to any analysis. A codebook is the documentation that explicitly tells you about the data you are working with and should be the first thing you review before starting any kind of analysis. Read [*Review the Codebook*](codebook) to get a taste of what to look for.

__2. Learn about the data:__ When first opening a data set it is important to get a basic understanding of the data dimensions (rows and columns), what the data looks like, how many missing values are in the data, and some basic summary statistis such as mean, median, and the range of each variable. Read and work through [*Learn About the Data*](about_the_data) to understand some of the first things you should do with a fresh data set.

__3. Visualize the data:__ Although visualizing your data is not always considered a data wrangling activity, it is essential in every step of data analysis. In this class we are going to focus on `ggplot2` for visualizing our data, as it is the premier data visualizing package in R. Read and work through [*Chapter 3: Data Visualization*](http://r4ds.had.co.nz/data-visualisation.html) of the [*R for Data Science*](http://r4ds.had.co.nz/) book.


## Assignment

Create an HTML R Markdown document titled “week-3.Rmd”. I want you to scrape the Cincinnati weather data located [here](http://academic.udayton.edu/kissock/http/Weather/gsod95-current/OHCINCIN.txt) and provide the following sections in the R Markdown document:

- __Synopsis:__ Include a short paragraph that summarizes what the point of this R Markdown file is and a short summary of your initial findings.
- __Packages Required:__ Include a code chunk in this section that loads all the packages required for this homework and a short comment that says what purpose each package provides.
- __Source Code:__  Describe what each of the variables are measuring in this data set. You will find a link to the codebook on this web page: [http://academic.udayton.edu/kissock/http/Weather/](http://academic.udayton.edu/kissock/http/Weather/).
- __Data Description:__ Provide an explanation of the data set that includes the number of observations and variables, if any missing values exist, and provide some basic summary statistics such as mean, median, min and max values.
- __Data Visualization:__ Create three different visualizations of this data set. Provide an explanation of the information that the visualization is providing.

Knit this R Markdown document to an HTML file, publish it on [RPubs](https://rpubs.com/about/getting-started), and send me the URL for your published report prior to class (either by email or through Slack messenger).  

