---
layout: tutorial
title: Week 7 (November 27 - December 3)
permalink: data_wrangling/week-7
---

Don't repeat yourself (DRY) is a software development principle aimed at reducing repetition. Formulated by Andy Hunt and Dave Thomas in their book [The Pragmatic Programmer](http://www.amazon.com/Pragmatic-Programmer-Journeyman-Master/dp/020161622X/ref=sr_1_1?s=books&ie=UTF8&qid=1456066112&sr=1-1&keywords=the+pragmatic+programmer), the DRY principle states that "every piece of knowledge must have a single, unambiguous, authoritative representation within a system." This principle has been widely adopted to imply that you should not duplicate code. Although the principle was meant to be far grander than that[^footnote], there's plenty of merit behind this slight misinterpretation.

Removing duplication is an important part of writing efficient code and reducing potential errors. First, reduced duplication of code can improve computing time and reduces the amount of code writing required. Second, less duplication results in less creating and saving of unnecessary objects. Inefficient code invariably creates copies of objects you have little interest in other than to feed into some future line of code; this wrecks havoc on properly managing your objects as it basically results in a global environment charlie foxtrot! Less duplication also results in less editing. When changes to code are required, duplicated code becomes tedious to edit and invariably mistakes or fat-fingering occur in the cut-and-paste editing process which just lengthens the editing that much more.

Thus, minimizing duplication and writing simple and readable code is important to becoming an effective and efficient data analyst. This week we will focus on two ways of removing duplication and increasing code efficiency:

1. Writing functions
2. Using iteration


## Tutorials & Resources

Please work through the following tutorials prior to Saturday’s class. The skills and functions introduced in these tutorials will be necessary to complete your assignment, which is due at the beginning of Saturday’s class, and will also be used in Saturday’s in-class small group work.

**Writing functions:** Functions allow you to reduce code duplication by automating a generalized task to be applied recursively. Whenever you catch yourself repeating a function or copy-and-pasteing code there is a good chance that you should write a function to eliminate the redundancies. Read [Chapter 19: Functions] to get started with functions.

**Iteration:**  Another tool for reducing duplication is <u>iteration</u>, which helps you when you need to do the same thing to multiple inputs: repeating the same operation on different columns, or on different datasets. Read [Chapter 21: Iteration](http://r4ds.had.co.nz/iteration.html) to learn how to perform iteration programming.

## Homework






[^footnote]: According to [Dave Thomas](http://www.artima.com/intv/dry.html), "DRY says that every piece of system knowledge should have one authoritative, unambiguous representation. Every piece of knowledge in the development of something should have a single representation. A system's knowledge is far broader than just its code. It refers to database schemas, test plans, the build system, even documentation."
