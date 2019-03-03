---
layout: tutorial
title: Week 6 (April 14-20)
permalink: data_wrangling/week-6
---

Don't repeat yourself (DRY) is a software development principle aimed at reducing repetition. Formulated by Andy Hunt and Dave Thomas in their book [The Pragmatic Programmer](http://www.amazon.com/Pragmatic-Programmer-Journeyman-Master/dp/020161622X/ref=sr_1_1?s=books&ie=UTF8&qid=1456066112&sr=1-1&keywords=the+pragmatic+programmer), the DRY principle states that "every piece of knowledge must have a single, unambiguous, authoritative representation within a system." This principle has been widely adopted to imply that you should not duplicate code. Although the principle was meant to be far grander than that, there's plenty of merit behind this slight misinterpretation.

Removing duplication is an important part of writing efficient code and reducing potential errors. First, reduced duplication of code can improve computing time and reduces the amount of code writing required. Second, less duplication results in less creating and saving of unnecessary objects. Inefficient code invariably creates copies of objects you have little interest in other than to feed into some future line of code; this wrecks havoc on properly managing your objects as it basically results in a global environment charlie foxtrot! Less duplication also results in less editing. When changes to code are required, duplicated code becomes tedious to edit and invariably mistakes or fat-fingering occur in the cut-and-paste editing process which just lengthens the editing that much more.

Thus, minimizing duplication by writing efficient code is important to becoming a data analyst and this week we will focus on two methods to achieve this:

1. Writing functions
2. Using iteration

<hr>

The following tutorials will provide you the knowledge and skills required to start becomming more efficient with your programming.

1. **Writing functions:** Functions allow you to reduce code duplication by automating a generalized task to be applied recursively. Whenever you catch yourself repeating a function or copy-and-pasteing code there is a good chance that you should write a function to eliminate the redundancies. Read [Chapter 19: Functions](http://r4ds.had.co.nz/functions.html) to get started with functions.

2. **Iteration:**  Another tool for reducing duplication is <u>iteration</u>, which helps you when you need to do the same thing to multiple inputs: repeating the same operation on different columns, or on different datasets. Read [Chapter 21: Iteration](http://r4ds.had.co.nz/iteration.html) to learn how to perform iteration programming.

3. **DataCamp:**  Once you've read through these chapters, test your skills with the following DataCamp assignments:
    - [Intermediate R](https://www.datacamp.com/enterprise/data-wrangling-5be74dc1-c06b-492c-a43e-10aa35bc87ec/assignments/45619)
    - [Writing Functions in R](https://www.datacamp.com/enterprise/data-wrangling-5be74dc1-c06b-492c-a43e-10aa35bc87ec/assignments/45620)

<hr>   

## Class

Please download this material for Saturday's class: &nbsp; <a href="https://www.dropbox.com/sh/rk9j6gs5t5pouno/AAAbmEl4BNFymzyAAu4JeAWua?dl=1" style="color:black;"><i class="fa fa-cloud-download" style="font-size:1em"></i></a>




