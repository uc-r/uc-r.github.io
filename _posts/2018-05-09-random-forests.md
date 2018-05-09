---
author: Brad Boehmke
layout: post
comments: true
title: Random Forests
---

<img src="/public/images/analytics/random_forests/RF_icon.jpg"  style="float:right; margin: 2px 5px 0px 20px; width: 30%; height: 30%;" />

Bagging regression trees is a technique that can turn a single tree model with high variance and poor predictive power into a fairly accurate prediction function.  Unfortunately, bagging regression trees typically suffers from tree correlation, which reduces the overall performance of the model.  ___Random forests___ are a modification of bagging that builds a large collection of *de-correlated* trees and have become a very popular "out-of-the-box" learning algorithm that enjoys good predictive performance. This [latest tutorial](http://uc-r.github.io/random_forests) will cover the fundamentals of random forests.
