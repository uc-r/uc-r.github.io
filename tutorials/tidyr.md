---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Data wrangling](data_wrangling) &#187; tidyr for reshaping the layout of data frames

<br>

Although many fundamental data processing functions exist in R, they have been a bit convoluted to date and have lacked consistent coding 
and the ability to easily *flow* together.  This leads to difficult-to-read nested functions and/or *choppy* code. [R Studio](http://www.rstudio.com/) is driving a lot of new packages to collate data management tasks and better integrate them with other analysis activities.
As a result, a lot of data processing tasks are becoming packaged in more cohesive and consistent ways, which leads to:

- More efficient code
- Easier to remember syntax
- Easier to read syntax

`tidyr` is a one such package which was built for the sole purpose of simplifying the process of creating [tidy data](http://vita.had.co.nz/papers/tidy-data.html). This tutorial provides you with the basic understanding of the four fundamental functions of data tidying that tidyr provides:

* <a href="#gather">**`gather()`**</a> makes “wide” data longer
* <a href="#spread">**`spread()`**</a> makes “long” data wider
* <a href="#separate">**`separate()`**</a> splits a single column into multiple columns
* <a href="#unite">**`unite()`**</a> combines multiple columns into a single column
* <a href="#resources">Additional Resources</a>

<br>

## <u>Packages Utilized</u>

{% highlight r %}
install.packages("tidyr")
library(tidyr)
{% endhighlight %}

<br>

<a id="pipe"> </a>

## <u><font face="consolas">%>%</font> Operator</u>

Although not required, the tidyr and dplyr packages make use of the pipe operator `%>%` developed by [Stefan Milton Bache](https://twitter.com/stefanbache) in the R package [magrittr](http://cran.r-project.org/web/packages/magrittr/magrittr.pdf).  Although all the functions in tidyr and dplyr *can be used without the pipe operator*, one of the great conveniences these packages provide is the ability to string multiple functions together by incorporating `%>%`.

This operator will forward a value, or the result of an expression, into the next function call/expression.  For instance a function to filter data can be written as:

<center>filter(data, variable == <em>numeric_value</em>)</center>

<center><em><u>or</u></em></center>

<center>data %>% filter(variable == <em>numeric_value</em>)</center>

<br>

Both functions complete the same task and the benefit of using `%>%` is not evident; however, when you desire to perform multiple functions its advantage becomes obvious.  For instance, if we want to filter some data, summarize it, and then order the summarized results we would write it out as:


&nbsp;&nbsp;<u>Nested Option:</u>

{% highlight r %}
arrange(
    summarize(
        filter(data, variable == *numeric_value*),
        Total = sum(variable)
    ),
    desc(Total)<br>
)
{% endhighlight %}

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*<u>or</u>*

&nbsp;&nbsp;<u>Multiple Object Option:</u>

{% highlight r %}
a <- filter(data, variable == *numeric_value*)
b <- summarise(a, Total = sum(variable))
c <- arrange(b, desc(Total))
{% endhighlight %}


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*<u>or</u>*


&nbsp;&nbsp;<u>%>% Option:</u>

{% highlight r %}
data %>%
    filter(variable == "value") %>%
    summarise(Total = sum(variable)) %>%
    arrange(desc(Total))
{% endhighlight %}

As your function tasks get longer the `%>%` operator becomes more efficient *<u>and</u>* makes your code more legible.  In addition, although not covered in this tutorial, the `%>%` operator allows you to flow from data manipulation tasks straight into vizualization functions *(via ggplot and ggvis)* and also into many analytic functions.

To learn more about the `%>%` operator and the magrittr package visit any of the following:

- [http://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html](http://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html)
- [http://www.r-bloggers.com/simpler-r-coding-with-pipes-the-present-and-future-of-the-magrittr-package/](http://www.r-bloggers.com/simpler-r-coding-with-pipes-the-present-and-future-of-the-magrittr-package/)
- [http://blog.revolutionanalytics.com/2014/07/magrittr-simplifying-r-code-with-pipes.html](http://blog.revolutionanalytics.com/2014/07/magrittr-simplifying-r-code-with-pipes.html)

<a href="#">Go to top</a>

<br>

<a id="gather"> </a>

## <u>gather( ) function</u>: 
**Objective:** Reshaping wide format to long format

**Description:** There are times when our data is considered unstacked and a common attribute of concern is spread out across columns.  To reformat the data such that these common attributes are *gathered* together as a single variable, the `gather()` function will take multiple columns and collapse them into key-value pairs, duplicating all other columns as needed.


<img src="/public/images/dataWrangling/gather1.png" alt="gather() function" align="middle" vspace="25">


{% highlight r %}
Function:       gather(data, key, value, ..., na.rm = FALSE, convert = FALSE)
Same as:        data %>% gather(key, value, ..., na.rm = FALSE, convert = FALSE)

Arguments:
        data:           data frame
        key:            column name representing new variable
        value:          column name representing variable values
        ...:            names of columns to gather (or not gather)
        na.rm:          option to remove observations with missing values (represented by NAs)
        convert:        if TRUE will automatically convert values to logical, integer, numeric, complex or factor as appropriate
{% endhighlight %}
&#9755; *This function is a complement to <a href="#spread">`spread()`</a>*

**Example**

We'll start with the following data set:

{% highlight r %}
## Source: local data frame [12 x 6]
## 
##    Group Year Qtr.1 Qtr.2 Qtr.3 Qtr.4
## 1      1 2006    15    16    19    17
## 2      1 2007    12    13    27    23
## 3      1 2008    22    22    24    20
## 4      1 2009    10    14    20    16
## 5      2 2006    12    13    25    18
## 6      2 2007    16    14    21    19
## 7      2 2008    13    11    29    15
## 8      2 2009    23    20    26    20
## 9      3 2006    11    12    22    16
## 10     3 2007    13    11    27    21
## 11     3 2008    17    12    23    19
## 12     3 2009    14     9    31    24
{% endhighlight %}

This data is considered wide since the *<u>time</u>* variable (represented as quarters) is structured such that each quarter represents a variable. To re-structure the time component as an individual variable, we can *gather* each quarter within one column variable and also *gather* the values associated with each quarter in a second column variable.


{% highlight r %}
long_DF <- DF %>% gather(Quarter, Revenue, Qtr.1:Qtr.4)
head(long_DF, 24)  # note, for brevity, I only show the data for the first two years 

## Source: local data frame [24 x 4]
## 
##    Group Year Quarter Revenue
## 1      1 2006   Qtr.1      15
## 2      1 2007   Qtr.1      12
## 3      1 2008   Qtr.1      22
## 4      1 2009   Qtr.1      10
## 5      2 2006   Qtr.1      12
## 6      2 2007   Qtr.1      16
## 7      2 2008   Qtr.1      13
## 8      2 2009   Qtr.1      23
## 9      3 2006   Qtr.1      11
## 10     3 2007   Qtr.1      13
## ..   ...  ...     ...     ...
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

## <u>separate( ) function</u>: 
**Objective:** Splitting a single variable into two

**Description:** Many times a single column variable will capture multiple variables, or even parts of a variable you just don't care about.  Some examples include:


{% highlight r %}
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

In each of these cases, our objective may be to *separate* characters within the variable string. This can be accomplished using the `separate()` function which turns a single character column into multiple columns.

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
&#9755; *This function is a complement to <a href="#unite">`unite()`</a>*

**Example**

We can go back to our **long_DF** dataframe we created above in which way may desire to clean up or separate the *Quarter* variable.

{% highlight r %}
## Source: local data frame [6 x 4]
## 
##   Group Year Quarter Revenue
## 1     1 2006   Qtr.1      15
## 2     1 2007   Qtr.1      12
## 3     1 2008   Qtr.1      22
## 4     1 2009   Qtr.1      10
## 5     2 2006   Qtr.1      12
## 6     2 2007   Qtr.1      16
{% endhighlight %}

By applying the `separate()` function we get the following:

{% highlight r %}
separate_DF <- long_DF %>% separate(Quarter, c("Time_Interval", "Interval_ID"))
head(separate_DF, 10)

## Source: local data frame [10 x 5]
## 
##    Group Year Time_Interval Interval_ID Revenue
## 1      1 2006           Qtr           1      15
## 2      1 2007           Qtr           1      12
## 3      1 2008           Qtr           1      22
## 4      1 2009           Qtr           1      10
## 5      2 2006           Qtr           1      12
## 6      2 2007           Qtr           1      16
## 7      2 2008           Qtr           1      13
## 8      2 2009           Qtr           1      23
## 9      3 2006           Qtr           1      11
## 10     3 2007           Qtr           1      13
{% endhighlight %}


{% highlight r %}
These produce the same results:
        long_DF %>% separate(Quarter, c("Time_Interval", "Interval_ID"))
        long_DF %>% separate(Quarter, c("Time_Interval", "Interval_ID"), sep = "\\.")
{% endhighlight %}

<a href="#">Go to top</a>

<br>
<a id="unite"> </a>

## <u>unite( ) function</u>: 
**Objective:** Merging two variables into one

**Description:** There may be a time in which we would like to combine the values of two variables.  The `unite()` function is a convenience function to paste together multiple variable values into one.  In essence, it combines two variables of a single observation into one variable.


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
&#9755; *This function is a complement to <a href="#separate">`separate()`</a>*

**Example**

Using the **separate_DF** dataframe we created above, we can re-unite the *Time_Interval* and *Interval_ID* variables we created and re-create the original *Quarter* variable we had in the **long_DF** dataframe.


{% highlight r %}
unite_DF <- separate_DF %>% unite(Quarter, Time_Interval, Interval_ID, sep = ".")
head(unite_DF, 10)

## Source: local data frame [10 x 4]
## 
##    Group Year Quarter Revenue
## 1      1 2006   Qtr.1      15
## 2      1 2007   Qtr.1      12
## 3      1 2008   Qtr.1      22
## 4      1 2009   Qtr.1      10
## 5      2 2006   Qtr.1      12
## 6      2 2007   Qtr.1      16
## 7      2 2008   Qtr.1      13
## 8      2 2009   Qtr.1      23
## 9      3 2006   Qtr.1      11
## 10     3 2007   Qtr.1      13
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

## <u>spread( ) function</u>: 

**Objective:** Reshaping long format to wide format

**Description:** There are times when we are required to turn long formatted data into wide formatted data.  The `spread()` function spreads a key-value pair across multiple columns.


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
&#9755; *This function is a complement to <a href="#gather">`gather()`</a>*


**Example**


{% highlight r %}
wide_DF <- unite_DF %>% spread(Quarter, Revenue)
head(wide_DF, 24)

## Source: local data frame [12 x 6]
## 
##    Group Year Qtr.1 Qtr.2 Qtr.3 Qtr.4
## 1      1 2006    15    16    19    17
## 2      1 2007    12    13    27    23
## 3      1 2008    22    22    24    20
## 4      1 2009    10    14    20    16
## 5      2 2006    12    13    25    18
## 6      2 2007    16    14    21    19
## 7      2 2008    13    11    29    15
## 8      2 2009    23    20    26    20
## 9      3 2006    11    12    22    16
## 10     3 2007    13    11    27    21
## 11     3 2008    17    12    23    19
## 12     3 2009    14     9    31    24
{% endhighlight %}

<a href="#">Go to top</a>

<br>

<a id="resources"> </a>

## Additional Resources

- Data wrangling [presentation](Data_Wrangling_MU) I gave at Miami University
- R Studio's [Data wrangling with R and RStudio webinar](http://www.rstudio.com/resources/webinars/)
- R Studio's [Data wrangling GitHub repository](https://github.com/rstudio/webinars/blob/master/2015-01/wrangling-webinar.pdf)
- R Studio's [Data wrangling cheat sheet](http://www.rstudio.com/resources/cheatsheets/)
- Hadley Wickham's paper on [Tidy Data](http://vita.had.co.nz/papers/tidy-data.html)


<a href="#">Go to top</a>
