---
id: 1836
title: Dealing with Factors
date: 2016-06-10
author: Brad Boehmke
layout: page
permalink: /factors
---

Factors are used to represent categorical data and can be unordered or ordered. One can think of a factor as an integer vector where each integer has a label. In fact, factors are built on top of integer vectors using two attributes: the `class()`, "factor", which makes them behave differently from regular integer vectors, and the `levels()`, which defines the set of allowed values.  Factors are important in statistical modeling and are treated specially by modelling functions like `lm()` and `glm()`. This section will provide you the basics of managing categorical data as factors.

* [Creating, Converting & Inspecting Factors](http://uc-r.github.io/create_factors)
* [Ordering, Revaluing, & Dropping Factor Levels](http://uc-r.github.io/factor_levels)





