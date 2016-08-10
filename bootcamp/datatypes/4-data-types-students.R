# Session 4: Understanding Data Types


###########
# Numbers #
###########

# two types of numbers
dbl_var <- c(1, 2.5, 4.5)
int_var <- c(1L, 6L, 10L)

class(dbl_var)
class(int_var)

as.integer(dbl_var)
as.double(int_var)

c(dbl_var, int_var)



# comparing numbers
x <- c(4, 4, 9, 12)
y <- c(4, 4, 9, 12.00000008)
z <- c(4, 4, 9, 12)

x == y
identical(x, y)
identical(x, z)
all.equal(x, y)         # all.equal assess near equality

# rounding numbers
x <- c(1, 1.35, 1.7, 2.05, 2.4, 2.75)

round(x)
round(x, digits = 1)
ceiling(x)
floor(x)


##############
# YOUR TURN! #
##############
# Import the numbers-your-turn.csv file in the data folder
df <- read.csv("data/numbers-your-turn.csv")

# 1. Are the vectors x & y equal? Exactly or approximately equal?
identical(df$x, df$y)
all.equal(df$x, df$y)

# 2. Are the vectors y & z equal? Exactly or approximately equal?
identical(df$x, df$z)
all.equal(df$x, df$z)

# 3. Round x & y numbers to the 4th digit
x <- round(df$x, digits = 4)
y <- round(df$y, digits = 4)

# 4. Are these vectors equal now?
identical(x, y)
all.equal(x, y)


##############
# Characters #
##############

# creating character strings
a <- "learning to create"
b <- "character strings"

## combine vectors with c(), paste(), or paste0
c(a, b)
paste(a, b)
paste(a, b, "in R")
paste("paste", "a", "string", "with", "dashes", sep = "-")
paste0("paste", "a", "string", "with", "no", "spaces")


# testing, converting & coercing character strings
a <- "Life of"
b <- pi

class(a)
mode(a)
is.character(a)

## coerce a non-character to character with as.character
as.character(pi)

## combining numbers and characters forces numbers to characters
c(a, pi)


# summarizing character strings
c1 <- "How many elements are in this string?"
c2 <- c("How", "many", "elements", "are", "in", "this", "string?")

length(c1)
length(c2)

nchar(c1)
nchar(c2)


###########
# Factors #
###########

# creating factors
gender <- c("male", "female", "female")
age.range <- c("18-24", "25-34", "35-44", "45-54", "55-64", "65 or Above", "Under 18")
levels <- c("Under 18", "18-24", "25-34", "35-44", "45-54", "55-64", "65 or Above")

class(gender)
factor(gender)
factor(gender, levels = c("male", "female"))

ordered(age.range)
ordered(age.range, levels = c("Under 18", "18-24", "25-34", "35-44", "45-54", "55-64", "65 or Above"))


# summarizing factors
facebook <- read.delim("data/facebook.tsv")

levels(facebook$gender)
table(facebook$gender)



##############
# YOUR TURN! #
##############
# Import the reddit.csv file in the data folder
reddit <- read.csv("data/reddit.csv")

# 1. What are the levels for the income.range variable?
levels(reddit$income.range)

# 2. Properly order the levels for income.range.
reddit$income.range <- ordered(reddit$income.range, 
                               levels = c("Under $20,000", "$20,000 - $29,999", "$30,000 - $39,999",
                                          "$40,000 - $49,999", "$50,000 - $69,999", "$70,000 - $99,999",
                                          "$100,000 - $149,999", "$150,000 or more"))

# 3. What are the counts for each level?
table(reddit$income.range)



#########
# Dates #
#########

# creating dates
dates <- c("2015-07-01", "2015-08-01", "2015-09-01")
class(dates)

# install.packages("lubridate") # run this line if you have not yet installed lubridate
library(lubridate)

dates2 <- ymd(dates)
class(dates2)
dates2


# create dates by merging
yr <- c("2012", "2013", "2014", "2015") 
mo <- c("1", "5", "7", "2")
day <- c("02", "22", "15", "28")

full_date <- ISOdate(year = yr, month = mo, day = day)
full_date
as.Date(full_date)


# extracting & manipulating parts of dates
full_date <- as.Date(ISOdate(year = c("2012", "2013", "2014", "2015"),
                             month = c("1", "5", "7", "2"),
                             day = c("02", "22", "15", "28")))

year(full_date)
week(full_date)
wday(full_date, label = TRUE)


# summarizing dates
dates <- ymd(lakers$date)

min(dates)
max(dates)
mean(dates)
summary(dates)



##############
# YOUR TURN! #
##############
# Import the `facebook.tsv` file in the data folder
facebook <- read.delim("data/facebook.tsv")

# 1. Create a new date variable that combines the dob_day, dob_month, & dob_year variables.
facebook$dob <- as.Date(ISOdate(year = facebook$dob_year, 
                                month = facebook$dob_month, 
                                day = facebook$dob_day))

# 2. What is the min, max, mean, and median date of births in this data frame?
summary(facebook$dob)




##################
# Logical Values #
##################
# Notes: 


# the basics
x <- c(4, 4, 9, 12, 2, 2, 10)
y <- c(4, 5, 9, 13, 2, 1, 10)

x == y
z <- x == y
class(z)

# any, all, and which are TRUE
any(z)
all(z)
which(z)


