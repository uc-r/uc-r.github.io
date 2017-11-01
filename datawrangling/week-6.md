---
layout: tutorial
title: Week 6 (November 13 - 19)
permalink: data_wrangling/week-6
---

Don't repeat yourself (DRY) is a software development principle aimed at reducing repetition. Formulated by Andy Hunt and Dave Thomas in their book [The Pragmatic Programmer](http://www.amazon.com/Pragmatic-Programmer-Journeyman-Master/dp/020161622X/ref=sr_1_1?s=books&ie=UTF8&qid=1456066112&sr=1-1&keywords=the+pragmatic+programmer), the DRY principle states that "every piece of knowledge must have a single, unambiguous, authoritative representation within a system." This principle has been widely adopted to imply that you should not duplicate code. Although the principle was meant to be far grander than that[^footnote], there's plenty of merit behind this slight misinterpretation.

Removing duplication is an important part of writing efficient code and reducing potential errors. First, reduced duplication of code can improve computing time and reduces the amount of code writing required. Second, less duplication results in less creating and saving of unnecessary objects. Inefficient code invariably creates copies of objects you have little interest in other than to feed into some future line of code; this wrecks havoc on properly managing your objects as it basically results in a global environment charlie foxtrot! Less duplication also results in less editing. When changes to code are required, duplicated code becomes tedious to edit and invariably mistakes or fat-fingering occur in the cut-and-paste editing process which just lengthens the editing that much more.

Thus, minimizing duplication by writing efficient code is important to becoming a data analyst and this week we will focus on two methods to achieve this:

1. Writing functions
2. Using iteration

## Tutorials & Resources

Please work through the following tutorials prior to Saturday’s class. The skills and functions introduced in these tutorials will be necessary to complete your assignment, which is due at the beginning of Saturday’s class, and will also be used in Saturday’s in-class small group work.

**Strings & regex:** To understand the fundamentals of working with strings and regex data read and work through [*Chapter 14: Strings*](http://r4ds.had.co.nz/strings.html).  If your final project is going to require you to work with lots of messy character string data you can get more practice by working through the [*Dealing with Characters* tutorial](http://uc-r.github.io/characters) and [*Dealing with Regular Expressions*](http://uc-r.github.io/regex) tutorials.

**Factors:**  Historically, factors were much easier to work with than characters. As a result, many of the functions in base R automatically convert characters to factors. This means that factors often crop up in places where they’re not actually helpful and you need to understand how to manipulate and work with them. Read and work through *[Chapter 15: Factors](http://r4ds.had.co.nz/factors.html)*. 

**Dates:**  Real world data are often associated with dates and time; however, dealing with dates accurately can appear to be a complicated task due to the variety in formats and accounting for time-zone differences and leap years. Read and work through [*Chapter 16: Dates and times*](http://r4ds.had.co.nz/dates-and-times.html) to learn how to manage date-time data.



## Homework

Your homework this week is to provide a proposal for your final project.  Create an HTML R markdown document titled "Project Proposal" and be sure to include your name in the YAML.  In this proposal I would like you to provide the following information:

__1. Data Description:__ Provide a thorough description of your data set.  This goes back to [week 3's](http://uc-r.github.io/data_wrangling/week-3) discussion about the data code book.  You need to explain what the original purpose of the data set is, what the variables are measuring, the data type and values that each variable is coded as (including how missing values are coded), and the range of values for each variable.  Be sure to hyperlink to the actual code book and source data.  Also, when describing your variables, please summarize this information as concisely as possible.  For example, if one of your variables is *Year*, summarize this variable by telling me that the *Year* variable is recorded as integer values that range from 1950-2016 and are measured annually.  Do not just use `unique(data$year)` to spit out the 50 unique year values in the data.  You want to write this in a report style but show your code.

__2. Import Your Data:__ Import your data set directly from the online source.  This means you cannot download the data onto your computer and then import it into R.  I want to be able to run the exact same line of code that you write and be able to import your data set. Store your data as a tibble and provide a preview of what the raw data looks like.

__3. Data Cleaning:__ You can start to clean your data to get in a tidy format as described in [week 5](http://uc-r.github.io/data_wrangling/week-5); however, I do not expect you to have your data completely cleaned.  If you do not clean your data, provide a discussion of what is required to get your data into a clean and tidy format and how you plan to accomplish this task.

__4. Planned Analysis:__ In this section I do not expect you to perform any coding or analysis yet.  However, I want you to propose 3-4 different ways you plan to analyse your data and the unique insights you hope to garner from this analysis.

Knit this R Markdown document to an HTML file, publish it on RPubs, and send me the URL for your published report prior to class (either by email or through Slack messenger).
