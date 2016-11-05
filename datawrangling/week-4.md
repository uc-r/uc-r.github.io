---
layout: tutorial
title: Week 4 (October 30 - November 5)
permalink: data_wrangling/week-4
---

Last week we discussed general guidelines for first interacting with a new data set. This week we want to build on those activities by performing early exploratory data analysis to answer questions about your data via transforming and visualizing your data. We have two objectives for this week:

1. Early in the data wrangling process you will likely need to sort, filter, or summarize your data set or even create new variables from the existing data. You will learn how to work with the `dplyr` package to perform many common data transformation and manipulation tasks.
2. Visualization should be used in explicit ways to answer questions regarding your data. You will learn how to build on your ggplot visualization skills to systematically analyze your data.

Combining the activities of data transformation and visualization in a methodical way is what defines *exploratory data analysis*. Only by systematically applying these techniques will you be able to answer and refine questions about your data.

## Tutorials & Resources

Please work through the following tutorials prior to Saturday’s class. The skills and functions introduced in these tutorials will be necessary to complete your assignment, which is due at the beginning of Saturday’s class, and will also be used in Saturday’s in-class small group work.

__1. Transform your data:__ Although many fundamental data manipulation functions exist in R, they have been a bit convoluted to date and have lacked consistent coding and the ability to easily flow together. `dplyr` is one such package which was built for the sole purpose of simplifying the process of manipulating, sorting, summarizing, and joining data frames.  Read and work through: 

 - [*Chapter 5: Data Transformation*](http://r4ds.had.co.nz/transform.html) of the [*R for Data Science*](http://r4ds.had.co.nz/) book. 
 - Jenny Bryan's [Introduction to dplyr](http://stat545.com/block009_dplyr-intro.html) and [`dplyr` functions for a single dataset](http://stat545.com/block010_dplyr-end-single-table.html) tutorials.

__2. Advancing your visualizations:__ Visualizing and transforming your data in a systematic way is a task that statisticians call exploratory data analysis. Combining the functionality of `dplyr` with the visualization capabilites of `dplyr` can help to answer a lot of initial questions about your data. Read and work through [*Chapter 7: Exploratory Data Analysis*](http://r4ds.had.co.nz/exploratory-data-analysis.html) of the [*R for Data Science*](http://r4ds.had.co.nz/) book to learn to use `dplyr` and `ggplot2` interactively to ask questions, answer them with data, and then ask new questions.


## Assignment

Create an HTML R Markdown document named “week-4.Rmd”.  Title this HTML document *"Gapminder Exploratory Data Analysis."* If you have not already done so, install the gapminder package (`install.packages("gapminder")`. Using the `gapminder_unfiltered` data answer the questions below. Be sure that your report includes the following sections:

- __Synopsis:__ Include a short paragraph that summarizes what the point of this R Markdown file is and a short summary of your initial findings.
- __Packages Required:__ Include a code chunk in this section that loads all the packages required for this homework and a short comment that says what purpose each package provides.
- __Source Code:__ Describe what each of the variables are measuring in this data set (`?gapminder`).
- __Data Description:__ Provide an explanation of the data set that includes the number of observations and variables, if any missing values exist, and provide some basic summary statistics such as what continents are included, how many countries are included, and what years are measured.
- __Exploratory Data Analysis:__ In this section answer the following questions using a combination of data transformation and visualization techniques:
   1. For the year 2007, what is the distribution of GDP per capita across all countries?
   2. For the year 2007, how do the distributions differ across the different continents?
   3. For the year 2007, what are the top 10 countries with the largest GDP per capita?
   4. Plot the GDP per capita for your country of origin for all years available. 
   5. What was the percent growth (or decline) in GDP per capita in 2007?
   6. What has been the historical growth (or decline) in GDP per capita for your country?

Knit this R Markdown document to an HTML file, publish it on [RPubs](https://rpubs.com/about/getting-started), and send me the URL for your published report prior to class (either by email or through Slack messenger).  

## Class

In today's lecture we are going to work through several exploratory data analysis exercises. Feel free to download these .R scripts to reference the functionality and capabilities of dplyr and ggplot2: &nbsp; <a href="https://www.dropbox.com/sh/l0wjulpnkyb60du/AADlUpVx46KAJmcaYntiNorWa?dl=1" style="color:black;"><i class="fa fa-cloud-download" style="font-size:1em"></i></a>
