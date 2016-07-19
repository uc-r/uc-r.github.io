---
layout: page
title: Function Basics
permalink: /function_basics
---

> *"To iterate is human, to recurse divine."* - L. Peter Deutsch

Don't repeat yourself (DRY) is a software development principle aimed at reducing repetition. Formulated by Andy Hunt and Dave Thomas in their book [The Pragmatic Programmer](http://www.amazon.com/Pragmatic-Programmer-Journeyman-Master/dp/020161622X/ref=sr_1_1?s=books&ie=UTF8&qid=1456066112&sr=1-1&keywords=the+pragmatic+programmer), the DRY principle states that "every piece of knowledge must have a single, unambiguous, authoritative representation within a system." This principle has been widely adopted to imply that you should not duplicate code.  Although the principle was meant to be far grander than that[^dave_thomas], there's plenty of merit behind this slight misinterpretation.  

Removing duplication is an important part of writing efficient code and reducing potential errors. First, reduced duplication of code can improve computing time and reduces the amount of code writing required. Second, less duplication results in less creation and saving of unnecessary objects. Inefficient code invariably creates copies of objects you have little interest in other than to feed into some future line of code; this wrecks havoc on properly managing your objects as it basically results in a global environment charlie foxtrot!  Less duplication also results in less editing. When changes to code are required, duplicated code becomes tedious to edit and invariably mistakes or fat-fingering occur in the cut-and-paste editing process which just lengthens the editing that much more. 

Furthermore, its important to have readable code. Clarity in your code creates clarity in your data analysis process. This is important as data analysis is a collaborative process so your code will likely need to be read and interpreted by others.  Plus, invariably there will come a time where you will need to go back to an old analysis so your code also needs to be clear to your future-self.  

The entire functions section covers the process of creating efficient and readable code. First, I cover the basics of [writing your own functions](http://uc-r.github.io/functions) so that you can reduce code duplication and automate generalized tasks to be applied recursively. I then cover [loop control statements](http://uc-r.github.io/control_statements) which allow you to perform repetititve code processes with different intentions and allow these automated expressions to naturally respond to features of your data.  Lastly, I demonstrate the various [apply family of functions](http://uc-r.github.io/apply_family) which make certain loop-like functionality over data frames, lists, matrices, and arrays simpler.  Combined, these tools will move you forward in writing effective, efficient and simplified code.






[^dave_thomas]: According to [Dave Thomas](http://www.artima.com/intv/dry.html), "DRY says that every piece of system knowledge should have one authoritative, unambiguous representation. Every piece of knowledge in the development of something should have a single representation. A system's knowledge is far broader than just its code. It refers to database schemas, test plans, the build system, even documentation."
