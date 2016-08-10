# Download the Police Crime Incident Data at 
# https://www.dropbox.com/s/vc4ldivb2op7phl/crime.csv?dl=0

library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(lubridate)

crime <- read_csv("data/crime.csv")


# What are the top 25 most prevelant offenses in this data set? What are some
# issues you are finding with the coding of this data?

# notice the difference in capitalization
crime %>%
        group_by(Offense) %>%
        tally() %>%
        arrange(desc(n))

# change to lower
crime$Offense <- tolower(crime$Offense)

top25_offenses <- crime %>%
        group_by(Offense) %>%
        tally() %>%
        arrange(desc(n)) %>%
        top_n(25)  %>%
        arrange(n) %>%
        mutate(Offense = factor(Offense, levels = .$Offense))


ggplot(top25_offenses, aes(n, Offense)) +
        geom_point() +
        labs(title = "Top 25 Criminal Offenses in Cincinnati", y = NULL, x = NULL) +
        scale_x_continuous(labels = scales::comma) +
        theme_minimal()

# Have the rate of occurrence for the top 10 offenses increasing or decreasing
# since 2010?
offenses <- top25_offenses %>%
        arrange(desc(n)) %>%
        top_n(10) %>%
        mutate(Offense = as.character(Offense)) %>%
        .$Offense

top10_offenses <- crime %>%
        filter(Offense %in% offenses) %>%
        mutate(Year = year(dmy(`Occurred On`))) %>%
        group_by(Offense, Year) %>%
        tally() %>%
        filter(Year >= 2010)

ggplot(top10_offenses, aes(Year, n, color = Offense)) +
        geom_line() +
        facet_wrap(~ Offense) +
        theme(legend.position = "none")


# What are the top 10 most prevelant offenses so far this year?
top10_2016 <- crime %>%
        filter(year(dmy(`Occurred On`)) == 2016) %>%
        group_by(Offense) %>%
        tally() %>%
        arrange(desc(n)) %>%
        top_n(10)

top10_2016


# What neighborhoods are these offenses most often occuring in?
crime %>%
        filter(Offense %in% top10_2016$Offense) %>%
        group_by(Offense, Neighborhood) %>%
        tally() %>%
        arrange(Offense, desc(n)) %>%
        group_by(Offense) %>%
        top_n(1)
