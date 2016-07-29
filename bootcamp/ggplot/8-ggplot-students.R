# Session 8: Advanced Graphics with ggplot

########
# GR&A #
########
# packages used
library(ggplot2)
library(readxl)
library(dplyr)

# data used
supermarket <- read_excel("data/Supermarket Transactions.xlsx", sheet = "Data")
facebook <- read.delim("data/facebook.tsv")
reddit <- read.csv("data/reddit.csv")
race <- read.csv("data/race-comparison.csv")
mpg


###############
# First Layer #
###############
# notes:

# blank canvas
ggplot(data = supermarket)

# map variables to coordinates
ggplot(data = mpg, aes(x = displ, y = hwy))
ggplot(mpg, aes(displ, hwy))


########################## UNIVARIATE GEOMS ##########################

##################################################
# Histogram, Frequency Polygons & Denisity Plots #
##################################################
# notes:

# default
ggplot(data = mpg, aes(x = hwy)) +
        geom_histogram()

ggplot(data = mpg, aes(x = hwy)) +
        geom_freqpoly()

ggplot(data = supermarket, aes(x = Revenue)) +
        geom_density()

# adjust aesthetics to each of these plots (i.e. bins, color, opacity)
ggplot(data = supermarket, aes(x = Revenue)) +
        geom_histogram()

ggplot(data = supermarket, aes(x = Revenue)) +
        geom_freqpoly()

ggplot(data = supermarket, aes(x = Revenue)) +
        geom_density()


#############
# Bar chart #
#############
# notes:

# default bar chart tallies counts for each variable
ggplot(data = supermarket, aes(x = `Product Family`)) +
        geom_bar()

# change this bar chart to plot data already tallied
summary <- supermarket %>%
        group_by(`Product Family`) %>%
        tally()

ggplot(data = summary, aes(x = `Product Family`, y = n)) +
        geom_bar()


# adjust aesthetics to this plot (i.e. fill, color, bar width)
ggplot(data = supermarket, aes(x = `Product Family`)) +
        geom_bar()



#############
# Your Turn #
#############

# 1. Assess the distribution of age, tenure, and gender in the facebook data.



# 2. Assess the frequency of age range, education, and income range in the reddit data.


########################## BIIVARIATE GEOMS ##########################

#################
# Scatter Plots #
#################
# notes:

# add the geom required to produce a scatter plot; add some color, change the
# shape, opacity, etc.
ggplot(supermarket, aes(`Purchase Date`, Revenue))


# what geom could replace geom_point to resolve the overplotting issues in this plot?
ggplot(supermarket, aes(factor(`Units Sold`), Revenue)) +
        geom_point()




###############
# Line Charts #
###############
# notes:

# this code produces total sales by date
sales_by_date <- supermarket %>%
        group_by(`Purchase Date`) %>%
        summarise(Revenue = sum(Revenue, na.rm = TRUE))

# add a geom to this base plot to visualize total sales by date
ggplot(sales_by_date, aes(`Purchase Date`, Revenue))


# now add some trend lines





############
# Box Plot #
############
# notes:

# add the required geom to turn this base plot into boxplots
ggplot(supermarket, aes(factor(Children), Revenue))


# add some parameters to the geom to adjust coloring, outliers, notching, etc.


# over-plotting on boxplots can be uesful for smaller data sets. Add/change the
# geom and some paramters to do some boxplot overplotting
ggplot(mpg, aes(class, hwy)) +
        geom_boxplot()





#############
# Bar Chart #
#############

# default bar chart plots counts
ggplot(supermarket, aes(x = `Product Family`)) +
        geom_bar()

# what if we want to plot a 2nd variable like revenue as in this data set:
prod_revenue <- supermarket %>%
        group_by(`Product Family`) %>%
        summarise(Revenue = sum(Revenue, na.rm = TRUE))

# add the parameter required in the geom_bar() function to plot this
ggplot(prod_revenue, aes(x = `Product Family`, y = Revenue)) +
        geom_bar()




#############
# Your Turn #
#############

# Assess bivariate relationships between tenure, age, gender, likes, etc. in 
# the facebook data.



########################## MULTIVARIATE CAPABILITIES ##########################

############################
# Color, Size, Shape, etc. #
############################

# Add the parameter required to assess these plots across different categories
ggplot(supermarket, aes(Revenue)) +
        geom_freqpoly()

ggplot(data = supermarket, aes(`Product Family`)) +
        geom_bar(position = "dodge")

ggplot(supermarket, aes(`Purchase Date`, Revenue)) +
        geom_point()

# likewise for line charts; here is data that represents total revenue by date
# for each product family (i.e. food, drink, non-consumable)
prod_revenue <- supermarket %>%
        group_by(`Purchase Date`, `Product Family`) %>%
        summarise(Revenue = sum(Revenue, na.rm = TRUE))

# add the parameter in aes to plot the three different lines that represent total
# revenue by product family
ggplot(prod_revenue, aes(`Purchase Date`, Revenue)) +
        geom_line(alpha = .2) +
        geom_smooth(se = FALSE, span = .1)


#############
# Facetting #
#############

# another option is to produce "small multiples"; add the required function to
# change this line chart to 3 small multiples
ggplot(prod_revenue, aes(`Purchase Date`, Revenue)) +
        geom_line(alpha = .2) +
        geom_smooth(se = FALSE, span = .1)






#############
# Your Turn #
#############

# Use color, shape, size, and facetting to assess multivariate relationships 
# between tenure, age, gender, likes, etc. in the facebook data.





########################## Visualization Aesthetics ##########################

##########################
# Scales, Axes & Legends #
##########################

# consider this basic histogram
p <- ggplot(supermarket, aes(Revenue)) +
        geom_histogram(bins = 100, color = "grey40", fill = "white")

# we can control axis parameters with scale_ ; insert certain parameters below
# to adjust the axis limits, breaks, and label formatting
p + scale_x_continuous()

p + scale_x_log10()


# we can also use the xlim, ylim, and lim shorthand functions; add parameters
# below to adjust the limits
p + xlim()
p + ylim()
p + lims(x = , y = )


# or we can use coord_ to adjust coordinates without impacting underlying data
p + coord_cartesian(xlim = c(10, 50), ylim = c(0, 400))
p + coord_flip()


# we can also use labs, xlab, ylab, & ggtitle for shorthand labeling; add
# titles to the parameters in the labs() function below
ggplot(prod_revenue, aes(`Purchase Date`, Revenue, color = `Product Family`)) +
        geom_line(alpha = .2) +
        geom_smooth(se = FALSE, span = .1) +
        labs(x = , y = , color = , title = )


# Legend features can be controlled with guides and positioning is 
# controlled within theme; add arguments to the guides() and theme() functions
# below to adjust the legend
ggplot(supermarket, aes(`Purchase Date`, Revenue, color = Country)) +
        geom_point(alpha = .2) +
        guides() +
        theme()




#############
# Your Turn #
#############

# Try to re-create displayed visualization as close as possible





##########
# Themes #
##########

# Several theme options are available (even more in the ggthemes package)
p <- ggplot(supermarket, aes(Revenue)) +
        geom_histogram(bins = 100, fill = "antiquewhite", color = "grey40")

p + theme_classic()
p + theme_minimal()
p + theme_dark()


# consider this basic plot
basic <- ggplot(prod_revenue, aes(`Purchase Date`, Revenue, color = `Product Family`)) +
         geom_line(alpha = .2) +
         geom_smooth(se = FALSE, span = .1) +
         scale_y_continuous(labels = scales::dollar) +
         labs(x = NULL, color = NULL, y = NULL, title = "Total Historical Revenue by Product Family")

# add some parameters to the theme() function to adjust how the graphic looks
basic + theme_minimal() +
        theme()





#############
# Your Turn #
#############

# Using this base plot practice adjusting theme parameters.

ggplot(supermarket, aes(Revenue)) +
        geom_histogram(bins = 100, fill = "antiquewhite", color = "grey40")



