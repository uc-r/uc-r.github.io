---
layout: tutorial
title: Week 7 (November 27 - December 3)
permalink: data_wrangling/week-7
---

Don't repeat yourself (DRY) is a software development principle aimed at reducing repetition. Formulated by Andy Hunt and Dave Thomas in their book [The Pragmatic Programmer](http://www.amazon.com/Pragmatic-Programmer-Journeyman-Master/dp/020161622X/ref=sr_1_1?s=books&ie=UTF8&qid=1456066112&sr=1-1&keywords=the+pragmatic+programmer), the DRY principle states that "every piece of knowledge must have a single, unambiguous, authoritative representation within a system." This principle has been widely adopted to imply that you should not duplicate code. Although the principle was meant to be far grander than that[^footnote], there's plenty of merit behind this slight misinterpretation.

Removing duplication is an important part of writing efficient code and reducing potential errors. First, reduced duplication of code can improve computing time and reduces the amount of code writing required. Second, less duplication results in less creating and saving of unnecessary objects. Inefficient code invariably creates copies of objects you have little interest in other than to feed into some future line of code; this wrecks havoc on properly managing your objects as it basically results in a global environment charlie foxtrot! Less duplication also results in less editing. When changes to code are required, duplicated code becomes tedious to edit and invariably mistakes or fat-fingering occur in the cut-and-paste editing process which just lengthens the editing that much more.

Thus, minimizing duplication by writing efficient code is important to becoming a data analyst and this week we will focus on two methods to achieve this:

1. Writing functions
2. Using iteration


## Tutorials & Resources

Please work through the following tutorials prior to Saturday’s class. The skills and functions introduced in these tutorials will be necessary to complete your assignment, which is due at the beginning of Saturday’s class, and will also be used in Saturday’s in-class small group work.

**Writing functions:** Functions allow you to reduce code duplication by automating a generalized task to be applied recursively. Whenever you catch yourself repeating a function or copy-and-pasteing code there is a good chance that you should write a function to eliminate the redundancies. Read [Chapter 19: Functions](http://r4ds.had.co.nz/functions.html) to get started with functions.

**Iteration:**  Another tool for reducing duplication is <u>iteration</u>, which helps you when you need to do the same thing to multiple inputs: repeating the same operation on different columns, or on different datasets. Read [Chapter 21: Iteration](http://r4ds.had.co.nz/iteration.html) to learn how to perform iteration programming.

## Homework

For the exercises that follow use this [NYC Restaurant data](https://nycopendata.socrata.com/Health/DOHMH-New-York-City-Restaurant-Inspection-Results/xx67-kt59).  Note that this is a SOPA API so `read.socrata` will come in handy to dowload this data. This is a large data set so allow several minutes to download.  Also, we will explore this data in class so you probably want to save it to your computer in an RDS format (hint: `readr::write_rds`).

1. Use the `map` function to identify the class of each variable.
2. Notice how the date variables are in POSIXlt form. Create a function that takes a single argument ("x") and checks if it is of POSIXlt class.  If it is, have the function change the input to a simple Date class with `as.Date`. If not then, the function should keep the input class as is. Apply this function to each of the columns in the NY restaurant data set by using the `map` function. Be sure the final output is a tibble and not a list.
3. Using this reformatted tibble, identify how many restaurants in 2016 had a violation regarding "mice"? How about "hair"? What about "sewage"? Hint: the VIOLATION.DESCRIPTION and INSPECTION.DATE variables will be useful here.
4. Create a function to apply to this tibble that takes a year and a regular expression (i.e. "mice") and returns a ggplot bar chart of the top 20 restaurants with the most violations. Make sure the restaurants are properly rank-ordered in the bar chart



<br>




[^footnote]: According to [Dave Thomas](http://www.artima.com/intv/dry.html), "DRY says that every piece of system knowledge should have one authoritative, unambiguous representation. Every piece of knowledge in the development of something should have a single representation. A system's knowledge is far broader than just its code. It refers to database schemas, test plans, the build system, even documentation."
