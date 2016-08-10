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
# blank canvas
ggplot(data = supermarket)

# map variables to coordinates
ggplot(data = mpg, aes(x = displ, y = hwy))
ggplot(mpg, aes(displ, hwy))


########################## UNIVARIATE GEOMS ##########################

##################################################
# Histogram, Frequency Polygons & Denisity Plots #
##################################################

# default
ggplot(data = mpg, aes(x = hwy)) +
        geom_histogram()

ggplot(data = mpg, aes(x = hwy)) +
        geom_freqpoly()

ggplot(data = supermarket, aes(x = Revenue)) +
        geom_density()

# adjust aesthetics
ggplot(data = supermarket, aes(x = Revenue)) +
        geom_histogram(bins = 100, color = "grey40", fill = "white")

ggplot(data = supermarket, aes(x = Revenue)) +
        geom_freqpoly(bins = 100, color = "blue")

ggplot(data = supermarket, aes(x = Revenue)) +
        geom_density(fill = "red", alpha = .5)


#############
# Bar chart #
#############

# default bar chart tallies counts for each variable
ggplot(data = supermarket, aes(x = `Product Family`)) +
        geom_bar()

# change stat = "identity" to plot data already tallied
summary <- supermarket %>%
        group_by(`Product Family`) %>%
        tally()

ggplot(data = summary, aes(x = `Product Family`, y = n)) +
        geom_bar(stat = "identity")


# adjust aesthetics
ggplot(data = supermarket, aes(x = `Product Family`)) +
        geom_bar(fill = "dodgerblue", color = "grey40")

ggplot(data = supermarket, aes(x = `Product Family`)) +
        geom_bar(fill = "dodgerblue", color = "grey40", width = .75)

ggplot(data = supermarket, aes(x = `Product Family`)) +
        geom_bar(fill = "dodgerblue", color = "grey40", width = .99)



#############
# Your Turn #
#############

# 1. Assess the distribution of age, tenure, and gender in the facebook data.
ggplot(facebook, aes(age)) +
        geom_histogram(bins = 100, color = "grey40", fill = "white")

ggplot(facebook, aes(gender)) +
        geom_bar()

# 2. Assess the frequency of age range, education, and income range in the reddit data.
ggplot(reddit, aes(age.range)) +
        geom_bar()


########################## BIIVARIATE GEOMS ##########################

#################
# Scatter Plots #
#################

# add geom_point for a scatter plot
ggplot(supermarket, aes(`Purchase Date`, Revenue)) +
        geom_point()

ggplot(supermarket, aes(`Purchase Date`, Revenue)) +
        geom_point(colour = "blue", size = 1, shape = 5)

ggplot(supermarket, aes(`Purchase Date`, Revenue)) +
        geom_point(colour = "blue", alpha = .25)


# use jitter to resolve overplotting issues
ggplot(supermarket, aes(factor(`Units Sold`), Revenue)) +
        geom_point()

ggplot(supermarket, aes(factor(`Units Sold`), Revenue)) +
        geom_jitter(size = 1)

ggplot(supermarket, aes(factor(`Units Sold`), Revenue)) +
        geom_jitter(size = 1, alpha = .5)



###############
# Line Charts #
###############
# create total sales by date
sales_by_date <- supermarket %>%
        group_by(`Purchase Date`) %>%
        summarise(Revenue = sum(Revenue, na.rm = TRUE))

sales_plot <- ggplot(sales_by_date, aes(`Purchase Date`, Revenue)) +
        geom_line()

sales_plot + geom_smooth(span = .1)
sales_plot + geom_smooth(span = .9, se = FALSE)
sales_plot + geom_smooth(method = "lm", se = FALSE)



############
# Box Plot #
############
ggplot(supermarket, aes(factor(Children), Revenue)) +
        geom_boxplot()

ggplot(supermarket, aes(factor(Children), Revenue)) +
        geom_boxplot(notch = TRUE, fill = "blue", alpha = .25)

ggplot(supermarket, aes(factor(Children), Revenue)) +
        geom_boxplot(outlier.color = "red", outlier.shape = 1)


# over-plotting on boxplots can be uesful for smaller data sets
ggplot(mpg, aes(class, hwy)) +
        geom_boxplot()

ggplot(mpg, aes(class, hwy)) +
        geom_boxplot() +
        geom_jitter(width = .2, alpha = .5)

ggplot(mpg, aes(class, hwy)) +
        geom_violin()



#############
# Bar Chart #
#############

# default bar chart plots counts
ggplot(supermarket, aes(x = `Product Family`)) +
        geom_bar()

# plot a 2nd variable on the y-axis for bar charts
prod_revenue <- supermarket %>%
        group_by(`Product Family`) %>%
        summarise(Revenue = sum(Revenue, na.rm = TRUE))

ggplot(prod_revenue, aes(x = `Product Family`, y = Revenue)) +
        geom_bar(stat = "identity")




#############
# Your Turn #
#############

# Assess bivariate relationships between tenure, age, gender, likes, etc. in 
# the facebook data.

ggplot(facebook, aes(age, likes)) +
        geom_point(alpha = .25)

ggplot(filter(facebook, gender != "NA"), aes(gender, friend_count)) +
        geom_boxplot() +
        coord_cartesian(ylim = c(0, 1000))




########################## MULTIVARIATE CAPABILITIES ##########################

############################
# Color, Size, Shape, etc. #
############################

# We can add color, size, shape parameters in aes() to add another variable
ggplot(supermarket, aes(Revenue, color = `Product Family`)) +
        geom_freqpoly()

ggplot(data = supermarket, aes(`Product Family`, fill = Gender)) +
        geom_bar(position = "dodge")

ggplot(supermarket, aes(`Purchase Date`, Revenue, color = Country)) +
        geom_point()

# likewise for line charts; here is data that represents total revenue by date
# for each product family (i.e. food, drink, non-consumable)
prod_revenue <- supermarket %>%
        group_by(`Purchase Date`, `Product Family`) %>%
        summarise(Revenue = sum(Revenue, na.rm = TRUE))

ggplot(prod_revenue, aes(`Purchase Date`, Revenue, color = `Product Family`)) +
        geom_line(alpha = .2) +
        geom_smooth(se = FALSE, span = .1)


#############
# Facetting #
#############

# another option is to produce "small multiples"
ggplot(prod_revenue, aes(`Purchase Date`, Revenue)) +
        geom_line(alpha = .2) +
        geom_smooth(se = FALSE, span = .1) +
        facet_wrap(~ `Product Family`)


# difference between facet_wrap and facet grid
ggplot(mpg, aes(displ, hwy)) +
        geom_point() + 
        facet_wrap(~ class)

ggplot(mpg, aes(displ, hwy)) +
        geom_point() + 
        facet_grid(cyl ~ class)

ggplot(mpg, aes(displ, hwy)) +
        geom_point() + 
        facet_grid(class ~ cyl)




#############
# Your Turn #
#############

# Use color, shape, size, and facetting to assess multivariate relationships 
# between tenure, age, gender, likes, etc. in the facebook data.

ggplot(facebook, aes(age, color = gender)) +
        geom_freqpoly(bins = 100)

# assess friendships initiated by gender for Generation Y users
gen_y <- facebook %>%
        filter(dob_year >= 1990, gender != "NA")

ggplot(gen_y, aes(friendships_initiated, color = gender)) +
        geom_freqpoly(bins = 100) +
        facet_wrap(~ dob_year) +
        scale_x_log10()


########################## Visualization Aesthetics ##########################

##########################
# Scales, Axes & Legends #
##########################

# consider this basic histogram
p <- ggplot(supermarket, aes(Revenue)) +
        geom_histogram(bins = 100, color = "grey40", fill = "white")

# we can control axis parameters with scale_
p + scale_x_continuous(name = "Revenue from Individual Transactions",
                       limits = c(10, 50),
                       breaks = seq(10, 50, by = 10),
                       labels = scales::dollar)

p + scale_x_log10(labels = scales::dollar)


# we can also use the xlim, ylim, and lim shorthand functions; add parameters
# below to adjust the limits
p + xlim(25, 55)
p + ylim(0, 400)
p + lims(x = c(0, 100), y = c(0, 1000))


# or we can use coord_ to adjust coordinates without impacting underlying data
p + coord_cartesian(xlim = c(10, 50), ylim = c(0, 400))
p + coord_flip()


# we can also use labs, xlab, ylab, & ggtitle for shorthand labeling; add
# titles to the parameters in the labs() function below
ggplot(prod_revenue, aes(`Purchase Date`, Revenue, color = `Product Family`)) +
        geom_line(alpha = .2) +
        geom_smooth(se = FALSE, span = .1) +
        labs(x = "x-axis title", y = "y-axis title", 
             color = "legend title", title = "Main title")


# Legend features can be controlled with guides and positioning is 
# controlled within theme
ggplot(supermarket, aes(`Purchase Date`, Revenue, color = Country)) +
        geom_point(alpha = .2) +
        guides(color = guide_legend(override.aes = list(alpha = 1), reverse = TRUE)) +
        theme(legend.position = "bottom")




#############
# Your Turn #
#############

# Try to re-create displayed visualization as close as possible

ggplot(supermarket, aes(Revenue)) +
        geom_histogram(bins = 100, fill = "antiquewhite", color = "grey40") +
        scale_x_continuous(limits = c(0, 60), breaks = seq(0, 60, by = 10),
                           labels = scales::dollar) +
        ggtitle("Gross Revenue per Transaction")


# harder one

## arrange cities by revenue
cty_levels <- supermarket %>%
        group_by(City) %>%
        summarise(Revenue = sum(Revenue, na.rm = TRUE)) %>%
        arrange(Revenue)

## summarise revenue by cities and gender and then set order of city
## with factor and levels
city_rev <- supermarket %>%
        group_by(City, Gender) %>%
        summarise(Revenue = sum(Revenue, na.rm = TRUE)) %>%
        ungroup() %>%
        mutate(City = factor(City, levels = cty_levels$City))

ggplot(city_rev, aes(Revenue, City, color = Gender)) +
        geom_point() +
        scale_x_continuous(labels = scales::dollar, 
                           limits = c(0, 10000),
                           breaks = seq(0, 10000, by = 2000)) +
        labs(x = NULL, y = NULL, title = "Total Revenue by Gender and Location") +
        theme_minimal()


##########
# Themes #
##########

# Several theme options are available (even more in the ggthemes package)
p <- ggplot(supermarket, aes(Revenue)) +
        geom_histogram(bins = 100, fill = "antiquewhite", color = "grey40")

p + theme_classic()
p + theme_minimal()
p + theme_dark()

# add some parameters to the theme() function to adjust how the graphic looks
basic + theme_minimal() +
        theme(
                text = element_text(family = "Georgia"),
                plot.title = element_text(face = "bold", size = 16), 
                legend.position = "top",
                axis.ticks = element_line(colour = "grey70", size = 0.2),
                panel.grid.major.y = element_line(linetype = "dashed", color = "darkgray"),
                panel.grid.major.x = element_blank(),
                panel.grid.minor = element_blank()
        )



#############
# Your Turn #
#############

# Using this base plot practice adjusting theme parameters.

ggplot(supermarket, aes(Revenue)) +
        geom_histogram(bins = 100, fill = "antiquewhite", color = "grey40")



