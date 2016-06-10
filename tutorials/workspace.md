---
layout: page
title: NULL
permalink: /tutorials/basics/workspace/
---

[R Vocab Topics](http://bradleyboehmke.github.io/tutorials/) &#187; [Basics](http://bradleyboehmke.github.io/tutorials/basics/) &#187; Workspace


<br>

The workspace is your current R working environment and includes any user-defined objects (vectors, matrices, data frames, lists, functions).  The following code provides the basics for understanding, configuring and customizing your current R environment.

<br>

# Working Directory
The *working directory* is the default location for all file inputs and outputs.  

{% highlight r %}
getwd()                  # returns path for the current working directory
setwd(directory_name)    # set the working directory to directory_name
{% endhighlight %}

For example, if I call `getwd()` the file path "/Users/bradboehmke/Desktop/Personal/R Vocabulary" is returned.  If I want to set the working directory to the "Workspace" folder within the "R Vocabulary" directory I would use `setwd("Workspace")`.  Now if I call `getwd()` again it returns "/Users/bradboehmke/Desktop/Personal/R Vocabulary/Workspace".

<br>

# Environment Objects
To identify or remove the objects (i.e. vectors, data frames, user defined functions, etc.) in your current R environment:

{% highlight r %}
ls()                         # list all objects 
exists("object_name")        # identify if an R object with a given name is present
rm("object_name")            # remove defined object from the environment 
rm(c("object1", "object2"))  # you can remove multiple objects by using the `c()` function
rm(list = ls())              # basically removes everything working environment -- use with caution!
{% endhighlight %}



<br>

# Command History
You can view previous commands one at a time by simply pressing &#8679; or view a defined number of previous commands with:

{% highlight r %}
history()        # default shows 25 most recent commands
history(100)     # show 100 most recent commands
history(Inf)     # show entire saved history
{% endhighlight %}

<br>

# Saving & Loading 
You can save and load your workspaces.  Saving your workspace will save all R files and objects within your workspace to a .RData file.

{% highlight r %}
save.image()                                     # save all items in workspace to a .RData file
save(object1, object2, file = "myfile.RData")    # save specified objects to a .RData file
load("myfile.RData")                             # load workspace into current session
{% endhighlight %}

Note that saving the workspace without specifying the working directory will default to saving in the current directory.  You can further specify where to save the .RData by including the path: `save(object1, object2, file = "/users/name/folder/myfile.RData")`

<br>

# Workspace Options
You can view and set options for the current R session:

{% highlight r %}
help(options)        # learn about available options
options()            # view current option settings
options(digits=3)    # change a specific option (i.e. number of digits to print on output)
{% endhighlight %}

<br>

# Shortcuts
To access a menu displaying all the shortcuts in RStudio you can use  &#8997;&#8679;k (option + shift + k).  Within RStudio you can also access them in the Help menu &#187; Keyboard Shortcuts.

<br>

<small><a href="#">Go to top</a></small>
