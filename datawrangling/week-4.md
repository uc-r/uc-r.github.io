---
layout: tutorial
title: Week 4 (March 31 - April 6)
permalink: data_wrangling/week-4
---

This week builds onto our data wrangling skills by focusing on transforming and joining data. Common transformation procedures include filtering observations by their values, reordering the rows, selecting variables, creating new variables with functions of existing variables, and collapsing values down to single summary summary statistics (i.e. mean, max, variance). 

Furthermore, it’s rare that a data analysis involves only a single table of data. Typically you have many tables of data, and you must combine them to answer the questions that you’re interested in. Collectively, multiple tables of data are called _relational_ data because it is the relations, not just the individual datasets, that are important.

This module covers these basic capabilities by teaching you how to use the `dplyr` package to perform common data transformation and joining tasks.


<hr>

## 1. Data Transformation with dplyr
Although many fundamental data manipulation functions exist in R, they have been a bit convoluted to date and have lacked consistent coding and the ability to easily flow together. dplyr is one such package which was built for the sole purpose of simplifying the process of manipulating, sorting, summarizing, and joining data frames. 

- Read and work through [Chapter 5: Data Transformation](http://r4ds.had.co.nz/transform.html) in R for Data Science.
- Now that you've learned the basics, complete the [Data Manipulation in R with dplyr](https://www.datacamp.com/enterprise/data-wrangling-3778d473-69e7-4941-97df-1bec3ca5ed7c/assignments/46410) DataCamp assignment to hone your skills.

<hr>

## 2. Joining relational data
It’s rare that a data analysis involves only a single data set. Typically you have many sets of data and you need to join them to perform your analysis and answer the questions that you’re interested in. This module will teach you to work with relational data sets.

- Read and work through [Chapter 13: Relational Data](http://r4ds.had.co.nz/relational-data.html) in R for Data Science.
- Now that you've learned the basics, complete the [Joining Data in R with dplyr](https://www.datacamp.com/enterprise/data-wrangling-3778d473-69e7-4941-97df-1bec3ca5ed7c/assignments/46411) DataCamp assignment to hone your skills.

   
<hr>   

## Class

Please download this material for Saturday's class: &nbsp; <a href="https://www.dropbox.com/sh/3ug411fje7g0iuf/AAA9zuyJQTMwTShxeW_ZZkvTa?dl=1" style="color:black;"><i class="fa fa-cloud-download" style="font-size:1em"></i></a>

In addition, be sure to have identified which data you are going to use for your final project.  Be sure to have access to this data because you will work on it during class.  Furthermore, identify at least 10 specific questions you want to ask of your project data. Using what you learned this week, what type of data transformations do you need to make to help answer these questions? Be ready to use dplyr to answer these questions in class.

See you in class on Saturday!

<hr>

## Mid-term Project Due!

Your mid-term project is due by the end of class this week.  Be sure to refer to the [grading rubric](mid-term) so you understand what is expected.  Create an HTML R markdown document titled "Project Proposal" and be sure to include your name in the YAML.
