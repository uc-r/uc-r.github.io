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

## Preparing Our Data {#preparing}

It is usually beneficial for each variable to be centered at zero for PCA, due to the fact that it makes comparing each principal component to the mean straightforward.  This also eliminates potential problems with the scale of each variable. For example, the variance of *Assault* is 6945, while the variance of *Murder* is only 18.97. The *Assault* data isn't necessarily more variable, it's simply on a different scale relative to *Murder*. 


```r
# compute variance of each variable
apply(USArrests, 2, var)
##     Murder    Assault   UrbanPop       Rape 
##   18.97047 6945.16571  209.51878   87.72916
```


Standardizing each variable will fix this issue. 


```r
# create new data frame with centered variables
scaled_df <- apply(USArrests, 2, scale)
head(scaled_df)
##          Murder   Assault   UrbanPop         Rape
## [1,] 1.24256408 0.7828393 -0.5209066 -0.003416473
## [2,] 0.50786248 1.1068225 -1.2117642  2.484202941
## [3,] 0.07163341 1.4788032  0.9989801  1.042878388
## [4,] 0.23234938 0.2308680 -1.0735927 -0.184916602
## [5,] 0.27826823 1.2628144  1.7589234  2.067820292
## [6,] 0.02571456 0.3988593  0.8608085  1.864967207
```

However, keep in mind that there may be instances where scaling is not desirable. An example would be if every variable in the data set had the same units and the analyst wished to capture this difference in variance for his or her results. Since *Murder, Assault,* and *Rape* are all measured on occurrences per 100,000 people this may be reasonable depending on how you want to interpret the results.  But since *UrbanPop* is measured as a percentage of total population it wouldn't make sense to compare the variability of *UrbanPop* to *Murder, Assault,* and *Rape*.  

The important thing to remember is PCA is influenced by the magnitude of each variable; therefore, *the results obtained when we perform PCA will also depend on whether the variables have been individually scaled.*

### What are Principal Components? {#what}

The goal of PCA is to explain most of the variability in the data with a smaller number of variables than the original data set. For a large data set with $$p$$ variables, we could examine pairwise plots of each variable against every other variable, but even for moderate $$p$$, the number of these plots becomes excessive and not useful.  For example, when $$p = 10$$ there are $$p(p-1)/2 = 45$$ scatterplots that could be analyzed!  Clearly, a better method is required to visualize the *n* observations when *p* is large. In particular, we would like to find a low-dimensional representation of the data that captures as much of the information as possible. For instance, if we can obtain a two-dimensional representation of the data that captures most of the information, then we can plot the observations in this low-dimensional space.

PCA provides a tool to do just this. It finds a low-dimensional representation of a data set that contains as much of the variation as possible. The idea is that each of the *n* observations lives in *p*-dimensional space, but not all of these dimensions are equally interesting. PCA seeks a small number of dimensions that are as interesting as possible, where the concept of *interesting* is measured by the amount that the observations vary along each dimension. Each of the dimensions found by PCA is a linear combination of the *p* features and we can take these linear combinations of the measurements and reduce the number of plots necessary for visual analysis while retaining most of the information present in the data. 

We now explain the manner in which these dimensions, or principal components, are found.

The *first principal component* of a data set $$X_1, X_2, ..., X_p$$ is the linear combination of the features

$$Z_{1} = \phi_{11}X_{1} + \phi_{21}X_{2} + ... + \phi_{p1}X_{p} \tag{1}$$ 

that has the largest variance and where $$\phi_1$$ is the first principal component loading vector, with elements $$\phi_{12}, \phi_{22}, \dots, \phi_{p2}$$. The $$\phi$$ are *normalized*, which means that $$\sum_{j=1}^{p}{\phi_{j1}^{2}} = 1$$.  After the first principal component $$Z_1$$ of the features has been determined, we can find the second principal component $$Z_2$$. The second principal component is the linear combination of $$X_1,\dots , X_p$$ that has maximal variance out of all linear combinations that are __*uncorrelated*__ with $$Z_1$$. The second principal component scores $$z_{12}, z_{22}, \dots, z_{n2}$$ take the form

$$Z_{2} = \phi_{12}X_{1} + \phi_{22}X_{2} + ... + \phi_{p2}X_{p} \tag{2}$$

This proceeds until all principal components are computed.  The elements $$\phi_{11}, ..., \phi_{p1}$$ in Eq. 1 are the *loadings* of the first principal component. To calculate these loadings, we must find the $$\phi$$ vector that maximizes the variance. It can be shown using techniques from linear algebra that the eigenvector corresponding to the largest eigenvalue of the covariance matrix is the set of loadings that explains the greatest proportion of the variability.

Therefore, to calculate principal components, we start by using the `cov()` function to calculate the covariance matrix, followed by the `eigen` command to calculate the eigenvalues of the matrix. `eigen` produces an object that contains both the ordered eigenvalues (`$values`) and the corresponding eigenvector matrix (`$vectors`). 

```r
# Calculate eigenvalues & eigenvectors
arrests.cov <- cov(scaled_df)
arrests.eigen <- eigen(arrests.cov)
str(arrests.eigen)
## List of 2
##  $ values : num [1:4] 2.48 0.99 0.357 0.173
##  $ vectors: num [1:4, 1:4] -0.536 -0.583 -0.278 -0.543 0.418 ...
```


For our example, we'll take the first two sets of loadings and store them in the matrix `phi`.


```r
# Extract the loadings
(phi <- arrests.eigen$vectors[,1:2])
##            [,1]       [,2]
## [1,] -0.5358995  0.4181809
## [2,] -0.5831836  0.1879856
## [3,] -0.2781909 -0.8728062
## [4,] -0.5434321 -0.1673186
```

Eigenvectors that are calculated in any software package are unique up to a sign flip. By default, eigenvectors in R point in the negative direction. For this example, we'd prefer the eigenvectors point in the positive direction because it leads to more logical interpretation of graphical results as we'll see shortly. To use the positive-pointing vector, we multiply the default loadings by -1. The set of loadings for the first principal component (*PC1*) and second principal component (*PC2*) are shown below:


```r
phi <- -phi
row.names(phi) <- c("Murder", "Assault", "UrbanPop", "Rape")
colnames(phi) <- c("PC1", "PC2")
phi
##                PC1        PC2
## Murder   0.5358995 -0.4181809
## Assault  0.5831836 -0.1879856
## UrbanPop 0.2781909  0.8728062
## Rape     0.5434321  0.1673186
```





