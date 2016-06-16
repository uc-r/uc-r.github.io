---
layout: tutorial
title: Workspace
permalink: /workspace/
---


The workspace is your current R working environment and includes any user-defined objects (vectors, matrices, data frames, lists, functions).  The following code provides the basics for understanding, configuring and customizing your current R environment.

<br>

## Working Directory {#directory}
The *working directory* is the default location for all file inputs and outputs.  


```r
# returns path for the current working directory
getwd()                  

# set the working directory to a specified directory
setwd(directory_name)    
```

For example, if I call `getwd()` the file path "/Users/bradboehmke/Desktop/Personal/Data Wrangling" is returned.  If I want to set the working directory to the "Workspace" folder within the "Data Wrangling" directory I would use `setwd("Workspace")`.  Now if I call `getwd()` again it returns "/Users/bradboehmke/Desktop/Personal/Data Wrangling/Workspace".

<br>

## Environment Objects {#environment}
To identify or remove the objects (i.e. vectors, data frames, user defined functions, etc.) in your current R environment:


```r
# list all objects
ls()              

# identify if an R object with a given name is present
exists("object_name")        

# remove defined object from the environment
rm("object_name")            

# you can remove multiple objects by using the `c()` function
rm(c("object1", "object2"))  

# basically removes everything in the working environment -- use with caution!
rm(list = ls())              
```

<br>

## Command History {#history}
You can view previous commands one at a time by simply pressing the up arrow on your keyboard or view a defined number of previous commands with:


```r
# default shows 25 most recent commands
history()        

# show 100 most recent commands
history(100)     

# show entire saved history
history(Inf)     
```

<br>

## Saving & Loading {#save}
You can save and load your workspaces.  Saving your workspace will save all R files and objects within your workspace to a .RData file.


```r
# save all items in workspace to a .RData file
save.image()                                  

# save specified objects to a .RData file
save(object1, object2, file = "myfile.RData")    

# load workspace into current session
load("myfile.RData")                             
```

Note that saving the workspace without specifying the working directory will default to saving in the current directory.  You can further specify where to save the .RData by including the path: `save(object1, object2, file = "/users/name/folder/myfile.RData")`

<br>

## Workspace Options {#options}
You can view and set options for the current R session:


```r
# learn about available options
help(options)

# view current option settings
options()            

# change a specific option (i.e. number of digits to print on output)
options(digits=3)    
```

<br>

## Shortcuts
To access a menu displaying all the shortcuts in RStudio you can use option + shift + k.  Within RStudio you can also access them in the Help menu &#187; Keyboard Shortcuts.


<br>


[^character_length]: Go to *RStudio* on the menu bar then *Preferences* > *Code* > *Display* and you can select the "show margin" option and set the margin to 80.
