---
layout: page
title: Visual Data Exploration
permalink: /gda
---

Data visualization is a critical tool in the data analysis process.  Visualization tasks can range from generating fundamental distribution plots to understanding the interplay of complex influential variables in machine learning algorithms.  In this tutotial we focus on the use of visualization for initial *data exploration*. 

Visual data exploration is a mandatory intial step whether or not more formal analysis follows.  When combined with [descriptive statistics](descriptive), visualization provides an effective way to identify summaries, structure, relationships, differences, and abnormalities in the data.  Often times no elaborate analysis is necessary as all the important conclusions required for a decision are evident from simple visual examination of the data.  Other times, data exploration will be used to help guide the data cleaning, feature selection, and sampling process.  

Regardless, visual data exploration is about investigating the characteristics of your data set.  To do this, we typically create numerous plots in an interactive fashion.  This tutorial will show you how to create plots that answer some of the fundamental questions we typically have of our data.  

<br>

## tl;dr
Don't have the time to scroll through the full tutorial?  Skip directly to the section of interest:

- [Replication requirements](#replication)
- [Univariate continuous visualizations](#continuous)
- [Univariate categorical visualizations](#categorical)
- [Visualizing bi-variate relationships & associations](#bivariate)
- [Visualizing multivariate relationships & associations](#multivariate)
- [Visualizing data quality](#quality)

<br>

## Prerequisites {#replication}

We’ll illustrate the key ideas by primarily focusing on data from the `AmesHousing` package.  We'll use `tidyverse` to provide some basic data manipulation capabilities along with `ggplot2` for plotting.  We also demonstrate some useful functions from a few other packages throughout the chapter.


```r
library(tidyverse)
library(caret)
library(GGally)
library(treemap)
```


```r
ames <- AmesHousing::make_ames()
```
<br>

## Univariate Distributions

Before moving on to more sophisticated visualizations that enable multidimensional investigation, it is important to be able to understand how an individual variable is distributed.  Visually understanding the distribution allows us to describe many features of a variable.

### Continuous Variables {#continuous}

A variable is continuous if it can take any of an infinite set of ordered values. There are several different plots that can effectively communicate the different features of continuous variables.  Features we are generally interested in include:

- Measures of location
- Measures of spread
- Asymmetry
- Outliers
- Gaps


[Histograms](histograms) are often overlooked, yet they are a very efficient means for communicating these features of continuous variables. Formulated by Karl Pearson, histograms display numeric values on the x-axis where the continuous variable is broken into intervals (aka bins) and the the y-axis represents the frequency of observations that fall into that bin. Histograms quickly signal what the most common observations are for the variable being assessed (the higher the bar the more frequent those values are observed in the data); they also signal the shape (spread and symmetry) of your data by illustrating if the observed values cluster towards one end or the other of the distribution.

To get a quick sense of how sales prices are distributed across the 2,930 properties in the `ames` data we can generate a simple histogram by applying ggplot’s `geom_histogram` function[^baseRhist]. This histogram tells us several important features about our variable:

- Measures of location: We can see the most common `Sale_Price` is around the low $100K.
- Measures of spread: Our `Sale_Price` ranges from near zero to over $700K.
- Asymmetry: `Sale_Price` is skewed right (a common issue with financial data).  Depending on the analytic technique we may want to apply later on this suggests we will likely need to transform this variable.
- Outliers: It appears that there are some large values far from the other `Sale_Price` values.  Whether these are outliers in the mathematical sense or outliers to be concerned about is another issue but for now we at least know they exist.
- Gaps: We see a gap exists between `Sale_Price` values around $650K and $700K+.  


```r
ggplot(ames, aes(Sale_Price)) +
  geom_histogram()
```

<img src="/public/images/visual/graphical_data_analysis/hist1-1.png" style="display: block; margin: auto;" />





