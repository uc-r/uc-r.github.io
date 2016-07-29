# Session 4: Understanding Data Types


###########
# Numbers #
###########
# Notes: 


# two types of numbers
dbl_var <- c(1, 2.5, 4.5)
int_var <- c(1L, 6L, 10L)


# comparing numbers
x <- c(4, 4, 9, 12)
y <- c(4, 4, 9, 12.00000008)
z <- c(4, 4, 9, 12)


# rounding numbers
x <- c(1, 1.35, 1.7, 2.05, 2.4, 2.75)



##############
# YOUR TURN! #
##############
# Import the numbers-your-turn.csv file in the data folder

# 1. Are the vectors x & y equal? Exactly or approximately equal?


# 2. Are the vectors y & z equal? Exactly or approximately equal?


# 3. Round x & y numbers to the 4th digit


# 4. Are these vectors equal now?



##############
# Characters #
##############
# Notes: 


# creating character strings
a <- "learning to create"
b <- "character strings"


# testing, converting & coercing character strings
a <- "Life of"
b <- pi


# summarizing character strings
c1 <- "How many elements are in this string?"
c2 <- c("How", "many", "elements", "are", "in", "this", "string?")



###########
# Factors #
###########
# Notes: 


# creating factors
gender <- c("male", "female", "female")
age.range <- c("18-24", "25-34", "35-44", "45-54", "55-64", "65 or Above", "Under 18")
levels <- c("Under 18", "18-24", "25-34", "35-44", "45-54", "55-64", "65 or Above")


# summarizing factors
facebook <- read.delim("data/facebook.tsv")



##############
# YOUR TURN! #
##############
# Import the reddit.csv file in the data folder

# 1. What are the levels for the income.range variable?


# 2. Properly order the levels for income.range.


# 3. What are the counts for each level?



#########
# Dates #
#########
# Notes: 


# creating dates
dates <- c("2015-07-01", "2015-08-01", "2015-09-01")
class(dates)

# install.packages("lubridate") # run this line if you have not yet installed lubridate
library(lubridate)


# create dates by merging
yr <- c("2012", "2013", "2014", "2015") 
mo <- c("1", "5", "7", "2")
day <- c("02", "22", "15", "28")


# extracting & manipulating parts of dates
full_date <- as.Date(ISOdate(year = c("2012", "2013", "2014", "2015"),
                             month = c("1", "5", "7", "2"),
                             day = c("02", "22", "15", "28")))


# summarizing dates
dates <- ymd(lakers$date)



##############
# YOUR TURN! #
##############
# Import the facebook.tsv file in the data folder

# 1. Create a new date variable that combines the dob_day, dob_month, & 
#    dob_year variables. 


# 2. What is the min, max, mean, and median date of births in this data frame?





##################
# Logical Values #
##################
# Notes: 


# the basics
x <- c(4, 4, 9, 12, 2, 2, 10)
y <- c(4, 5, 9, 13, 2, 1, 10)





