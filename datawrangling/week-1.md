---
layout: tutorial
title: Week 1 (October 9-15)
permalink: data_wrangling/week-1
---

Welcome to week 1. Although we will not meet in class until the end of this week (Saturday, October 15<sup>th</sup>), I do not want to waste time in getting started. We only have 7 weeks together (&#x1f622;) so I want to pack each week as full as possible. I am assuming you have fully read the [syllabus](syllabus) by now but if not please do so that you understand how this class is structured and what is expected of you.  I will spend the first few minutes of class on Saturday re-iterating the details so that we are all on the same page but I do not want to spend 30-60 minutes doing so, so make sure you read (and re-read) it thoroughly.

The focus of this week is to get yourself (re-)introduced to data wrangling, R, and the general workflow that makes for productive analyses.  Below outlines the tutorials that you need to review, additional resource available to you, and the assignment that is due at the beginning of Saturday's class. If you have any questions or concerns your first step should be going to our [slack channel](https://uc-data-wrangling.slack.com/) and posting your issue.  You and your classmates should be monitoring slack to help each other out. In addition, I will also be watching slack and will chime in when necessary but my hope is that this will be a social process where everyone contributes to knowledge advancement.

## Tutorials & Resources

Please work through the following tutorials prior to Saturday's class. The skills and functions introduced in these tutorials will be necessary to complete your assignment, which is due at the beginning of Saturday's class, and will also be used in Saturday's in-class small group work. 

### Introduction to the course, data wrangling, and R

- Read about the [Role of Data Wrangling](http://uc-r.github.io/why_wrangle)
- Work through the [R Basics tutorial](http://uc-r.github.io/section2_basics) to (re-)familiarize yourself with the basic functionality of R and RStudio


### Managing your workflow

- Work through the [R Projects tutorial](http://uc-r.github.io/r_projects)
- Work through the [R Markdown tutorial](http://uc-r.github.io/r_markdown)
- Not necessary but for those more ambitious folks, work through the [R Notebook](http://uc-r.github.io/r_notebook) tutorial. This will require you to install the [Preview Release](https://www.rstudio.com/products/rstudio/download/preview/) version of RStudio.


## Assignment

1. Create an R Project that will be your central project directory for this class. Title this R Project "Data Wrangling with R (BANA 8090)".
2. Create a .R script titled "week-1.R" and in this script perform the following exercises:
   - compute $$100(1 + \frac{0.05}{12})^{24}$$
   - what is the remainder when 3333 is divided by 222?
   - investigate the behavior of $$(1 + \frac{1}{n})^n$$ for large, integer values in *n*.
   - the Economic Order Quantity (EOQ) gives the optimal order quantity as $$Q = \sqrt{\frac{2DK}{h}}$$ where *D* is the annual demand, *K* is the fixed cost per order, and *h* is the annual holding cost per item. Create and set the variables $$D = 1000$$, $$K = 5$$, and $$h = 0.25$$ and compute the associated value of Q.
   - for an initial principal amount *P* and a nominal annual interest rate *r* that is compounded *n* times per year over a span of *t* years, the final value of a certificate of deposit is $$F = P(1 + \frac{r}{n})^{nt}$$. Create and set the variables $$P = 100$$, $$r = 0.08$$, $$n = 12$$, and $$t = 3$$ and compute the associated value of *F*.
3. Create an HTML R Markdown titled "week-1.Rmd" that includes two sections:
   - Section 1 will be an introduction of yourself that describes where you are from, your academic and professional background, your experience with R (or other coding languages), and what your plans are after you complete your UC masters degree. This section will serve as a way to introduce yourself to your small group peers.
   - In section 2 you will use code chunks to complete the exercises you performed in the .R script in your R markdown file.
   - You will find an example [here](http://rpubs.com/bradleyboehmke/datawrangling_week1_homework) of the basic output I am looking for but feel free to be creative and test out the many syntax features for R Markdown.
   

See you in class on Saturday!
