---
layout: tutorial
title: Learn About the Data
permalink: /data_wrangling/about_the_data
---

Once you have a basic understanding of your source data from the codebook, and once you have imported the data, next you need to start learning the basics of your variables.  To illustrate how we can get some basic insights from our data, I'll illustrate with the built-in `mtcars` data set (remember, if you want to see the codebook for a built-in R data set such as `mtcars` just type `?mtcars` in the console). 


## Dimensions and Attributes

Some of the first things we want to understand are the dimensions of our data (number of variables and number of observations):


```r
# number of variables
ncol(mtcars)
## [1] 11

# number of rows
nrow(mtcars)
## [1] 32

# number of rows and variables
dim(mtcars)
## [1] 32 11
```

We also want to understand the names of our columns so we can link them back to the codebook and understand the variables we are dealing with:


```r
# names of variables
names(mtcars)
##  [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear"
## [11] "carb"
```

Sometimes the data we are working with also have row names.  Personally, I believe that if row names are meaningful then they should be a variable in-themselves but that is not always the case for an initial data set we are provided.  We can check for row names with:


```r
row.names(mtcars)
##  [1] "Mazda RX4"           "Mazda RX4 Wag"       "Datsun 710"         
##  [4] "Hornet 4 Drive"      "Hornet Sportabout"   "Valiant"            
##  [7] "Duster 360"          "Merc 240D"           "Merc 230"           
## [10] "Merc 280"            "Merc 280C"           "Merc 450SE"         
## [13] "Merc 450SL"          "Merc 450SLC"         "Cadillac Fleetwood" 
## [16] "Lincoln Continental" "Chrysler Imperial"   "Fiat 128"           
## [19] "Honda Civic"         "Toyota Corolla"      "Toyota Corona"      
## [22] "Dodge Challenger"    "AMC Javelin"         "Camaro Z28"         
## [25] "Pontiac Firebird"    "Fiat X1-9"           "Porsche 914-2"      
## [28] "Lotus Europa"        "Ford Pantera L"      "Ferrari Dino"       
## [31] "Maserati Bora"       "Volvo 142E"
```

Column (variable) and row names are considered attributes of our data.  Sometimes there are additional meta-data (comments, descriptions, etc.) embedded in our data set.  We can get all this information quickly by using `attributes()`:


```r
attributes(mtcars)
## $names
##  [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear"
## [11] "carb"
## 
## $row.names
##  [1] "Mazda RX4"           "Mazda RX4 Wag"       "Datsun 710"         
##  [4] "Hornet 4 Drive"      "Hornet Sportabout"   "Valiant"            
##  [7] "Duster 360"          "Merc 240D"           "Merc 230"           
## [10] "Merc 280"            "Merc 280C"           "Merc 450SE"         
## [13] "Merc 450SL"          "Merc 450SLC"         "Cadillac Fleetwood" 
## [16] "Lincoln Continental" "Chrysler Imperial"   "Fiat 128"           
## [19] "Honda Civic"         "Toyota Corolla"      "Toyota Corona"      
## [22] "Dodge Challenger"    "AMC Javelin"         "Camaro Z28"         
## [25] "Pontiac Firebird"    "Fiat X1-9"           "Porsche 914-2"      
## [28] "Lotus Europa"        "Ford Pantera L"      "Ferrari Dino"       
## [31] "Maserati Bora"       "Volvo 142E"         
## 
## $class
## [1] "data.frame"
```

<br>

## Viewing our Data

For a large data set this can sometimes produce quite a lengthy list.  Sometimes we just want to check out our data in a spreadsheet view.  We can do this using `View()`.  Go ahead and type the following in your console:


```r
View(mtcars)
```

We may also want to check out the first or last *n* rows of the data set. We can do this with `head()` and `tail()`, which defaults to looking at the first or last 6 rows but we can adjust this.


```r
# by default head() will display the first 6 rows
head(mtcars)
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1


# look at the last 10 rows
tail(mtcars, 10)
##                   mpg cyl  disp  hp drat    wt  qsec vs am gear carb
## AMC Javelin      15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
## Camaro Z28       13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
## Pontiac Firebird 19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
## Fiat X1-9        27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
## Porsche 914-2    26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
## Lotus Europa     30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
## Ford Pantera L   15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
## Ferrari Dino     19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
## Maserati Bora    15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
## Volvo 142E       21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
```

<br>

## Data Types

We also want to know what type of data each variable is recorded as.  We will learn more about how to manage data types (i.e. [numeric](numbers), [character](characters), [factors](factors), and [dates](dates)) later in the class; however, right now you just want to understand what type of data you are working with. We can do this a couple ways but one of the easiest ways is to use the `str()` function, which displays the **str**ucture of the data. `str()` is very convenient because it will also provide the number of observations, number of variables, the name of each variable, the type of data each variable is, and will also display the first several observations to give you a taste of the data.  In this example all variables are numeric (indicated by "num" listed after the variable names).



```r
str(mtcars)
## 'data.frame':	32 obs. of  11 variables:
##  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
##  $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
##  $ disp: num  160 160 108 258 360 ...
##  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
##  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
##  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
##  $ qsec: num  16.5 17 18.6 19.4 17 ...
##  $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
##  $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
##  $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
##  $ carb: num  4 4 1 1 2 1 4 2 2 4 ...
```


However, you may notice something. According to the codebook (`?mtcars`) the *cyl*, *vs*, *gear*, and *carb* are not necessarily continuous variables. These variables are *categorical* variables (we'll get into this more later in the class) where:

- `cyl` is the number of cylinders (4 , 6, or 8)
- `vs` represents a V-engine (0) or straight engine (1)
- `gear` is the number of gears (3, 4, or 5)
- `carb` is the number of carburetors (1, 2, 3, 4, 6, or 8)

We can change variable types using the suite of `as.` functions (`as.character`, `as.integer`, `as.factor`, etc.). In R, categorical variables are considered "factors" so to change these variables to factors we simply apply the `as.factor()` function. 


```r
# change variables from numerics to factors
mtcars$cyl <- as.factor(mtcars$cyl)
mtcars$vs <- as.factor(mtcars$vs)
mtcars$gear <- as.factor(mtcars$gear)
mtcars$carb <- as.factor(mtcars$carb)
```

Now when we look at the structure of our `mtcars` data we see that *cyl*, *vs*, *gear*, and *carb* are recorded as factors.


```r
str(mtcars)
## 'data.frame':	32 obs. of  11 variables:
##  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
##  $ cyl : Factor w/ 3 levels "4","6","8": 2 2 1 2 3 2 3 1 1 2 ...
##  $ disp: num  160 160 108 258 360 ...
##  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
##  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
##  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
##  $ qsec: num  16.5 17 18.6 19.4 17 ...
##  $ vs  : Factor w/ 2 levels "0","1": 1 1 2 2 1 2 1 2 2 2 ...
##  $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
##  $ gear: Factor w/ 3 levels "3","4","5": 2 2 2 1 1 1 1 2 2 2 ...
##  $ carb: Factor w/ 6 levels "1","2","3","4",..: 4 4 1 1 2 1 4 2 2 4 ...
```

We can also apply the `class()` function to get the type of data for a specific variable.  Here I get the type of data that the *cyl* variable of the `mtcars` data sset is.


```r
class(mtcars$cyl)
## [1] "factor"
```


Now, a simple trick is to apply this `class` function iteratively over each column of our data set.  We can use the `sapply()` function to do this.  We simply supply the data set we want to iterate over and then the function we want to apply to each variable:


```r
sapply(mtcars, class)
##       mpg       cyl      disp        hp      drat        wt      qsec 
## "numeric"  "factor" "numeric" "numeric" "numeric" "numeric" "numeric" 
##        vs        am      gear      carb 
##  "factor" "numeric"  "factor"  "factor"
```

Don't worry, you will learn more about iteration functions later in the course.

<br>

## Missing Data

Next, before we start looking at statistical summaries of the data, we want to understand if we have any missing observations.  The `is.na()` function will return TRUE or FALSE for each cell in the `mtcars` data frame stating whether or not it is a missing value. This allows us to identify how many missing values are in our data by wrapping `is.na()` with `sum()` (in R TRUE = 1 and FALSE = 0):


```r
# get the count of missing values in the data set
sum(is.na(mtcars))
## [1] 0
```

In this example we have no missing values. However, if we did have missing values we may want to recode or omit them.  To manage missing values read the short tutorial on *[Dealing with missing values](http://uc-r.github.io/missing_values)*.

<br>

## Basic Descriptive Statistics

Ok, so now we should have a pretty good understanding of the basic structure of our data. Next, we need to start understanding some descriptive statistics of our data. Descriptive statistics are the first pieces of information used to understand and represent a data set. The goal, in essence, is to describe the main features of numerical and categorical information with simple summaries. These summaries can be presented with a single numeric measure, frequency distributions, using summary tables, etc. 

A simple approach to get basic summary statistics for all the variables in a data set is to use `summary`.  This provides the minimum, 1st quantile, median, mean, 3rd quantile, and maximum summary measures. 


```r
summary(mtcars)
##      mpg        cyl         disp             hp             drat             wt             qsec       vs           am         gear   carb  
## Min.   :10.40   4:11   Min.   : 71.1   Min.   : 52.0   Min.   :2.760   Min.   :1.513   Min.   :14.50   0:18   Min.   :0.0000   3:15   1: 7  
## 1st Qu.:15.43   6: 7   1st Qu.:120.8   1st Qu.: 96.5   1st Qu.:3.080   1st Qu.:2.581   1st Qu.:16.89   1:14   1st Qu.:0.0000   4:12   2:10  
## Median :19.20   8:14   Median :196.3   Median :123.0   Median :3.695   Median :3.325   Median :17.71          Median :0.0000   5: 5   3: 3  
## Mean   :20.09          Mean   :230.7   Mean   :146.7   Mean   :3.597   Mean   :3.217   Mean   :17.85          Mean   :0.4062          4:10  
## 3rd Qu.:22.80          3rd Qu.:326.0   3rd Qu.:180.0   3rd Qu.:3.920   3rd Qu.:3.610   3rd Qu.:18.90          3rd Qu.:1.0000          6: 1  
## Max.   :33.90          Max.   :472.0   Max.   :335.0   Max.   :4.930   Max.   :5.424   Max.   :22.90          Max.   :1.0000          8: 1  
```


We may also want to look more closely at individual variables to get a better understanding of them.  Here, I illustrate the most common forms of descriptive statistics for [numerical](#numerical) and [categorical](#categorical) variables but keep in mind there are numerous ways to describe and illustrate key features of data.

### Numerical Data {#numerical}

#### Central Tendency {#central}

There are three common measures of central tendency, all of which try to answer the basic question of which value is the most “typical.” These are the mean (average of all observations), median (middle observation), and mode (appears most often). Each of these measures can be calculated for an individual variable or across all variables in a particular data frame.  For example, if we are interested in finding the central tendency measures for the *mpg* variable we can employ the following (note that when you use `mtcars$mpg` you are selecting the mpg variable from the mtcars data set):


```r
mean(mtcars$mpg)
## [1] 20.09062
median(mtcars$mpg)
## [1] 19.2
```

Unfortunately, there is not a built-in function to compute the mode of a variable[^mode]. However, we can create a function that takes the vector as an input and gives the mode value as an output.


```r
get_mode <- function(v) {
  unique_value <- unique(v)
  unique_value[which.max(tabulate(match(v, unique_value)))]
}

get_mode(mtcars$mpg)
## [1] 21
```

#### Variability {#variance}

The central tendencies give you a sense of the *most likely* values (mpg in this case) but do not provide you with information on the variability of the values. Variability can be summarized in different ways, each providing you unique understanding of how the values are spread out.

##### Range

The range is a fairly crude measure of variability, defining the maximum and minimum values and the difference thereof. We can compute range summaries with the following:


```r
# get the minimum value
min(mtcars$mpg)
## [1] 10.4

# get the maximum value
max(mtcars$mpg)
## [1] 33.9

# get both the min and max values
range(mtcars$mpg)
## [1] 10.4 33.9

# compute the spread between min & max values
max(mtcars$mpg) - min(mtcars$mpg)
## [1] 23.5
```

##### Percentiles

Given a certain percentage such as 25%, what is the mpg value such that 25% of the `mtcars` observations fall below it? This type of question leads to <u>percentiles</u> and <u>quartiles</u>. Specifically, for any percentage *p*, the *p*th percentile is the value such that a percentage *p* of all values are less than it. Similarly, the first, second, and third quartiles are the percentiles corresponding to $$p=25\%$$, $$p=50\%$$, and $$p=75\%$$. These three values divide the data into four groups, each with (approximately) a quarter of all observations. Note that the second quartile is equal to the median by definition. These measures are easily computed in R:


```r
# fivenum() function provides min, 25%, 50% (median), 75%, and max
fivenum(mtcars$mpg)
## [1] 10.40 15.35 19.20 22.80 33.90

# default quantile() percentiles are 0%, 25%, 50%, 75%, and 100% 
# provides same output as fivenum()
quantile(mtcars$mpg)
##     0%    25%    50%    75%   100% 
## 10.400 15.425 19.200 22.800 33.900

# we can customize quantile() for specific percentiles
quantile(mtcars$mpg, probs = seq(from = 0, to = 1, by = .1))
##    0%   10%   20%   30%   40%   50%   60%   70%   80%   90%  100% 
## 10.40 14.34 15.20 15.98 17.92 19.20 21.00 21.47 24.08 30.09 33.90

# we can quickly compute the difference between the 1st and 3rd quantile
IQR(mtcars$mpg)
## [1] 7.375
```


An alternative approach is to use the `summary` function directly on the individual variable:


```r
summary(mtcars$mpg)
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   10.40   15.43   19.20   20.09   22.80   33.90
```

##### Variance

Although the range provides a crude measure of variability and percentiles/quartiles provide an understanding of divisions of the data, the most common measures to summarize variability are variance and its derivatives (standard deviation and mean/median absolute deviation). We can compute each of these as follows:


```r
# variance
var(mtcars$mpg)
## [1] 36.3241

# standard deviation
sd(mtcars$mpg)
## [1] 6.026948

# mean absolute deviation
mad(mtcars$mpg, center = mean(mtcars$mpg))
## [1] 6.37518

# median absolute deviation - note that the center argument defaults to median
# so it does not need to be specified, although I do just be clear
mad(mtcars$mpg, center = median(mtcars$mpg))
## [1] 5.41149
```


##### Shape

Two additional measures of a distribution that you will hear occasionally include skewness and kurtosis. Skewness is a measure of symmetry for a distribution. Negative values represent a *left-skewed* distribution where there are more extreme values to the left causing the mean to be less than the median. Positive values represent a *right-skewed* distribution where there are more extreme values to the right causing the mean to be more than the median.  

Kurtosis is a measure of peakedness for a distribution. Negative values indicate a flat (platykurtic) distribution, positive values indicate a peaked (leptokurtic) distribution, and a value near 3 indicates a normal (mesokurtic) distribution.

We can get both skewness and kurtosis values using the `moments` package.  Here, since our skewness is positive we can tell monthly card expenditures is right-skewed and since the kurtosis is much greater than 3 this suggests a very peaked distribution.


```r
library(moments)

skewness(mtcars$mpg)
## [1] 0.6404399
kurtosis(mtcars$mpg)
## [1] 2.799467
```

#### Outliers {#outliers}

Outliers in data can distort predictions and affect their accuracy. Consequently, its important to understand if outliers are present and, if so, which observations are considered outliers. The `outliers` package provides a number of useful functions to systematically extract outliers. The functions of most use are `outlier()` and `scores()`. The `outlier` function gets the most extreme observation from the mean. The `scores` function computes the normalized (*z*, *t*, *chisq*, etc.) score which you can use to find observation(s) that lie beyond a given value.


```r
library(outliers)

# gets most extreme right-tail observation (same as max)
outlier(mtcars$mpg)

# gets most extreme left-tail observation (same as min)
outlier(mtcars$mpg, opposite = TRUE)

# observations that are outliers based on z-scores greater than 2. In other 
# words, these observations exceed 2 standard deviations from the mean.
z_scores <- scores(mtcars$mpg, type = "z")
which(abs(z_scores) > 2)

# outliers based on values less than or greater than the "whiskers" on a 
# boxplot (1.5 x IQR or more below 1st quartile or above 3rd quartile)
which(scores(mtcars$mpg, type = "iqr", lim = 1.5))
```

How you deal with outliers is a topic worthy of its own chapter; however, if you want to simply remove an outlier or replace it with the sample mean or median then I recommend the `rm.outlier` function provided also by the `outliers` package.


<br>

### Categorical variables {#categorical}
Common forms of descriptive statistics for categorical data typically include the following variances of contingency tables: 

#### Frequency Tables {#frequencies}

To produce contingency tables which calculate counts for each combination of categorical variables we can use R’s `table()` function. For instance, we may want to get the total count of observations that fall into each cylinder category.


```r
# counts for cylinders
table(mtcars$cyl)
## 
##  4  6  8 
## 11  7 14
```

If we want to understand the number of observations by cylinders *and* carburetors we can produce a cross classification table:


```r
# cross classification counts for cylinders by carburetors
table(mtcars$cyl, mtcars$carb)
##    
##     1 2 3 4 6 8
##   4 5 6 0 0 0 0
##   6 2 0 0 4 1 0
##   8 0 4 3 6 0 1
```

There are also functions such as `ftable` that allows us to create three-plus dimensional contingency tables. In this case we assess the count of observations by cylinder, carburetors, *and* transmission (0 = automatic, 1 = manual):


```r
table1 <- table(mtcars$am, mtcars$cyl, mtcars$carb)
ftable(table1)
##      1 2 3 4 6 8
##                 
## 0 4  1 2 0 0 0 0
##   6  2 0 0 2 0 0
##   8  0 4 3 5 0 0
## 1 4  4 4 0 0 0 0
##   6  0 0 0 2 1 0
##   8  0 0 0 1 0 1
```



#### Proportions Tables {#proportions}

We can also produce contingency tables that present the proportions (percentages) of each category or combination of categories. To do this we simply feed the frequency tables produced by `table()` to the `prop.table()` function. The following reproduces the previous tables but calculates the proportions rather than counts.


```r
library(magrittr)

# counts for cylinders
table(mtcars$cyl) %>% prop.table()
## 
##       4       6       8 
## 0.34375 0.21875 0.43750

# cross classification counts for cylinders by carburetors
table(mtcars$cyl, mtcars$carb) %>% prop.table()
##    
##           1       2       3       4       6       8
##   4 0.15625 0.18750 0.00000 0.00000 0.00000 0.00000
##   6 0.06250 0.00000 0.00000 0.12500 0.03125 0.00000
##   8 0.00000 0.12500 0.09375 0.18750 0.00000 0.03125

# cross classification of cylinder, carburetors, *and* transmission
table(mtcars$am, mtcars$cyl, mtcars$carb) %>%
  prop.table() %>%
  ftable()
##            1       2       3       4       6       8
##                                                     
## 0 4  0.03125 0.06250 0.00000 0.00000 0.00000 0.00000
##   6  0.06250 0.00000 0.00000 0.06250 0.00000 0.00000
##   8  0.00000 0.12500 0.09375 0.15625 0.00000 0.00000
## 1 4  0.12500 0.12500 0.00000 0.00000 0.00000 0.00000
##   6  0.00000 0.00000 0.00000 0.06250 0.03125 0.00000
##   8  0.00000 0.00000 0.00000 0.03125 0.00000 0.03125
```

You probably noticed something you haven't seen before - `%>%`.  This is called the pipe operator and it is provided by the `magrittr` package.  This simply allows us to pipe an output from one function directly into the next.  You'll learn more about the pipe operator later in this class. In the meantime if you want to learn more about this very useful tool now you can check out the [Simplify Your Code with %>% tutorial](pipe).

We can add `round()` after `prop.table()` to round our values to a specified decimal:


```r
# percentages of observations by cylinders
table(mtcars$cyl) %>% 
  prop.table() %>% 
  round(2)
## 
##    4    6    8 
## 0.34 0.22 0.44

# percentages of observations by cylinders and carburetors
table(mtcars$cyl, mtcars$carb) %>% 
  prop.table() %>% 
  round(2)
##    
##        1    2    3    4    6    8
##   4 0.16 0.19 0.00 0.00 0.00 0.00
##   6 0.06 0.00 0.00 0.12 0.03 0.00
##   8 0.00 0.12 0.09 0.19 0.00 0.03

# percentages of observations by cylinder, carburetors, *and* transmission
table(mtcars$am, mtcars$cyl, mtcars$carb) %>%
  prop.table() %>% 
  round(2) %>%
  ftable()
##         1    2    3    4    6    8
##                                   
## 0 4  0.03 0.06 0.00 0.00 0.00 0.00
##   6  0.06 0.00 0.00 0.06 0.00 0.00
##   8  0.00 0.12 0.09 0.16 0.00 0.00
## 1 4  0.12 0.12 0.00 0.00 0.00 0.00
##   6  0.00 0.00 0.00 0.06 0.03 0.00
##   8  0.00 0.00 0.00 0.03 0.00 0.03
```

#### Margins Tables {#margins}

Margins show the total counts or percentages across columns or rows in a contingency table. For instance, if we go back to the cross classification counts for cylinders and carburetors:


```r
table(mtcars$cyl, mtcars$carb)
##    
##     1 2 3 4 6 8
##   4 5 6 0 0 0 0
##   6 2 0 0 4 1 0
##   8 0 4 3 6 0 1
```

We can compute and add the column and row margins with `addmargins()`


```r
table(mtcars$cyl, mtcars$carb) %>%
  addmargins()
##      
##        1  2  3  4  6  8 Sum
##   4    5  6  0  0  0  0  11
##   6    2  0  0  4  1  0   7
##   8    0  4  3  6  0  1  14
##   Sum  7 10  3 10  1  1  32
```

We may want to understand the marginal distribution by row or column.  For example, we may want to understand what the distribution of observations of cylinders across carburetors.  In other words, for each carburetor level, what percent are 4, 6, and 8 cylinders. We can use the `prop.table` function we saw earlier and incorporate the `margin` argument.  `margin = 2` will provide the distribution of cylinders for each carburetor level.  Here we see that for vehicles with 1 carburetor, 71% are 4 cylinder and 29% are 6 cylinder.


```r
table(mtcars$cyl, mtcars$carb) %>%
  prop.table(margin = 2) %>%
  round(2)
##    
##        1    2    3    4    6    8
##   4 0.71 0.60 0.00 0.00 0.00 0.00
##   6 0.29 0.00 0.00 0.40 1.00 0.00
##   8 0.00 0.40 1.00 0.60 0.00 1.00
```

Alternatively, `margin = 1` will provide the row-wise distribution (i.e. how carburetors are distributed across cylinders). 


```r
table(mtcars$cyl, mtcars$carb) %>%
  prop.table(margin = 1) %>%
  round(2)
##    
##        1    2    3    4    6    8
##   4 0.45 0.55 0.00 0.00 0.00 0.00
##   6 0.29 0.00 0.00 0.57 0.14 0.00
##   8 0.00 0.29 0.21 0.43 0.00 0.07
```

<br>

## Wrapping up

These initial bits of information of your data are primarily for your own benefit.  You do not always report these in your studies in this manner but you should always report the number of variables, what the variables are, how they are coded, the number of observations, and the number of missing values in your data. This is typically done in the *Data Preparation* section of your report (I will be looking for this info in your final report!).

<br>

## Exercises

Using the built-in `airquality` data set, answer the following questions:

1. What are the dimensions of this data set?
2. What are the variable names?
3. What type of data are each variable recorded as?  Can you change the *Month* variable to a factor?
4. How many missing values are in this data set?  Which columns are these missing values concentrated in? Omit all rows with missing observations (reference [Dealing with Missing Values tutorial](missing_values)).
5. What is the mean, median, standard deviation, and 85th percentile for *Temp*?
7. How many observations in the *Temp* variable are beyond 2 standard deviations from the mean?
8. Which *Month*s are represented and how many observations are in each one? Are the percentage of observations in each month approximately equal? 
