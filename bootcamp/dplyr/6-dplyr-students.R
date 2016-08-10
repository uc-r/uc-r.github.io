# Session 6: Transforming & manipulating data sets with dplyr


################
# Requirements #
################
# install.packages("dplyr")
# devtools::install_github("rstudio/EDAWR")

library(dplyr)
library(EDAWR)

# data used (from the EDAWR package)
storms
tb
pollution
iris
a
b


############
# select() #
############

# these two options are the same
select(storms, storm, pressure)
storms %>% select(storm, pressure)



##############
# YOUR TURN! #
##############
# Import the facebook.tsv file in the data folder
facebook <- read.delim("data/facebook.tsv")

# Create a new data frame that includes: userid, age, gender, friend_count
facebook2 <- facebook %>% select(userid, age, gender, friend_count)

head(facebook2)




############
# filter() #
############
# Notes: 


# these two options are the same
filter(storms, wind >= 50)
storms %>% filter(wind >= 50)

# can filter for multiple conditions
storms %>% filter(wind >= 50,
                  storm %in% c("Alberto", "Alex", "Allison"))



##############
# YOUR TURN! #
##############
# 1. Filter the facebook data for just males
fb_males <- facebook %>% filter(gender == "male")


# 2. Select the userid, age, gender, friend_count variables and then 
#    filter for males

# Option 1
facebook2 <- facebook %>% select(userid, age, gender, friend_count)
fb2_males <- facebook %>% filter(gender == "male")

# Option 2
fb2_males <- facebook %>%
        select(userid, age, gender, friend_count) %>%
        filter(gender == "male")

fb2_males




##############
# group_by() #
##############
# Notes: 


# these two options are the same
group_by(tb, country)
tb %>% group_by(country)

# group by multiple categorical variables
tb %>% group_by(country, year)



##############
# YOUR TURN! #
##############
# 1. Select the userid, age, gender, friend_count variables variables and 
#    then group by gender
facebook %>%
        select(userid, age, gender, friend_count) %>%
        group_by(gender)




###############
# summarise() #
###############
# Notes: 


iris

# these are the same
summarise(iris, Avg_SL = mean(Sepal.Length))
iris %>% summarise(Avg_SL = mean(Sepal.Length))

# get multiple summary statistics of a single variable
iris %>% summarise(mean_SL = mean(Sepal.Length),
                   med_SL = median(Sepal.Length),
                   SD_SL = sd(Sepal.Length),
                   n = n())


# combine group_by() and summarise()
iris %>% 
        group_by(Species) %>%
        summarise(mean_SL = mean(Sepal.Length),
                  med_SL = median(Sepal.Length),
                  SD_SL = sd(Sepal.Length),
                  n = n())

# get summary statistics of multiple variables
iris %>% 
        group_by(Species) %>%
        summarise_each(funs(mean))

iris %>% 
        group_by(Species) %>%
        summarise_each(funs(mean, sd))



##############
# YOUR TURN! #
##############
# Continuing with our facebook data...
# 1. Calculate the mean and median for tenure and friend_count
facebook %>% summarise(tenure_avg = mean(tenure, na.rm = TRUE),
                       tenure_med = median(tenure, na.rm = TRUE),
                       fc_avg = mean(friend_count, na.rm = TRUE),
                       fc_med = median(friend_count, na.rm = TRUE))

# 2. Select the gender, age, and friend_count variables, group by gender, 
# and calculate mean and median
facebook %>%
        select(gender, age, friend_count) %>%
        group_by(gender) %>%
        summarise_each(funs(mean, median))



#############
# arrange() #
#############
# Notes: 


iris %>% arrange(Sepal.Length)
iris %>% arrange(desc(Sepal.Length))



##############
# YOUR TURN! #
##############
# Continuing with our facebook data...
# 1. Group the data by age
# 2. Calculate the median friend_count for each age
# 3. Arrange the median calculated friend_count variable in descending order 
# to find the ages with the greatest median friend count
facebook %>% 
        group_by(age) %>% 
        summarise(friend_count = median(friend_count, na.rm = TRUE)) %>% 
        arrange(desc(friend_count))



############
# mutate() #
############
# Notes: 


# add a new variable to the iris data
iris
iris %>% mutate(Sepal.Area = Sepal.Length * Sepal.Width)

# create a new variable but drop all the original columns
iris %>% transmute(Sepal.Area = Sepal.Length * Sepal.Width)

# apply function to each column - in this case get the ranking of each
# value for each variable
iris %>% mutate_each(funs(min_rank))



##############
# YOUR TURN! #
##############
# Continuing with our facebook data...
# 1. Create a new variable `friend_ratio` that equals friendships_initiated / friend_count
# 2. Find the median `friend_ratio` for males and females
facebook %>% 
        mutate(friend_ratio = friendships_initiated / friend_count) %>%
        group_by(gender) %>%
        summarise(fr_median = median(friend_ratio, na.rm = TRUE))



#########
# joins #
#########
# Notes: 


# there are different ways to join a and b
a
b

# left_join
left_join(a, b, by = "x1")
a %>% left_join(b)

# right_join
right_join(a, b, by = "x1")
a %>% right_join(b, by = "x1")

# inner_join
inner_join(a, b, by = "x1")
a %>% inner_join(b, by = "x1")

# full_join
full_join(a, b, by = "x1")
a %>% full_join(b, by = "x1")

# semi_join
semi_join(a, b, by = "x1")
a %>% semi_join(b, by = "x1")

# anti_join
anti_join(a, b, by = "x1")
a %>% anti_join(b, by = "x1")



##############
# YOUR TURN! #
##############
# 1. Import the reddit.csv and regions.csv files in the data folder
reddit <- read.csv("data/reddit.csv", stringsAsFactors = FALSE)
regions <- read.csv("data/regions.csv", stringsAsFactors = FALSE)


# 2. Join the regions data to the reddit data
reddit <- reddit %>% left_join(regions)







