---
layout: tutorial
title: Week 6 (November 13 - 19)
permalink: data_wrangling/week-6
---

Don't repeat yourself (DRY) is a software development principle aimed at reducing repetition. Formulated by Andy Hunt and Dave Thomas in their book [The Pragmatic Programmer](http://www.amazon.com/Pragmatic-Programmer-Journeyman-Master/dp/020161622X/ref=sr_1_1?s=books&ie=UTF8&qid=1456066112&sr=1-1&keywords=the+pragmatic+programmer), the DRY principle states that "every piece of knowledge must have a single, unambiguous, authoritative representation within a system." This principle has been widely adopted to imply that you should not duplicate code. Although the principle was meant to be far grander than that[^footnote], there's plenty of merit behind this slight misinterpretation.

Removing duplication is an important part of writing efficient code and reducing potential errors. First, reduced duplication of code can improve computing time and reduces the amount of code writing required. Second, less duplication results in less creating and saving of unnecessary objects. Inefficient code invariably creates copies of objects you have little interest in other than to feed into some future line of code; this wrecks havoc on properly managing your objects as it basically results in a global environment charlie foxtrot! Less duplication also results in less editing. When changes to code are required, duplicated code becomes tedious to edit and invariably mistakes or fat-fingering occur in the cut-and-paste editing process which just lengthens the editing that much more.

Thus, minimizing duplication by writing efficient code is important to becoming a data analyst and this week we will focus on two methods to achieve this:

1. Writing functions
2. Using iteration


The following tutorials will provide you the knowledge and skills required to create the meaningful, elegant, and finely tuned  data visualizations that I will be looking for in your final project.

1. __Introduction to `ggplot2`:__ Read and work through [Chapter 3: Data Visualization](http://r4ds.had.co.nz/data-visualisation.html) in R for Data Science to get an introduction to the `ggplot2` package.
    - Now that you've learned the basics, complete the [Data Visualization with ggplot2 (Part 1)](https://www.datacamp.com/groups/data-wrangling-with-r/assignments/9242) and the [Data Visualization with ggplot2 (Part 2)](https://www.datacamp.com/groups/data-wrangling-with-r/assignments/9243) DataCamp assignments to hone your skills.

2. __Advancing your visualizations:__ In your final project I will be looking for publication worthy visualizations. Thus, I fully expect your visualizations to improve with each deliverable submitted. Therefore it is essential that you learn how to use some of the more advanced features of `ggplot2` and other packages that work with `ggplot2`.  Here are some resources to help you take your visualizations to the next level:  
    - Reading and working through [Chapter 28: Graphics for Communication](http://r4ds.had.co.nz/graphics-for-communication.html) in R for Data Science.
    - Review some of the currently available [advanced plotting tutorials](ggplot).
    - Although not required, you can further hone you advanced visualization skills with the [Data Visualization with ggplot2 (Part 3)](https://www.datacamp.com/courses/data-visualization-with-ggplot2-part-3) DataCamp module, which covers statistical, network, and mapping plots along with some of the internal functioning of `ggplot2`.
   
<hr>   

## Class

Please download this material for Saturday's: &nbsp; <a href="https://www.dropbox.com/sh/powzifsazrok00f/AAB4RimS4pEXpLVV8xJECmbla?dl=1" style="color:black;"><i class="fa fa-cloud-download" style="font-size:1em"></i></a>

In addition, be sure to bring your final project data to class because you will work on it during class.  Furthermore, identify at least 10 specific questions you want to ask of your project data. Using what you learned this week, what type of visualizations can you apply to help answer these questions? Be ready to use `ggplot2` to answer these questions in class.


