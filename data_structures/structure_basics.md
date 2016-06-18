---
layout: page
title: Data Structure Basics
permalink: /structure_basics
---

> *"Smart data structures and dumb code works a lot better than the other way around"* - Eric S. Raymond

In the prior sections I illustrated how to work with different types of data; however, we primarily focused on data in a one-dimensional structure.  In typical data analyses you often need more than one dimension.  Many datasets can contain variables of different length and or types of values (i.e. numeric vs character).  Furthermore, many statistical and mathematical calculations are based on matrices.  R provides multiple types of data structures to deal with these different needs.

The basic data structures in R can be organized by their dimensionality (1D, 2D, ..., *n*D) and their "likeness" (homogenous vs. heterogeneous).  This results in five data structure types most often used in data analysis; and almost all other objects in R are built from these foundational types:

<p>
<center>
<img src="/public/images/r_vocab/data_structure_types.png" alt="Data Structure Types" vspace="25">
</center>  
</p>

In the data structure tutorials that follow I will cover the basics of these data structures.  But prior to jumping into the data structures, it's beneficial to understand two components of data structures - the structure and attributes.  

- [Identifying the structure](http://uc-r.github.io/data_structure_id)
- [Understanding attributes](http://uc-r.github.io/understanding_attributes)


