# Session 3: Understanding Data Structures


###########
# Vectors #
###########

# Creating vectors
## simple vector creation
1:10
2.5:15
c(2, 10, 4)


## sequences of numbers with non-random specifications
seq(0, 30, by = 3)
seq(0, 30, length.out = 6)
rep(1:4, times = 2)
rep(1:4, each = 2)


## sequences of numbers with random specifications
runif(n = 100, min = 0, max = 10)
rnorm(n = 100, mean = 10, sd = 2)


# Understanding vector properties
facebook <- read.delim("data/facebook.tsv")
likes <- facebook$likes

class(likes)
str(likes)
length(likes)
head(likes)
tail(likes, 20)


# Extracting/subsetting vectors (vector[i])
## extract elements with bracket notation
likes[1]
likes[1:10]
likes[c(10, 13512, 3778, 59131)]


## extract elements based on another vector
subset_vector <- c(10, 13512, 3778, 59131, 99004)
x <- likes[subset_vector]


# Comparison operators
viral <- likes >= 5000
dull <- likes == 0
normal <- likes > 0 & likes < 5000
know_somebody <- likes != 0

sum(viral)
sum(viral) / length(likes)
which(viral)


# Subsetting data based on comparison operators
likes[likes > 15000]
popular <- likes[likes >= 5000]
lonely <- likes[likes == 0]


# Summarizing vectors
summary(likes)
mean(likes, na.rm = TRUE)
median(likes, na.rm = T)
sd(likes)
range(likes)
min(likes)
max(likes)


##############
# YOUR TURN! #
##############
# Save the friend_count variable from the facebook data as a vector:
        
fc <- facebook$friend_count

# 1. What are the min, max, median, and mean number of friends?
summary(fc)

# 2. How many people have 0 friends?
sum(fc == 0)

# 3. How many people have 1,000 or more friends?
sum(fc >= 1000)

# 4. Which element contains the maximum number of friends?
which(fc == max(fc))



############
# Matrices #
############

# Creating matrices
matrix(1:12, nrow = 3, ncol = 3)


# Understanding matrix properties
m <- matrix(runif(12), nrow = 3)

class(m)
str(m)
length(m)
dim(m)


# Extracting/subsetting matrices (matrix[row, col])
m[1, 3]
m[1:2, ]
m[, 2]
m[, 2, drop = FALSE]


# Comparison operators
m > .5
sum(m > .5)
which(m > .5)
m[m > .5]


# Summarizing matrices
summary(m)
mean(m)
median(m)
mean(m[1, ])
apply(m, MARGIN = 1, FUN = mean)


##############
# YOUR TURN! #
##############
# Save the friend_count variable from the facebook data as a vector:

fc <- facebook$friend_count

# 1. Subset fc to find individuals with more than 4,600 friends
Q1 <- fc[fc > 4600]

# 2. Turn this subsetted vector into a matrix with 10 rows
Q2 <- matrix(Q1, nrow = 10)

# 3. What are the dimensions of this matrix
dim(Q2)





############
# Lists #
############

# Creating lists
l1 <- list(item1 = 1:3,
           item2 = letters[1:5],
           item3 = c(T, F, T, T),
           item4 = matrix(1:9, nrow = 3))
l1


# Understanding list properties
class(l1)
str(l1)
length(l1)
names(l1)


# Extracting/subsetting lists 
l1["item4"]
l1[["item4"]]
l1$item4

l1[[2]]
l1[[2]][2]
l1$item2[2]


# What you need to know - how to get results out of statistical models
model <- lm(mpg ~ wt, data = mtcars)    # linear regression model
mode(model)
str(model)
names(model)

model$residuals


##############
# YOUR TURN! #
##############
# Create this linear regression model:

fb_model <- lm(friend_count ~ gender + age, data = facebook)

# 1. Extract the residuals from the fb_model list
Q1 <- fb_model$residuals

# 2. What is the min, max, median, and mean of these residuals?
summary(Q1)





###############
# Data Frames #
###############

# Creating data frames
df <- data.frame(variable.1 = 1:3,
                 variable.2 = c("a", "b", "c"),
                 variable.3 = c(TRUE, TRUE, FALSE))


# Understanding data frame properties
class(facebook)
names(facebook)
str(facebook)


# Extracting/subsetting data frames (data.frame[row, col])
## extract the second column and all rows using column indexing or the name
facebook[, 2]
facebook[, "age"]

## extract all rows and columns 1 through 3
facebook[, 1:3]
facebook[, c("userid", "age", "dob_day")]

## subset for first row and all columns
facebook[1, ]

## use a vector to subset
columns <- c(2, 3, 5)
rows <- c(1:25)
facebook[rows, columns]


# Conditional subsetting data frames (subset[data.frame, row condition, column selection])
subset(facebook, age == 113, 1:10)
subset(facebook, gender == "male" & age > 35, likes)


# Summarizing data frames
## summarize a single variable (column)
summary(facebook$tenure)

## summarize specific variables (columns)
summary(facebook[, c("age", "friend_count")])

## summary stats for all columns
summary(facebook)



##############
# YOUR TURN! #
##############
# 1. Import the reddit data located at https://bradleyboehmke.github.io/public/data/reddit.csv
url <- "https://bradleyboehmke.github.io/public/data/reddit.csv"
reddit <- read.csv(url)

# 2. What variables (column names) does this data frame contain?
names(reddit)

# 3. How many users have the employment status of "Student"?
summary(reddit$employment.status)

# 4. Subset the reddit data frame for only those individuals that are students.
students <- subset(reddit, employment.status == "Student")









