---
layout: page
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

The principal goal of this project is to import an existing data set on the web, clean and tidy the data, and perform basic exploratory data analysis; all while using R Markdown to produce an HTML report that is fully reproducible. 

### Project Data

You will need to identify a data set that is freely available online. I have supplied several options below; however, you are free to choose a data set outside of these.  You will need to get your data set approved by me by the 4th week of class. Considering this is a data wrangling class I do expect your data set to have certain qualities so that your analysis illustrates your knowledge of data wrangling.  The following are some data attributes that I will look for (but your data does not need to contain *all* of these attributes, just some):

- multiple data types (numerics, characters, dates, etc)
- non-normalized characteristics (may contain punctuations, upper and lowercase letters, etc)
- variables that need to be separated or joined
- two or more data sets that need to be merged
- wide or long format where you need to re-shape the data
- variables that need to be created (i.e. the data may contain income and expense variables but you want to analyze savings such that you need to create a savings variable out of the income and expense variables)
- data needs to be filtered out

Potential data sets include:

- [GDP by industry](http://www.bea.gov/iTable/iTable.cfm?ReqID=51&step=1#reqid=51&step=51&isuri=1&5114=q&5102=1)
- [Direct investments by country and industry](http://www.bea.gov/iTable/iTable.cfm?ReqID=2&step=1#reqid=2&step=10&isuri=1&202=1&203=30&204=1&205=1&200=1&201=1&207=30,31,32,33,34,35,36,37,38,39,40,41,42,43,48,49,52&208=1&209=1)
- [American Community Survey data sets](https://www.census.gov/acs/www/data/data-tables-and-tools/data-profiles/2014/)
- [Bureau of Labor Statistics data sets](http://www.bls.gov/data/)
- [Cincinnati police crime incident data](https://data.cincinnati-oh.gov/Safer-Streets/Police-Crime-Incident-Data/w7vh-beui)
- [City of Cincinnati vendor payments](https://data.cincinnati-oh.gov/Growing-Economy/City-of-Cincinnati-Vendor-Payments/qrj9-83t8)
- [City of Cincinnati salary schedule](https://data.cincinnati-oh.gov/Innovative-Government/City-of-Cincinnati-Salary-Schedule/yaws-h72m)

However, an important requirement is that you will need to import/scrape the data directly from web or through an API connection with R rather than downloading the data as .csv or .xlsx file on your local hard drive and then importing the data. 

### Project Report

You will write an [R Markdown](http://uc-r.github.io/r_markdown) HTML report that provides the following sections:

- **Synopsis**: Provide an abstract of your project. Introduce what your analysis is meant to accomplish and summarize the findings your uncovered.
- **Packages Required**: State the packages you use to perform your analysis and what the general purpose of each package is.
- **Data Preparation**: Explain where your raw data was obtained from (and be sure to hyperlink to this data source) and the process you used to import and clean your data. Be sure to show your clean and tidy data set at the end of this section. 
- **Exploratory Data Analysis**: I do not expect you to do any sophisticated analytic techniques; rather, I want you to explore the data set you obtained and try to uncover some interesting insights.  I expect you to report some basic summary statistics of the data sliced and diced in different ways along with reporting findings with plots *and* tables.
- **Summary**: Provide a concluding paragraph that summarizes your findings.

I expect your report to tell a story with the data. I do not want you to just report some statistics that you find but, rather, to provide a coherent narrative of your findings. An example of the type of report that I am looking for can be seen [here](https://rpubs.com/bradleyboehmke/final_project_example).  When you turn in your report I will require two things:

1. The HTML file that you will produce when you knit your R Markdown report
2. The .Rmd file you write your report in. I expect the .Rmd file to be executable on its own; thus I should be able to take your .Rmd file (without any required files such as a .csv data file) and run it on my computer and produce the exact same results that you produced in your HTML report.

Any additional details regarding the final project will be provided in class.


