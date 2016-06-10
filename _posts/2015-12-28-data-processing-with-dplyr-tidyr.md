---
layout: post
title:  Data Processing with dplyr & tidyr
date: 2015-09-07
author: Bradley Boehmke
published: true
tags: [r, data-wrangling, dplyr, tidyr]
categories: [programming]
---

> It is often said that 80% of data analysis is spent on the process of cleaning and preparing the data. (Dasu and Johnson, 2003)

Although many fundamental data processing functions exist in R, they have been a bit convoluted to date and have lacked consistent coding and the ability to easily flow together. [R Studio](https://www.rstudio.com/) is driving a lot of new packages to collate data management tasks and better integrate them with other analysis activities. As a result, a lot of data processing tasks are becoming packaged in more cohesive and consistent ways which leads to more efficient code and easier to read syntax. This post covers two of these packages: `tidyr` & `dplyr`.
<!--more-->

The `tidyr` and `dplyr` packages provide fundamental functions for cleaning, processing, & manipulating data. [`tidyr`](https://cran.r-project.org/web/packages/tidyr/index.html) is a package built for the sole purpose of simplifying the process of creating [tidy data](http://vita.had.co.nz/papers/tidy-data.html). In this tutorial I'll provides you with the basic understanding of the four fundamental functions of data tidying that tidyr provides:

* <a href="#gather">`gather()`</a>
* <a href="#spread">`spread()`</a>
* <a href="#separate">`separate()`</a>
* <a href="#unite">`unite()`</a>

[`dplyr`](https://cran.r-project.org/web/packages/dplyr/index.html) is a package built for muliple purposes but with a focus on the process of manipulating, sorting, summarizing, and joining data frames. In this tutorial I'll introduce you to the basic data transformation functions offered by the dplyr package:

* <a href="#select">`select()`</a>
* <a href="#filter">`filter()`</a>
* <a href="#group">`group_by()`</a>
* <a href="#summarise">`summarise()`</a>
* <a href="#arrange">`arrange()`</a>
* <a href="#join">`join()`</a>
* <a href="#mutate">`mutate()`</a>

But prior to jumping into these packages and functions we'll first take a detour to introduce a simple little mechanism that `tidyr` and `dplyr` leverage that is transforming the way we read and write code. 

<center><hr width="50%"></center>

<br>

## <u>%>% Operator</u>
Although not required, the tidyr and dplyr packages make use of the pipe operator `%>%` developed by [Stefan Milton Bache](https://twitter.com/stefanbache) in the R package [magrittr](http://cran.r-project.org/web/packages/magrittr/magrittr.pdf).  Although all the functions in tidyr and dplyr *can be used without the pipe operator*, one of the great conveniences these packages provide is the ability to string multiple functions together by incorporating `%>%`.

This operator will forward a value, or the result of an expression, into the next function call/expression.  For instance a function to filter data can be written as:

<center>filter(data, variable == <em>numeric_value</em>)</center>

<center><em><u>or</u></em></center>

<center>data %>% filter(variable == <em>numeric_value</em>)</center>

<br>

Both functions complete the same task and the benefit of using `%>%` is not evident; however, when you desire to perform multiple functions its advantage becomes obvious.  For instance, if we want to filter some data, summarize it, and then order the summarized results we would write it out as:

&nbsp;&nbsp;<u>Nested Option:</u>

&nbsp;&nbsp;&nbsp;&nbsp;arrange(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;summarize(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;filter(data, variable == *numeric_value*),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Total = sum(variable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;desc(Total)<br>
&nbsp;&nbsp;&nbsp;&nbsp;)

<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*<u>or</u>*
<br>

&nbsp;&nbsp;<u>Multiple Object Option:</u>

&nbsp;&nbsp;&nbsp;&nbsp;  a <- filter(data, variable == *numeric_value*)<br>
&nbsp;&nbsp;&nbsp;&nbsp;  b <- summarise(a, Total = sum(variable))<br>
&nbsp;&nbsp;&nbsp;&nbsp;  c <- arrange(b, desc(Total))<br>

<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*<u>or</u>*
<br>

&nbsp;&nbsp;<u>%>% Option:</u>

&nbsp;&nbsp;&nbsp;&nbsp; data %>%<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;filter(variable == "value") %>%<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;summarise(Total = sum(variable)) %>%<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arrange(desc(Total))

<br>

As your function tasks get longer the `%>%` operator becomes more efficient *<u>and</u>* makes your code more legible.  In addition, although not covered in this tutorial, the `%>%` operator allows you to flow from data manipulation tasks straight into vizualization functions *(via ggplot and ggvis)* and also into many analytic functions.

To learn more about the `%>%` operator and the magrittr package visit any of the following:

- [http://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html](http://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html)
- [http://www.r-bloggers.com/simpler-r-coding-with-pipes-the-present-and-future-of-the-magrittr-package/](http://www.r-bloggers.com/simpler-r-coding-with-pipes-the-present-and-future-of-the-magrittr-package/)
- [http://blog.revolutionanalytics.com/2014/07/magrittr-simplifying-r-code-with-pipes.html](http://blog.revolutionanalytics.com/2014/07/magrittr-simplifying-r-code-with-pipes.html)

<br>

<a href="#">Go to top</a>

<center><hr width="50%"></center>

<br>

## <u>tidyr Operations</u>

There are four fundamental functions of data tidying:

* <a href="#gather">`gather()`</a> takes multiple columns, and gathers them into key-value pairs: it makes “wide” data longer
* <a href="#spread">`spread()`</a> takes two columns (key & value) and spreads in to multiple columns, it makes “long” data wider
* <a href="#separate">`separate()`</a> splits a single column into multiple columns
* <a href="#unite">`unite()`</a> combines multiple columns into a single column

<br><br>

<a id="gather"> </a>

### <u>gather( ) function</u>: 
**Objective:** Reshaping wide format to long format

**Description:** There are times when our data is considered unstacked and a common attribute of concern is spread out across columns.  To reformat the data such that these common attributes are *gathered* together as a single variable, the `gather()` function will take multiple columns and collapse them into key-value pairs, duplicating all other columns as needed.

**Complement to:**  <a href="#spread">`spread()`</a>



{% highlight r %}
Function:       gather(data, key, value, ..., na.rm = FALSE, convert = FALSE)
Same as:        data %>% gather(key, value, ..., na.rm = FALSE, convert = FALSE)

Arguments:
        data:           data frame
        key:            column name representing new variable
        value:          column name representing variable values
        ...:            names of columns to gather (or not gather)
        na.rm:          option to remove observations with missing values (represented by NAs)
        convert:        if TRUE will automatically convert values to logical, integer, numeric, complex or 
                        factor as appropriate
{% endhighlight %}

<br>

**Example**

We'll start with the following data set:

{% highlight text %}
## Source: local data frame [12 x 6]
## 
##    Group  Year Qtr.1 Qtr.2 Qtr.3 Qtr.4
##    (int) (int) (int) (int) (int) (int)
## 1      1  2006    15    16    19    17
## 2      1  2007    12    13    27    23
## 3      1  2008    22    22    24    20
## 4      1  2009    10    14    20    16
## 5      2  2006    12    13    25    18
## 6      2  2007    16    14    21    19
## 7      2  2008    13    11    29    15
## 8      2  2009    23    20    26    20
## 9      3  2006    11    12    22    16
## 10     3  2007    13    11    27    21
## 11     3  2008    17    12    23    19
## 12     3  2009    14     9    31    24
{% endhighlight %}


<br>

This data is considered wide since the *<u>time</u>* variable (represented as quarters) is structured such that each quarter represents a variable. To re-structure the time component as an individual variable, we can *gather* each quarter within one column variable and also *gather* the values associated with each quarter in a second column variable.


{% highlight r %}
long_DF <- DF %>% gather(Quarter, Revenue, Qtr.1:Qtr.4)
head(long_DF, 24)  # note, for brevity, I only show the data for the first two years 
{% endhighlight %}



{% highlight text %}
## Source: local data frame [24 x 4]
## 
##    Group  Year Quarter Revenue
##    (int) (int)  (fctr)   (int)
## 1      1  2006   Qtr.1      15
## 2      1  2007   Qtr.1      12
## 3      1  2008   Qtr.1      22
## 4      1  2009   Qtr.1      10
## 5      2  2006   Qtr.1      12
## 6      2  2007   Qtr.1      16
## 7      2  2008   Qtr.1      13
## 8      2  2009   Qtr.1      23
## 9      3  2006   Qtr.1      11
## 10     3  2007   Qtr.1      13
## ..   ...   ...     ...     ...
{% endhighlight %}



{% highlight r %}
These all produce the same results:
        DF %>% gather(Quarter, Revenue, Qtr.1:Qtr.4)
        DF %>% gather(Quarter, Revenue, -Group, -Year)
        DF %>% gather(Quarter, Revenue, 3:6)
        DF %>% gather(Quarter, Revenue, Qtr.1, Qtr.2, Qtr.3, Qtr.4)

Also note that if you do not supply arguments for na.rm or convert values then the defaults are used
{% endhighlight %}

<a href="#">Go to top</a>

<br>
<a id="separate"> </a>

### <u>separate( ) function</u>: 
**Objective:** Splitting a single variable into two

**Description:** Many times a single column variable will capture multiple variables, or even parts of a variable you just don't care about.  Some examples include:


{% highlight text %}
##   Grp_Ind    Yr_Mo       City_State        First_Last Extra_variable
## 1     1.a 2006_Jan      Dayton (OH) George Washington   XX01person_1
## 2     1.b 2006_Feb Grand Forks (ND)        John Adams   XX02person_2
## 3     1.c 2006_Mar       Fargo (ND)  Thomas Jefferson   XX03person_3
## 4     2.a 2007_Jan   Rochester (MN)     James Madison   XX04person_4
## 5     2.b 2007_Feb     Dubuque (IA)      James Monroe   XX05person_5
## 6     2.c 2007_Mar Ft. Collins (CO)        John Adams   XX06person_6
## 7     3.a 2008_Jan   Lake City (MN)    Andrew Jackson   XX07person_7
## 8     3.b 2008_Feb    Rushford (MN)  Martin Van Buren   XX08person_8
## 9     3.c 2008_Mar          Unknown  William Harrison   XX09person_9
{% endhighlight %}

<br>

In each of these cases, our objective may be to *separate* characters within the variable string. This can be accomplished using the `separate()` function which turns a single character column into multiple columns.

**Complement to:** <a href="#unite">`unite()`</a>


{% highlight r %}
Function:       separate(data, col, into, sep = " ", remove = TRUE, convert = FALSE)
Same as:        data %>% separate(col, into, sep = " ", remove = TRUE, convert = FALSE)

Arguments:
        data:           data frame
        col:            column name representing current variable
        into:           names of variables representing new variables
        sep:            how to separate current variable (char, num, or symbol)
        remove:         if TRUE, remove input column from output data frame
        convert:        if TRUE will automatically convert values to logical, integer, numeric, complex or 
                        factor as appropriate
{% endhighlight %}


**Example**

We can go back to our **long_DF** dataframe we created above in which way may desire to clean up or separate the *Quarter* variable.

{% highlight text %}
## Source: local data frame [6 x 4]
## 
##   Group  Year Quarter Revenue
##   (int) (int)  (fctr)   (int)
## 1     1  2006   Qtr.1      15
## 2     1  2007   Qtr.1      12
## 3     1  2008   Qtr.1      22
## 4     1  2009   Qtr.1      10
## 5     2  2006   Qtr.1      12
## 6     2  2007   Qtr.1      16
{% endhighlight %}

<br>

By applying the `separate()` function we get the following:

{% highlight r %}
separate_DF <- long_DF %>% separate(Quarter, c("Time_Interval", "Interval_ID"))
head(separate_DF, 10)
{% endhighlight %}



{% highlight text %}
## Source: local data frame [10 x 5]
## 
##    Group  Year Time_Interval Interval_ID Revenue
##    (int) (int)         (chr)       (chr)   (int)
## 1      1  2006           Qtr           1      15
## 2      1  2007           Qtr           1      12
## 3      1  2008           Qtr           1      22
## 4      1  2009           Qtr           1      10
## 5      2  2006           Qtr           1      12
## 6      2  2007           Qtr           1      16
## 7      2  2008           Qtr           1      13
## 8      2  2009           Qtr           1      23
## 9      3  2006           Qtr           1      11
## 10     3  2007           Qtr           1      13
{% endhighlight %}


{% highlight r %}
These produce the same results:
        long_DF %>% separate(Quarter, c("Time_Interval", "Interval_ID"))
        long_DF %>% separate(Quarter, c("Time_Interval", "Interval_ID"), sep = "\\.")
{% endhighlight %}

<a href="#">Go to top</a>

<br>
<a id="unite"> </a>

### <u>unite( ) function</u>: 
**Objective:** Merging two variables into one

**Description:** There may be a time in which we would like to combine the values of two variables.  The `unite()` function is a convenience function to paste together multiple variable values into one.  In essence, it combines two variables of a single observation into one variable.

**Complement to:**  <a href="#separate">`separate()`</a>


{% highlight r %}
Function:       unite(data, col, ..., sep = " ", remove = TRUE)
Same as:        data %>% unite(col, ..., sep = " ", remove = TRUE)

Arguments:
        data:           data frame
        col:            column name of new "merged" column
        ...:            names of columns to merge
        sep:            separator to use between merged values
        remove:         if TRUE, remove input column from output data frame
{% endhighlight %}

<br>

**Example**

Using the **separate_DF** dataframe we created above, we can re-unite the *Time_Interval* and *Interval_ID* variables we created and re-create the original *Quarter* variable we had in the **long_DF** dataframe.


{% highlight r %}
unite_DF <- separate_DF %>% unite(Quarter, Time_Interval, Interval_ID, sep = ".")
head(unite_DF, 10)
{% endhighlight %}



{% highlight text %}
## Source: local data frame [10 x 4]
## 
##    Group  Year Quarter Revenue
##    (int) (int)   (chr)   (int)
## 1      1  2006   Qtr.1      15
## 2      1  2007   Qtr.1      12
## 3      1  2008   Qtr.1      22
## 4      1  2009   Qtr.1      10
## 5      2  2006   Qtr.1      12
## 6      2  2007   Qtr.1      16
## 7      2  2008   Qtr.1      13
## 8      2  2009   Qtr.1      23
## 9      3  2006   Qtr.1      11
## 10     3  2007   Qtr.1      13
{% endhighlight %}


{% highlight r %}
These produce the same results:
        separate_DF %>% unite(Quarter, Time_Interval, Interval_ID, sep = "_")
        separate_DF %>% unite(Quarter, Time_Interval, Interval_ID)

If no spearator is identified, "_" will automatically be used
{% endhighlight %}

<a href="#">Go to top</a>

<br>
<a id="spread"> </a>

### <u>spread( ) function</u>: 

**Objective:** Reshaping long format to wide format

**Description:** There are times when we are required to turn long formatted data into wide formatted data.  The `spread()` function spreads a key-value pair across multiple columns.

**Complement to:** <a href="#gather">`gather()`</a>


{% highlight r %}
Function:       spread(data, key, value, fill = NA, convert = FALSE)
Same as:        data %>% spread(key, value, fill = NA, convert = FALSE)

Arguments:
        data:           data frame
        key:            column values to convert to multiple columns
        value:          single column values to convert to multiple columns' values 
        fill:           If there isn't a value for every combination of the other variables and the key 
                        column, this value will be substituted
        convert:        if TRUE will automatically convert values to logical, integer, numeric, complex or 
                        factor as appropriate
{% endhighlight %}

**Example**


{% highlight r %}
wide_DF <- unite_DF %>% spread(Quarter, Revenue)
head(wide_DF, 24)
{% endhighlight %}



{% highlight text %}
## Source: local data frame [12 x 6]
## 
##    Group  Year Qtr.1 Qtr.2 Qtr.3 Qtr.4
##    (int) (int) (int) (int) (int) (int)
## 1      1  2006    15    16    19    17
## 2      1  2007    12    13    27    23
## 3      1  2008    22    22    24    20
## 4      1  2009    10    14    20    16
## 5      2  2006    12    13    25    18
## 6      2  2007    16    14    21    19
## 7      2  2008    13    11    29    15
## 8      2  2009    23    20    26    20
## 9      3  2006    11    12    22    16
## 10     3  2007    13    11    27    21
## 11     3  2008    17    12    23    19
## 12     3  2009    14     9    31    24
{% endhighlight %}

<a href="#">Go to top</a>

<center><hr width="50%"></center>

<br>

## <u>dplyr Operations</u>

There are seven fundamental functions of data transformation:

* <a href="#select">`select()`</a> selecting variables
* <a href="#filter">`filter()`</a> provides basic filtering capabilities
* <a href="#group">`group_by()`</a> groups data by categorical levels
* <a href="#summarise">`summarise()`</a> summarise data by functions of choice
* <a href="#arrange">`arrange()`</a> ordering data
* <a href="#join">`join()`</a> joining separate dataframes
* <a href="#mutate">`mutate()`</a> create new variables

<br>

For these examples we'll use the following [census data](http://www.census.gov/en.html) which includes the K-12 public school expenditures by state.  This dataframe currently is 50x16 and includes expenditure data for 14 unique years.

Left half of data:

{% highlight text %}
## Warning in left_join_impl(x, y, by$x, by$y): joining factor and
## character vector, coercing into character vector
{% endhighlight %}



{% highlight text %}
##   Division      State   X1980    X1990    X2000    X2001    X2002
## 1        6    Alabama 1146713  2275233  4176082  4354794  4444390
## 2        9     Alaska  377947   828051  1183499  1229036  1284854
## 3        8    Arizona  949753  2258660  4288739  4846105  5395814
## 4        7   Arkansas  666949  1404545  2380331  2505179  2822877
## 5        9 California 9172158 21485782 38129479 42908787 46265544
## 6        8   Colorado 1243049  2451833  4401010  4758173  5151003
##      X2003
## 1  4657643
## 2  1326226
## 3  5892227
## 4  2923401
## 5 47983402
## 6  5551506
{% endhighlight %}

Right half of data:

{% highlight text %}
##      X2004    X2005    X2006    X2007    X2008    X2009    X2010
## 1  4812479  5164406  5699076  6245031  6832439  6683843  6670517
## 2  1354846  1442269  1529645  1634316  1918375  2007319  2084019
## 3  6071785  6579957  7130341  7815720  8403221  8726755  8482552
## 4  3109644  3546999  3808011  3997701  4156368  4240839  4459910
## 5 49215866 50918654 53436103 57352599 61570555 60080929 58248662
## 6  5666191  5994440  6368289  6579053  7338766  7187267  7429302
##      X2011
## 1  6592925
## 2  2201270
## 3  8340211
## 4  4578136
## 5 57526835
## 6  7409462
{% endhighlight %}

<a href="#">Go to top</a>

<br>
<a id="select"> </a>

### <u>select( ) function</u>: 
**Objective:** Reduce dataframe size to only desired variables for current task

**Description:** When working with a sizable dataframe, often we desire to only assess specific variables.  The `select()` function allows you to select and/or rename variables.


{% highlight r %}
Function:       select(data, ...)
Same as:        data %>% select(...)

Arguments:
        data:           data frame
        ...:            call variables by name or by function

Special functions:
        starts_with(x, ignore.case = TRUE): names starts with x
        ends_with(x, ignore.case = TRUE):   names ends in x
        contains(x, ignore.case = TRUE):    selects all variables whose name contains x
        matches(x, ignore.case = TRUE):     selects all variables whose name matches the regular expression x
{% endhighlight %}

**Example**
Let's say our goal is to only assess the 5 most recent years worth of expenditure data.  Applying the `select()` function we can *select* only the variables of concern. 


{% highlight r %}
sub.exp <- expenditures %>% select(Division, State, X2007:X2011)
head(sub.exp)  # for brevity only display first 6 rows
{% endhighlight %}



{% highlight text %}
##   Division      State    X2007    X2008    X2009    X2010    X2011
## 1        6    Alabama  6245031  6832439  6683843  6670517  6592925
## 2        9     Alaska  1634316  1918375  2007319  2084019  2201270
## 3        8    Arizona  7815720  8403221  8726755  8482552  8340211
## 4        7   Arkansas  3997701  4156368  4240839  4459910  4578136
## 5        9 California 57352599 61570555 60080929 58248662 57526835
## 6        8   Colorado  6579053  7338766  7187267  7429302  7409462
{% endhighlight %}

<br>

We can also apply some of the special functions within `select()`. For instance we can select all variables that start with 'X':


{% highlight r %}
head(expenditures %>% select(starts_with("X")))
{% endhighlight %}



{% highlight text %}
##     X1980    X1990    X2000    X2001    X2002    X2003    X2004
## 1 1146713  2275233  4176082  4354794  4444390  4657643  4812479
## 2  377947   828051  1183499  1229036  1284854  1326226  1354846
## 3  949753  2258660  4288739  4846105  5395814  5892227  6071785
## 4  666949  1404545  2380331  2505179  2822877  2923401  3109644
## 5 9172158 21485782 38129479 42908787 46265544 47983402 49215866
## 6 1243049  2451833  4401010  4758173  5151003  5551506  5666191
##      X2005    X2006    X2007    X2008    X2009    X2010    X2011
## 1  5164406  5699076  6245031  6832439  6683843  6670517  6592925
## 2  1442269  1529645  1634316  1918375  2007319  2084019  2201270
## 3  6579957  7130341  7815720  8403221  8726755  8482552  8340211
## 4  3546999  3808011  3997701  4156368  4240839  4459910  4578136
## 5 50918654 53436103 57352599 61570555 60080929 58248662 57526835
## 6  5994440  6368289  6579053  7338766  7187267  7429302  7409462
{% endhighlight %}



{% highlight r %}
You can also de-select variables by using "-" prior to name or function.  The following produces the inverse of functions above
        expenditures %>% select(-X1980:-X2006)
        expenditures %>% select(-starts_with("X"))
{% endhighlight %}

<a href="#">Go to top</a>

<br>
<a id="filter"> </a>

### <u>filter( ) function</u>: 
**Objective:** Reduce rows/observations with matching conditions

**Description:** Filtering data is a common task to identify/select observations in which a particular variable matches a specific value/condition. The `filter()` function provides this capability. 


{% highlight r %}
Function:       filter(data, ...)
Same as:        data %>% filter(...)

Arguments:
        data:           data frame
        ...:            conditions to be met
{% endhighlight %}

<br>

**Examples**

Continuing with our **sub.exp** dataframe which includes only the recent 5 years worth of expenditures, we can filter by *Division*:

{% highlight r %}
sub.exp %>% filter(Division == 3)
{% endhighlight %}



{% highlight text %}
##   Division     State    X2007    X2008    X2009    X2010    X2011
## 1        3  Illinois 20326591 21874484 23495271 24695773 24554467
## 2        3   Indiana  9497077  9281709  9680895  9921243  9687949
## 3        3  Michigan 17013259 17053521 17217584 17227515 16786444
## 4        3      Ohio 18251361 18892374 19387318 19801670 19988921
## 5        3 Wisconsin  9029660  9366134  9696228  9966244 10333016
{% endhighlight %}

<br>

We can apply multiple logic rules in the `filter()` function such as:

{% highlight r %}
<   Less than                    !=      Not equal to
>   Greater than                 %in%    Group membership
==  Equal to                     is.na   is NA
<=  Less than or equal to        !is.na  is not NA
>=  Greater than or equal to     &,|,!   Boolean operators
{% endhighlight %}

<br>

For instance, we can filter for Division 3 and expenditures in 2011 that were greater than $10B.  This results in Indiana, which is in Division 3, being excluded since its expenditures were < $10B *(FYI - the raw census data are reported in units of $1,000)*.


{% highlight r %}
sub.exp %>% filter(Division == 3, X2011 > 10000000)  # Raw census data are in units of $1,000
{% endhighlight %}



{% highlight text %}
##   Division     State    X2007    X2008    X2009    X2010    X2011
## 1        3  Illinois 20326591 21874484 23495271 24695773 24554467
## 2        3  Michigan 17013259 17053521 17217584 17227515 16786444
## 3        3      Ohio 18251361 18892374 19387318 19801670 19988921
## 4        3 Wisconsin  9029660  9366134  9696228  9966244 10333016
{% endhighlight %}

<a href="#">Go to top</a>

<br>
<a id="group"> </a>

### <u>group_by( ) function</u>: 
**Objective:** Group data by categorical variables

**Description:** Often, observations are nested within groups or categories and our goals is to perform statistical analysis both at the observation level and also at the group level.  The `group_by()` function allows us to create these categorical groupings.


{% highlight r %}
Function:       group_by(data, ...)
Same as:        data %>% group_by(...)

Arguments:
        data:           data frame
        ...:            variables to group_by

*Use ungroup(x) to remove groups
{% endhighlight %}

<br>

**Example**
The `group_by()` function is a *silent* function in which no observable manipulation of the data is performed as a result of applying the function.  Rather, the only change you'll notice is, if you print the dataframe you will notice underneath the *Source* information and prior to the actual dataframe, an indicator of what variable the data is grouped by will be provided. The real magic of the `group_by()` function comes when we perform summary statistics which we will cover shortly. 


{% highlight r %}
group.exp <- sub.exp %>% group_by(Division)

head(group.exp)
{% endhighlight %}



{% highlight text %}
## Source: local data frame [6 x 7]
## Groups: Division [4]
## 
##   Division      State    X2007    X2008    X2009    X2010    X2011
##      (int)      (chr)    (int)    (int)    (int)    (int)    (int)
## 1        6    Alabama  6245031  6832439  6683843  6670517  6592925
## 2        9     Alaska  1634316  1918375  2007319  2084019  2201270
## 3        8    Arizona  7815720  8403221  8726755  8482552  8340211
## 4        7   Arkansas  3997701  4156368  4240839  4459910  4578136
## 5        9 California 57352599 61570555 60080929 58248662 57526835
## 6        8   Colorado  6579053  7338766  7187267  7429302  7409462
{% endhighlight %}

<a href="#">Go to top</a>

<br>
<a id="summarise"> </a>

### <u>summarise( ) function</u>:
**Objective:** Perform summary statistics on variables

**Description:** Obviously the goal of all this data *wrangling* is to be able to perform statistical analysis on our data.  The `summarise()` function allows us to perform the majority of the initial summary statistics when performing exploratory data analysis.


{% highlight r %}
Function:       summarise(data, ...)
Same as:        data %>% summarise(...)

Arguments:
        data:           data frame
        ...:            Name-value pairs of summary functions like min(), mean(), max() etc.

*Developer is from New Zealand...can use "summarise(x)" or "summarize(x)"
{% endhighlight %}

<br>

**Examples**

Lets get the mean expenditure value across all states in 2011

{% highlight r %}
sub.exp %>% summarise(Mean_2011 = mean(X2011))
{% endhighlight %}



{% highlight text %}
##   Mean_2011
## 1  10513678
{% endhighlight %}


Not too bad, lets get some more summary stats

{% highlight r %}
sub.exp %>% summarise(Min = min(X2011, na.rm=TRUE),
                     Median = median(X2011, na.rm=TRUE),
                     Mean = mean(X2011, na.rm=TRUE),
                     Var = var(X2011, na.rm=TRUE),
                     SD = sd(X2011, na.rm=TRUE),
                     Max = max(X2011, na.rm=TRUE),
                     N = n())
{% endhighlight %}



{% highlight text %}
##       Min  Median     Mean         Var       SD      Max  N
## 1 1049772 6527404 10513678 1.48619e+14 12190938 57526835 50
{% endhighlight %}


This information is useful, but being able to compare summary statistics at multiple levels is when you really start to gather some insights.  This is where the `group_by()` function comes in.  First, let's group by *Division* and see how the different regions compared in by 2010 and 2011.

{% highlight r %}
sub.exp %>%
        group_by(Division)%>% 
        summarise(Mean_2010 = mean(X2010, na.rm=TRUE),
                  Mean_2011 = mean(X2011, na.rm=TRUE))
{% endhighlight %}



{% highlight text %}
## Source: local data frame [9 x 3]
## 
##   Division Mean_2010 Mean_2011
##      (int)     (dbl)     (dbl)
## 1        1   5121003   5222277
## 2        2  32415457  32877923
## 3        3  16322489  16270159
## 4        4   4672332   4672687
## 5        5  10975194  11023526
## 6        6   6161967   6267490
## 7        7  14916843  15000139
## 8        8   3894003   3882159
## 9        9  15540681  15468173
{% endhighlight %}


Now we're starting to see some differences pop out.  How about we compare states within a Division?  We can start to apply multiple functions we've learned so far to get the 5 year average for each state within Division 3.

{% highlight r %}
sub.exp %>%
        gather(Year, Expenditure, X2007:X2011) %>%   # this turns our wide data to a long format
        filter(Division == 3) %>%                    # we only want to compare states within Division 3
        group_by(State) %>%                          # we want to summarize data at the state level
        summarise(Mean = mean(Expenditure),
                  SD = sd(Expenditure))
{% endhighlight %}



{% highlight text %}
## Source: local data frame [5 x 3]
## 
##       State     Mean        SD
##       (chr)    (dbl)     (dbl)
## 1  Illinois 22989317 1867527.7
## 2   Indiana  9613775  238971.6
## 3  Michigan 17059665  180245.0
## 4      Ohio 19264329  705930.2
## 5 Wisconsin  9678256  507461.2
{% endhighlight %}

<a href="#">Go to top</a>

<br>
<a id="arrange"> </a>

### <u>arrange( ) function</u>: 
**Objective:** Order variable values

**Description:**  Often, we desire to view observations in rank order for a particular variable(s). The `arrange()` function allows us to order data by variables in accending or descending order.


{% highlight r %}
Function:       arrange(data, ...)
Same as:        data %>% arrange(...)

Arguments:
        data:           data frame
        ...:            Variable(s) to order

*use desc(x) to sort variable in descending order
{% endhighlight %}

<br>

**Examples**

For instance, in the summarise example we compared the the mean expenditures for each division. We could apply the `arrange()` function at the end to order the divisions from lowest to highest expenditure for 2011.  This makes it easier to see the significant differences between Divisions 8,4,1 & 6 as compared to Divisions 5,7,9,3 & 2.


{% highlight r %}
sub.exp %>%
        group_by(Division)%>% 
        summarise(Mean_2010 = mean(X2010, na.rm=TRUE),
                  Mean_2011 = mean(X2011, na.rm=TRUE)) %>%
        arrange(Mean_2011)
{% endhighlight %}



{% highlight text %}
## Source: local data frame [9 x 3]
## 
##   Division Mean_2010 Mean_2011
##      (int)     (dbl)     (dbl)
## 1        8   3894003   3882159
## 2        4   4672332   4672687
## 3        1   5121003   5222277
## 4        6   6161967   6267490
## 5        5  10975194  11023526
## 6        7  14916843  15000139
## 7        9  15540681  15468173
## 8        3  16322489  16270159
## 9        2  32415457  32877923
{% endhighlight %}


We can also apply an *descending* argument to rank-order from highest to lowest.  The following shows the same data but in descending order by applying `desc()` within the `arrange()` function.

{% highlight r %}
sub.exp %>%
        group_by(Division)%>% 
        summarise(Mean_2010 = mean(X2010, na.rm=TRUE),
                  Mean_2011 = mean(X2011, na.rm=TRUE)) %>%
        arrange(desc(Mean_2011))
{% endhighlight %}



{% highlight text %}
## Source: local data frame [9 x 3]
## 
##   Division Mean_2010 Mean_2011
##      (int)     (dbl)     (dbl)
## 1        2  32415457  32877923
## 2        3  16322489  16270159
## 3        9  15540681  15468173
## 4        7  14916843  15000139
## 5        5  10975194  11023526
## 6        6   6161967   6267490
## 7        1   5121003   5222277
## 8        4   4672332   4672687
## 9        8   3894003   3882159
{% endhighlight %}


<a href="#">Go to top</a>

<br>
<a id="join"> </a>

### <u>join( ) functions</u>: 
**Objective:** Join two datasets together

**Description:** Often we have separate dataframes that can have common and differing variables for similar observations and we wish to *join* these dataframes together.  The multiple `xxx_join()` functions provide multiple ways to join dataframes.


{% highlight r %}
Description:    Join two datasets

Function:       
                inner_join(x, y, by = NULL)
                left_join(x, y, by = NULL)
                semi_join(x, y, by = NULL)
                anti_join(x, y, by = NULL)

Arguments:
        x,y:           data frames to join
        by:            a character vector of variables to join by. If NULL, the default, join will do a natural join, using all 
                        variables with common names across the two tables.
{% endhighlight %}

<br>

**Example**

Our public education expenditure data represents then-year dollars.  To make any accurate assessments of longitudinal trends and comparison we need to adjust for inflation.  I have the following dataframe which provides inflation adjustment factors for base-year 2012 dollars *(obviously I should use 2014 values but I had these easily accessable and it only serves for illustrative purposes)*.

{% highlight text %}
##    Year  Annual Inflation
## 28 2007 207.342 0.9030811
## 29 2008 215.303 0.9377553
## 30 2009 214.537 0.9344190
## 31 2010 218.056 0.9497461
## 32 2011 224.939 0.9797251
## 33 2012 229.594 1.0000000
{% endhighlight %}


To join to my expenditure data I obviously need to get my expenditure data in the proper form that allows my to join these two dataframes.  I can apply the following functions to accomplish this:

{% highlight r %}
long.exp <- sub.exp %>%
        gather(Year, Expenditure, X2007:X2011) %>%         # turn to long format
        separate(Year, into=c("x", "Year"), sep="X") %>%   # separate "X" from year value
        select(-x)                                         # remove "x" column

long.exp$Year <- as.numeric(long.exp$ Year)  # convert from character to numeric

head(long.exp)
{% endhighlight %}



{% highlight text %}
##   Division      State Year Expenditure
## 1        6    Alabama 2007     6245031
## 2        9     Alaska 2007     1634316
## 3        8    Arizona 2007     7815720
## 4        7   Arkansas 2007     3997701
## 5        9 California 2007    57352599
## 6        8   Colorado 2007     6579053
{% endhighlight %}


I can now apply the `left_join()` function to join the inflation data to the expenditure data.  This aligns the data in both dataframes by the *Year* variable and then joins the remaining inflation data to the expenditure dataframe as new variables.

{% highlight r %}

join.exp <- long.exp %>% left_join(inflation)

head(join.exp)
{% endhighlight %}



{% highlight text %}
##   Division      State Year Expenditure  Annual Inflation
## 1        6    Alabama 2007     6245031 207.342 0.9030811
## 2        9     Alaska 2007     1634316 207.342 0.9030811
## 3        8    Arizona 2007     7815720 207.342 0.9030811
## 4        7   Arkansas 2007     3997701 207.342 0.9030811
## 5        9 California 2007    57352599 207.342 0.9030811
## 6        8   Colorado 2007     6579053 207.342 0.9030811
{% endhighlight %}


To illustrate the other joining methods we can use these two simple dateframes:



Dataframe "x":

{% highlight text %}
##     name instrument
## 1   John     guitar
## 2   Paul       bass
## 3 George     guitar
## 4  Ringo      drums
## 5 Stuart       bass
## 6   Pete      drums
{% endhighlight %}

Dataframe "y":

{% highlight text %}
##     name  band
## 1   John  TRUE
## 2   Paul  TRUE
## 3 George  TRUE
## 4  Ringo  TRUE
## 5  Brian FALSE
{% endhighlight %}

<br>

`inner_join()`: Include only rows in both x and y that have a matching value

{% highlight r %}
inner_join(x,y)
{% endhighlight %}



{% highlight text %}
##     name instrument band
## 1   John     guitar TRUE
## 2   Paul       bass TRUE
## 3 George     guitar TRUE
## 4  Ringo      drums TRUE
{% endhighlight %}

<br>

`left_join()`: Include all of x, and matching rows of y

{% highlight r %}
left_join(x,y)
{% endhighlight %}



{% highlight text %}
##     name instrument band
## 1   John     guitar TRUE
## 2   Paul       bass TRUE
## 3 George     guitar TRUE
## 4  Ringo      drums TRUE
## 5 Stuart       bass <NA>
## 6   Pete      drums <NA>
{% endhighlight %}

<br>

`semi_join()`: Include rows of x that match y but only keep the columns from x

{% highlight r %}
semi_join(x,y)
{% endhighlight %}



{% highlight text %}
##     name instrument
## 1   John     guitar
## 2   Paul       bass
## 3 George     guitar
## 4  Ringo      drums
{% endhighlight %}

<br>

`anti_join()`: Opposite of semi_join

{% highlight r %}
anti_join(x,y)
{% endhighlight %}



{% highlight text %}
##     name instrument
## 1   Pete      drums
## 2 Stuart       bass
{% endhighlight %}


<a href="#">Go to top</a>

<br>
<a id="mutate"> </a>

### <u>mutate( ) function</u>: 
**Objective:** Creates new variables

**Description:** Often we want to create a new variable that is a function of the current variables in our dataframe or even just add a new variable.  The `mutate()` function allows us to add new variables while preserving the existing variables.


{% highlight r %}
Function:       
                mutate(data, ...)
Same as:        data %>% mutate(...)                

Arguments:
        data:           data frame
        ...:            Expression(s)
{% endhighlight %}

<br>

**Examples**

If we go back to our previous **join.exp** dataframe, remember that we joined inflation rates to our non-inflation adjusted expenditures for public schools.  The dataframe looks like:


{% highlight text %}
##   Division      State Year Expenditure  Annual Inflation
## 1        6    Alabama 2007     6245031 207.342 0.9030811
## 2        9     Alaska 2007     1634316 207.342 0.9030811
## 3        8    Arizona 2007     7815720 207.342 0.9030811
## 4        7   Arkansas 2007     3997701 207.342 0.9030811
## 5        9 California 2007    57352599 207.342 0.9030811
## 6        8   Colorado 2007     6579053 207.342 0.9030811
{% endhighlight %}


If we wanted to adjust our annual expenditures for inflation we can use `mutate()` to create a new inflation adjusted cost variable which we'll name *Adj_Exp*:

{% highlight r %}

inflation_adj <- join.exp %>% mutate(Adj_Exp = Expenditure/Inflation)

head(inflation_adj)
{% endhighlight %}



{% highlight text %}
##   Division      State Year Expenditure  Annual Inflation  Adj_Exp
## 1        6    Alabama 2007     6245031 207.342 0.9030811  6915249
## 2        9     Alaska 2007     1634316 207.342 0.9030811  1809711
## 3        8    Arizona 2007     7815720 207.342 0.9030811  8654505
## 4        7   Arkansas 2007     3997701 207.342 0.9030811  4426735
## 5        9 California 2007    57352599 207.342 0.9030811 63507696
## 6        8   Colorado 2007     6579053 207.342 0.9030811  7285119
{% endhighlight %}


Lets say we wanted to create a variable that rank-orders state-level expenditures (inflation adjusted) for the year 2010 from the highest level of expenditures to the lowest.  

{% highlight r %}

rank_exp <- inflation_adj %>% 
        filter(Year == 2010) %>%
        arrange(desc(Adj_Exp)) %>%
        mutate(Rank = 1:length(Adj_Exp))

head(rank_exp)
{% endhighlight %}



{% highlight text %}
##   Division      State Year Expenditure  Annual Inflation  Adj_Exp
## 1        9 California 2010    58248662 218.056 0.9497461 61330774
## 2        2   New York 2010    50251461 218.056 0.9497461 52910417
## 3        7      Texas 2010    42621886 218.056 0.9497461 44877138
## 4        3   Illinois 2010    24695773 218.056 0.9497461 26002501
## 5        2 New Jersey 2010    24261392 218.056 0.9497461 25545135
## 6        5    Florida 2010    23349314 218.056 0.9497461 24584797
##   Rank
## 1    1
## 2    2
## 3    3
## 4    4
## 5    5
## 6    6
{% endhighlight %}


If you wanted to assess the percent change in cost for a particular state you can use the `lag()` function within the `mutate()` function:

{% highlight r %}

inflation_adj %>%
        filter(State == "Ohio") %>%
        mutate(Perc_Chg = (Adj_Exp-lag(Adj_Exp))/lag(Adj_Exp))
{% endhighlight %}



{% highlight text %}
##   Division State Year Expenditure  Annual Inflation  Adj_Exp
## 1        3  Ohio 2007    18251361 207.342 0.9030811 20210102
## 2        3  Ohio 2008    18892374 215.303 0.9377553 20146378
## 3        3  Ohio 2009    19387318 214.537 0.9344190 20747992
## 4        3  Ohio 2010    19801670 218.056 0.9497461 20849436
## 5        3  Ohio 2011    19988921 224.939 0.9797251 20402582
##       Perc_Chg
## 1           NA
## 2 -0.003153057
## 3  0.029862103
## 4  0.004889357
## 5 -0.021432441
{% endhighlight %}


You could also look at what percent of all US expenditures each state made up in 2011.  In this case we use `mutate()` to take each state's inflation adjusted expenditure and divide by the sum of the entire inflation adjusted expenditure column.  We also apply a second function within `mutate()` that provides the cummalative percent in rank-order.  This shows that in 2011, the top 8 states with the highest expenditures represented over 50% of the total U.S. expenditures in K-12 public schools.  *(I remove the non-inflation adjusted Expenditure, Annual & Inflation columns so that the columns don't wrap on the screen view)*


{% highlight r %}

perc.of.whole <- inflation_adj %>%
        filter(Year == 2011) %>%
        arrange(desc(Adj_Exp)) %>%
        mutate(Perc_of_Total = Adj_Exp/sum(Adj_Exp),
               Cum_Perc = cumsum(Perc_of_Total)) %>%
        select(-Expenditure, -Annual, -Inflation)
        
head(perc.of.whole, 8)
{% endhighlight %}



{% highlight text %}
##   Division        State Year  Adj_Exp Perc_of_Total  Cum_Perc
## 1        9   California 2011 58717324    0.10943237 0.1094324
## 2        2     New York 2011 52575244    0.09798528 0.2074177
## 3        7        Texas 2011 43751346    0.08154005 0.2889577
## 4        3     Illinois 2011 25062609    0.04670957 0.3356673
## 5        5      Florida 2011 24364070    0.04540769 0.3810750
## 6        2   New Jersey 2011 24128484    0.04496862 0.4260436
## 7        2 Pennsylvania 2011 23971218    0.04467552 0.4707191
## 8        3         Ohio 2011 20402582    0.03802460 0.5087437
{% endhighlight %}

<a href="#">Go to top</a>

<br>

<center><hr width="50%"></center>

<br>

## <u>Additional Resources</u>
This tutorial simply touches on the basics that these two packages can do. There are several other resources you can check out to learn more.  In addition, much of what I have learned and, therefore, much of the content in this tutorial is simply a modified regurgitation of the wonderful resources provided by [R Studio](http://www.rstudio.com/), [Hadley Wickham](https://twitter.com/hadleywickham), and [Garrett Grolemund](https://twitter.com/StatGarrett).

- R Studio's [Data wrangling with R and RStudio webinar](http://www.rstudio.com/resources/webinars/)
- R Studio's [Data wrangling GitHub repository](https://github.com/rstudio/webinars/blob/master/2015-01/wrangling-webinar.pdf)
- R Studio's [Data wrangling cheat sheet](http://www.rstudio.com/resources/cheatsheets/)
- Hadley Wickham’s dplyr tutorial at useR! 2014, [Part 1](http://www.r-bloggers.com/hadley-wickhams-dplyr-tutorial-at-user-2014-part-1/)
- Hadley Wickham’s dplyr tutorial at useR! 2014, [Part 2](http://www.r-bloggers.com/hadley-wickhams-dplyr-tutorial-at-user-2014-part-2/)
- Hadley Wickham's paper on [Tidy Data](http://vita.had.co.nz/papers/tidy-data.html)

<br>

<a href="#">Go to top</a>

<br>

*<font size="2">Special thanks to Tom Filloon and Jason Freels for providing constructive comments while developing this tutorial.</font>*
