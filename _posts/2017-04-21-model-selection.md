---
author: Brad Boehmke
layout: post
comments: true
title: New Tutorial on Linear Model Selection
---

<img src="/public/images/analytics/model_selection/unnamed-chunk-6-1.png"  style="float:right; margin: 2px 0px 0px 10px; width: 50%; height: 50%;" />

It is often the case that some or many of the variables used in a multiple regression model are in fact *not* associated with the response variable. Including such irrelevant variables leads to unnecessary complexity in the resulting model. Unfortunately, manually filtering through and comparing regression models can be tedious. Luckily, several approaches exist for automatically performing feature selection or variable selection — that is, for identifying those variables that result in superior regression results. This latest [tutorial](http://uc-r.github.io/model_selection) covers a traditional approach known as *linear model selection*.
