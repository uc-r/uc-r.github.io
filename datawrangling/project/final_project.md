---
layout: tutorial
title: Final Project
permalink: /data_wrangling/final-project
---


### Purpose

The purpose of this final project is to put to work the tools and knowledge that you gain throughout this course. This provides you with multiple benefits. 

1. It will provide you with more experience using data wrangling tools on real life data sets. 
2. It helps you become a self-directed learner. As a data scientist, a large part of your job is to self-direct your learning and interests to find unique and creative ways to find insights in data.
3. It starts to build your data science portfolio. Establishing a data science portfolio is a great way to show potential employers your ability to work with data.

The course is structured in a way that allows you to work on your project as you progress through the weeks. Thus, you *should* not have to cram during the last two weeks of the term to complete your project. Rather, I plan to have you work on the project and use some of the in-class time to do peer evaluation of your code.


### Project Goal

The principal goal of this project is to import a real life data set, clean and tidy the data, and perform basic exploratory data analysis; all while using R Markdown to produce an HTML report that is fully reproducible. 

### Project Data

You will need to select one data set from the three that I have supplied below.  All three data sets contain key attributes that will demonstrate the data science capabilities that you have learned throughout this couse.  You may even need to learn new skills not taught to accomplish your mission.  These include working with:

- multiple data types (numerics, characters, dates, etc)
- non-normalized characteristics (may contain punctuations, upper and lowercase letters, etc)
- data sets that need to be merged
- unclean data (missing values, values that do not align to the data dictionary)
- variables that need to be created (i.e. the data may contain income and expense variables but you want to analyze savings such that you need to create a savings variable out of the income and expense variables)
- data that needs to be filtered out
- and much more!

Available data sets include:

You can choose from one of the following data sets.  All three represent customer transactions for a major retailer.

- [Carbo-loading data](https://www.dropbox.com/sh/591v3xk6xn799vn/AADy_n-qROUJWBSPEtP-PSqSa?dl=1)
- [Complete Journey customer transactions (without marketing campaigns)](https://www.dropbox.com/sh/xzat5mcqy9dt791/AAC8w9Ep0IWpaNze0XHY258Xa?dl=1)
- [Complete Journey customer transactions (with marketing campaigns)](https://www.dropbox.com/sh/7g8npy9k51dhtjm/AACOwFfvFSjw26fWNDZmaSS1a?dl=1)

### Project Report

You will write an [R Markdown](http://wfu-r.github.io/r_markdown) HTML report that provides the sections in the grading rubric below.  You will need to import, assess, clean & tidy the data, and then come up with your own research questions that you would like to answer from the data by performing exploratory data analysis (if you'd like to perform a predictive model to answer your hypothesis that is fine but it is not required.  Some questions you may want to ask include: 

- Do specific marketing campaigns influence customer purchasing behavior? 
- Have certain products experienced an increase or decrease in consumption over time?  
- Do certain products seem to be purchased together more often than others (complimentary products)?  
- Can we predict how much a customer is going to spend based on their attributes?

Although each data sets data dictionary contains some additiona questions worth pursuing, try to be creative in your analysis and investigate the data in a way that your classmates most likely will not.  Creativity is an essential ingredient for a good data scientist!

<div id="final-project-rubric" class="section level1" style="width: 120%;">
<table style="font-size:13px;">
<col width="15%">
<col width="77%">
<col width="8%">
<thead>
<tr class="header">
<th align="left">Section</th>
<th align="center">Standard</th>
<th align="center">Possible Points</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left" valign="top">Introduction </td>
<td align="left" valign="top">
  <b>1.1</b> Provide an introduction that explains the problem statement you are addressing. Why should I be interested in this? <br> 
  <b>1.2</b> Provide a short explanation of how you plan to address this problem statement (the data used and the methodology employed) <br> 
  <b>1.3</b> Discuss your current proposed approach/analytic technique you think will address (fully or partially) this problem. <br> 
  <b>1.4</b> Explain how your analysis will help the consumer of your analysis. 
</td>
<td align="center" valign="top"> 5 </td>
</tr>
<tr class="even">
<td align="left" valign="top">Packages Required </td>
<td align="left" valign="top"> 
  <b>2.1</b> All packages used are loaded upfront so the reader knows which are required to replicate the analysis. <br> 
  <b>2.2</b> Messages and warnings resulting from loading the package are suppressed. <br> 
  <b>2.3</b> Explanation is provided regarding the purpose of each package (there are over 10,000 packages, don't assume that I know why you loaded each package). 
</td>
<td align="center" valign="top"> 5 </td>
</tr>
<tr class="odd">
<td align="left" valign="top">Data Preparation </td>
<td align="left" valign="top"> 
  <b>3.1</b> Original source where the data was obtained is cited and, if possible, hyperlinked. <br> 
  <b>3.2</b> Source data is thoroughly explained (i.e. what was the original purpose of the data, when was it collected, how many variables did the original have, explain any peculiarities of the source data such as how missing values are recorded, or how data was imputed, etc.). <br> 
  <b>3.3</b> Data importing and cleaning steps are explained in the text (tell me why you are doing the data cleaning activities that you perform) and follow a logical process. <br>
  <b>3.4</b> Once your data is clean, show what the final data set looks like.  However, do not print off a data frame with 200+ rows; show me the data in the most condensed form possible. <br>
  <b>3.5</b> Provide summary information about the variables of concern in your cleaned data set. Do not just print off a bunch of code chunks with <code>str()</code>, <code>summary()</code>, etc.  Rather, provide me with a consolidated explanation, either with a table that provides summary info for each variable or a nicely written summary paragraph with inline code.
</td>
<td align="center" valign="top"> 10 </td>
</tr>
<tr class="even">
<td align="left" valign="top">Exploratory Data Analysis </td>
<td align="left" valign="top"> 
  <b>4.1</b> Uncover new information in the data that is not self-evident (i.e. do not just plot the data as it is; rather, slice and dice the data in different ways, create new variables, or join separate data frames to create new summary information). <br>
  <b>4.2</b> Provide findings in the form of plots and tables. Show me you can display findings in different ways. <br>
  <b>4.3</b> Graph(s) are carefully tuned for desired purpose. One graph illustrates one primary point and is appropriately formatted (plot and axis titles, legend if necessary, scales are appropriate, appropriate geoms used, etc.). <br>
  <b>4.4</b> Table(s) carefully constructed to make it easy to perform important comparisons. Careful styling highlights important features. Size of table is appropriate. <br>
  <b>4.5</b> Insights obtained from the analysis are thoroughly, yet succinctly, explained.  Easy to see and understand the interesting findinsg that you uncovered. <br>
</td>
<td align="center" valign="top"> 10 </td>
</tr>
<tr class="even">
<td align="left" valign="top">Summary </td>
<td align="left" valign="top">
  <b>6.1</b> Summarize the problem statement you addressed. <br>
  <b>6.2</b> Summarize how you addressed this problem statement (the data used and the methodology employed). <br>
  <b>6.3</b> Summarize the interesting insights that your analysis provided. <br>
  <b>6.4</b> Summarize the implications to the consumer of your analysis. <br>
  <b>6.5</b> Discuss the limitations of your analysis and how you, or someone else, could improve or build on it.
</td>
<td align="center" valign="top"> 5 </td>
</tr>
<tr class="odd">
<td align="left" valign="top">Formatting & Other Requirements </td>
<td align="left" valign="top"> 
  <b>7.1</b> Proper coding style is followed and code is well commented (see section regarding <a href="http://uc-r.github.io/basics#style">style</a>). <br>
  <b>7.2</b> Coding is systematic - complicated problem broken down into sub-problems that are individually much simpler. Code is efficient, correct, and minimal. Code uses appropriate data structure (list, data frame, vector/matrix/array). Code checks for common errors. <br>
  <b>7.3</b> Achievement, mastery, cleverness, creativity:  Tools and techniques from the course are applied very competently and, perhaps,somewhat creatively. Perhaps student has gone beyond what was expected and required, e.g., extraordinary effort, additional tools not addressed by this course, unusually sophisticated application of tools from course. <br>
  <b>7.4</b> .Rmd fully executes without any errors and HTML produced matches the HTML report submitted by student.
</td>
<td align="center" valign="top"> 15 </td>
</tr>
</tbody>
</table>
<p>
  <em>Total possible points: 50</em> 
  <br>
  <em>Due no later than: Sunday, April 28, 2019, 11:59PM ET</em>
</p>
</div>

I expect your report to tell a story with the data. I do not want you to just report some statistics that you find but, rather, to provide a coherent narrative of your findings. Here are some examples of the type of report that I am looking for: 

- [State-level savings rates](https://rpubs.com/bradleyboehmke/final_project_example)
- [Undergraduate student diversity](http://rpubs.com/murphm6/233993)
- [AirBnB sentiment](http://rpubs.com/ishantnayer/234221)
- [Capital punishment in America](http://rpubs.com/hailce17/301571)
- [Ideal cities and states for analytic students](http://rpubs.com/dyang9411/301598)
- [Movie exploratory analysis](http://rpubs.com/yash91sharma/dw_project_ys)
- [AirBnB user pathways](http://rpubs.com/angiechen/234334)

Upon submission you will upload the final HTML report to RPubs and provide me with the URL. You will also submit the .Rmd file that produced the HTML report, your data, and any other files your .Rmd file leverages (images, .bib file, etc.). Your submitted files should be named with year, course number, lastname, first & middle initial, and then “finalproject.” For example my file name would be: 2018_BANA8090 _boehmkebc_finalproject.Rmd.  I expect to be able to fully reproduce your report by knitting your .Rmd file.


**Optional:**  For those who are more advanced or daring, I challenge you to develop a [Shiny app](http://shiny.rstudio.com/) using [flexdashboard](http://rmarkdown.rstudio.com/flexdashboard/) to accompany your report. This will turn your exploratory data analysis into an interactive tool for users.  Here are some examples:

- [U.S. Savings Rates](https://bradleyboehmke.shinyapps.io/us_savings_rate_app/)
- [International Logistics Performance Index](https://bradleyboehmke.shinyapps.io/LPI_Rankings/)
- [Craft Beer in the U.S.](http://rpubs.com/steffanigomez/301609)
- [Co2 Emmissions](http://rpubs.com/AlinaC/final_project)
- [McDonald's Nutrition Facts](https://zhanb17.shinyapps.io/mcdonaldsnutrition/)


Any additional details regarding the final project will be provided in class.
