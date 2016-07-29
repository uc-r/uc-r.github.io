# Session 5: Creating tidy data sets with tidyr


################
# Requirements #
################
# install.packages("tidyr")
# install.packages("dplyr")
# devtools::install_github("rstudio/EDAWR")

library(tidyr)
library(dplyr)  # to illustrate pipe function
library(EDAWR)  # for the data

# data used (from the EDAWR package)
cases
storms


#####################
# pipe %>% operator #
#####################
# Notes: 


# filter(data, variable == numeric_value) is the same as...
# data %>% filter(variable == numeric_value)

# nested function approach
summarise(
        group_by(
                filter(mtcars, am == 1),
                cyl
        ),
        Avg_mpg = mean(mpg)
)

# multiple object approach
a <- filter(mtcars, am == 1)
b <- group_by(a, cyl)
c <- summarise(b, Avg_mpg = mean(mpg))

# pipe approach
mtcars %>%
        filter(am == 1) %>%
        group_by(cyl) %>%
        summarise(Avg_mpg = mean(mpg))


############
# gather() #
############
# Notes: 


# these two options are the same
gather(data = cases, key = Year, value = n, 2:4)
cases %>% gather(Year, n, 2:4)



##############
# YOUR TURN! #
##############
# Import the `expenditures.csv` file in the data folder


# Reshape this data from wide to long





############
# spread() #
############
# Notes: 


# if our data is wide we can spread it out
wide <- cases %>% gather(Year, n, 2:4)
wide

# these two options are the same
spread(data = wide, key = Year, value = n)
wide %>% spread(Year, n)



##############
# YOUR TURN! #
##############
# Create the following data frame
long <- expenditures %>% gather(Year, Costs, 2:15)

# Reshape this data from long to wide





##############
# separate() #
##############
# Notes: 


# these two options are the same
separate(data = storms, col = date, into = c("year", "month", "day"), sep = "-")
storms %>% separate(date, c("year", "month", "day"), sep = "-")



##############
# YOUR TURN! #
##############
# using the original expenditures data...

# 1. Reshape this data from wide to long


# 2. Separate FY from the Year





###########
# unite() #
###########
# Notes: 


# if we want to unite separate columns
sep_col <- storms %>% separate(date, c("year", "month", "day"), sep = "-")
sep_col

# these two options work the same
unite(data = sep_col, col = date, year, month, day, sep = "-")
sep_col %>% unite(date, year, month, day, sep = "-")



##############
# YOUR TURN! #
##############
# Import the facebook.tsv file in the data folder


# Combine the `Period` and `Year` variables


