# Session 7: Quick plotting with base R


####################
# What to Remember #
####################
# Notes: Graphs are created iteratively - run the following code one line at a time
attach(mtcars)
plot(wt, mpg) 
abline(lm(mpg~wt))
title("Regression of MPG on Weight")



#############
# Data Used #
#############
# Notes: 

library(readxl)
facebook <- read.delim("data/facebook.tsv")
reddit <- read.csv("data/reddit.csv")
race <- read.csv("data/race-comparison.csv")
supermarket <- read_excel("data/Supermarket Transactions.xlsx", sheet = "Data")


###############
# Strip Chart #
###############

# default
stripchart(mtcars$mpg)

# change the type the point style w/pch
stripchart(facebook$tenure, pch = 16)   



#############
# Histogram #
#############

# default
hist(facebook$tenure)     

# add different parameters to change breaks, color, title, etc.
hist(facebook$tenure, breaks = 100, col = "grey", 
     main = "Facebook User Tenure", xlab = "Tenure (Days)")

# get probabilities versus counts by entering probability = TRUE
hist(facebook$tenure, breaks = 100, col = "grey", probability = TRUE)

# you can also compare the histogram to a normal curve to see how it deviates
# there's a lot going on here so this is just for your reference

## remove missing values
x <- na.omit(facebook$tenure)

## create the histogram
h <- hist(x, breaks = 100, col = "grey", main = "Facebook User Tenure", 
          xlab = "Tenure (Days)")

## create normal curve data
xfit <- seq(min(x), max(x), length = 100) 
yfit <- dnorm(xfit, mean = mean(x), sd = sd(x)) 
yfit <- yfit * diff(h$mids[1:2]) * length(x)

## add normal curve to the histogram
lines(xfit, yfit, col = "red", lwd = 2)



################
# Density Plot #
################

# first you need to calculate the density (be sure to remove missing data with
# na.rm = TRUE)
d <- density(facebook$tenure, na.rm = TRUE)

# you can now use plot() to plot the density data
plot(d)

# you can fill area under the curve with polygon()
polygon(d, col = "red", border = "blue")



############
# Box Plot #
############

# default
boxplot(facebook$tenure)

# change to horizontal
boxplot(facebook$tenure, horizontal = TRUE)

# add notches
boxplot(facebook$tenure, horizontal = TRUE, notch = TRUE, col = "grey40")
boxplot(mtcars$mpg, horizontal = TRUE, notch = TRUE, col = "grey40") # better example


# you can also add mean value points but you can only do it to vertical boxplots
boxplot(mtcars$mpg, notch = TRUE)
points(mean(mtcars$mpg), pch=18, col = "red")



#############
# Your Turn #
#############
# Using the facebook data visually assess the continous variables. 
# What insights do you find?

# Example 1 - age of users
hist(facebook$age, breaks = 100, col = "grey", main = "Age of Facebook Users", 
     xlab = "Age (Years)")

# Example 2 - friend count of users
hist(facebook$friend_count, breaks = 100, col = "grey")
hist(log10(facebook$friend_count), breaks = 100, col = "grey")

# Example 3 - anyone want to share?


#############
# Bar Chart #
#############
# Notes:

# bar charts plot the count of each category so you first need to calculate
# the counts
table(reddit$dog.cat)

# embed this in the barplot() function
barplot(table(reddit$dog.cat))

# include and/or change features such as title, horizontal alignment, category
# names, color
pets <- table(reddit$dog.cat)
par(las = 1)
barplot(pets, main = "Reddit User Animal Preferences", horiz = TRUE, 
        names.arg = c("Cats", "Dogs", "Turtles"), col = 'cyan')

# plot this data
library(dplyr)

state <- reddit %>%
        group_by(state) %>%
        tally() %>%
        arrange(n) %>%
        filter(state != "")

par(mar = c(3,8,1,1), las = 1)
barplot(state$n, names.arg = state$state, horiz = TRUE)


############
# Dot Plot #
############
# Notes:

# now plot the same state data with a dot plot
dotchart(state$n, labels = state$state, cex = .7)



#############
# Your Turn #
#############
# Using the Reddit data... 

# 1) assess the frequency of education levels
reddit_ed <- reddit %>%
        group_by(education) %>%
        tally() %>%
        filter(education != "NA") %>%
        arrange(n)

par(mar = c(5,15,1,1), las = 1)
barplot(reddit_ed$n, names.arg = reddit_ed$education, horiz = TRUE)

# 2) assess how the different cheeses rank with Reddit users. What do you find?
cheese <- reddit %>%
        group_by(cheese) %>%
        tally() %>%
        filter(cheese != "NA") %>%
        arrange(n)

dotchart(cheese$n, labels = cheese$cheese, bg = "yellow")

# reset margins
par(mar = c(5, 4, 4, 2))




################
# Scatter Plot #
################
# Notes:

# default (add some color with col = ? or change the point style with pch = ?)
plot(x = race$White_unemployment, y = race$Black_unemployment)
plot(x = race$Black_unemployment, y = race$black_college)

# you can fit lines to the scatter plot to assess its linearity; note that you 
# need to use "~" rather than "x =" and "y ="
plot(White_unemployment ~ Black_unemployment, data = race)
abline(lm(White_unemployment ~ Black_unemployment, data = race), col = "red")
lines(lowess(race$White_unemployment ~ race$Black_unemployment), col = "blue")

# quickly assess multiple scatter plots with pairs()
pairs(race)
pairs(race[, c("White_unemployment", "Black_unemployment", 
               "white_college", "black_college")])


###############
# Line Charts #
###############
# Notes:

# apply different "type = ?" for line, step, and line-point charts
## turn this default to a line chart using "type = ?" 
plot(x = race$Year, y = race$black_college)

## how about a step chart
plot(x = race$Year, y = race$black_college)

## and a line chart with dots
plot(x = race$Year, y = race$black_college)


# you can plot multiple lines on a chart 
plot(x = race$Year, y = race$Black_hs, type = "l", ylim = c(0, max(race$Black_hs)))
lines(x = race$Year, y = race$black_college, col = "red")
lines(x = race$Year, y = race$Black_unemployment, col = "blue", lty = 2)

# and you probably want to add a legend
legend("topleft", legend = c("HS Rate", "College Rate", "Unemployment"), 
       col = c("black", "red", "blue"), lty = c(1, 1, 2))



#####################
# Box Plots...again #
#####################
# Notes:

# turn this single variable boxplot into two box plots comparing gender
boxplot(supermarket$Revenue)
boxplot(Revenue ~ Gender, data = supermarket)

# add a third variable for marital status
boxplot(Revenue ~ Gender + `Marital Status`, data = supermarket)



#############
# Your Turn #
#############
# Using the supermarket data analyze revenue by date, homeownership, city, product 
# family, etc.  Don't forget you can summarize the data using dplyr like you
# learned about earlier...example:

## total revenues by date
revenue_by_date <- supermarket %>%
        group_by(`Purchase Date`) %>%
        summarise(Revenue = sum(Revenue, na.rm = TRUE))

plot(Revenue ~ `Purchase Date`, data = revenue_by_date, type = "l", col = "grey")
lines(lowess(revenue_by_date$Revenue ~ revenue_by_date$`Purchase Date`, f = 1/4), col = "blue")


## revenue by product category
par(mar = c(5, 10, 4, 2))
boxplot(Revenue ~ `Product Category`, data = supermarket, horizontal = TRUE)


# reset margins
par(mar = c(5, 4, 4, 2))

######################
# Bar Charts...again #
######################
# Notes:

# we can get frequency tables across two groups
counts <- table(supermarket$`Marital Status`, supermarket$Children)

# you can plot these results either stacked or side-by-side with barplot()
barplot(counts, col = c("darkblue", "red"), legend = c("Married", "Single"))
barplot(counts, col = c("darkblue", "red"), legend = c("Married", "Single"), beside = TRUE)

# you can turn these counts into proportions
proportions <- prop.table(counts)

# now plot these results in a similar manner as above
barplot(proportions, col = c("darkblue", "red"), legend = c("Married", "Single"))
barplot(proportions, col = c("darkblue", "red"), legend = c("Married", "Single"), beside = TRUE)


#############
# Your Turn #
#############
# Using the reddit data compare counts of...
# 1) product family by homeownership
Q1 <- table(supermarket$`Product Family`, supermarket$Homeowner)

barplot(Q1, beside = TRUE, legend.text = TRUE)


# 2) annual income by homeownership
supermarket$`Annual Income` <- factor(supermarket$`Annual Income`, 
                                      levels = c("$10K - $30K", "$30K - $50K",
                                                 "$50K - $70K", "$70K - $90K",
                                                 "$90K - $110K", "$110K - $130K",
                                                 "$130K - $150K", "$150K +"))

Q2 <- prop.table(table(supermarket$`Annual Income`, supermarket$Homeowner))

barplot(Q2, legend.text = TRUE, 
        args.legend = list(x = "topleft", cex = 1, bty = "n", y.intersp=1.5))

# 3) country by gender
Q3 <- prop.table(table(supermarket$Gender, supermarket$Country))

barplot(Q3, beside = TRUE, legend.text = c("Female", "Male"), col = c("pink", "blue"),
        args.legend = list(x = "topleft", cex = 1.5, bty = "n", y.intersp=1.5))

# 4) etc.





