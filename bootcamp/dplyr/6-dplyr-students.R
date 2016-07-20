# Session 6: Transforming & manipulating data sets with dplyr



################
# Requirements #
################
# install.packages("dplyr")
library(dplyr)

install.packages("EDAWR")
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
# Notes: 


# these two options are the same
select(storms, storm, pressure)
storms %>% select(storm, pressure)


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
# group_by() #
##############
# Notes: 


# these two options are the same
group_by(tb, country)
tb %>% group_by(country)

# group by multiple categorical variables
tb %>% group_by(country, year)



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



#############
# arrange() #
#############
# Notes: 


iris %>% arrange(Sepal.Length)
iris %>% arrange(desc(Sepal.Length))



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







