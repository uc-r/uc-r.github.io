# Session 2: Get me some data!

######################
# Built-in Data Sets #
######################

# R built-in data sets
data()

mtcars
iris
USArrests

# package built-in data sets
data(package = "ggplot2")       
economics

# understand more behind the data
?economics


########################
# Importing Text Files #
########################

# importing text files
read.csv("data/mydata.csv")
read.delim("data/mydata.txt")

# assign data to new object
mydata <- read.delim("data/mydata.tsv")
mydata

View(mydata)



##############
# YOUR TURN! #
##############
# 1. Read in the facebook.tsv file in the data folder
read.delim("data/facebook.tsv")

# 2. Read in and save the facebook.tsv file as an object titled facebook
facebook <- read.delim("data/facebook.tsv")

# 3. Take a peek at what this data looks like
View(facebook)



#########################
# Importing Excel Files #
#########################
# install.packages("readxl")
library(readxl)

read_excel("data/mydata.xlsx", sheet = "Sheet5")

# people love to make notes at the top of Excel files
read_excel("data/mydata.xlsx", sheet = "Sheet3")
read_excel("data/mydata.xlsx", sheet = "Sheet3", skip = 2)



##############
# YOUR TURN! #
##############
# 1. Read in the spreadsheet titled "3. Median HH income, metro" in the 
# "PEW Middle Class Data.xlsx" file
read_excel("data/PEW Middle Class Data.xlsx", 
           sheet = "3. Median HH income, metro", 
           skip = 5)

# 2. Save it as an object titled pew
pew <- read_excel("data/PEW Middle Class Data.xlsx", 
                  sheet = "3. Median HH income, metro", 
                  skip = 5)

# 3. Take a peek at what this data looks like
View(pew)



#########################
# Scraping Online Files #
#########################

# scraping text files
url <- "https://www.data.gov/media/federal-agency-participation.csv" 
data_gov <- read.csv(url)

View(data_gov)

# scraping Excel files
library(gdata)

url <- "http://www.huduser.org/portal/datasets/fmr/fmr2015f/FY2015F_4050_Final.xls"
rents <- read.xls(url)

View(rents)




##############
# YOUR TURN! #
##############
# 1. Download the file stored at: https://bradleyboehmke.github.io/public/data/reddit.csv

url <- "https://bradleyboehmke.github.io/public/data/reddit.csv"
read.csv(url)

# 2. Save it as an object titled reddit
reddit <- read.csv(url)

# 3. Take a peek at what this data looks like
View(reddit)

