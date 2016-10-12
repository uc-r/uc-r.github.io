---
layout: tutorial
title: Learn About the Data
permalink: /data_wrangling/about_the_data
---

Once you have a basic understanding of your source data from the codebook, and once you have imported the data, next you need to start learning the basics of your variables.  To illustrate, let's continue with our `mtcars` data set. This typically includes understanding the number of variables, names of the variables, and number of observations:


```r
# number of variables
ncol(mtcars)
## [1] 11

# names of variables
names(mtcars)
##  [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear"
## [11] "carb"

# number of rows
nrow(mtcars)
## [1] 32

# number of rows and variables
dim(mtcars)
## [1] 32 11
```

We also want to know what type of data each variable is (i.e. numeric, character, etc).  We can do this a couple ways but the easiest way is to use the `str()` function, which displays the **str**ucture of the data. `str()` is very convenient because it will also provide the number of observations, number of variables, the name of each variable, the type of data each variable is, and will also display the first several observations to give you a taste of the data.  In this example all variables are numeric (indicated by "num" listed after the variable names).


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

We may also want to check out the first or last *n* rows of the data set. In addition to using `head()` and `tail()` to look at the first and last *n* rows, you can use `View(mtcars)` to display the entire `mtcars` data set in a spreadsheet viewer.


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

Lastly, before we start looking at statistical summaries of the data, we want to understand if we have any missing observations.  The `is.na()` function will return TRUE or FALSE for each cell in the `mtcars` data frame stating whether or not it is a missing value. This allows us to identify how many missing values are in our data by wrapping `is.na()` with `sum()` (in R TRUE = 1 and FALSE = 0):


```r
# get the count of missing values in the data set
sum(is.na(mtcars))
## [1] 0
```

In this example we have no missing values. However, if we did have missing values we may want to recode or omit them.  To manage missing values read the short tutorial on *[Dealing with missing values](http://uc-r.github.io/missing_values)*.

Ok, so now we should have a pretty good understanding of the basic structure of our data. Next, we need to start understanding some descriptive statistics of our data. The easiest way to get a good summary of all our variables is with the `summary()` function:


```r
summary(mtcars)
##       mpg             cyl             disp             hp       
##  Min.   :10.40   Min.   :4.000   Min.   : 71.1   Min.   : 52.0  
##  1st Qu.:15.43   1st Qu.:4.000   1st Qu.:120.8   1st Qu.: 96.5  
##  Median :19.20   Median :6.000   Median :196.3   Median :123.0  
##  Mean   :20.09   Mean   :6.188   Mean   :230.7   Mean   :146.7  
##  3rd Qu.:22.80   3rd Qu.:8.000   3rd Qu.:326.0   3rd Qu.:180.0  
##  Max.   :33.90   Max.   :8.000   Max.   :472.0   Max.   :335.0  
##       drat             wt             qsec             vs        
##  Min.   :2.760   Min.   :1.513   Min.   :14.50   Min.   :0.0000  
##  1st Qu.:3.080   1st Qu.:2.581   1st Qu.:16.89   1st Qu.:0.0000  
##  Median :3.695   Median :3.325   Median :17.71   Median :0.0000  
##  Mean   :3.597   Mean   :3.217   Mean   :17.85   Mean   :0.4375  
##  3rd Qu.:3.920   3rd Qu.:3.610   3rd Qu.:18.90   3rd Qu.:1.0000  
##  Max.   :4.930   Max.   :5.424   Max.   :22.90   Max.   :1.0000  
##        am              gear            carb      
##  Min.   :0.0000   Min.   :3.000   Min.   :1.000  
##  1st Qu.:0.0000   1st Qu.:3.000   1st Qu.:2.000  
##  Median :0.0000   Median :4.000   Median :2.000  
##  Mean   :0.4062   Mean   :3.688   Mean   :2.812  
##  3rd Qu.:1.0000   3rd Qu.:4.000   3rd Qu.:4.000  
##  Max.   :1.0000   Max.   :5.000   Max.   :8.000
```

However, you may notice something. According to the codebook (`?mtcars`) the `cyl`, `vs`, `gear`, and `carb` are not necessarily continuous variables. These variables are categorical variables (we'll get into this more later in the class) where:

- `cyl` is the number of cylinders (4 , 6, or 8)
- `vs` represents a V-engine (0) or straight engine (1)
- `gear` is the number of gears (3, 4, or 5)
- `carb` is the number of carburetors (1, 2, 3, 4, 6, or 8)

To get a better summary of these variables we can grab a single variable using the dollar sign `$` and then use `table()` to get a total count of observations at each categorical level:


```r
table(mtcars$cyl)
## 
##  4  6  8 
## 11  7 14

table(mtcars$vs)
## 
##  0  1 
## 18 14

table(mtcars$gear)
## 
##  3  4  5 
## 15 12  5

table(mtcars$carb)
## 
##  1  2  3  4  6  8 
##  7 10  3 10  1  1
```

Alternatively, we can change these variables from continuous to categorical. In R, categorical variables are considered "factors" and to change these variables to factors we simply apply the `factor()` function. If you are not familiar with the different data types (numericals, characters, factors, dates) don't worry, we'll get into the details behind these in later classes.  For now, just realize if we change the `cyl`, `vs`, `gear`, and `carb` variables to factors and then run `summary()` again you can see that a more meaningful summary of these variables is provided.


```r
# change variables from numerics to factors
mtcars$cyl <- factor(mtcars$cyl)
mtcars$vs <- factor(mtcars$vs)
mtcars$gear <- factor(mtcars$gear)
mtcars$carb <- factor(mtcars$carb)

summary(mtcars)
##       mpg        cyl         disp             hp             drat      
##  Min.   :10.40   4:11   Min.   : 71.1   Min.   : 52.0   Min.   :2.760  
##  1st Qu.:15.43   6: 7   1st Qu.:120.8   1st Qu.: 96.5   1st Qu.:3.080  
##  Median :19.20   8:14   Median :196.3   Median :123.0   Median :3.695  
##  Mean   :20.09          Mean   :230.7   Mean   :146.7   Mean   :3.597  
##  3rd Qu.:22.80          3rd Qu.:326.0   3rd Qu.:180.0   3rd Qu.:3.920  
##  Max.   :33.90          Max.   :472.0   Max.   :335.0   Max.   :4.930  
##        wt             qsec       vs           am         gear   carb  
##  Min.   :1.513   Min.   :14.50   0:18   Min.   :0.0000   3:15   1: 7  
##  1st Qu.:2.581   1st Qu.:16.89   1:14   1st Qu.:0.0000   4:12   2:10  
##  Median :3.325   Median :17.71          Median :0.0000   5: 5   3: 3  
##  Mean   :3.217   Mean   :17.85          Mean   :0.4062          4:10  
##  3rd Qu.:3.610   3rd Qu.:18.90          3rd Qu.:1.0000          6: 1  
##  Max.   :5.424   Max.   :22.90          Max.   :1.0000          8: 1
```
