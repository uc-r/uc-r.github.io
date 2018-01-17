---
layout: page
title: Graphical Data Analysis
permalink: /gda
---

Data visualization is a critical tool in the data analysis process.  Visualization tasks can range from generating fundamental distribution plots to understanding the interplay of complex influential variables in machine learning algorithms.  In this chapter we focus on the use of visualization for initial *data exploration*. 

Visual data exploration is a mandatory intial step whether or not more formal analysis follows.  When combined with descriptive statistics (Chapter~\ref{ch2:descriptive}), visualization provides an effective way to identify summaries, structure, relationships, differences, and abnormalities in the data.  Often times no elaborate analysis is necessary as all the important conclusions required for a decision are evident from simple visual examination of the data **(REF: Box and Hunter)**.  Other times, data exploration will be used to help guide the data cleaning, feature selection, and sampling process.  

Regardless, visual data exploration is about investigating the characteristics of your data set.  To do this, we typically create numerous plots in an interactive fashion.  This chapter will show you how to create plots that answer some of the fundamental questions we typically have of our data.  


# Prerequisites

In this chapter we’ll illustrate the key ideas by primarily focusing on data from the `AmesHousing` package.  We'll use `tidyverse` to provide some basic data manipulation capabilities along with `ggplot2` for plotting.  We also demonstrate some useful functions from a few other packages throughout the chapter.


```r
library(tidyverse)
library(caret)
library(GGally)
library(treemap)
```


```r
ames <- AmesHousing::make_ames()
```
