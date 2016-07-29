# Session 3: Understanding Data Structures


###########
# Vectors #
###########
# Notes: 

# Creating vectors


# Understanding vector properties
facebook <- read.delim("data/facebook.tsv")
likes <- facebook$likes

# Extracting/subsetting vectors (vector[i])


# Comparison operators


# Subsetting data based on comparison operators


# Summarizing vectors



##############
# YOUR TURN! #
##############
# Save the friend_count variable from the facebook data as a vector:

fc <- facebook$friend_count

# 1. What are the min, max, median, and mean number of friends?

# 2. How many people have 0 friends?

# 3. How many people have 1,000 or more friends?

# 4. Which element contains the maximum number of friends?





############
# Matrices #
############
# Notes: 

# Creating matrices


# Understanding matrix properties
m <- matrix(runif(12), nrow = 3)


# Extracting/subsetting matrices (matrix[row, col])


# Comparison operators


# Summarizing matrices



##############
# YOUR TURN! #
##############
# Save the friend_count variable from the facebook data as a vector:

fc <- facebook$friend_count

# 1. Subset fc to find individuals with more than 4,600 friends


# 2. Turn this subsetted vector into a matrix with 10 rows


# 3. What are the dimensions of this matrix






############
# Lists #
############
# Notes: 

# Creating lists
l1 <- list(item1 = 1:3,
           item2 = letters[1:5],
           item3 = c(T, F, T, T),
           item4 = matrix(1:9, nrow = 3))


# Understanding list properties


# Extracting/subsetting lists 


# What you need to know - how to get results out of statistical models
model <- lm(mpg ~ wt, data = mtcars)    # linear regression model
mode(model)
str(model)
names(model)



##############
# YOUR TURN! #
##############
# Create this linear regression model:

fb_model <- lm(friend_count ~ gender + age, data = facebook)

# 1. Extract the residuals from the fb_model list


# 2. What is the min, max, median, and mean of these residuals?






###############
# Data Frames #
###############
# Notes: 

# Creating data frames
df <- data.frame(variable.1 = 1:3,
                 variable.2 = c("a", "b", "c"),
                 variable.3 = c(TRUE, TRUE, FALSE))


# Understanding data frame properties


# Extracting/subsetting data frames (data.frame[row, col])


# Conditional subsetting data frames (subset[data.frame, row condition, column selection])


# Summarizing data frames



##############
# YOUR TURN! #
##############
# 1. Import the reddit data located at https://bradleyboehmke.github.io/public/data/reddit.csv


# 2. What variables (column names) does this data frame contain?


# 3. How many users have the employment status of "Student"?


# 4. Subset the reddit data frame for only those individuals that are students.










