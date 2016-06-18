---
layout: page
title: Data Structure Basics
permalink: /structure_basics
---

> *"Smart data structures and dumb code works a lot better than the other way around"* - Eric S. Raymond

In the previous section I illustrated how to work with different types of data; however, we primarily focused on data in a one-dimensional structure.  In typical data analyses you often need more than one dimension.  Many datasets can contain variables of different length and or types of values (i.e. numeric vs character).  Furthermore, many statistical and mathematical calculations are based on matrices.  R provides multiple types of data structures to deal with these different needs.

The basic data structures in R can be organized by their dimensionality (1D, 2D, ..., *n*D) and their "likeness" (homogenous vs. heterogeneous).  This results in five data structure types most often used in data analysis; and almost all other objects in R are built from these foundational types:

![Basic Data Structures in R](images/data_structure_types.png)

In this section I will cover the basics of these data structures.  I have not had the need to use multi-dimensional arrays, therefore, the topics I will go into details on will include [vectors](#managing_vectors), [lists](#managing_lists), [matrices](#managing_matrices), and [data frames](#managing_dataframes). These types represent the most commonly used data structures for day-to-day analyses.  For each data structure I will illustrate how to create the structure, add additional elements to a pre-existing structure, add attributes to structures, and how to subset the various data structures.  Lastly, I will cover how to [deal with missing values](#managing_missing_values) in data structures.  Consequently, this section will provide a robust understanding of managing various forms of datasets depending on dimensionality needs.
