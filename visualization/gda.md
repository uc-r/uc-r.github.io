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

By default, `geom_histogram` will divide your data into 30 equal bins or intervals. Since sales prices range from \$12,789 - \$755,000, dividing this range into 30 equal bins means the bin width is \$24,740. So the first bar will represent the frequency of `Sale_Price` values that range from about \$12,500 to about \$37,500[^bins], the second bar represents the income range from about 37,500 to 62,300, and so on.

However, we can control this parameter by changing the bin width argument in `geom_histogram`. By changing the bin width when doing exploratory analysis you can get a more detailed picture of the relative densities of the distribution. For instance, in the default histogram there was a bin of \$136,000 - \$161,000 values that had the highest frequency but as the histograms that follow show, we can gather more information as we adjust the binning. 


```r

p1 <- ggplot(ames, aes(Sale_Price)) +
  geom_histogram(binwidth = 100000) +
  ggtitle("Bin width = $100,000")

p2 <- ggplot(ames, aes(Sale_Price)) +
  geom_histogram(binwidth = 50000) +
  ggtitle("Bin width = $50,000")

p3 <- ggplot(ames, aes(Sale_Price)) +
  geom_histogram(binwidth = 5000) +
  ggtitle("Bin width = $5,000")

p4 <- ggplot(ames, aes(Sale_Price)) +
  geom_histogram(binwidth = 1000) +
  ggtitle("Bin width = $1,000")

gridExtra::grid.arrange(p1, p2, p3, p4, ncol = 2)
```

<img src="/public/images/visual/graphical_data_analysis/hist2-1.png" style="display: block; margin: auto;" />

Overall, the histograms consistently show the most common income level to be right around \$130,000. We can also find the most frequent bin by combining `ggplot2::cut_width` (`ggplot2::cut_interval` and `ggplot2::cut_number` are additional options) with `dplyr::count`. We see that the most frequent bin when using increments of \$5,000 is \$128,000 - \$132,000.


```r
ames %>%
  count(cut_width(Sale_Price, width = 5000)) %>%
  arrange(desc(n))
## # A tibble: 106 x 2
##    `cut_width(Sale_Price, width = 5000)`     n
##    <fctr>                                <int>
##  1 (1.28e+05,1.32e+05]                     137
##  2 (1.42e+05,1.48e+05]                     130
##  3 (1.32e+05,1.38e+05]                     125
##  4 (1.38e+05,1.42e+05]                     125
##  5 (1.22e+05,1.28e+05]                     118
##  6 (1.52e+05,1.58e+05]                     103
##  7 (1.48e+05,1.52e+05]                     101
##  8 (1.18e+05,1.22e+05]                      99
##  9 (1.58e+05,1.62e+05]                      92
## 10 (1.72e+05,1.78e+05]                      92
## # ... with 96 more rows
```

Our histogram with `binwidth = 1000` also shows us that there are spikes at specific intervals.  This is likely due to home sale prices usually occuring around increments of \$5,000.  In addition to our primary central tendency (bins with most frequency), we also get a clearer picture of the spread of our variable and its skewness.  This suggests there may be a concern with our variable meeting assumptions of normality.  If we were to apply an analytic technique that is sensitive to normality assumptions we would likely need to transform our variable.

We can assess the applicability of a log transformation by adding `scale_x_log()` to our ggplot visual[^transf]. This log transformed histogram provides a few new insights:

1. There is a slight multimodal effect at the top of the distribution suggesting that houses selling in the \$150-170K range are not as common as those selling just below and above that price range.
2. It appears the log transformation helps our variable meet normality assumptions.  More on this in a second.
3. It appears there is a new potential outlier that we did not see earlier.  There is at least one observation where the `Sale_Price` is near zero.  In fact, further investigation identifies two observations, one with a `Sale_Price` of \$12,789 and another at \$13,100.


```r
ggplot(ames, aes(Sale_Price)) +
  geom_histogram(bins = 100) +
  geom_vline(xintercept = c(150000, 170000), color = "red", lty = "dashed") +
  scale_x_log10(
    labels = scales::dollar, 
    breaks = c(50000, 125000, 300000)
    )
```

<img src="/public/images/visual/graphical_data_analysis/logtrans-1.png" style="display: block; margin: auto;" />

Let's take a closer look at the second two insights.  First, we'll consider the issue of normality.

If you really want to look at normality, then Q-Q plots are a great visual to assess. This graph plots the cumulative values we have in our data against the cumulative probability of a particular distribution (the default is a normal distribution). In essence, this plot compares the actual value against the expected value that the score should have in a normal distribution. If the data are normally distributed the plot will display a straight (or nearly straight) line. If the data deviates from normality then the line will display strong curvature or "snaking."  These plots illustrate how much the untransformed variable deviates from normality whereas the log transformed values align much closer to a normal distribution.


```r
par(mfrow = c(1, 2))

# non-log transformed
qqnorm(ames$Sale_Price, main = "Untransformed\nNormal Q-Q Plot")
qqline(ames$Sale_Price)

# log transformed
qqnorm(log(ames$Sale_Price), main = "Log Transformed\nNormal Q-Q Plot")
qqline(log(ames$Sale_Price))
```

<img src="/public/images/visual/graphical_data_analysis/qqplot-1.png" style="display: block; margin: auto;" />

I also mentioned how we obtained a new insight regarding a new potential outlier that we did not see earlier.  So far our histogram identified potential outliers at the lower end and upper end of the sale price spectrum. Unfortunately histograms are not very good at delineating outliers.  Rather, we can use a boxplot which does a better job identifying specific outliers.

Boxplots are an alternative way to illustrate the distribution of a variable and is a concise way to illustrate the standard quantiles and outliers of data. As the below visual indicates, the box itself extends, left to right, from the 1st quartile to the 3rd quartile. This means that it contains the middle half of the data. The line inside the box is positioned at the median. The lines (whiskers) coming out either side of the box extend to 1.5 interquartile ranges (IQRs) from the quartiles. These generally include most of the data outside the box. More distant values, called outliers, are denoted separately by individual points. Now we have a more analytically specific approach to identifying outliers. 

<center>
<img src="https://www.leansigmacorporation.com/wp/wp-content/uploads/2015/12/Box-Plot-MTB_01.png" alt="Generic Box Plot" width="500" vspace="20">
</center>

There are two efficient graphs to get an indication of potential outliers in our data.  The classic boxplot on the left will identify points beyond the whiskers which are beyond $$1.5 \times IQR$$ from the first and third quantile.  This illustrates there are several additional observations that we may need to assess as outliers that were not evident in our histogram.  However, when looking at a boxplot we lose insight into the shape of the distribution.  A violin plot on the right provides us a similar chart as the boxplot but we lose insight into the quantiles of our data and outliers are not plotted (hence the reason I plot `geom_point` prior to `geom_violin`).  Violin plots will come in handy later when we start to visualize multiple distributions along side each other.


```r
p1 <- ggplot(ames, aes("var", Sale_Price)) +
  geom_boxplot(outlier.alpha = .25) +
  scale_y_log10(
    labels = scales::dollar, 
    breaks = quantile(ames$Sale_Price)
  )

p2 <- ggplot(ames, aes("var", Sale_Price)) +
  geom_point() +
  geom_violin() +
  scale_y_log10(
    labels = scales::dollar, 
    breaks = quantile(ames$Sale_Price)
  )

gridExtra::grid.arrange(p1, p2, ncol = 2)
```

<img src="/public/images/visual/graphical_data_analysis/boxplot-1.png" style="display: block; margin: auto;" />

The boxplot starts to answer the question of what potential outliers exist in our data. Outliers in data can distort predictions and affect their accuracy. Consequently, its important to understand if outliers are present and, if so, which observations are considered outliers. Boxplots provide a visual assessment of potential outliers while the `outliers` package provides a number of useful functions to systematically extract these outliers. The most useful function is the `scores` function, which computes normal, t, chi-squared, IQR and MAD scores of the given data which you can use to find observation(s) that lie beyond a given value.

Here, I use the `outliers::score` function to extract those observations beyond the whiskers in our boxplot and then use a stem-and-leaf plot to assess them.  A stem-and-leaf plot is a special table where each data value is split into a "stem" (the first digit or digits) and a "leaf" (usually the second digit).  Since the decimal point is located 5 digits to the right of the "|"" the last stem of "7" and and first leaf of "5" means an outlier exists at around \$750,000.  The last stem of "7" and and second leaf of "6" means an outlier exists at around \$760,000.  This is a concise way to see approximately where our outliers are.  In fact, I can now see that I have 28 lower end outliers ranging from \$10,000-\$60,000 and 32 upper end outliers ranging from \$450,000-\$760,000.


```r
outliers <- outliers::scores(log(ames$Sale_Price), type = "iqr", lim = 1.5)
stem(ames$Sale_Price[outliers])
## 
##   The decimal point is 5 digit(s) to the right of the |
## 
##   0 | 1134444445555555666666666666
##   1 | 
##   2 | 
##   3 | 
##   4 | 56666777788899
##   5 | 000445566889
##   6 | 1123
##   7 | 56
```

Another useful plot for univariate assessment includes the *smoothed* histogram in which a non-parametric approach is used to estimate the density function. Displaying in density form just means the y-axis is now in a probability scale where the proportion of the given value (or bin of values) to the overall population is displayed. In essence, the y-axis tells you the estimated probability of the x-axis value occurring.  This results in a *smoothed* curve known as the density plot that allows us visualize the distribution.  Since the focus of a density plot is to view the overall distribution rather than individual bin observations we lose insight into how many observations occur at certain x values.  Consequently, it can be helpful to use `geom_rug` with `geom_density` to highlight where clusters, outliers, and gaps of observations are occuring.


```r
p1 <- ggplot(ames, aes(Sale_Price)) +
  geom_density()

p2 <- ggplot(ames, aes(Sale_Price)) +
  geom_density() +
  geom_rug()

gridExtra::grid.arrange(p1, p2, nrow = 1)
```

<img src="/public/images/visual/graphical_data_analysis/density-1.png" style="display: block; margin: auto;" />

Often you will see density plots layered onto histograms. To layer the density plot onto the histogram we need to first draw the histogram but tell ggplot to have the y-axis in density form rather than count. You can then add the `geom_density` function to add the density plot on top.


```r
ggplot(ames, aes(Sale_Price)) +
  geom_histogram(aes(y = ..density..),
                 binwidth = 5000, color = "grey30", fill = "white") +
  geom_density(alpha = .2, fill = "antiquewhite3")
```

<img src="/public/images/visual/graphical_data_analysis/density2-1.png" style="display: block; margin: auto;" />

You may also be interested to see if there are any systematic groupings with how the data is structured.  For example, using base R's `plot` function with just the `Sale_Price` will plot the sale price versus the index (row) number of each observation.  In the plot below we see a pattern which indicates that groupings of homes with high versus lower sale prices are concentrated together throughout the data set. 


```r
plot(ames$Sale_Price, col = rgb(0,0,0, alpha = 0.3))
```

<img src="/public/images/visual/graphical_data_analysis/indexplot-1.png" style="display: block; margin: auto;" />


There are also a couple plots that can come in handy when dealing with smaller data sets.  For example, the dotplot below provides more clarity than the histogram for viewing the distribution of `mpg` in the built-in `mtcars` dataset with only 32 observations.  An alternative to this would be using a strip chart (see `stripchart`). 


```r
p1 <- ggplot(mtcars, aes(x = mpg)) +
  geom_dotplot(method = "histodot", binwidth = 1) +
  ggtitle("dotplot")

p2 <- ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(binwidth = 1) +
  ggtitle("histogram")

gridExtra::grid.arrange(p1, p2, nrow = 1)
```

<img src="/public/images/visual/graphical_data_analysis/dotplot-1.png" style="display: block; margin: auto;" />

As demonstrated, several plots exist for examining univariate continuous variables.  Several exampes were provided here but still more exist (i.e. frequency polygon, beanplot, shifted histograms).  There is some general advice to follow such as histograms being poor for small data sets, dotplots being poor for large data sets, histograms being poor for identifying outlier cut-offs, boxplots being good for outliers but obscuring multimodality.  Conseqently, it is important to draw a variety of plots.  Moreover, it is important to adjust parameters within plots (i.e. binwidth, axis transformation for skewed data) to get a comprehensive picture of the variable of concern.

### Categorical Variables {#categorical}

A categorical variable is a variable that can take on one of a limited, and usually fixed, number of possible values, assigning each individual or other unit of observation to a particular group or nominal category on the basis of some qualitative property (i.e. gender, grade, manufacturer). There are a few different plots that can effectively communicate features of categorical variables.  Features we are generally interested in include:

- Count of each category
- Proportion of each category
- Imbalanced categories
- Mislabeled categories

[Bar charts](barcharts) are one of the most commonly used data visualizations for categorical variables. Bar charts display the levels of a categorical variable of interest (typically) along the x-axis and the length of the bar illustrates the value along the y-axis. Consequently, the length of the bar is the primary visual cue in a bar chart and in a univariate visualization this length represents counts of cases in that particular level.

If we look at the general zoning classification for each property sold in our `ames` dataset we see that the majority of all properties fall within one category. Here, `geom_bar` simply counts up all observations for each zoning level.


```r
ggplot(ames, aes(MS_Zoning)) +
  geom_bar()
```

<img src="/public/images/visual/graphical_data_analysis/bar1-1.png" style="display: block; margin: auto;" />

Here, `MS_Zoning` represents a nominal categorical variable where there is no logical ordering of the labels; they simply represent mutually exclusive levels within our variable.  To get better clarity of nominal variables we can make some refinements.  Here I use `dplyr::count` to count the observations in each level prior to plotting.  In the second plot I use `mutate` to compute the percent that each level makes up of all observations.  I then feed these summarized data into `ggplot` where I can `reorder` the `MS_Zoning` variable from most frequent to least and then apply `coord_flip` to rotate the plot and make it easier to read the level categories.  Also, notice that now I feeding an x (`MS_Zoning`) and y (`n` in the left plot and `pct` in the right plot) arguments so I apply `geom_col` rather than `geom_bar`.


```r
# total count
p1 <- ames %>% 
  count(MS_Zoning) %>%
  ggplot(aes(reorder(MS_Zoning, n), n)) +
  geom_col() +
  coord_flip() +
  ggtitle("Total count")

# percent of whole
p2 <- ames %>% 
  count(MS_Zoning) %>%
  mutate(pct = n / sum(n)) %>%
  ggplot(aes(reorder(MS_Zoning, pct), pct)) +
  geom_col() +
  coord_flip() +
  ggtitle("Percent of whole")

gridExtra::grid.arrange(p1, p2, nrow = 1)
```

<img src="/public/images/visual/graphical_data_analysis/bar2-1.png" style="display: block; margin: auto;" />

Now we can see that properties zoned as residential low density make up nearly 80% of all observations . We also see that properties zoned as aggricultural (`A_agr`), industrial (`I_all`), commercial (`C_all`), and residential high density make up a very small amount of observations.  In fact, below we see that these imbalanced category levels each make up less than 1\% of all observations.  


```r
ames %>% 
  count(MS_Zoning) %>%
  mutate(pct = n / sum(n)) %>%
  arrange(pct)
## # A tibble: 7 x 3
##   MS_Zoning                        n      pct
##   <fctr>                       <int>    <dbl>
## 1 A_agr                            2 0.000683
## 2 I_all                            2 0.000683
## 3 C_all                           25 0.00853 
## 4 Residential_High_Density        27 0.00922 
## 5 Floating_Village_Residential   139 0.0474  
## 6 Residential_Medium_Density     462 0.158   
## 7 Residential_Low_Density       2273 0.776
```

This imbalanced nature can cause problems in future analytic models so it may make sense to combine these infrequent levels into an "other" category. An easy way to do that is to use `fct_lump`.[^factors]  Here we use `n = 2` to retain the top 2 levels in our variable and condense the remaining into an "other" category.  You can see that this combined category still represents less than 10% of all observations.


```r
ames %>% 
  mutate(MS_Zoning = fct_lump(MS_Zoning, n = 2)) %>% 
  count(MS_Zoning) %>%
  mutate(pct = n / sum(n)) %>%
  ggplot(aes(reorder(MS_Zoning, pct), pct)) +
  geom_col() +
  coord_flip()
```

<img src="/public/images/visual/graphical_data_analysis/bar3-1.png" style="display: block; margin: auto;" />

Basic bar charts such as these are great when the number of category levels is smaller.  However, as the number of levels increase the thick nature of the bar can be distracting.  [Cleveland dot plots](cleveland-dot-plots) and [lollipop charts](lollipop) are useful for assessing the frequency or proportion of many levels while minizing the amount of ink on the graphic.

For example, if we assess the frequencies and proportions of home sales by  the 38 different neighborhoods a dotplot simplifies the chart.


```r
ames %>%  
  count(Neighborhood) %>%
  mutate(pct = n / sum(n)) %>%
  ggplot(aes(pct, reorder(Neighborhood, pct))) +
  geom_point()
```

<img src="/public/images/visual/graphical_data_analysis/dot-1.png" style="display: block; margin: auto;" />

Similar to the Cleveland dot plot, a lollipop chart minimizes the visual ink but uses a line to draw the readers attention to the specific x-axis value achieved by each category. In the lollipop chart we use `geom_segment` to plot the lines and we explicitly state that we want the lines to start at `x = 0` and extend to the neighborhood value with `xend = pct`. We simply need to include `y = neighborhood` and `yend = neighborhood` to tell R the lines are horizontally attached to each neighborhood.


```r
ames %>%  
  count(Neighborhood) %>%
  mutate(pct = n / sum(n)) %>%
  ggplot(aes(pct, reorder(Neighborhood, pct))) +
  geom_point() +
  geom_segment(aes(x = 0, xend = pct, y = Neighborhood, yend = Neighborhood), size = .15)
```

<img src="/public/images/visual/graphical_data_analysis/dot1-1.png" style="display: block; margin: auto;" />


Sometimes we have categorical data that have natural, ordered categories.  These types of categorical variables can be ordinal or interval.  An ordinal variable is one in which the order of the values can be important but the differences between each one is not really known.  For example, our `ames` data categorizes the quality of kitchens into five buckets and these buckets have a natural order that is not captured with a regular bar chart.


```r
ggplot(ames, aes(Kitchen_Qual)) + 
  geom_bar()
```

<img src="/public/images/visual/graphical_data_analysis/ord1-1.png" style="display: block; margin: auto;" />

Here, rather than order by frequency it may be important to order the bars by the natural order of the quality lables:  Poor, Fair, Typical, Good, Excellent.  This can provide better insight into where most observations fall within this spectrum of quality.  To do this we reorder the factor levels with `fct_relevel` and now its easier to see that most homes have average to slightly above average quality kitchens.


```r
ames %>%
  mutate(Kitchen_Qual = fct_relevel(Kitchen_Qual, "Poor", "Fair", "Typical", "Good")) %>%
  ggplot(aes(Kitchen_Qual)) + 
  geom_bar()
```

<img src="/public/images/visual/graphical_data_analysis/ord2-1.png" style="display: block; margin: auto;" />

We may also have a categorical variable that has set intervals and may even be identified by integer values.  For example, our data identifies the month each home was sold but uses integer values to represent the months.  In this case we do not need to reorder our factor levels but we should ensure we visualize these as discrete factor levels (note how I apply `factor(Mo_Sold)` within ggplot) so that the home sale counts are appropriately bucketed into each month.  


```r
p1 <- ggplot(ames, aes(Mo_Sold)) + 
  geom_bar()

p2 <- ggplot(ames, aes(factor(Mo_Sold))) + 
  geom_bar()

gridExtra::grid.arrange(p1, p2, nrow = 2)
```

<img src="/public/images/visual/graphical_data_analysis/int1-1.png" style="display: block; margin: auto;" />


Bar charts can also illustrate how our missing values are disbursed across categorical variables.  Using the `MASS::survey` data (since our `ames` data does not have any missing data) we can make small multiples (more on this in the next section) using `facet_wrap` to visualize the `NA`s. 


```r
MASS::survey %>%
  select(Sex, Exer, Smoke, Fold, Clap, M.I) %>%
  gather(var, value, Sex:M.I) %>%
  ggplot(aes(value)) +
  geom_bar() +
  facet_wrap(~ var, scales = "free")
```

<img src="/public/images/visual/graphical_data_analysis/missing1-1.png" style="display: block; margin: auto;" />

Or in some cases observations are not labeled correctly.  If we look at the `Embarked` variable in the `titanic` package we see that the levels are labeled as C, Q, and S; however, there are two cases that have no label (these values are coded as `""` in the actual data set).  These are missing values that are just not coded as `NA`s.  For modeling purposes we would likely recode these as either `NA`s or impute them as one of the other three levels (C, Q, or S).


```r
ggplot(titanic::titanic_train, aes(Embarked)) +
  geom_bar()
```

<img src="/public/images/visual/graphical_data_analysis/mislabeled-1.png" style="display: block; margin: auto;" />

Bar charts and their cousins are a simple form of visual display, yet they can provide much information about our categorical variables.  Whether viewing nominal, ordinal, or interval data we can make minor adjustments in our bar charts to highlight the important features of our variables.

