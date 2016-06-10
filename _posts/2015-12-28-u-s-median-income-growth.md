---
layout: post
title:  U.S. Median Income Growth
date: 2015-09-21
author: Bradley Boehmke
published: true
tags: [r, ggplot2]
categories: [programming, visualization, economics]
---

This post walks through the code behind the [visual graphic](https://twitter.com/bradleyboehmke/status/558490399917236226) created to illustrate the historical growth rates of median income in the United States.

![Final_Graphic](http://bradleyboehmke.github.io/figure/source/u-s-median-income-growth/2015-12-28-u-s-median-income-growth/median_income.jpg)

<!--more-->

<br>

### <font face="serif">R Packages Utilized</font>

{% highlight r %}
# Preprocessing & summarizing data
library(dplyr)
library(tidyr)

# Visualization development
library(grid)
library(scales)
library(ggplot2)
{% endhighlight %}

<br>

### <font face="serif">Getting & Preparing the Data</font>
The data used was obtained from the [U.S. Census Bureau](https://www.census.gov/hhes/www/income/data/statemedian/) website which contains median income for all 50 U.S. states, D.C., and the overall U.S. median income.  The values have been inflation adjusted to 2013 constant year dollars and range from 1984-2013.  The raw data included standard errors for each year which I removed prior to reading into R.  So, the initial data I am starting with here looks like:


{% highlight text %}
##           State X2013 X2012 X2011 X2010 X2009 X2008 X2007 X2006 X2005
## 1 United States 51939 51758 51842 52646 54059 54423 56436 55689 55278
## 2       Alabama 41381 44096 44112 43733 43420 48119 47424 43848 44329
## 3        Alaska 61137 64573 59483 61804 66904 69230 70771 65183 66691
## 4       Arizona 50602 47728 50358 50103 49674 50757 53045 53905 53988
## 5      Arkansas 39919 39585 42778 41226 39681 42828 45832 42814 43742
## 6    California 57528 57849 55274 57996 60963 61684 62616 63913 61756
{% endhighlight %}

The first step I took was to create my baseline comparison which is the overall U.S. median income.  This simply required me to filter out values only for the U.S. (labeled *"United States"*), transpose the data into a long format using `gather()`, and removing the unecessary "X" at the beginning of each year value by using `separate()`.


{% highlight r %}
# clean overall U.S. data and turn it into long format
us <- data %>%
        filter(State == "United States") %>%
        gather(Year, Income, X2013:X1984) %>%
        separate(Year, c("left","Year"), sep="X") %>%
        select(-left) %>%
        arrange(Year)

# extract 1984 value as the baseline value and add to us dataframe
us_base <- us[us$Year==1984,3]
us$us_baseline <- us_base

# calculate the percent change in U.S. median income for each year as compared
# to 1984 (aka the baseline)
us <- us %>% mutate(us_change = (Income-us_baseline)/us_baseline)
{% endhighlight %}

The second step is to do the same process but for each of the states.  


{% highlight r %}
# create a states dataframe, clean and turn into long format
states <- data %>%
        filter(State != "United States") %>%
        gather(Year, Income, X2013:X1984) %>%
        separate(Year, c("left","Year"), sep="X") %>%
        select(-left) %>%
        arrange(Year) %>%
        filter(Income != "NA")

# create baselines for each state
state_base <- states %>%
        filter(Year == 1984) %>%
        select(State, State_Baseline = Income)

# add baseline to the states and calculate the percent change in median income
# for each state as compared to 1984 (aka the baseline)
states <- states %>%
        left_join(state_base) %>%
        arrange(State) %>%
        mutate(state_change = (Income-State_Baseline)/State_Baseline)

# change year variables from character to numeric
states$Year <- as.numeric(states$Year)
us$Year <- as.numeric(us$Year)

# get top 5 and bottom 5 states which will allow me to identify them
# graphically
rank <- states %>% 
        filter(Year == 2013) %>% 
        arrange(desc(state_change)) %>%
        mutate(rank = seq(1,length(State), by=1)) %>%
        filter(rank < 6 | rank > 46 )
{% endhighlight %}

<br>

### <font face="serif">Creating the Visual Graphic</font>
Now that we have our data formatted properly we can proceed to building our graphic.

<br>

#### <u><font face="serif">Step 1</font></u>
The first thing I like to do is create my canvas.  I tend to stay true to Edward Tufte's principles and keep it as minimalistic as possible. This usually includes the `theme_bw()` theme along with minimal gridlines.  For this plot I also remove the borders, axis tick marks, titles, and make the y-axis major gridlines a light grey with a dotted linetype.  Next, I plot the trend lines for all 50 states (and D.C.).  Since this creates a lot of noise, I use a light grey with some transparency because I want this to act as a "backdrop" of sorts.


{% highlight r %}
p <- ggplot(states, aes(Year, state_change, group=State)) +
        theme_bw() +
        theme(plot.background = element_blank(),
              panel.grid.minor = element_blank(),
              panel.grid.major.x = element_blank(),
              panel.grid.major.y = element_line(linetype = 3, colour = "grey50"),
              panel.border = element_blank(),
              panel.background = element_blank(),
              axis.ticks = element_blank(),  
              axis.title = element_blank()) +
        geom_line(colour="grey90", alpha=.9)

print(p)
{% endhighlight %}

![plot of chunk unnamed-chunk-5](http://bradleyboehmke.github.io/figure/source/u-s-median-income-growth/2015-12-28-u-s-median-income-growth/unnamed-chunk-5-1.png) 

<br>

#### <u><font face="serif">Step 2</font></u>
Next, I plot the U.S. overall average with a dashed line.


{% highlight r %}
p <- p +
        geom_line(data=us, aes(Year, us_change, group=1), linetype=5)

print(p)
{% endhighlight %}

![plot of chunk unnamed-chunk-6](http://bradleyboehmke.github.io/figure/source/u-s-median-income-growth/2015-12-28-u-s-median-income-growth/unnamed-chunk-6-1.png) 

<br>

#### <u><font face="serif">Step 3</font></u>
I also wanted to identify how my own state (Ohio) has trended over the years so I filtered the states dataframe for only Ohio data and singled it out with a blue color.


{% highlight r %}
p <- p +
        geom_line(data=filter(states, State=="Ohio"), 
                  aes(Year, state_change, group=State), colour="dodgerblue", size = 1)

print(p)
{% endhighlight %}

![plot of chunk unnamed-chunk-7](http://bradleyboehmke.github.io/figure/source/u-s-median-income-growth/2015-12-28-u-s-median-income-growth/unnamed-chunk-7-1.png) 

<br>

#### <u><font face="serif">Step 4</font></u>
I wanted to create some boundaries with the biggest economic "winner" and "loser".  So I identified the state that had the largest growth from 1984 to 2013 and the state that had the greatest contraction and singled these out with a slightly darker grey than all the other states.


{% highlight r %}
p <- p +
        geom_line(data=filter(states, State=="D.C."), 
                  aes(Year, state_change, group=State), colour="grey70") +
        geom_line(data=filter(states, State=="Nevada"), 
                  aes(Year, state_change, group=State), colour="grey70")

print(p)
{% endhighlight %}

![plot of chunk unnamed-chunk-8](http://bradleyboehmke.github.io/figure/source/u-s-median-income-growth/2015-12-28-u-s-median-income-growth/unnamed-chunk-8-1.png) 

<br>

#### <u><font face="serif">Step 5</font></u>
Next, I identify the top 5 and bottom 5 states along the overall US by plotting points on their 2013 values.


{% highlight r %}
p <- p +
        geom_point(data=rank, aes(Year, state_change), shape=21, size=1.5, alpha=.6) +
        geom_point(data=filter(us, Year == 2013), aes(Year, us_change), size=2.5, alpha=.6)

print(p)
{% endhighlight %}

![plot of chunk unnamed-chunk-9](http://bradleyboehmke.github.io/figure/source/u-s-median-income-growth/2015-12-28-u-s-median-income-growth/unnamed-chunk-9-1.png) 

<br>

#### <u><font face="serif">Step 6</font></u>
The last step I performed in R was to format the x- and y-axis.  For the y-axis I fixed the limits and breaks (this was primarily because I was tinkering around with the dimensions of the chart but wanted to keep the breaks fixed) and turned the labels to a percent format.  For the x-axis I increased the breaks to every 5 years and reduced the padding at the ends of the axis.  Also note that I extend the x-axis to 1983 even though my data only goes back to 1984.  This is to add more space on the left side of the x-axis; the reason for this becomes evident in the final graphic where I move the y-axis labels.


{% highlight r %}
p <- p +
        scale_y_continuous(limits=c(-.2,.55), breaks=seq(-.2,.4,by=.2), label=percent) +
        scale_x_continuous(limits=c(1983,2013),breaks=seq(1985,2010,by=5), expand=c(0,.25))

print(p)
{% endhighlight %}

![plot of chunk unnamed-chunk-10](http://bradleyboehmke.github.io/figure/source/u-s-median-income-growth/2015-12-28-u-s-median-income-growth/unnamed-chunk-10-1.png) 

<br>

#### <u><font face="serif">Step 7</font></u>
With my data plotted, all that was left was to annotate the graphic.  Annotation can be done in R, which I showed the intricacies required in my [weather graphic tutorial](http://bradleyboehmke.github.io//2015/08/new-post.html); however, I find it much easier to use Adobe Illustrator to annotate finely detailed graphics like this one.

I'm a big fan of Georgia font so in Illustrator I usually change my fonts to include my axis labels. I also ended up increasing the size of the axis labels and adjusted the position of the y-axis labels to sit on top of the gridlines rather than adjacent to them.

Annotation adds a lot to a graphic and is really what makes it able to tell a story on its own. Whether you do it in R or in editor such as Illustrator, these are the final touches that really make a graphic shine.

![Final_Graphic](http://bradleyboehmke.github.io/figure/source/u-s-median-income-growth/2015-12-28-u-s-median-income-growth/median_income.jpg)
