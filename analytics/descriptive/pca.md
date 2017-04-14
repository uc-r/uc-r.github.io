---
layout: tutorial
title: Principal Components Analysis
permalink: /pca
---


<img src="/public/images/analytics/pca/unnamed-chunk-8-1.png"  style="float:right; margin: 2px 0px 0px 10px; width: 50%; height: 50%;" />

Principal Component Analysis (PCA) involves the process by which principal components are computed, and their role in understanding the data. PCA is an unsupervised approach, which means that it is performed on a set of variables $$X_1$$, $$X_2$$, ..., $$X_p$$ with no associated response $$Y$$. PCA reduces the dimensionality of the data set, allowing most of the variability to be explained using fewer variables.  PCA is commonly used as one step in a series of analyses. You can use PCA to reduce the number of variables and avoid multicollinearity, or when you have too many predictors relative to the number of observations.

## tl;dr

This tutorial serves as an introduction to Principal Component Analysis (PCA).[^islr]

1. [Replication Requirements](#replication): What you'll need to reproduce the analysis in this tutorial
2. [Preparing Our Data](#preparing): Cleaning up the data set to make it easy to work with
3. [What are Principal Components?](#what): Understanding and computing Principal Components for $$X_1, X_2, \dots, X_p$$
4. [Selecting the Number of Principal Components](#selecting): Using Proportion of Variance Explained (PVE) to decide how many principal components to use
5. [Built-in PCA Functions](#built): Using built-in R functions to perform PCA
6. [Other Uses for Principal Components](#other): Application of PCA to other statistical techniques such as regression, classification, and clustering

## Replication Requirements {#replication}

This tutorial primarily leverages the `USArrests` data set that is built into R. This is a set that contains four variables that represent the number of arrests per 100,000 residents for *Assault*, *Murder*, and *Rape* in each of the fifty US states in 1973. The data set also contains the percentage of the population living in urban areas, *UrbanPop*. In addition to loading the set, we'll also use a few packages that provide added functionality in graphical displays and data manipulation. We use the `head` command to examine the first few rows of the data set to ensure proper upload.


```r
library(tidyverse)  # data manipulation and visualization
library(gridExtra)  # plot arrangement

data("USArrests")
head(USArrests, 10)
##             Murder Assault UrbanPop Rape
## Alabama       13.2     236       58 21.2
## Alaska        10.0     263       48 44.5
## Arizona        8.1     294       80 31.0
## Arkansas       8.8     190       50 19.5
## California     9.0     276       91 40.6
## Colorado       7.9     204       78 38.7
## Connecticut    3.3     110       77 11.1
## Delaware       5.9     238       72 15.8
## Florida       15.4     335       80 31.9
## Georgia       17.4     211       60 25.8
```











