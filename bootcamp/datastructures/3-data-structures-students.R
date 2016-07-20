# Session 3: Understanding Data Structures


###########
# Vectors #
###########
# Notes: 

# Creating vectors


# Understanding vector properties


# Extracting/subsetting vectors (vector[i])


# Comparison operators


# Summarizing vectors




############
# Matrices #
############
# Notes: 

# Creating matrices


# Understanding matrix properties


# Extracting/subsetting matrices (matrix[row, col])


# Comparison operators


# Summarizing matrices




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









