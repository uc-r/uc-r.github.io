---
layout: tutorial
title: Style Guide
permalink: /style/
---


> *"Good coding style is like using correct punctuation. You can manage without it, but it sure makes things easier to read."* - Hadley Wickham 

As a medium of communication, its important to realize that the readability of code does in fact make a difference. Well styled code has many benefits to include making it easy to *i*) read, *ii*) extend, and *iii*) debug. Unfortunately, R does not come with official guidelines for code styling but such is an inconvenient truth of most open source software. However, this should not lead you to believe there is no style to be followed and over time implicit guidelines for proper code styling have been documented. What follows are guidelines that have been widely accepted as good practice in the R community and are based on [Google's](https://google.github.io/styleguide/Rguide.xml) and [Hadley Wickham's](http://adv-r.had.co.nz/Style.html) R style guides. 

<br>

## Notation and naming
File names should be meaningful and end with a `.R` extension.


```r
# Good
weather-analysis.R
emerson-text-analysis.R

# Bad
basic-stuff.r
detail.r
```

If files need to be run in sequence, prefix them with numbers:


```r
0-download.R
1-preprocessing.R
2-explore.R
3-fit-model.R
```

In R, naming conventions for variables and function are famously muddled. They include the following:


```r
namingconvention        # all lower case; no separator
naming.convention       # period separator
naming_convention       # underscore separator
namingConvention        # lower camel case
NamingConvention        # upper camel case
```

Historically, there has been no clearly preferred approach with multiple naming styles sometimes used within a single package. Bottom line, your naming convention will be driven by your preference but the ultimate goal should be consistency.

My personal preference is to use all lowercase with an underscore (_) to separate words within a name. This follows Hadley Wickham's suggestions in his style guide. Furthermore, variable names should be nouns and function names should be verbs to help distinguish their purpose. Also, refrain from using existing names of functions (i.e. mean, sum, true).

<br>

## Organization
Organization of your code is also important.  There's nothing like trying to decipher 2,000 lines of code that has no organization. The easiest way to achieve organization is to comment your code.  The general commenting scheme I use is the following.

I break up principal sections of my code that have a common purpose with:


```r
#################
# Download Data #
#################
lines of code here

###################
# Preprocess Data #
###################
lines of code here

########################
# Exploratory Analysis #
########################
lines of code here
```

Then comments for specific lines of code can be done as follows:


```r
code_1  # short comments can be placed to the right of code 
code_2  # blah
code_3  # blah

# or comments can be placed above a line of code
code_4

# Or extremely long lines of commentary that go beyond the suggested 80 
# characters per line can be broken up into multiple lines. Just don't forget
# to use the hash on each.
code_5
```

<br>

## Syntax

The maximum number of characters on a single line of code should be 80 or less. If you are using RStudio you can have a margin displayed so you know when you need to break to a new line.[^character_length]  This allows your code to be printed on a normal 8.5 x 11 page with a reasonably sized font.  Also, when indenting your code use two spaces rather than using tabs.  The only exception is if a line break occurs inside parentheses. In this case align the wrapped line with the first character inside the parenthesis:


```r
super_long_name <- seq(ymd_hm("2015-1-1 0:00"), 
                       ymd_hm("2015-1-1 12:00"), 
                       by = "hour")
```

Proper spacing within your code also helps with readability.  The following pulls straight from [Hadley Wickham's suggestions](http://adv-r.had.co.nz/Style.html). Place spaces around all infix operators (`=`, `+`, `-`, `<-`, etc.). The same rule applies when using `=` in function calls. Always put a space after a comma, and never before.


```r
# Good
average <- mean(feet / 12 + inches, na.rm = TRUE)

# Bad
average<-mean(feet/12+inches,na.rm=TRUE)
```

There's a small exception to this rule: `:`, `::` and `:::` don't need spaces around them.


```r
# Good
x <- 1:10
base::get

# Bad
x <- 1 : 10
base :: get
```

It is important to think about style when communicating any form of language. Writing code is no exception and is especially important if your code will be read by others. Following these basic style guides will get you on the right track for writing code that can be easily communicated to others. 


[^hadley_R_Packages]: [Wickham, H. (2015). *R packages.* "O'Reilly Media, Inc.".](http://r-pkgs.had.co.nz/)

[^character_length]: Go to *RStudio* on the menu bar then *Preferences* > *Code* > *Display* and you can select the "show margin" option and set the margin to 80.
