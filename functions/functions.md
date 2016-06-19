---
layout: tutorial
title: Writing Functions
permalink: /functions
---

R is a functional programming language, meaning that everything you do is basically built on functions.  However, moving beyond simply *using* pre-built functions to *writing* your own functions is when your capabilities really start to take off and your code development/writing takes on a new level of efficiency. Functions allow you to reduce code duplication by automating a generalized task to be applied recursively. Whenever you catch yourself repeating a function or copy and pasting code there is a good change that you should write a function to eliminate the redundancies.  

Unfortunately, due to their abstractness, grasping the idea of writing functions (let alone writing them well) can take some time.  However, in this section I will provide you with the basic knowledge of how functions operate in R to get you started on the right path.  To do this, I cover the general: 

- [components of functions](#function_components)
- [specifying function [arguments](#function_arguments)
- [scoping](#function_scoping)
- [evaluation](#function_lazy) rules
- [managing function outputs](#function_outputs)
- handling [invalid parameters](#function_invalid)
- [saving & sourcing functions](#function_saving) 
- [additional resources](#functions_add_resource)
