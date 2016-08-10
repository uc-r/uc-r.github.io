# Download the most recent Occupational Employment Statistics data (May 2015)
# from https://www.dropbox.com/s/5cagoqaa67uix3e/all_data_M_2015.xlsx?dl=0

library(readxl)
library(dplyr)
library(ggplot2)
library(ggthemes)

oes <- read_excel("data/all_data_M_2015.xlsx", sheet = 'All May 2015 Data')



# How does Cincinnati rank nationally for median annual wage across all occupations & industries?
# Note, you only want to compare Cincinnati to other Metropolitan Statistical Areas
oes %>%
        filter(area_type == "4", `occ title` == "All Occupations") %>%
        arrange(desc(a_mean)) %>%
        select(area_title, a_median) %>%
        mutate(rank = seq(1, n(), by = 1)) %>%
        filter(area_title == "Cincinnati, OH-KY-IN")



# How does Cincinnati rank among the following locations for median annual wage and
# also total employment
cities <- c("Akron, OH", "Cincinnati, OH-KY-IN", "Cleveland-Elyria, OH", "Columbus, OH", 
            "Dayton, OH", "Springfield, OH", "Toledo, OH")

oes %>%
        filter(area_title %in% cities, `occ title` == "All Occupations") %>%
        select(area_title, a_median, tot_emp) %>%
        arrange(desc(a_median)) %>%
        mutate(salary_rank = seq(1, n(), 1))  %>%
        arrange(desc(tot_emp)) %>%
        mutate(employment_rank = seq(1, n(), 1))


# Identify the top 25 occupations that employ the most people in Cincinnati
top25_emp <- oes %>%
        filter(area_title == "Cincinnati, OH-KY-IN", `occ title` != "All Occupations") %>%
        select(area_title, `occ title`, tot_emp) %>%
        arrange(desc(tot_emp)) %>%
        top_n(25) %>%
        arrange(tot_emp) %>%
        mutate(`occ title` = factor(`occ title`, levels = .$`occ title`))

ggplot(top25_emp, aes(tot_emp, `occ title`)) +
        geom_point() +
        scale_x_continuous(labels = scales::comma) +
        labs(title = "Top 25 Occupations for Employment in Cincinnati",
             subtitle = "Measured as estimated total employment within each occupation rounded \nto the nearest 10 (excludes self-employed).",
             caption = "Source: Bureau of Labor Statistics",
             y = NULL, x = "Total Employment") +
        theme_minimal() +
        theme(text = element_text(family = "Georgia"),
              axis.title.x = element_text(margin = margin(t = 15)),
              plot.title = element_text(size = 18, margin = margin(b = 10)),
              plot.subtitle = element_text(size = 12, color = "darkslategrey", margin = margin(b = 25)),
              plot.caption = element_text(size = 8, margin = margin(t = 10), color = "grey70"))



# Do these occupations provide the top paying salaries? If not, which occupations do?
top25_salary <- oes %>%
        filter(area_title == "Cincinnati, OH-KY-IN", `occ title` != "All Occupations") %>%
        select(`occ title`, tot_emp, a_median) %>%
        arrange(desc(tot_emp)) %>%
        mutate(emp_rank = seq(1, n(), 1))  %>%
        arrange(desc(a_median)) %>%
        mutate(salary_rank = seq(1, n(), 1)) %>%
        head(25) %>%
        arrange(a_median) %>%
        mutate(`occ title` = factor(`occ title`, levels = .$`occ title`))

ggplot(top25_salary, aes(a_median, `occ title`)) +
        geom_point() +
        scale_x_continuous(labels = scales::comma) +
        labs(title = "Top 25 Occupations for Salary in Cincinnati",
             subtitle = "Measured as the annual median wage (or the 50th percentile).",
             caption = "Source: Bureau of Labor Statistics",
             y = NULL, x = "Median Annual Wage") +
        theme_minimal() +
        theme(text = element_text(family = "Georgia"),
              axis.title.x = element_text(margin = margin(t = 15)),
              plot.title = element_text(size = 18, margin = margin(b = 10)),
              plot.subtitle = element_text(size = 12, color = "darkslategrey", margin = margin(b = 25)),
              plot.caption = element_text(size = 8, margin = margin(t = 10), color = "grey70"))



