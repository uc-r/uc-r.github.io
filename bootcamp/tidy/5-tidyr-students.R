# Session 5: Creating tidy data sets with tidyr



################
# Requirements #
################
# install.packages("tidyr")
library(tidyr)

install.packages("EDAWR")
library(EDAWR)

# data used (from the EDAWR package)
cases
storms


#####################
# pipe %>% operator #
#####################
# Notes: 

library(dplyr)

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
# separate() #
##############
# Notes: 


# these two options are the same
separate(data = storms, col = date, into = c("year", "month", "day"), sep = "-")
storms %>% separate(date, c("year", "month", "day"), sep = "-")



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
