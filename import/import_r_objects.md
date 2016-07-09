---
layout: tutorial
title: Importing R Object Files
permalink: /import_r_objects
---

Sometimes you may need to save data or other R objects outside of your workspace.  You may want to share R data/objects with co-workers, transfer between projects or computers, or simply archive them.  There are three primary ways that people tend to save R data/objects: as .RData, .rda, or as .rds files.  The differences behind when you use each will be covered in the [Saving data as an R object file](http://uc-r.github.io/import_r_objects) section.  This section will simply shows how to load these data/object forms.


```r
load("mydata.RData")

load(file = "mydata.rda")

name <- readRDS("mydata.rds")
```
